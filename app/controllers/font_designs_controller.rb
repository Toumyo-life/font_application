class FontDesignsController < ApplicationController
  def index
    @font_designs = FontDesign.includes(:user, svg_file_attachment: :blob, png_file_attachment: :blob)
  end
end
