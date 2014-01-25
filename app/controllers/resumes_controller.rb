class ResumesController < ApplicationController
   before_filter :authenticate_user!
   helper_method :sort_column, :sort_direction
   
   def index
  #@resume = Resume.all
    
       if params[:lev].blank? || params[:sem].blank?
        $level = params[:q][:lev] 
        $semester = params[:q][:sem]
       else 
        $level = params[:lev] 
        $semester = params[:sem]
       end	   
	    @resumes = Resume.where("level = :level and semester = :semester" ,  level: $level, semester: $semester ).order("created_at DESC")
#@resumes = Resume.select("resumes.level, resumes.semester, resumes.name ,  " ).joins("LEFT OUTER JOIN subjects ON subjects.id = resumes.subject_name")		
       	@resumes = @resumes.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => $data_per_page)  
		 #@resumes = Resume.all
		  
		   @search = @resumes.search(params[:q])
           @resumes = @search.result
		 
  end

  def new
   @resume = Resume.new
  end

def create
    
@resume = Resume.new(params[:resume].permit(:level, :semester,:name, :subject_id,  :attachment, :user_id))

    if @resume.save
      redirect_to resumes_path(:lev => @resume.level , :sem=> @resume.semester) , notice: "The resume #{@resume.name} has been uploaded."
    else
      #redirect_to new_resume_path(:level => $level , :semester=> $semester) and return unless Resume.valid?
       render 'new'
	end
  end


  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path(:lev => $level , :sem=> $semester), notice:  "The resume #{@resume.name} has been deleted."
  end
  
  def select_level  
  end
  def select_semester 
   
  end
  
  private
  
   def sort_column
    Resume.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
end
