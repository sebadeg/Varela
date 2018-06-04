Rails.application.routes.draw do
  devise_for :usuarios, controllers: { registrations: 'usuarios/registrations' }
  
  get 'principal/index'
  
  get 'principal/registrado'
  post 'principal/download_pdf'
  post 'principal/autorizar'

  post 'principal/asociar'
  post 'principal/movimientos'
  post 'principal/cuentas'

  post 'principal/cambiar'
  post 'principal/duda'

  post 'principal/cargarmovimientos'

  patch 'principal/movimientoupdate'

  delete 'principal/movimientoborrar'

  patch 'principal/movimientofin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'principal#index'
end
