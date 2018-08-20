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

  post 'principal/download_factura'
  patch 'principal/download_factura'


  get 'principal/eventos'
  patch 'principal/eventos_registrar'
  post 'principal/eventos_registrar'
  get 'principal/eventos_registrado'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get 'principal/registro'
  patch 'principal/validarregistro'
  patch 'principal/enviarpassword'

  patch 'principal/inscribir'
  post 'principal/download_inscripcion'
  patch 'principal/download_inscripcion'
  post 'principal/download_ayuda'
  patch 'principal/download_ayuda'

  root 'principal#index'
end
