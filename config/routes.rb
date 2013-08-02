Accruto::Application.routes.draw do
  resources :jobs do
  	get 'search', on: :collection, as: 'search'
  end

  resources :job_categories

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
# Generated on 01 Aug 2013 16:03
#
#             jobs GET    /jobs(.:format)                jobs#index
#                  POST   /jobs(.:format)                jobs#create
#          new_job GET    /jobs/new(.:format)            jobs#new
#         edit_job GET    /jobs/:id/edit(.:format)       jobs#edit
#              job GET    /jobs/:id(.:format)            jobs#show
#                  PUT    /jobs/:id(.:format)            jobs#update
#                  DELETE /jobs/:id(.:format)            jobs#destroy
#       admin_jobs GET    /admin/jobs(.:format)          admin/jobs#index
#                  POST   /admin/jobs(.:format)          admin/jobs#create
#    new_admin_job GET    /admin/jobs/new(.:format)      admin/jobs#new
#   edit_admin_job GET    /admin/jobs/:id/edit(.:format) admin/jobs#edit
#        admin_job GET    /admin/jobs/:id(.:format)      admin/jobs#show
#                  PUT    /admin/jobs/:id(.:format)      admin/jobs#update
#                  DELETE /admin/jobs/:id(.:format)      admin/jobs#destroy
# pages_stylesheet GET    /pages/stylesheet(.:format)    pages#stylesheet
#       pages_home GET    /pages/home(.:format)          pages#home
#      pages_about GET    /pages/about(.:format)         pages#about
#        pages_faq GET    /pages/faq(.:format)           pages#faq
#    pages_contact GET    /pages/contact(.:format)       pages#contact
#             root        /                              pages#home
