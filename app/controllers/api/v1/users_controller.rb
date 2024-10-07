class Api::V1::UsersController < ApiBaseController
  before_action :load_resource!, only: %i[show edit destroy update]

  def index
    @users = User.all.order(created_at: :desc)
    render_listing_success_response(@users, UserSerializer, {}, 200,"Users fetched successfully")
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render_show_success_response(@user, UserSerializer, {}, 201,"User created successfully")
    else
      respond_with_error(@user.errors.full_messages.join(", "), 422)
    end
  end

  def show
    render_show_success_response(@user, UserSerializer, {}, 200,"User fetched successfully")
  end

  def edit
    render_show_success_response(@user, UserSerializer, {}, 200,"User fetched successfully")
  end

  def update
    if @user.update(user_params)
      render_show_success_response(@user, UserSerializer, {}, 200,"User updated successfully")
    else
      respond_with_error(@user.errors.full_messages.join(", "), 422)
    end
  end

  def destroy
     if @user&.destroy
      respond_success_message("User deleted", 201)
    else
      respond_with_error(@user.errors.full_messages.join(", "), 422)
    end
  end

  private

  def load_resource!
    @user = User.find_by(id: params[:id])
    render json: { error: "User not found" }, status: 404 if @user.blank? 
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :age, :address, :area, :image)
  end
end
