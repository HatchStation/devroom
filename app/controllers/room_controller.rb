class RoomController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.only(:name, :online, :id).all
    @conversations = current_user.conversations
  end

  def start_conversation
    # Get the user the current_user wants to converse with
    second_user = User.find(params[:id])
    return unless second_user

    # Create conversation and add both as participants
    @conversation = Conversation.new
    @conversation.users = [current_user, second_user]
    if @conversation.save
      render
    else
    end
  end

  def new_message
    @conversation = Conversation.find(params[:id])
    return unless @conversation

    @message = Message.new(conversation: @conversation, user: current_user, text: params[:message][:text])
    if @message.save
      render
    else
    end

  end

end
