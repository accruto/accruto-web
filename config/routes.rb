Accruto::Application.routes.draw do

  devise_for :users, controllers: {registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks'}

  get 'api/jobs', format: :xml
  get 'users/preference'
  post 'users/update_preference' , as: 'preferences'
  put 'users/update_preference' , as: 'preference'
  get 'users/applications'
  get 'users/edit_profile'

  get 'profile/show', to: 'candidates#show', as: 'show_profile'
  get 'profile/edit', to: 'candidates#edit', as: 'edit_profile'
  put 'profile/update', to: 'candidates#update', as: 'update_profile'
  get 'profile/create', to: 'candidates#create', as: 'create_profile'
  get 'profile/publish', to: 'candidates#publish', as: 'publish_profile'
  get 'profile/unpublish', to: 'candidates#unpublish', as: 'unpublish_profile'
  get 'profile/activation/:auth_token', to: 'candidates#edit'
  get '/candidates/search_job_categories', to: 'candidates#search_job_categories', as: 'search_job_categories'

  match '/delayed_job' => DelayedJobWeb, :anchor => false

  get 'jobs/category/:category', to: 'jobs#search'
  get '/candidate_search/signup', to: 'candidate_search_beta_users#signup', as: 'candidate_search_signup'

  get '/invited/:invite_email', to: 'pages#home', :constraints => { :invite_email => /[^\/]+/ }

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
	  	get ':job_id/apply', to: 'job_applications#new', as: 'apply'
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

  resources :invites

  namespace :admin do
  	resources :jobs
    #resources :job_categories
    #resources :job_subcategories
    resources :referral_sites
    resources :candidates do
      collection do
        get 'csv'
      end
    end
    resources :bounties
    root :to => 'pages#dashboard'
  end

  get 'pages/stylesheet'
  get 'pages/modal_apply'
  get 'pages/modal_signup'
  get 'pages/modal_email_alert'
  get 'pages/home'
  get 'pages/home_new'
  get '/about', to: 'pages#about'
  get '/faq', to: 'pages#faq'
  get '/privacy', to: 'pages#privacy'
  get '/terms', to: 'pages#terms'
  get '/contact', to: 'pages#contact'
  post 'pages/send_contact_form'
  get 'users/csv', to: 'users#csv'
  post 'users/download_csv', to: 'users#download_csv'

  root :to => 'pages#home'
end
#== Route Map
# Generated on 14 Oct 2013 14:51
#
#             user_session POST     /users/sign_in(.:format)                          devise/sessions#create
#     destroy_user_session DELETE   /users/sign_out(.:format)                         devise/sessions#destroy
#  user_omniauth_authorize GET|POST /users/auth/:provider(.:format)                   omniauth_callbacks#passthru {:provider=>/linkedin/}
#   user_omniauth_callback GET|POST /users/auth/:action/callback(.:format)            omniauth_callbacks#(?-mix:linkedin)
#            user_password POST     /users/password(.:format)                         devise/passwords#create
#        new_user_password GET      /users/password/new(.:format)                     devise/passwords#new
#       edit_user_password GET      /users/password/edit(.:format)                    devise/passwords#edit
#                          PUT      /users/password(.:format)                         devise/passwords#update
# cancel_user_registration GET      /users/cancel(.:format)                           registrations#cancel
#        user_registration POST     /users(.:format)                                  registrations#create
#    new_user_registration GET      /users/sign_up(.:format)                          registrations#new
#   edit_user_registration GET      /users/edit(.:format)                             registrations#edit
#                          PUT      /users(.:format)                                  registrations#update
#                          DELETE   /users(.:format)                                  registrations#destroy
#                 api_jobs GET      /api/jobs(.:format)                               api#jobs {:format=>:xml}
#         users_preference GET      /users/preference(.:format)                       users#preference
#              preferences POST     /users/update_preference(.:format)                users#update_preference
#               preference PUT      /users/update_preference(.:format)                users#update_preference
#       users_applications GET      /users/applications(.:format)                     users#applications
#       users_edit_profile GET      /users/edit_profile(.:format)                     users#edit_profile
#             show_profile GET      /profile/show(.:format)                           candidates#show
#             edit_profile GET      /profile/edit(.:format)                           candidates#edit
#           update_profile PUT      /profile/update(.:format)                         candidates#update
#           create_profile GET      /profile/create(.:format)                         candidates#create
#          publish_profile GET      /profile/publish(.:format)                        candidates#publish
#        unpublish_profile GET      /profile/unpublish(.:format)                      candidates#unpublish
#                          GET      /profile/activation/:auth_token(.:format)         candidates#edit
#    search_job_categories GET      /candidates/search_job_categories(.:format)       candidates#search_job_categories
#              delayed_job          /delayed_job(.:format)                            DelayedJobWeb
#                          GET      /jobs/category/:category(.:format)                jobs#search
#  candidate_search_signup GET      /candidate_search/signup(.:format)                candidate_search_beta_users#signup
#                          GET      /invited/:invite_email(.:format)                  pages#home {:invite_email=>/[^\/]+/}
#     job_job_applications GET      /jobs/:job_id/job_applications(.:format)          job_applications#index
#                          POST     /jobs/:job_id/job_applications(.:format)          job_applications#create
#  new_job_job_application GET      /jobs/:job_id/job_applications/new(.:format)      job_applications#new
# edit_job_job_application GET      /jobs/:job_id/job_applications/:id/edit(.:format) job_applications#edit
#      job_job_application GET      /jobs/:job_id/job_applications/:id(.:format)      job_applications#show
#                          PUT      /jobs/:job_id/job_applications/:id(.:format)      job_applications#update
#                          DELETE   /jobs/:job_id/job_applications/:id(.:format)      job_applications#destroy
#    add_to_favourite_jobs POST     /jobs/add_to_favourite(.:format)                  jobs#add_to_favourite
#    remove_favourite_jobs POST     /jobs/remove_favourite(.:format)                  jobs#remove_favourite
#       set_job_alert_jobs POST     /jobs/set_job_alert(.:format)                     jobs#set_job_alert
#      clear_searches_jobs DELETE   /jobs/clear_searches(.:format)                    jobs#clear_searches
#    clear_favourites_jobs DELETE   /jobs/clear_favourites(.:format)                  jobs#clear_favourites
#              search_jobs GET      /jobs/search(.:format)                            jobs#search
#               apply_jobs GET      /jobs/:job_id/apply(.:format)                     job_applications#new
#           shortlist_jobs GET      /jobs/shortlist(.:format)                         jobs#shortlist
#                list_jobs GET      /jobs/list(.:format)                              jobs#list
#            location_jobs GET      /jobs/location(.:format)                          jobs#location
#                     jobs GET      /jobs(.:format)                                   jobs#index
#                          POST     /jobs(.:format)                                   jobs#create
#                  new_job GET      /jobs/new(.:format)                               jobs#new
#                 edit_job GET      /jobs/:id/edit(.:format)                          jobs#edit
#                      job GET      /jobs/:id(.:format)                               jobs#show
#                          PUT      /jobs/:id(.:format)                               jobs#update
#                          DELETE   /jobs/:id(.:format)                               jobs#destroy
#           job_categories GET      /job_categories(.:format)                         job_categories#index
#                          POST     /job_categories(.:format)                         job_categories#create
#         new_job_category GET      /job_categories/new(.:format)                     job_categories#new
#        edit_job_category GET      /job_categories/:id/edit(.:format)                job_categories#edit
#             job_category GET      /job_categories/:id(.:format)                     job_categories#show
#                          PUT      /job_categories/:id(.:format)                     job_categories#update
#                          DELETE   /job_categories/:id(.:format)                     job_categories#destroy
#        job_subcategories GET      /job_subcategories(.:format)                      job_subcategories#index
#                          POST     /job_subcategories(.:format)                      job_subcategories#create
#      new_job_subcategory GET      /job_subcategories/new(.:format)                  job_subcategories#new
#     edit_job_subcategory GET      /job_subcategories/:id/edit(.:format)             job_subcategories#edit
#          job_subcategory GET      /job_subcategories/:id(.:format)                  job_subcategories#show
#                          PUT      /job_subcategories/:id(.:format)                  job_subcategories#update
#                          DELETE   /job_subcategories/:id(.:format)                  job_subcategories#destroy
#                  resumes GET      /resumes(.:format)                                resumes#index
#                          POST     /resumes(.:format)                                resumes#create
#               new_resume GET      /resumes/new(.:format)                            resumes#new
#              edit_resume GET      /resumes/:id/edit(.:format)                       resumes#edit
#                   resume GET      /resumes/:id(.:format)                            resumes#show
#                          PUT      /resumes/:id(.:format)                            resumes#update
#                          DELETE   /resumes/:id(.:format)                            resumes#destroy
#        search_candidates GET      /candidates/search(.:format)                      candidates#search
#               candidates GET      /candidates(.:format)                             candidates#index
#                          POST     /candidates(.:format)                             candidates#create
#            new_candidate GET      /candidates/new(.:format)                         candidates#new
#           edit_candidate GET      /candidates/:id/edit(.:format)                    candidates#edit
#                candidate GET      /candidates/:id(.:format)                         candidates#show
#                          PUT      /candidates/:id(.:format)                         candidates#update
#                          DELETE   /candidates/:id(.:format)                         candidates#destroy
#                  invites GET      /invites(.:format)                                invites#index
#                          POST     /invites(.:format)                                invites#create
#               new_invite GET      /invites/new(.:format)                            invites#new
#              edit_invite GET      /invites/:id/edit(.:format)                       invites#edit
#                   invite GET      /invites/:id(.:format)                            invites#show
#                          PUT      /invites/:id(.:format)                            invites#update
#                          DELETE   /invites/:id(.:format)                            invites#destroy
#               admin_jobs GET      /admin/jobs(.:format)                             admin/jobs#index
#                          POST     /admin/jobs(.:format)                             admin/jobs#create
#            new_admin_job GET      /admin/jobs/new(.:format)                         admin/jobs#new
#           edit_admin_job GET      /admin/jobs/:id/edit(.:format)                    admin/jobs#edit
#                admin_job GET      /admin/jobs/:id(.:format)                         admin/jobs#show
#                          PUT      /admin/jobs/:id(.:format)                         admin/jobs#update
#                          DELETE   /admin/jobs/:id(.:format)                         admin/jobs#destroy
#     admin_referral_sites GET      /admin/referral_sites(.:format)                   admin/referral_sites#index
#                          POST     /admin/referral_sites(.:format)                   admin/referral_sites#create
#  new_admin_referral_site GET      /admin/referral_sites/new(.:format)               admin/referral_sites#new
# edit_admin_referral_site GET      /admin/referral_sites/:id/edit(.:format)          admin/referral_sites#edit
#      admin_referral_site GET      /admin/referral_sites/:id(.:format)               admin/referral_sites#show
#                          PUT      /admin/referral_sites/:id(.:format)               admin/referral_sites#update
#                          DELETE   /admin/referral_sites/:id(.:format)               admin/referral_sites#destroy
#         admin_candidates GET      /admin/candidates(.:format)                       admin/candidates#index
#                          POST     /admin/candidates(.:format)                       admin/candidates#create
#      new_admin_candidate GET      /admin/candidates/new(.:format)                   admin/candidates#new
#     edit_admin_candidate GET      /admin/candidates/:id/edit(.:format)              admin/candidates#edit
#          admin_candidate GET      /admin/candidates/:id(.:format)                   admin/candidates#show
#                          PUT      /admin/candidates/:id(.:format)                   admin/candidates#update
#                          DELETE   /admin/candidates/:id(.:format)                   admin/candidates#destroy
#           admin_bounties GET      /admin/bounties(.:format)                         admin/bounties#index
#                          POST     /admin/bounties(.:format)                         admin/bounties#create
#         new_admin_bounty GET      /admin/bounties/new(.:format)                     admin/bounties#new
#        edit_admin_bounty GET      /admin/bounties/:id/edit(.:format)                admin/bounties#edit
#             admin_bounty GET      /admin/bounties/:id(.:format)                     admin/bounties#show
#                          PUT      /admin/bounties/:id(.:format)                     admin/bounties#update
#                          DELETE   /admin/bounties/:id(.:format)                     admin/bounties#destroy
#               admin_root          /admin(.:format)                                  admin/pages#dashboard
#         pages_stylesheet GET      /pages/stylesheet(.:format)                       pages#stylesheet
#        pages_modal_apply GET      /pages/modal_apply(.:format)                      pages#modal_apply
#       pages_modal_signup GET      /pages/modal_signup(.:format)                     pages#modal_signup
#  pages_modal_email_alert GET      /pages/modal_email_alert(.:format)                pages#modal_email_alert
#               pages_home GET      /pages/home(.:format)                             pages#home
#           pages_home_new GET      /pages/home_new(.:format)                         pages#home_new
#                    about GET      /about(.:format)                                  pages#about
#                      faq GET      /faq(.:format)                                    pages#faq
#                  privacy GET      /privacy(.:format)                                pages#privacy
#                    terms GET      /terms(.:format)                                  pages#terms
#                  contact GET      /contact(.:format)                                pages#contact
#  pages_send_contact_form POST     /pages/send_contact_form(.:format)                pages#send_contact_form
#              users_index GET      /users/index(.:format)                            users#index
#                     root          /                                                 pages#home
