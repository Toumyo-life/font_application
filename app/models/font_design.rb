class FontDesign < ApplicationRecord
  belongs_to :user

  has_one_attached :svg_file
  has_one_attached :png_file
  has_many :font_design_tags, dependent: :destroy

  validate :svg_or_png_present

  # バリデーション(SVGまたはPNGのみ許可)
  validates :svg_file, 
            content_type: ['image/svg+xml', 'application/postscript', 'application/illustrator'],
            size: { less_than: 10.megabytes },
            if: -> { svg_file.attached? }
                       
  validates :png_file, 
            content_type: ['image/png'],
            size: { less_than: 10.megabytes },
            if: -> { png_file.attached? }
  private

  def acceptable_image_file
    return unless image_file.attached?

    # ファイルサイズのチェック
    unless image_file.byte_size <= 10.megabytes
      errors.add(:image_file, "は10MB以下にしてください")
  end

    # 拡張子のチェック
    acceptable_types = %w[.svg .png .ai]
    unless acceptable_types.include?(File.extname(image_file.filename.to_s).downcase)
      errors.add(:image_file, "はSVG、PNG、AIファイルのみアップロード可能です")
    end
  end

  def svg_or_png_present
    if !svg_file.attached? && !png_file.attached?
      errors.add(:base, "SVGまたはPNGファイルを1つ以上アップロードしてください")
    end
  end
end