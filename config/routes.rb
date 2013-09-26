Accruto::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users


  get "api/jobs", format: :xml
  get "users/preference"
  get "users/applications"
  post "users/update_preference" , as: 'preferences'
  put "users/update_preference" , as: 'preference'

  match "/delayed_job" => DelayedJobWeb, :anchor => false

  get "jobs/category/:category", to: "jobs#search"
  get "/candidate_search/signup", to: "candidate_search_beta_users#signup", as: "candidate_search_signup"

  resources :jobs do
  	resources :job_applications
  	collection do
      ## POST
      post 'add_to_favourite'
      post 'remove_favourite'
      post 'set_job_alert'
      ## DELETE
      delete 'clear_searches'
      delete 'clear_favourites'
	  	## GET
      get 'search'
	  	get ':job_id/apply', to: "job_applications#new", as: "apply"
      get 'shortlist'
      get 'list'
      get 'location'
	  end
  end

  resources :job_categories
  resources :job_subcategories
  resources :resumes

  resources :candidates do
    collection do
      get 'search'
    end
  end

  # namespace :admin do
  # 	resources :jobs
  # 	resources :job_categories
  # 	resources :job_subcategories
  #   resources :referral_sites
  # end

  get "pages/stylesheet"
  get "pages/modal_apply"
  get "pages/modal_signup"
  get "pages/modal_email_alert"
  get "pages/home"
  get "/about", to: "pages#about"
  get "/faq", to: "pages#faq"
  get "/privacy", to: "pages#privacy"
  get "/terms", to: "pages#terms"
  get "/contact", to: "pages#contact"
  post "pages/send_contact_form"


  root :to => 'pages#home'
