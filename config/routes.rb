Accruto::Application.routes.draw do
  resources :jobs


  get "pages/stylesheet"
  get "pages/home"
  get "pages/about"
  get "pages/faq"
  get "pages/contact"

  root :to => 'pages#home'
end
#== Route Map
# Generated on 07 Jul 2013 20:46
#
#       pages_home GET /pages/home(.:format)       pages#home
#      pages_about GET /pages/about(.:format)      pages#about
#        pages_faq GET /pages/faq(.:format)        pages#faq
#    pages_contact GET /pages/contact(.:format)    pages#contact
#             root     /                           pages#home
