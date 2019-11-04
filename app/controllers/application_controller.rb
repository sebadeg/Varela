class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_usuario!, except: [:eventos,:eventos_registrar,:eventos_registrado]
  before_action :configure_permitted_parameters, if: :devise_controller? 
  #before_filter :set_locale

  before_filter :set_mailer

  def set_mailer
    mail = "soporte@varela.edu.uy"
    contrasena = Contrasena.find_by(mail: mail) rescue nil
    passwd = contrasena != nil ? contrasena.password : ""

    ActionMailer::Base.default_url_options[:user_name] = mail
    ActionMailer::Base.default_url_options[:password] = passwd
  end

  $bienvenida = false

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:cedula, :nombre, :apellido, :direccion, :celular, :factura, :alumno1, :alumno2, :alumno3, :email, :password, :password, :current_password, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end  
end
