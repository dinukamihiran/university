class MainPageController < ApplicationController
 before_filter :authenticate_user!
  def index
   session[:dinuka]= current_user.full_name #session variable eka test kranna. not relevent to the site
  end
  
  def contact  
  end
  
  def about
  end
  
  def privacy
  end
  
  def help
  end
  
  def terms
  end
end
