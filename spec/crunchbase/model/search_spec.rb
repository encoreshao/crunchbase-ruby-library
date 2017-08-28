# frozen_string_literal: true

module Crunchbase
  module Model
    describe Search do
      # # Full text search of an Organization's name,
      # # aliases (i.e. previous names or "also known as"), and short description
      # it 'Search organizations with -> query through crunchbase API' do
      #   Search.search({ query: 'Google' }, 'organizations')
      # end

      # # Full text search limited to name and aliases
      # it 'Search organizations with -> name through crunchbase API' do
      #   Search.search({ name: 'Google' }, 'organizations')
      # end

      # # Text search of an Organization's domain_name (e.g. www.google.com)
      # it 'Search organizations with -> domain_name through crunchbase API' do
      #   Search.search({ domain_name: 'google.com' }, 'organizations')
      # end

      # # A full-text query of name, title, and company
      # it 'Search person with -> query through crunchbase API' do
      #   Search.search({ query: 'encore' }, 'people')
      # end
    end
  end
end
