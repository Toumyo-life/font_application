class FontDesignsController < ApplicationController
  before_action :require_login, only: [:download, :download_file]
  before_action :set_font_design, only: [:show, :edit, :update, :destroy, :download, :download_file]
  before_action :require_login, except: [:index, :show, :download, :download_file]
  
  def index
    @font_designs = FontDesign.includes(:user, svg_file_attachment: :blob, png_file_attachment: :blob)
  end

  def new
    if current_user.nil?
      flash[:notice] = "ログインが必要です"
      redirect_to "/login"
      return
    end
    @font_design = FontDesign.new
  end

  def show
  end

  def edit
    # 編集フォームで既存のタグを表示するために変数を追加
    @tag_names = @font_design.tags.pluck(:name).join(', ')
  end

  def update
    if @font_design.update(font_design_params)
      save_tags(@font_design, params[:tag_names])
      redirect_to @font_design, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @font_design = current_user.font_designs.find(params[:id])
    @font_design.destroy
    redirect_to root_path, notice: '削除しました'
  end

  def download
    @font_design = FontDesign.find(params[:id])
  end

  def download_file
    @font_design = FontDesign.find(params[:id])

    case params[:type]
    when "png"
      if @font_design.png_file.attached?
        redirect_to rails_blob_path(@font_design.png_file, disposition: "attachment")
      end
    when "svg"
      if @font_design.svg_file.attached?
        redirect_to rails_blob_path(@font_design.svg_file, disposition: "attachment")
      end
    else
      redirect_to root_path, alert: "ファイルがありません"
    end
  end

  private

  def set_font_design
    # ログイン必須
    unless logged_in?
      flash[:notice] = "ログインが必要です"
      redirect_to login_path
      return
    end
    
    # downloadアクションは他のユーザーの画像もOK
    if action_name == 'download'
      @font_design = FontDesign.find(params[:id])
    else
      # edit, update, destroyは自分の画像のみ
      @font_design = current_user.font_designs.find(params[:id])
    end
  end

  def font_design_params
    params.fetch(:font_design, {}).permit(:svg_file, :png_file)
  end
end
