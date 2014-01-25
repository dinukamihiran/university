Univesity::Application.routes.draw do
   
  get "main_page/index"
  get "main_page/contact"
  get "main_page/about"
  get "main_page/privacy"
  get "main_page/help"
  get "main_page/terms"
  
  
  post 'gpa/display_gpa' 
  get 'gpa/calculate_gpa'
  get 'gpa/enter_level_semester'
  
  post 'gpa/add_subject'
  post 'gpa/remove_subject'  
  
  get 'resumes/select_semester'
  
  get 'questions/select_semester'
  get 'questions/select_subject'
  get 'questions/all_questions'
  get 'questions/all_answers'
   
  post 'questions/create_answer'
  post 'questions/create_reply'  
  
  delete 'questions/delete_reply'
  delete 'questions/delete_answer'
  delete 'questions/delete_question'
  
  get 'messages/reply_to_message'
  post 'messages/send_message'
  get 'messages/select_inbox_outbox'
  
  delete 'messages/delete_message'
  delete 'messages/delete_response'
  
  post 'messages/create_response' 
  
  post 'statuses/find_user'
  get 'statuses/user_profile'
  post 'statuses/relationships_create'
    
  devise_for :users
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root to: 'welcome#index'
 
   
     resources :questions do
		  resources :answers do
			resources :replies
		  end
     end
	 
    resources :subjects
    resources :resumes  
	
	resources :users 
	
		resources :messages do
		  resources :responses
		end
	 
    resources :statuses
	resources :relationships
  
  
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
