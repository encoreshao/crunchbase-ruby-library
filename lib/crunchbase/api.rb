# frozen_string_literal: true

require 'net/http'

begin
  require 'yajl'
rescue LoadError
  require 'json'
end

require 'timeout'

module Crunchbase
  class API
    SUPPORTED_ENTITIES = {
      'categories' => Model::Category,
      'organizations' => Model::OrganizationSummary,
      'organization' => Model::Organization,
      'people' => Model::PersonSummary,
      'person' => Model::Person,
      'products' => Model::ProductSummary,
      'ipos' => Model::Ipo,
      'funding_rounds' => Model::FundingRound,
      'funding-rounds' => Model::FundingRound,
      'acquisitions' => Model::Acquisition,
      'locations' => Model::Location,
      'offices' => Model::Office,
      'customers' => Model::Customer,
      'degrees' => Model::Degree,
      # 'experience' => nil,
      'primary_affiliation' => Model::PrimaryAffiliation,
      'videos' => Model::Video,
      'founded_companies' => Model::FoundedCompany,
      'primary_location' => Model::PrimaryLocation,
      'advisor_at' => Model::AdvisoryRole,
      'investors' => Model::Organization
    }.freeze

    @redirect_limit = 2
    @timeout  = 60
    @debug = false

    # Must be overridden in subclasses
    RESOURCE_NAME         = 'undefined'.freeze
    RESOURCE_LIST         = 'undefineds'.freeze

    ORDER_CREATED_AT_ASC  = 'created_at ASC'.freeze
    ORDER_CREATED_AT_DESC = 'created_at DESC'.freeze
    ORDER_UPDATED_AT_ASC  = 'updated_at ASC'.freeze
    ORDER_UPDATED_AT_DESC = 'updated_at DESC'.freeze

    class << self
      attr_accessor :key # Necessary
      attr_accessor :debug, :timeout, :redirect_limit

      def api_url
        API_BASE_URL.gsub(/\/$/, '') + '/v' + API_VERSION + '/'
      end

      def single_entity(permalink, entity_name)
        raise CrunchException, 'Unsupported Entity Type' unless SUPPORTED_ENTITIES.keys.include?(entity_name)

        fetch(permalink, entity_name)
      end

      # Returns the JSON parser, whether that's an instance of Yajl or JSON
      def parser
        return Yajl::Parser if defined?(Yajl)

        JSON
      end

      # Fetches URI for the permalink interface.
      def fetch(permalink, kclass_name)
        get_json_response(api_url + "#{kclass_name}/#{permalink}")
      end

      # Fetches URI for the search interface.
      def search(options, resource_list)
        options[:page] = 1 if options[:page].nil?
        options[:order] = ORDER_CREATED_AT_ASC if options[:order].nil?

        uri = api_url + "#{resource_list}?" + collect_parameters(options)

        get_json_response(uri)
      end

      # Fetches URI for the search interface and adapts the payload.
      def batch_search(requests_array)
        uri = "#{api_url}batch"
        request_body = { requests: requests_array }

        post_json_response(uri, request_body)
      end

      # Fetches URI for the search interface.
      def list(options, resource_list)
        options[:page]  = 1 if options[:page].nil?
        model_name      = options.delete(:model_name) || SUPPORTED_ENTITIES[resource_list]

        uri = api_url + "#{resource_list}?" + collect_parameters(options)

        Model::Search.new options, get_json_response(uri), model_name
      end

      def collect_parameters(options)
        options.map { |k, v| "#{k}=#{v}" }.join('&')
      end

      def organization_lists(permalink, category, options)
        lists_for_category('organizations', permalink, category, options)
      end

      def person_lists(permalink, category, options)
        lists_for_category('people', permalink, category, options)
      end

      def funding_rounds_lists(permalink, category, options)
        lists_for_category('funding-rounds', permalink, category, options)
      end

      def lists_for_category(classify_name, permalink, category, options)
        options[:page]  = 1 if options[:page].nil?
        options[:order] = ORDER_CREATED_AT_ASC if options[:order].nil?
        model_name      = options.delete(:model_name)

        uri = api_url + "#{classify_name}/#{permalink}/#{category}?#{collect_parameters(options)}"

        Model::Search.new options, get_json_response(uri), model_name
      end

      # Gets specified URI, then parses the returned JSON. Raises Timeout error
      #   if request time exceeds set limit. Raises Exception if returned
      #   JSON contains an error.
      def get_json_response(uri)
        raise Exception, 'User key required, visit https://data.crunchbase.com/v3.1/docs' unless @key
        uri += "#{uri =~ /\?/ ? '&' : '?'}user_key=#{@key}"

        resp = Timeout.timeout(@timeout) do
          get_url_following_redirects(uri, @redirect_limit)
        end

        response = parser.parse(resp)
        response = response[0] if response.is_a?(Array)
        raise Exception, response['message'] unless response['message'].nil?

        response['data']
      end

      # Performs actual HTTP requests, recursively if a redirect response is
      # encountered. Will raise HTTP error if response is not 200, 404, or 3xx.
      def get_url_following_redirects(uri_str, limit = 10)
        raise Exception, 'HTTP redirect too deep' if limit.zero?

        uri = URI.parse(URI.encode(uri_str))

        debugging(uri)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == 'https'
        response = http.start do |h|
          h.request Net::HTTP::Get.new(uri.request_uri, 'User-Agent' => 'crunchbase-ruby-library')
        end

        case response
        when Net::HTTPSuccess, Net::HTTPNotFound, Net::HTTPInternalServerError, Net::HTTPConflict
          response.body
        when Net::HTTPRedirection
          get_url_following_redirects(response['location'], limit - 1)
        else
          response.error!
        end
      end

      # Gets specified URI, and the object for request's body, then parses the returned JSON. Raises Timeout error
      #   if request time exceeds set limit. Raises Exception if returned
      #   JSON contains an error.
      def post_json_response(uri, request_body)
        raise Exception, 'User key required, visit https://data.crunchbase.com/v3.1/docs' unless @key

        body_string = request_body.to_json

        resp = Timeout.timeout(@timeout) do
          post_url_following_redirects(uri, body_string, @redirect_limit)
        end

        response = parser.parse(resp)
        raise Exception, response['message'] unless response['message'].nil?

        response['data']
      end

      # Performs actual HTTP requests, recursively if a redirect response is
      # encountered. Will raise HTTP error if response is not 200, 404, or 3xx.
      def post_url_following_redirects(uri_str, body_string, limit = 10)
        raise Exception, 'HTTP redirect too deep' if limit.zero?

        uri = URI.parse(URI.encode(uri_str))

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme == 'https'

        req = Net::HTTP::Post.new(uri.request_uri)
        req.add_field('User-Agent', 'crunchbase-ruby-library')
        req.add_field('Content-Type', 'application/json')
        req.add_field('X-Cb-User-Key', @key)

        req.body = body_string

        response = http.start do |h|
          h.request req
        end

        case response
        when Net::HTTPSuccess, Net::HTTPNotFound, Net::HTTPInternalServerError, Net::HTTPConflict
          response.body
        when Net::HTTPRedirection
          post_url_following_redirects(response['location'], limit - 1)
        else
          response.error!
        end
      end

      def debugging(uri)
        return unless debug

        puts '*' * 140
        puts "***  #{uri}  ***"
        puts '*' * 140
      end
    end
  end
end
