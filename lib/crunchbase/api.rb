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

    SUPPORTED_ENTITIES = ['organizations', 'people', 'person', 'products', 'funding_rounds', 'funding-round', 'acquisition', 'ipo', 'fund-raise', 'locations', 'categories', 'offices', 'customers', 'degrees', 'experience', 'primary_affiliation', 'videos', 'founded_companies', 'primary_location', 'advisor_at']

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
      attr_accessor :timeout_limit, :redirect_limit, :key, :base_url, :version, 
                    :debug, :image_url, :site_url

      def api_url
        base_url.gsub(/\/$/, '') + '/v/' + version + '/'
      end
    end

    def self.single_entity(permalink, entity_name)
      raise CrunchException, "Unsupported Entity Type" unless SUPPORTED_ENTITIES.include?(entity_name)

      fetch(permalink, entity_name)
    end
    
    def self.all(entity)
      get_json_response( api_url + entity )
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
      uri = api_url + "#{object_name}/#{permalink}"

      get_json_response(uri)
    end
    
    # Fetches URI for the search interface.
    def self.search(options, object_lists)
      options[:page] = 1 if options[:page].nil?
      options[:order] = ORDER_CREATED_AT_ASC if options[:order].nil?
      
      uri = api_url + "#{object_lists}?" + collect_parameters(options)

      get_json_response(uri)
    end
    
    
    # Fetches URI for the search interface.
    def self.list(options, object_lists)
      options[:page]  = 1 if options[:page].nil?
      model_name      = options.delete(:model_name)
      
      uri = api_url + "#{object_lists}?" + collect_parameters(options)

      Crunchbase::Search.new options, get_json_response(uri), SearchResult
    end
    
    def self.collect_parameters(options)
      require "cgi"

      options.map{|k,v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}"}.join('&')
    end

    # Searches for a permalink in a particular category.
    # Demo: https://api.crunchbase.com/v/2/organization/#{organization-permalink}/offices?user_key=key
    def self.lists_for_permalink(permalink, category, options)
      lists_for_category('organization', permalink, category, options)
    end

    # Demo: https://api.crunchbase.com/v/2/person/#{person-permalink}/offices?user_key=key
    def self.lists_for_person_permalink(permalink, category, options)
      lists_for_category('person', permalink, category, options)
    end

    class << self
      alias_method :category_lists_by_organization, :lists_for_permalink
      alias_method :category_lists_by_person, :lists_for_person_permalink
    end

    def self.lists_for_category(classify_name, permalink, category, options)
      options[:page]  = 1 if options[:page].nil?
      options[:order] = ORDER_CREATED_AT_ASC if options[:order].nil?
      model_name      = options.delete(:model_name)

      uri = api_url + "#{classify_name}/#{permalink}/#{category}?#{collect_parameters(options)}"

      Crunchbase::Model::Search.new options, get_json_response(uri), model_name
    end
    
    # Gets specified URI, then parses the returned JSON. Raises Timeout error 
    # if request time exceeds set limit. Raises Crunchbase::Exception if returned
    # JSON contains an error.
    def self.get_json_response(uri)
      raise Crunchbase::Exception, "User key required, visit http://developer.crunchbase.com" unless @key
      uri = uri + "#{uri.match('\?') ? "&" : "?"}user_key=#{@key}"

      resp = Timeout::timeout(@timeout_limit) {
        get_url_following_redirects(uri, @redirect_limit)
      }
      response = parser.parse(resp)["data"]

      raise Crunchbase::Exception, response["error"] if response.class == Hash && response["error"]

      response
    end

    # Performs actual HTTP requests, recursively if a redirect response is
    # encountered. Will raise HTTP error if response is not 200, 404, or 3xx.
    def self.get_url_following_redirects(uri_str, limit = 10)
      raise Crunchbase::Exception, 'HTTP redirect too deep' if limit == 0

      uri = URI.parse(uri_str)
      if self.debug
        puts "*"*120
        puts "***  #{uri}  ***"
        puts "*"*120
      end

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      response = http.start do |h|
        h.request Net::HTTP::Get.new(uri.request_uri)
      end

      case response
        when Net::HTTPSuccess, Net::HTTPNotFound
          response.body
        when Net::HTTPRedirection
          get_url_following_redirects(response['location'], limit - 1)
        else
          response.error!
      end
    end

  end
end
