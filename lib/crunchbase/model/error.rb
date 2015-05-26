# encoding: utf-8

module Crunchbase::Model
  class Error < Crunchbase::Model::Entity

    attr_reader :message, :code

    def initialize(json)
      @message  = json['message']
      @code     = json['code']
    end

  end
end