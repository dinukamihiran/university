class WelcomeController < ApplicationController 
  def index
   #redirect_to new_user_session_path
   if current_user   
     redirect_to main_page_index_path, :notice => "Successfully Login!"
    
   else
     redirect_to new_user_session_path
   end
  end
end
