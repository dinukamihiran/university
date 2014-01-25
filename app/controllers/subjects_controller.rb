class SubjectsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @subjects = Subject.where("lower(name) like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
     # format.json { render :json => @subjects.map(&:attributes) }
	  format.json { render :json => @subjects.map{|t| {:id => t.id, :name => t.name << ' - ' << t.subject_code }}}
   
   end
  end

  def new
  
  end
end
