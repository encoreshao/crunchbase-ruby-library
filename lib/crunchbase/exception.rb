# encoding: utf-8

module Crunchbase
  class Exception < ::Exception
  end

  class ConfigurationException < Exception
  end

  class MissingParamsException < Exception
  end

  class InvalidRequestException < Exception
  end

  class ResponseTypeException < Exception
  end
end
