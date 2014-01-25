class StatusesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
     
   #@statuses = Status.where("user_id = :current_login_user ",  current_login_user: "#{current_user.id}")
   @status = Status.new
   
   #@followed_status = Relationship.where("follower_id = :login_user ", login_user: "#{current_user.id}")
   
   #@followed_status.each do |follow|      
		# @buddies_posts = Status.find_by_user_id(@followed_status.followed_id)
		# $count = $count + 1
	 
 # end
        buddies_ids = current_user.followeds.map(&:id).push(current_user.id)
        @ribbits = Status.find_all_by_user_id buddies_ids
   
   
   
   #render text: @buddies_posts[0][:id].inspect
    
  end
   
   def find_user
     @search_user = User.find(params[:search_user][:user_id])
	 redirect_to statuses_user_profile_path(:user_id => @search_user.id)
   end
   
   def user_profile
    @relation = Array.new
     $user_status_name = User.find(params[:user_id])
     @user_statuses = Status.where("user_id = :request_user ", request_user: "#{params[:user_id]}")
	 
	 @relation = Relationship.where("follower_id = :login_user and followed_id = :requested_user " , login_user: "#{current_user.id}" , requested_user: "#{params[:user_id]}")
     #$relation_id = @relation.followed_id
	 #if !@relation.blank?
	 # render text: @relation[0][:id].inspect
	 #end
   end
   
   def relationships_create 
	  if params[:follow][:command] == "follow"
		  @follow = Relationship.new(params[:follow].permit(:follower_id,:followed_id))
		  if @follow.save
			redirect_to statuses_path , notice: "Now you follow the #{$user_status_name.full_name} "
		  else
			redirect_to statuses_path , notice: "something wrong"
		  end
	  elsif params[:follow][:command] == "unfollow"
	   # @delete_follow_relationship = Relationship.where("follower_id = :login_user and followed_id = :requested_user " , login_user: "#{current_user.id}" , requested_user: "#{params[:follow][:followed_id]}")
        @delete_follow_relationship = Relationship.find(params[:follow][:follow_id])
		@delete_follow_relationship.destroy
		redirect_to statuses_user_profile_path(:user_id => params[:follow][:followed_id]) , notice: "Now you are not follow the #{$user_status_name.full_name} "
	  else	  
	  end
   end
  
  def create
    if params[:status][:status_content].blank?
	  redirect_to statuses_path , alert: "Status content cannot be blank" 
	else
	   @status = Status.new(params[:status].permit(:status_content,:user_id))
	   if @status.save
		 redirect_to statuses_path , notice: "Status updated"
	   else
		redirect_to statuses_path , notice: "Something wrong" 
	   end
	end
  end
  
  def destroy
   @status = Status.find(params[:id])
   @status.destroy
   redirect_to statuses_path , notice: "status is deleted" 
  end
  
  
end
