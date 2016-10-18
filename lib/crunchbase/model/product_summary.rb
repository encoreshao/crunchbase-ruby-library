module Crunchbase::Model
  class ProductSummary < Crunchbase::Model::Entity

    attr_reader :permalink, :api_path, :web_path, :name, :short_description,
                :owner_permalink, :owner_api_path, :owner_web_path, :owner_name,
                :profile_image_url, :homepage_url, :facebook_url, :twitter_url, :linkedin_url,
                :created_at, :updated_at


    def property_keys
      %w[
        permalink api_path web_path name short_description
        owner_permalink owner_api_path owner_web_path owner_name
        profile_image_url homepage_url facebook_url twitter_url linkedin_url
        created_at updated_at
      ]
    end
  end
end
