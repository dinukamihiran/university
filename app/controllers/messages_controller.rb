class MessagesController < ApplicationController 
 before_filter :authenticate_user!
 def index
  @mes1 = 0
  @mes_receiver = Array.new
  
  if params[:page] == "1"  
    $no_of_receivers = 0
  else
    $no_of_receivers = $data_per_page*(params[:page].to_i-1)
  end
  
  if params[:type].blank?
    $type = params[:q][:type]
  else
    $type = params[:type]
  end
   	  
    if $type == "in"
	  @messages = Message.where("receiver_id = :login_user ", login_user: "#{current_user.id}").order("created_at DESC")
	  
	elsif $type == "out"
	  @messages = Message.where("user_id = :login_user ", login_user: "#{current_user.id}").order("created_at DESC")
	  #@messages.each do |m|
	    # @receipient[$mes] = User.where("id = :receiver ", receiver: "#{m.user_id}")
		# $mes = $mes + 1
	  #end 
	  
	  @messages.each do |message_receiver|
		  @mes_receiver[@mes1] = User.find(message_receiver.receiver_id)		  
		  #@mes[$mes1] = User.select(:id).distinct.where("receiver_id != :log_user" , log_user: "#{current_user.id}")
		  #@mes = User.find(1)
		  @mes1 = @mes1 + 1
	  end 
	       
	else
	  redirect_to messages_select_inbox_outbox_path, notice: "Something wrong"
    end
	 @messages = @messages.paginate(:page => params[:page], :per_page => $data_per_page)  
		  
	  $stable = 0
	 @search = @messages.search(params[:q]) 
	 
	 if $type == "in"
	    if !@search.blank? and !params[:q].blank? and !params[:q][:user_id_eq].blank?
			  #$us = User.find(params[:q][:receiver_id_eq])
			  $us = User.where("id = :pa ", pa: "#{params[:q][:user_id_eq]}")
			  if $us.blank?
			   redirect_to messages_path(:type => $type, :page => 1), notice: "Cannot find user" #this cannot happen.because get users from token input
			   end
			  $stable = 1
			 end
	 else
	 
			 if !@search.blank? and !params[:q].blank? and !params[:q][:receiver_id_eq].blank?
			  #$us = User.find(params[:q][:receiver_id_eq])
			  $us = User.where("id = :pa ", pa: "#{params[:q][:receiver_id_eq]}")
			  if $us.blank?
			   redirect_to messages_path(:type => $type, :page => 1), notice: "Cannot find user" #this cannot happen.because get users from token input
			   end
			  $stable = 1
			 end
	 end		 
			 @messages = @search.result 
	 
	 
	 
	 
	 
		#@messages.each do |se|
		  
		  #@me = @messages.joins(:user)
			 
	      #end
 end
 
 def reply_to_message
  @rep = 0
 
  $selected_message_id = params[:message_id]
  $selected_message_array_id = params[:message_array_id]
  
  @message_start = Message.find($selected_message_id)
  $selected_message_start_user = User.find(@message_start.user_id)
  
  @responses = Response.where("message_id = :selected_message_id", selected_message_id: $selected_message_id)
 	  
	  
 end
 
 def send_message
 
   if params[:new_message][:message_content].blank? || params[:new_message][:receiver_id].blank?
     redirect_to messages_path(:type => $type, :page => 1), alert: "Please enter both receipient and the message"
   else
	   @message = Message.new(params[:new_message].permit(:message_content, :user_id, :receiver_id))
	   if @message.save
		 redirect_to messages_path(:type => $type, :page => 1), notice: "Your message has been send"
	   else
		 redirect_to messages_path(:type => $type, :page => 1), notice: "Something wrong"
	   end
	end
 end
 
  def delete_message
		@message = Message.find(params[:id])
		@message.destroy
		redirect_to messages_path(:type => $type) , notice:  "Your message has been deleted."
  end
  
  def delete_response
		@response = Response.find(params[:id])
		@response.destroy
		redirect_to messages_reply_to_message_path( :message_id => $selected_message_id) , notice:  "Your response has been deleted."
  end
  
  def create_response
    if params[:response][:response_content].blank? 
     redirect_to messages_reply_to_message_path( :message_id => $selected_message_id), alert: "Please enter the reply"
   else
	   @response = Response.new(params[:response].permit(:response_content,:message_id, :user_id))
	   if @response.save
		 redirect_to messages_reply_to_message_path( :message_id => $selected_message_id), notice: "Your reply has been send"
	   else
		 redirect_to messages_reply_to_message_path( :message_id => $selected_message_id), notice: "Something wrong"
	   end
	end
  
  end
end
