Accruto::Application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false

  devise_for :users

  get "jobs/category/:category", to: "jobs#search"

  resources :jobs do
  	collection do
	  	## GET
      get 'search'
	  	get 'apply'
      get 'favourites'
      ## POST
      post 'add_to_favourite'
      post 'remove_favourite'
      post 'set_job_alert'
      ## DELETE
      delete 'clear_searches'
      delete 'clear_favourites'
	  end
  end

  resources :job_categories

  resources :job_subcategories do
  end

  namespace :admin do
  	resources :jobs
  	resources :job_categories
  	resources :job_subcategories
  end

  get "pages/stylesheet"
  get "pages/home"
  get "pages/about"
  get "pages/faq"
  get "pages/contact"

  root :to => 'pages#home'
end
#== Route Map
# Generated on 12 Aug 2013 11:41
#
#               user_session POST   /users/sign_in(.:format)                    devise/sessions#create
#       destroy_user_session DELETE /users/sign_out(.:format)                   devise/sessions#destroy
#              user_password POST   /users/password(.:format)                   devise/passwords#create
#          new_user_password GET    /users/password/new(.:format)               devise/passwords#new
#         edit_user_password GET    /users/password/edit(.:format)              devise/passwords#edit
#                            PUT    /users/password(.:format)                   devise/passwords#update
#   cancel_user_registration GET    /users/cancel(.:format)                     devise/registrations#cancel
#          user_registration POST   /users(.:format)                            devise/registrations#create
#      new_user_registration GET    /users/sign_up(.:format)                    devise/registrations#new
#     edit_user_registration GET    /users/edit(.:format)                       devise/registrations#edit
#                            PUT    /users(.:format)                            devise/registrations#update
#                            DELETE /users(.:format)                            devise/registrations#destroy
#                            GET    /jobs/category/:category(.:format)          jobs#search
#                search_jobs GET    /jobs/search(.:format)                      jobs#search
#                       jobs GET    /jobs(.:format)                             jobs#index
#                            POST   /jobs(.:format)                             jobs#create
#                    new_job GET    /jobs/new(.:format)                         jobs#new
#                   edit_job GET    /jobs/:id/edit(.:format)                    jobs#edit
#                        job GET    /jobs/:id(.:format)                         jobs#show
#                            PUT    /jobs/:id(.:format)                         jobs#update
#                            DELETE /jobs/:id(.:format)                         jobs#destroy
#             job_categories GET    /job_categories(.:format)                   job_categories#index
#                            POST   /job_categories(.:format)                   job_categories#create
#           new_job_category GET    /job_categories/new(.:format)               job_categories#new
#          edit_job_category GET    /job_categories/:id/edit(.:format)          job_categories#edit
#               job_category GET    /job_categories/:id(.:format)               job_categories#show
#                            PUT    /job_categories/:id(.:format)               job_categories#update
#                            DELETE /job_categories/:id(.:format)               job_categories#destroy
#          job_subcategories GET    /job_subcategories(.:format)                job_subcategories#index
#                            POST   /job_subcategories(.:format)                job_subcategories#create
#        new_job_subcategory GET    /job_subcategories/new(.:format)            job_subcategories#new
#       edit_job_subcategory GET    /job_subcategories/:id/edit(.:format)       job_subcategories#edit
#            job_subcategory GET    /job_subcategories/:id(.:format)            job_subcategories#show
#                            PUT    /job_subcategories/:id(.:format)            job_subcategories#update
#                            DELETE /job_subcategories/:id(.:format)            job_subcategories#destroy
#                 admin_jobs GET    /admin/jobs(.:format)                       admin/jobs#index
#                            POST   /admin/jobs(.:format)                       admin/jobs#create
#              new_admin_job GET    /admin/jobs/new(.:format)                   admin/jobs#new
#             edit_admin_job GET    /admin/jobs/:id/edit(.:format)              admin/jobs#edit
#                  admin_job GET    /admin/jobs/:id(.:format)                   admin/jobs#show
#                            PUT    /admin/jobs/:id(.:format)                   admin/jobs#update
#                            DELETE /admin/jobs/:id(.:format)                   admin/jobs#destroy
#       admin_job_categories GET    /admin/job_categories(.:format)             admin/job_categories#index
#                            POST   /admin/job_categories(.:format)             admin/job_categories#create
#     new_admin_job_category GET    /admin/job_categories/new(.:format)         admin/job_categories#new
#    edit_admin_job_category GET    /admin/job_categories/:id/edit(.:format)    admin/job_categories#edit
#         admin_job_category GET    /admin/job_categories/:id(.:format)         admin/job_categories#show
#                            PUT    /admin/job_categories/:id(.:format)         admin/job_categories#update
#                            DELETE /admin/job_categories/:id(.:format)         admin/job_categories#destroy
#    admin_job_subcategories GET    /admin/job_subcategories(.:format)          admin/job_subcategories#index
#                            POST   /admin/job_subcategories(.:format)          admin/job_subcategories#create
#  new_admin_job_subcategory GET    /admin/job_subcategories/new(.:format)      admin/job_subcategories#new
# edit_admin_job_subcategory GET    /admin/job_subcategories/:id/edit(.:format) admin/job_subcategories#edit
#      admin_job_subcategory GET    /admin/job_subcategories/:id(.:format)      admin/job_subcategories#show
#                            PUT    /admin/job_subcategories/:id(.:format)      admin/job_subcategories#update
#                            DELETE /admin/job_subcategories/:id(.:format)      admin/job_subcategories#destroy
#           pages_stylesheet GET    /pages/stylesheet(.:format)                 pages#stylesheet
#                 pages_home GET    /pages/home(.:format)                       pages#home
#                pages_about GET    /pages/about(.:format)                      pages#about
#                  pages_faq GET    /pages/faq(.:format)                        pages#faq
#              pages_contact GET    /pages/contact(.:format)                    pages#contact
#                       root        /                                           pages#home
