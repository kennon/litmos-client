require 'rest_client'
require 'json'

require File.dirname(__FILE__) + '/litmos_client/users'
require File.dirname(__FILE__) + '/litmos_client/teams'
require File.dirname(__FILE__) + '/litmos_client/courses'

module LitmosClient
  class NotFound < Exception; end
  class ApiError < Exception; end
  class ArgumentError < Exception; end

  class API
    include LitmosClient::Users
    include LitmosClient::Teams
    include LitmosClient::Courses

    # Litmos Developer API Documentation: http://help.litmos.com/developer-api/
    API_VERSION = "1"

    # Initialize with an API key and config options
    def initialize(api_key, source = nil, config = {})
      raise ArgumentError.new('Your need to specify your api key') unless api_key
      raise ArgumentError.new('You need to specify a source website') unless source

      defaults = {
        :api_version        => API_VERSION
      }

      @config = defaults.merge(config).freeze
      @api_key = api_key
      @source = source
      @litmosURL = "https://api.litmos.com/v#{@config[:api_version]}.svc/"
    end

    def get(path, params={})
      dont_parse_response = params.delete(:dont_parse_response)

      options = {
        :content_type => :json, 
        :accept => :json, 
        :params => params.merge(:apikey => @api_key, :source => @source)
      }

      RestClient.get("#{@litmosURL}/#{path}", options) do |response, request, result|
        case response.code
        when 200, 201 
          # 200 Success. User/Course etc updated, deleted or retrieved
          # 201 Success. User/Course etc created
          if response.blank?
            true
          else
            if dont_parse_response
              response
            else
              parse_response(response)
            end
          end
        when 404 # 404 Not Found. The User/Course etc that you requested does not exist
          raise NotFound.new(response)

        else
          # 400 Bad Request. Check that your Uri and request body is well formed
          # 403 Forbidden. Check your API key, HTTPS setting, Source parameter etc
          # 409 Conflict. Often occurs when trying to create an item that already exists
          raise ApiError.new(response)

        end        
      end
    end

    def post(path, params={}, query_params={})
      query_params = query_params.merge(:apikey => @api_key, :source => @source)
      query_string = query_params.collect { |k,v| "#{k}=#{CGI::escape(v)}" }.join('&')
      query_string = "?#{query_string}" unless query_string.blank?

      dont_parse_response = params.delete(:dont_parse_response)
      
      options = {
        :content_type => :json, 
        :accept => :json, 
      }

      RestClient.post("#{@litmosURL}/#{path}#{query_string}", params.to_json, options) do |response, request, result|
        case response.code
        when 200, 201 
          # 200 Success. User/Course etc updated, deleted or retrieved
          # 201 Success. User/Course etc created

          if response.blank?
            true
          else
            if dont_parse_response
              response
            else
              parse_response(response)
            end
          end

        when 404 # 404 Not Found. The User/Course etc that you requested does not exist
          raise NotFound.new(response)

        else
          # 400 Bad Request. Check that your Uri and request body is well formed
          # 403 Forbidden. Check your API key, HTTPS setting, Source parameter etc
          # 409 Conflict. Often occurs when trying to create an item that already exists
          raise ApiError.new(response)

        end        
      end
    end
    
    def put(path, params={}, query_params={})
      query_params = query_params.merge(:apikey => @api_key, :source => @source)
      query_string = query_params.collect { |k,v| "#{k}=#{CGI::escape(v)}" }.join('&')
      query_string = "?#{query_string}" unless query_string.blank?

      dont_parse_response = params.delete(:dont_parse_response)
      
      options = {
        :content_type => :json, 
        :accept => :json, 
      }

      RestClient.put("#{@litmosURL}/#{path}#{query_string}", params.to_json, options) do |response, request, result|
        case response.code
        when 200, 201 
          # 200 Success. User/Course etc updated, deleted or retrieved
          # 201 Success. User/Course etc created

          if response.blank?
            true
          else
            if dont_parse_response
              response
            else
              parse_response(response)
            end
          end

        when 404 # 404 Not Found. The User/Course etc that you requested does not exist
          raise NotFound.new(response)

        else
          # 400 Bad Request. Check that your Uri and request body is well formed
          # 403 Forbidden. Check your API key, HTTPS setting, Source parameter etc
          # 409 Conflict. Often occurs when trying to create an item that already exists
          raise ApiError.new(response)

        end        
      end
    end

    def delete(path, params={})
      dont_parse_response = params.delete(:dont_parse_response)

      options = {
        :content_type => :json, 
        :accept => :json, 
        :params => params.merge(:apikey => @api_key, :source => @source)
      }

      RestClient.delete("#{@litmosURL}/#{path}", options) do |response, request, result|
        case response.code
        when 200, 201 
          # 200 Success. User/Course etc updated, deleted or retrieved
          # 201 Success. User/Course etc created

          if response.blank?
            true
          else
            if dont_parse_response
              response
            else
              parse_response(response)
            end
          end

        when 404 # 404 Not Found. The User/Course etc that you requested does not exist
          raise NotFound.new(response)

        else
          # 400 Bad Request. Check that your Uri and request body is well formed
          # 403 Forbidden. Check your API key, HTTPS setting, Source parameter etc
          # 409 Conflict. Often occurs when trying to create an item that already exists
          raise ApiError.new(response)

        end        
      end
    end

  protected

    ASP_DATE_REGEXP=/\/Date\(([0-9]+)\+[0-9]+\)\//

    def parse_asp_date(asp_date)
      DateTime.strptime(asp_date.gsub(ASP_DATE_REGEXP, '\1'), '%Q')
    end

    # for de-camelCasing the result keys
    # from: http://stackoverflow.com/questions/8706930/converting-nested-hash-keys-from-camelcase-to-snake-case-in-ruby

    def underscore(string)
      string.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    def underscore_key(k)
      underscore(k.to_s).to_sym
    end

    def parse_response(response)
      convert_hash_keys(JSON.parse(response))
    end

    def convert_hash_keys(value)
      if value.is_a?(String) and value =~ ASP_DATE_REGEXP
        return parse_asp_date(value)
      end

      case value
      when Array
        value.map { |v| convert_hash_keys(v) }
        # or `value.map(&method(:convert_hash_keys))`
      when Hash
        Hash[value.map { |k, v| [underscore_key(k), convert_hash_keys(v)] }]
      else
        value
       end
    end

  end

end
