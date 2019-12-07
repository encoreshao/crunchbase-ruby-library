# frozen_string_literal: true

module Crunchbase::Model
  class AdvisoryRole < Job
    # called advisor_at from people api

    RESOURCE_LIST = 'advisor_at'.freeze
  end
end
