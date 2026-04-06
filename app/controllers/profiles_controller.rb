class ProfilesController < ApplicationController
  before_action :require_login
  
  def show
    @user = current_user
    @font_designs = current_user.font_designs.includes(:tags,png_file_attachment: :blob,svg_file_attachment: :blob).order(created_at: :desc)
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, success: t('defaults.flash_message.updated', item: User.model_name.human)
    else
      flash.now[:danger] = t('defaults.flash_message.not_updated', item: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy_avatar
    @user = current_user
    @user.remove_avatar!
    @user.save
    redirect_to edit_profile_path, success: 'アバター画像を削除しました'
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :avatar, :avatar_cache)
  end
end
