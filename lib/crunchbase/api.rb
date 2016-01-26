# encoding: utf-8

require 'net/http'

begin
  require 'yajl'
rescue LoadError
  require 'json'
end

require 'timeout'

module Crunchbase
  class API

    SUPPORTED_ENTITIES = ['organizations', 'people', 'products', 'funding_rounds', 'funding-rounds', 'acquisitions', 'ipos', 'locations', 'categories', 'offices', 'customers', 'degrees', 'experience', 'primary_affiliation', 'videos', 'founded_companies', 'primary_location', 'advisor_at']

    @timeout_limit  = 60
    @redirect_limit = 2
    @version        = '3'
    @base_url       = 'https://api.crunchbase.com'
    @site_url       = "https://www.crunchbase.com"
    @image_url      = "https://res.cloudinary.com/crunchbase-production/"
    @debug          = false

    # Must be overridden in subclasses
    RESOURCE_NAME         = "undefined"
    RESOURCE_LIST         = "undefineds"

    ORDER_CREATED_AT_ASC  = 'created_at asc'
    ORDER_CREATED_AT_DESC = 'created_at desc'
    ORDER_UPDATED_AT_ASC  = 'updated_at asc'
    ORDER_UPDATED_AT_DESC = 'updated_at desc'

    class << self
      attr_accessor :timeout_limit, :redirect_limit, :key, :base_url, :version, :debug, :image_url, :site_url

      def api_url
        base_url.gsub(/\/$/, '') + '/v/' + version + '/'
      end
    end

    def self.single_entity(permalink, entity_name)
      raise CrunchException, "Unsupported Entity Type" unless SUPPORTED_ENTITIES.include?(entity_name)

      fetch(permalink, entity_name)
    end

    private

    # Returns the JSON parser, whether that's an instance of Yajl or JSON
    def self.parser
      if defined?(Yajl)
        Yajl::Parser
      else
        JSON
      end
    end

    # Fetches URI for the permalink interface.
    def self.fetch(permalink, object_name)
      get_json_response( api_url + "#{object_name}/#{permalink}" )
    end

    # Fetches URI for the search interface.
    def self.search(options, resource_list)
      options[:page] = 1 if options[:page].nil?
      options[:sort_order] = ORDER_CREATED_AT_ASC if options[:sort_order].nil?

      uri = api_url + "#{resource_list}?" + collect_parameters(options)

      get_json_response(uri)
    end


    # Fetches URI for the search interface.
    def self.list(options, resource_list)
      options[:page]  = 1 if options[:page].nil?
      options[:sort_order] = ORDER_CREATED_AT_ASC if options[:sort_order].nil?
      model_name      = options.delete(:model_name)

      uri = api_url + "#{resource_list}?" + collect_parameters(options)

      Crunchbase::Model::Search.new options, get_json_response(uri), model_name
    end

    def self.collect_parameters(options)
      require "cgi"

      options.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"}.join('&')
    end

    def self.organization_lists(permalink, category, options)
      lists_for_category('organizations', permalink, category, options)
    end

    # Visit: https://api.crunchbase.com/v/#{version}/people/#{permalink}/#{category}?user_key=key
    def self.person_lists(permalink, category, options)
      lists_for_category('people', permalink, category, options)
    end

    # Visit: https://api.crunchbase.com/v/#{version}/funding-rounds/#{permalink}/#{category}?user_key=key
    def self.funding_rounds_lists(permalink, category, options)
      lists_for_category('funding-rounds', permalink, category, options)
    end

    def self.lists_for_category(classify_name, permalink, category, options)
      options[:page]  = 1 if options[:page].nil?
      options[:sort_order] = ORDER_CREATED_AT_ASC if options[:sort_order].nil?
      model_name      = options.delete(:model_name)

      uri = api_url + "#{classify_name}/#{permalink}/#{category}?#{collect_parameters(options)}"

      Crunchbase::Model::Search.new options, get_json_response(uri), model_name
    end

    # Gets specified URI, then parses the returned JSON. Raises Timeout error
    # if request time exceeds set limit. Raises Crunchbase::Exception if returned
    # JSON contains an error.
    def self.get_json_response(uri)
      raise Crunchbase::Exception, "User key required, visit http://data.crunchbase.com" unless @key
      uri = uri + "#{uri.match('\?') ? "&" : "?"}user_key=#{@key}"

      resp = Timeout::timeout(@timeout_limit) {
        get_url_following_redirects(uri, @redirect_limit)
      }

      _response = parser.parse(resp)
      raise Crunchbase::Exception, { message: _response["error"], code: _response["status"].to_i } unless _response["error"].blank?

      response = _response["data"]
      raise Crunchbase::Exception, response["error"] if response.class == Hash && response["error"] && response["error"]["code"] != 500

      response
    end

    # Performs actual HTTP requests, recursively if a redirect response is
    # encountered. Will raise HTTP error if response is not 200, 404, or 3xx.
    def self.get_url_following_redirects(uri_str, limit = 10)
      raise Crunchbase::Exception, 'HTTP redirect too deep' if limit == 0

      uri = URI.parse(URI.encode(uri_str))

      debug_log!(uri) if debug

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      response = http.start do |h|
        h.request Net::HTTP::Get.new(uri.request_uri)
      end

      case response
        when Net::HTTPSuccess, Net::HTTPNotFound, Net::HTTPInternalServerError
          response.body
        when Net::HTTPRedirection
          get_url_following_redirects(response['location'], limit - 1)
        else
          response.error!
      end
    end

    def self.debug_log!(uri)
      puts "*"*120
      puts "***  #{uri}  ***"
      puts "*"*120
    end

  end
end
