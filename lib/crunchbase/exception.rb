# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
  class Exception < RuntimeError; end
  class ConfigurationException < RuntimeError; end
  class MissingParamsException < RuntimeError; end
  class InvalidRequestException < RuntimeError; end
  class ResponseTypeException < RuntimeError; end
  class CertificateError < StandardError; end

  class ResponseError < StandardError
    attr_reader :response

    def initialize(message, response)
      @response = response
      super(message)
    end
  end
end
