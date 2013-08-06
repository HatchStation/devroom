class RoomController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.only(:name, :online, :id).all
    @tasks = Task.all.asc(:resolved).desc(:created_at)
    @conversations = current_user.conversations
    update_user_list(true)
  end

  def start_conversation

    # There are 3 possible scenarios
    # 1.) General conversation b/w two persons and we create one and add both participants
    # 2.) Conversation on a task and we create one with both particpants with task assigned
    # 3.) Conversation is already present for a task and we just want to add a new participant to it

    # Get task if any. Cases 2 and 3
    if params[:task_id] != "0"
      task = Task.find(params[:task_id])
      
      # Case 3
      if task.conversation
        @case = 3
        @conversation = task.conversation
        @conversation.users << current_user
      # Case 2
      else
        @conversation = Conversation.new
        @conversation.task = task  
        second_user = User.find(params[:user_id])
        @conversation.users = [current_user, second_user]    
      end
    # Case 1
    else
      @conversation = Conversation.new
      second_user = User.find(params[:user_id])
      @conversation.users = [current_user, second_user]
    end
      
    if @conversation.save
      render
    else
      @error = @conversation.errors.full_messages.join(",")
      render "shared/error"
    end
  end

  def archive_conversation
    @conversation = Conversation.find(params[:id])
    @conversation.update_attributes(archived: true)
  end

  def new_task
    @task = Task.new
    @task.description =  params[:description]
    @task.user = current_user

    if @task.save
      render
    else
      @error = @task.errors.full_messages.join(",")
      render "shared/error"
    end
  end

  def new_message
    @conversation = Conversation.find(params[:id])
    return unless @conversation

    @message = Message.new(conversation: @conversation, user: current_user, text: params[:message][:text])
    if @message.save
      render
    else
      @error = @message.errors.full_messages.join(",")
      render "shared/error"
    end

  end

  def alive
    current_user.touch
    render text: "OK"    
  end

end