end
#== Route Map
# Generated on 29 Aug 2013 14:33
#
#           users_preference GET    /users/preference(.:format)                       users#preference
#         users_applications GET    /users/applications(.:format)                     users#applications
#                preferences POST   /users/update_preference(.:format)                users#update_preference
#                 preference PUT    /users/update_preference(.:format)                users#update_preference
#                delayed_job        /delayed_job(.:format)                            DelayedJobWeb
#           new_user_session GET    /users/sign_in(.:format)                          devise/sessions#new
#               user_session POST   /users/sign_in(.:format)                          devise/sessions#create
#       destroy_user_session DELETE /users/sign_out(.:format)                         devise/sessions#destroy
#              user_password POST   /users/password(.:format)                         devise/passwords#create
#          new_user_password GET    /users/password/new(.:format)                     devise/passwords#new
#         edit_user_password GET    /users/password/edit(.:format)                    devise/passwords#edit
#                            PUT    /users/password(.:format)                         devise/passwords#update
#   cancel_user_registration GET    /users/cancel(.:format)                           devise/registrations#cancel
#          user_registration POST   /users(.:format)                                  devise/registrations#create
#      new_user_registration GET    /users/sign_up(.:format)                          devise/registrations#new
#     edit_user_registration GET    /users/edit(.:format)                             devise/registrations#edit
#                            PUT    /users(.:format)                                  devise/registrations#update
#                            DELETE /users(.:format)                                  devise/registrations#destroy
#                            GET    /jobs/category/:category(.:format)                jobs#search
#       job_job_applications GET    /jobs/:job_id/job_applications(.:format)          job_applications#index
#                            POST   /jobs/:job_id/job_applications(.:format)          job_applications#create
#    new_job_job_application GET    /jobs/:job_id/job_applications/new(.:format)      job_applications#new
#   edit_job_job_application GET    /jobs/:job_id/job_applications/:id/edit(.:format) job_applications#edit
#        job_job_application GET    /jobs/:job_id/job_applications/:id(.:format)      job_applications#show
#                            PUT    /jobs/:job_id/job_applications/:id(.:format)      job_applications#update
#                            DELETE /jobs/:job_id/job_applications/:id(.:format)      job_applications#destroy
#                search_jobs GET    /jobs/search(.:format)                            jobs#search
#                 apply_jobs GET    /jobs/:job_id/apply(.:format)                     job_applications#new
#             shortlist_jobs GET    /jobs/shortlist(.:format)                         jobs#shortlist
#                  list_jobs GET    /jobs/list(.:format)                              jobs#list
#              location_jobs GET    /jobs/location(.:format)                          jobs#location
#      add_to_favourite_jobs POST   /jobs/add_to_favourite(.:format)                  jobs#add_to_favourite
#      remove_favourite_jobs POST   /jobs/remove_favourite(.:format)                  jobs#remove_favourite
#         set_job_alert_jobs POST   /jobs/set_job_alert(.:format)                     jobs#set_job_alert
#        clear_searches_jobs DELETE /jobs/clear_searches(.:format)                    jobs#clear_searches
#      clear_favourites_jobs DELETE /jobs/clear_favourites(.:format)                  jobs#clear_favourites
#                       jobs GET    /jobs(.:format)                                   jobs#index
#                            POST   /jobs(.:format)                                   jobs#create
#                    new_job GET    /jobs/new(.:format)                               jobs#new
#                   edit_job GET    /jobs/:id/edit(.:format)                          jobs#edit
#                        job GET    /jobs/:id(.:format)                               jobs#show
#                            PUT    /jobs/:id(.:format)                               jobs#update
#                            DELETE /jobs/:id(.:format)                               jobs#destroy
#             job_categories GET    /job_categories(.:format)                         job_categories#index
#                            POST   /job_categories(.:format)                         job_categories#create
#           new_job_category GET    /job_categories/new(.:format)                     job_categories#new
#          edit_job_category GET    /job_categories/:id/edit(.:format)                job_categories#edit
#               job_category GET    /job_categories/:id(.:format)                     job_categories#show
#                            PUT    /job_categories/:id(.:format)                     job_categories#update
#                            DELETE /job_categories/:id(.:format)                     job_categories#destroy
#          job_subcategories GET    /job_subcategories(.:format)                      job_subcategories#index
#                            POST   /job_subcategories(.:format)                      job_subcategories#create
#        new_job_subcategory GET    /job_subcategories/new(.:format)                  job_subcategories#new
#       edit_job_subcategory GET    /job_subcategories/:id/edit(.:format)             job_subcategories#edit
#            job_subcategory GET    /job_subcategories/:id(.:format)                  job_subcategories#show
#                            PUT    /job_subcategories/:id(.:format)                  job_subcategories#update
#                            DELETE /job_subcategories/:id(.:format)                  job_subcategories#destroy
#                 admin_jobs GET    /admin/jobs(.:format)                             admin/jobs#index
#                            POST   /admin/jobs(.:format)                             admin/jobs#create
#              new_admin_job GET    /admin/jobs/new(.:format)                         admin/jobs#new
#             edit_admin_job GET    /admin/jobs/:id/edit(.:format)                    admin/jobs#edit
#                  admin_job GET    /admin/jobs/:id(.:format)                         admin/jobs#show
#                            PUT    /admin/jobs/:id(.:format)                         admin/jobs#update
#                            DELETE /admin/jobs/:id(.:format)                         admin/jobs#destroy
#       admin_job_categories GET    /admin/job_categories(.:format)                   admin/job_categories#index
#                            POST   /admin/job_categories(.:format)                   admin/job_categories#create
#     new_admin_job_category GET    /admin/job_categories/new(.:format)               admin/job_categories#new
#    edit_admin_job_category GET    /admin/job_categories/:id/edit(.:format)          admin/job_categories#edit
#         admin_job_category GET    /admin/job_categories/:id(.:format)               admin/job_categories#show
#                            PUT    /admin/job_categories/:id(.:format)               admin/job_categories#update
#                            DELETE /admin/job_categories/:id(.:format)               admin/job_categories#destroy
#    admin_job_subcategories GET    /admin/job_subcategories(.:format)                admin/job_subcategories#index
#                            POST   /admin/job_subcategories(.:format)                admin/job_subcategories#create
#  new_admin_job_subcategory GET    /admin/job_subcategories/new(.:format)            admin/job_subcategories#new
# edit_admin_job_subcategory GET    /admin/job_subcategories/:id/edit(.:format)       admin/job_subcategories#edit
#      admin_job_subcategory GET    /admin/job_subcategories/:id(.:format)            admin/job_subcategories#show
#                            PUT    /admin/job_subcategories/:id(.:format)            admin/job_subcategories#update
#                            DELETE /admin/job_subcategories/:id(.:format)            admin/job_subcategories#destroy
#       admin_referral_sites GET    /admin/referral_sites(.:format)                   admin/referral_sites#index
#                            POST   /admin/referral_sites(.:format)                   admin/referral_sites#create
#    new_admin_referral_site GET    /admin/referral_sites/new(.:format)               admin/referral_sites#new
#   edit_admin_referral_site GET    /admin/referral_sites/:id/edit(.:format)          admin/referral_sites#edit
#        admin_referral_site GET    /admin/referral_sites/:id(.:format)               admin/referral_sites#show
#                            PUT    /admin/referral_sites/:id(.:format)               admin/referral_sites#update
#                            DELETE /admin/referral_sites/:id(.:format)               admin/referral_sites#destroy
#           pages_stylesheet GET    /pages/stylesheet(.:format)                       pages#stylesheet
#          pages_modal_apply GET    /pages/modal_apply(.:format)                      pages#modal_apply
#         pages_modal_signup GET    /pages/modal_signup(.:format)                     pages#modal_signup
#    pages_modal_email_alert GET    /pages/modal_email_alert(.:format)                pages#modal_email_alert
#                 pages_home GET    /pages/home(.:format)                             pages#home
#                      about GET    /about(.:format)                                  pages#about
#                        faq GET    /faq(.:format)                                    pages#faq
#                    privacy GET    /privacy(.:format)                                pages#privacy
#                      terms GET    /terms(.:format)                                  pages#terms
#                    contact GET    /contact(.:format)                                pages#contact
#    pages_send_contact_form POST   /pages/send_contact_form(.:format)                pages#send_contact_form
#                       root        /                                                 pages#home
