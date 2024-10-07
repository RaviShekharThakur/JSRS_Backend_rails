class UserSerializer
  include JSONAPI::Serializer
  
  attributes :id, :name, :email, :phone, :age, :address, :area, :created_at, :updated_at

  attribute :image_url do |obj|
    if obj.image.attached?
      Rails.application.routes.url_helpers.rails_blob_url(obj.image, only_path: false, host: ActiveStorage::Current.url_options[:host])
    else
      ActionController::Base.helpers.asset_url('customer.jpg', host: ActiveStorage::Current.url_options[:host]) 
    end
  end
end
