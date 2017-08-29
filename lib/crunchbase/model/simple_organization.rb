# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class SimpleOrganization < Entity
    attr_reader :type, :name, :path, :created_at, :updated_at

    def initialize(json)
      property_keys.each do |v|
        instance_variable_set("@#{v}", json[v] || nil)
      end

      %w(created_at updated_at).each do |v|
        instance_variable_set("@#{v}", Time.at(json[v])) unless json[v].nil?
      end
    end

    def property_keys
      %w(
        type name path created_at updated_at
      )
    end
  end
end
