module DesignerNews
  module Response
    class Error < StandardError

      def self.from_response(response)
        status  = response[:status].to_i
        body    = response[:body].to_s
        headers = response[:response_headers]

        if klass =  case status
                      when 400      then DesignerNews::Response::BadRequest
                      when 401      then DesignerNews::Response::Unauthorized
                      when 403      then DesignerNews::Response::Forbidden
                      when 404      then DesignerNews::Response::NotFound
                      when 406      then DesignerNews::Response::NotAcceptable
                      when 400..499 then DesignerNews::Response::ClientError
                      when 500      then DesignerNews::Response::InternalServerError
                      when 501      then DesignerNews::Response::NotImplemented
                      when 502      then DesignerNews::Response::BadGateway
                      when 503      then DesignerNews::Response::ServiceUnavailable
                      when 500..599 then DesignerNews::Response::ServerError
                    end
          klass.new(response)
        end
      end

      def initialize(response=nil)
        @response = response
        super(build_error_message)
      end

      def errors
        if data && data.is_a?(Hash)
          data[:errors] || []
        else
          []
        end
      end

      private

      def build_error_message
        return nil if @response.nil?

        message =  "#{@response[:method].to_s.upcase} "
        message << "#{@response[:url].to_s}: "
        message << "#{@response[:status]} - "
        message << "#{response_message}" unless response_message.nil?
        message << "#{response_error}" unless response_error.nil?
        message << "#{response_error_summary}" unless response_error_summary.nil?
        message
      end

      def response_message
        case data
        when Hash
          data[:message]
        when String
          data
        end
      end

      def response_error
        "Error: #{data[:error]}" if data.is_a?(Hash) && data[:error]
      end

      def response_error_summary
        return nil unless data.is_a?(Hash) && !Array(data[:errors]).empty?

        summary = "\nError summary:\n"
        summary << data[:errors].map do |hash|
          hash.map { |k,v| "  #{k}: #{v}" }
        end.join("\n")

        summary
      end

      def data
        @data ||=
          if (body = @response[:body]) && !body.empty?
            if body.is_a?(String) &&
              @response[:response_headers] &&
              @response[:response_headers][:content_type] =~ /json/

              MultiJson.load(body)
            else
              body
            end
          else
            nil
          end
      end
    end

    class ClientError < Error; end

    class BadRequest < ClientError; end
    class Unauthorized < ClientError; end
    class Forbidden < ClientError; end
    class TooManyRequests < Forbidden; end
    class NotFound < ClientError; end
    class NotAcceptable < ClientError; end

    class ServerError < Error; end

    class InternalServerError < ServerError; end
    class NotImplemented < ServerError; end
    class BadGateway < ServerError; end
    class ServiceUnavailable < ServerError; end
  end
end
