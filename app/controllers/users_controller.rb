class UsersController < ApplicationController
  before_action :signed_in_user, only:[:index,:edit, :update]
  before_action :correct_user,   only:[:edit, :update]  
  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #do stuff when it works
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user 
    else
      render 'new'
    end
  end

  def edit
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    if current_user?(@user)
      redirect_to users_url
    else
      @user.destroy
      flash[:success] = "User deleted."
      redirect_to users_url
    end
  end

  def update
    if @user.update_attributes(user_params) 
      flash[:success] = "Profile updated"
      redirect_to @user
      #handle a successful update
    else
      render 'edit'
    end 
  end

  private
    def user_params
       params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

=begin
    def signed_in_user
      unless signed_in? 
        store_location
        redirect_to signin_url, notice: "Please sign in."
       end
    end
=end

    def correct_user
       @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user)
    end


end
