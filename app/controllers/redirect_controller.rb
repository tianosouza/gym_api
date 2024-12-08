class RedirectController < ApplicationController
  def video
    video_file = ActiveStorage::Blob.find_by(filename: params[:filename])
    if video_file
      redirect_to rails_blob_url(video_file, host: "http://localhost:4000")
    else
      render plain: "File not found", status: :not_found
    end
  end

  def image
    image_file = ActiveStorage::Blob.find_by(filename: params[:filename])
    if image_file
      redirect_to rails_blob_url(image_file, host: "http://localhost:4000")
    else
      render plain: "File not found", status: :not_found
    end
  end
end
