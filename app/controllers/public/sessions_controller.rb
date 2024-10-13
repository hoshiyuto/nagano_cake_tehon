# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_inactive_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def reject_inactive_customer
    @customer = Customer.find_by(email: params[:customer][:email])
    if @customer
      if @customer.valid_password?(params[:customer][:password]) && !@customer.is_active
        flash[:danger] = 'お客様は退会済みです。申し訳ございませんが、別のメールアドレスをお使いください。'
        redirect_to new_customer_session_path
      end
    end
  end
  #ガード節を使う場合
  # def customer_state
  #   # 【処理内容1】 入力されたemailからアカウントを1件取得
  #   customer = Customer.find_by(email: params[:customer][:email])
  #   # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
  #   return if customer.nil?
  #   # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
  #   return unless customer.valid_password?(params[:customer][:password])
  #   # 【処理内容4】 アクティブでない会員に対する処理
  #   return if customer.is_active
  #   redirect_to new_customer_registration_path
  # end

end
