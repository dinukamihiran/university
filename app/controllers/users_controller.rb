class UsersController < ApplicationController
 before_filter :authenticate_user!
 def index
    @users = User.where("lower(full_name) like :accept and id != :login_user", accept: "%#{params[:q]}%" , login_user: current_user.id)
    respond_to do |format|
      format.html
     # format.json { render :json => @subjects.map(&:attributes) }
	  format.json { render :json => @users.map{|t| {:id => t.id, :name => t.username << ' - ' << t.full_name }}}
    end
   end
end
