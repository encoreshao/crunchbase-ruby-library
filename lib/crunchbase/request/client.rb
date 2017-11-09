# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
  module Request
    module Client
      # Factory method to return an instance from a permalink
      def get(permalink)
        result = api.single_entity(permalink, self::RESOURCE_NAME)

        new(result)
      end

      def list(page = nil)
        model_name = kclass_name(self::RESOURCE_LIST)

        api.list({ page: page, model_name: model_name }, self::RESOURCE_LIST)
      end

      def organization_lists(permalink, options = {})
        options = options.merge(model_name: self)

        api.organization_lists(permalink, self::RESOURCE_LIST, options)
      end

      def person_lists(permalink, options = {})
        options = options.merge(model_name: self)

        api.person_lists(permalink, self::RESOURCE_LIST, options)
      end

      def funding_rounds_lists(permalink, options = {})
        options = options.merge(model_name: self)

        api.funding_rounds_lists(permalink, self::RESOURCE_LIST.tr('_', '-'), options)
      end

      def array_from_list(list)
        return [] if list.nil?

        list['items'].map do |l|
          new l if l.is_a?(Hash)
        end.compact
      end

      def parsing_from_list(list)
        return [] if list.nil?

        list.map do |l|
          new l if l.is_a?(Hash)
        end.compact
      end

      def total_items_from_list(list)
        return 0 if list.nil?

        list['paging']['total_items']
      end

      def kclass_name(resource_list)
        api::SUPPORTED_ENTITIES[resource_list] || nil
      end

      def api
        Crunchbase::API
      end
    end
  end
end
