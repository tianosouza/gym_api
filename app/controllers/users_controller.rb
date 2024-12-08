class UsersController < ApplicationController
  before_action :ensure_json_request, except: [:sign_in]
  before_action :authorize, only: [ :index ]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)

    if @user.save
      token = encode_token(user_id: @user.id)
      render json: { user: @user, token: token }, status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def sign_in
    if request.post?
      if params[:username].blank? || params[:password].blank?
        respond_to do |format|
          format.html { flash.now[:alert] = "Username and password are required"; render :sign_in, status: :unprocessable_entity }
          format.json { render json: { error: "Username and password are required" }, status: :unprocessable_entity }
        end
        return
      end
  
      @user = User.find_by(username: params[:username])
  
      if @user.nil?
        respond_to do |format|
          format.html { flash.now[:alert] = "Username not found"; render :sign_in, status: :unprocessable_entity }
          format.json { render json: { error: "Username not found" }, status: :unprocessable_entity }
        end
        return
      end
  
      if @user.authenticate(params[:password])
        token = encode_token(user_id: @user.id)
        respond_to do |format|
          format.html { redirect_to exercises_path, notice: "Signed in successfully" }
          format.json { render json: { user: @user, token: token }, status: :ok }
        end
      else
        respond_to do |format|
          format.html { flash.now[:alert] = "Incorrect password"; render :sign_in, status: :unprocessable_entity }
          format.json { render json: { error: "Incorrect password" }, status: :unprocessable_entity }
        end
      end
    else
      render :sign_in
    end
  end
  

  def destroy
    unless is_admin?
      return render json: { error: "Access denied: Only administrators can delete users." }, status: :forbidden
    end

    @user = User.find(params[:id])
    if @user&.destroy
      render json: { message: "User deleted" }, status: :ok
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def ensure_json_request
    return if request.format.json?
    render nothing: true, status: 406
  end

  def is_admin?
    current_user&.role == "admin"
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :email)
  end
end
