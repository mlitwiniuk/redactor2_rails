class Redactor3Rails::ImagesController < ApplicationController
  before_action :redactor3_authenticate_user!

  def create
    @image = Redactor3Rails.image_model.new

    file = Array.wrap(params[:file]).first
    @image.data = Redactor3Rails::Http.normalize_param(file, request)
    if @image.has_attribute?(:"#{Redactor3Rails.devise_user_key}")
      @image.send("#{Redactor3Rails.devise_user}=", redactor3_current_user)
      @image.assetable = redactor3_current_user
    end

    if @image.save
      render json: { filekey: { id: @image.id, url: @image.url(:content) } }
    else
      render json: { error: @image.errors }
    end
  end


  def list
    images = Redactor3Rails.image_model.order(created_at: :desc).all
    images_array = images.to_a.map do |f|
      { thumb: f.data.url(:thumb),
        url: f.data.url,
        id: f.id,
        title: f.data_file_name
      }
    end
    render json: images_array.to_json
  end

  private

  def redactor3_authenticate_user!
    if Redactor3Rails.image_model.new.has_attribute?(Redactor3Rails.devise_user)
      super
    end
  end
end
