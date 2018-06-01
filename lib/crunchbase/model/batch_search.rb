# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
	module Model
		class BatchSearch < Entity
			include Enumerable

			attr_reader :results

			alias items results

			def initialize(json)
				@results = []

				populate_results(json)
			end

			def populate_results(json)
				@results = []

				@results = json['items'].map do |r|
					kclass = kclass_name(r['type'])
					kclass.new(r)
				end
			end

			def self.batch_search(requests)
				raise ConfigurationException, 'Invalid argument. Please pass in an array as an argument' unless requests.is_a?(Array)
				raise InvalidRequestException, "Too many requests(#{requests.length}) in batch, max allowed 10" if requests.length > 10
				raise MissingParamsException, 'Missing :type or :uuid parameter in some requests' if requests.any? { |request| !request.key?(:type) || !request.key?(:uuid) }
				return [] if requests.empty?

				BatchSearch.new API.batch_search(requests)
			end

			private

			def kclass_name(model_name)
				self.class.kclass_name(model_name.downcase)
			end

		end
	end
end