# frozen_string_literal: true

# encoding utf-8

module Crunchbase::Model
  class FundRaise < Entity
    RESOURCE_LIST = 'funds'.freeze

    attr_reader :name, :path, :created_at, :updated_at

    def initialize(json)
      property_keys.each do |v|
        instance_variable_set("@#{v}", json[v] || nil)
      end

      %w(created_at updated_at).each do |v|
        instance_variable_set("@#{v}", Time.at(json[v]))
      end
    end

    def property_keys
      %w(name path created_at updated_at)
    end
  end
end
