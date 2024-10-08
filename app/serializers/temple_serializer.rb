class TempleSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :location, :description, :latitude, :longitude, :founding_date, :deity

  attribute :images do |obj|
    if obj.images.attached?
      obj.images.map do |image|
        Rails.application.routes.url_helpers.rails_blob_url(image, only_path: false, host: ActiveStorage::Current.url_options[:host])
      end
    else
      [ActionController::Base.helpers.asset_url('medicine_image.png', host: ActiveStorage::Current.url_options[:host])]
    end
  end
end
