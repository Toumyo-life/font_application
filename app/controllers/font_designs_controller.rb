require 'nkf'
class FontDesignsController < ApplicationController
  before_action :set_font_design, only: [:show, :edit, :update, :destroy, :download, :download_file]
  before_action :require_login, except: [:index]

  def index
    @font_designs = FontDesign.includes(:user, :tags, svg_file_attachment: :blob, png_file_attachment: :blob)

      # もし検索ワード(params[:q])があれば、名前かタグ名で絞り込む
    if params[:q].present?
      # 検索ワードをカタカナ・ひらがなに変換（前述のNKFを使用）
      q_hira = NKF.nkf('-w --hiragana', params[:q])
      q_kana = NKF.nkf('-w --katakana', params[:q])
      @font_designs = @font_designs.joins(:tags)
                                   .where(
                                     "tags.name LIKE ? OR tags.name LIKE ? OR tags.name LIKE ?", 
                                     "%#{params[:q]}%", "%#{q_hira}%", "%#{q_kana}%"
                                   )
                                   .distinct
    end
  end

  def new
    @font_design = FontDesign.new
  end

  def create
    @font_design = current_user.font_designs.build(font_design_params)
  
    if @font_design.save
      # タグの保存処理を追加
      save_tags(@font_design, params[:tag_names])
      
      redirect_to root_path, notice: 'フォントデザインが保存されました'
    else
      render :new, status: :unprocessable_entity
    end
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

  # タグを保存するメソッドを追加
  def save_tags(font_design, tag_names_string)
    # 空であれば処理を終了
    return if tag_names_string.blank?
    # 古いタグやリンクを削除
    font_design.tags.clear
    # ,で区切った部分を分ける、前後の空白を削除,空のデータがあれば削除
    tag_names = tag_names_string.split(',').map(&:strip).reject(&:blank?)
    # 既存のデータ(同じタグは)再利用する
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      font_design.tags << tag unless font_design.tags.include?(tag)
    end
  end
end
