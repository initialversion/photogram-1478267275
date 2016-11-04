class FriendRequestsController < ApplicationController
  before_action :current_user_must_be_friend_request_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_friend_request_user
    friend_request = FriendRequest.find(params[:id])

    unless current_user == friend_request.sender
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @friend_requests = current_user.sent_friend_requests.page(params[:page])
  end

  def show
    @friend_request = FriendRequest.find(params[:id])
  end

  def new
    @friend_request = FriendRequest.new
  end

  def create
    @friend_request = FriendRequest.new
    @friend_request.sender_id = params[:sender_id]
    @friend_request.recipient_id = params[:recipient_id]
    @friend_request.status = params[:status]

    if @friend_request.save
      redirect_to "/friend_requests", :notice => "Friend request created successfully."
    else
      render 'new'
    end
  end

  def edit
    @friend_request = FriendRequest.find(params[:id])
  end

  def update
    @friend_request = FriendRequest.find(params[:id])

    @friend_request.sender_id = params[:sender_id]
    @friend_request.recipient_id = params[:recipient_id]
    @friend_request.status = params[:status]

    if @friend_request.save
      redirect_to "/friend_requests", :notice => "Friend request updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])

    @friend_request.destroy

    redirect_to "/friend_requests", :notice => "Friend request deleted."
  end
end
