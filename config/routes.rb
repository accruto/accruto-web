Accruto::Application.routes.draw do
  resources :jobs do
  	get 'search', on: :collection
  end


  get "pages/stylesheet"
  get "pages/home"
  get "pages/about"
  get "pages/faq"
  get "pages/contact"

  root :to => 'pages#home'
end
#== Route Map
# Generated on 25 Jul 2013 16:52
#
#                  POST   /jobs(.:format)             jobs#create
#          new_job GET    /jobs/new(.:format)         jobs#new
#         edit_job GET    /jobs/:id/edit(.:format)    jobs#edit
#              job GET    /jobs/:id(.:format)         jobs#show
#                  PUT    /jobs/:id(.:format)         jobs#update
#                  DELETE /jobs/:id(.:format)         jobs#destroy
# pages_stylesheet GET    /pages/stylesheet(.:format) pages#stylesheet
#       pages_home GET    /pages/home(.:format)       pages#home
#      pages_about GET    /pages/about(.:format)      pages#about
#        pages_faq GET    /pages/faq(.:format)        pages#faq
#    pages_contact GET    /pages/contact(.:format)    pages#contact
#             root        /                           pages#home
