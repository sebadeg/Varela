# frozen_string_literal: true

class Usuarios::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end


      p "Create"
      unless params[resource_name].nil?
      p "Create 2"

        usuario = Usuario.new(
          cedula: params[resource_name][:cedula], 
          email: params[resource_name][:email], 
          nombre: params[resource_name][:nombre], 
          apellido: params[resource_name][:apellido], 
          alumno1: params[resource_name][:alumno1], 
          alumno2: params[resource_name][:alumno2], 
          alumno3: params[resource_name][:alumno3] 
          )
        p usuario.nombre
        UserMailer.nuevo_usuario(usuario).deliver_now
      end


    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource, location: after_inactive_sign_up_path_for(resource)
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:cedula])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:cedula])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    principal_registrado_path
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    principal_registrado_path
  end


  def sign_up(resource_name, resource)
    #sign_in(resource_name, resource)
  end

end
