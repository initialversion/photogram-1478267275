class PhotosController < ApplicationController
  before_action :current_user_must_be_photo_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_photo_user
    photo = Photo.find(params[:id])

    unless current_user == photo.owner
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @photos = current_user.posted_photos.page(params[:page])
  end

  def show
    @comment = Comment.new
    @vote = Vote.new
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new
    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.owner_id = params[:owner_id]

    if @photo.save
      redirect_to "/photos", :notice => "Photo created successfully."
    else
      render 'new'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])

    @photo.caption = params[:caption]
    @photo.image = params[:image]
    @photo.owner_id = params[:owner_id]

    if @photo.save
      redirect_to "/photos", :notice => "Photo updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    @photo.destroy

    redirect_to "/photos", :notice => "Photo deleted."
  end
end
