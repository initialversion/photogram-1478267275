class CommentsController < ApplicationController
  before_action :current_user_must_be_comment_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_comment_user
    comment = Comment.find(params[:id])

    unless current_user == comment.commenter
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @comments = current_user.comments.page(params[:page])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new
    @comment.commenter_id = params[:commenter_id]
    @comment.photo_id = params[:photo_id]
    @comment.body = params[:body]

    if @comment.save
      redirect_to "/comments", :notice => "Comment created successfully."
    else
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    @comment.commenter_id = params[:commenter_id]
    @comment.photo_id = params[:photo_id]
    @comment.body = params[:body]

    if @comment.save
      redirect_to "/comments", :notice => "Comment updated successfully."
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    @comment.destroy

    redirect_to "/comments", :notice => "Comment deleted."
  end
end
