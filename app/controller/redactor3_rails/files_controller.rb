class Redactor3Rails::FilesController < ApplicationController
  before_action :redactor3_authenticate_user!

  def create
    @file = Redactor3Rails.file_model.new

    file = Array.wrap(params[:file]).first
    @file.data = Redactor3Rails::Http.normalize_param(file, request)
    if @file.has_attribute?(:"#{Redactor3Rails.devise_user_key}")
      @file.send("#{Redactor3Rails.devise_user}=", redactor3_current_user)
      @file.assetable = redactor3_current_user
    end

    if @file.save
      render json: { filekey: { id: @file.id, url: @file.data.url } }
    else
      render json: { error: @file.errors }
    end
  end

  private

  def redactor3_authenticate_user!
    if Redactor3Rails.file_model.new.has_attribute?(Redactor3Rails.devise_user)
      super
    end
  end
end
