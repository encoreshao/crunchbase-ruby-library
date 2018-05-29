# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
  class Client
    # Get information by permalink with optional one relationship
    def get(permalink, kclass_name, relationship_name = nil)
      case kclass_name
      when 'Person'
        person(permalink, relationship_name)
      when 'Organization'
        organization(permalink, relationship_name)
      end
    end

    # Get organization information by the permalink
    def organization(permalink, kclass_name = nil)
      request_perform('Organization', permalink, kclass_name)
    end

    # Get person information by the permalink
    def person(permalink, kclass_name = nil)
      request_perform('Person', permalink, kclass_name)
    end

    def list(kclass_name, options = {})
      page = options[:page] || 1

      kclass(kclass_name).list(page)
    end

    # options -> { query: "Ekohe" } || { name: "Ekohe" } || { domain_name: "ekohe.com" }
    def search(options, kclass_name)
      return [] if kclass_name.nil?

      kclass('Search').search(options, kclass_name)
    end

    def request_perform(stand_kclass, permalink, kclass_name)
      return kclass(stand_kclass).get(permalink) if kclass_name.nil?

      kclass(kclass_name).organization_lists(permalink)
    end

    # Runs a batch search and returns matched results
    # Params:
    # +request_body+:: An array of hashes with following attributes: { 'type': String, 'uuid': String, 'relationships': String[] }
    def batch_search(request_body)
      return [] if request_body.nil?

      kclass('BatchSearch').batch_search(request_body)
    end

    private
    def kclass(kclass_name)
      Crunchbase::Model.const_get kclass_name
    end
  end
end
