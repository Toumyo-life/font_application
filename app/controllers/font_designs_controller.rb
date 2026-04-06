class FontDesignsController < ApplicationController
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
end
