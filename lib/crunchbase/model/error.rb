# frozen_string_literal: true

module Crunchbase::Model
  class Error < Entity
    attr_reader :message, :code

    def initialize(json)
      @message  = json['message']
      @code     = json['code']
    end
  end
end
