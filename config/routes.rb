Rails.application.routes.draw do
  devise_for :usuarios, controllers: { registrations: 'usuarios/registrations' }
  
  get 'principal/index'
  
  get 'principal/registrado'
  get 'principal/download_pdf'
  post 'principal/autorizar'

  post 'principal/asociar'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'principal#index'
end
