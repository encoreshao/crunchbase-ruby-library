# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
	module Model
		class BatchSearch < Entity
			include Enumerable

			attr_reader :results

			alias items results

			def initialize(json, kclass_array)
				@results = []

				populate_results(json, kclass_array)
			end

			def populate_results(json, kclass_array)
				@results = []
				@results = json['items'].map.with { |r, index| kclass_array[index].new(r) }

				# TODO - finish populating results
			end

			def self.batch_search(request_body)
				raise MissingParamsException if request_body.empty?
				model_names = request_body.collect { |request| request[:type] }

				BatchSearch.new API.batch_search(request_body), kclass_array(model_names)
			end

			private

				def kclass_array(model_names)
					model_names.collect { |model_name| kclass_name(model_name) }
				end

		end
	end
end