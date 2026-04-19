class FontDesign < ApplicationRecord
  belongs_to :user

  has_one_attached :svg_file
  has_one_attached :png_file
  has_many :font_design_tags, dependent: :destroy
  has_many :tags, through: :font_design_tags

  validate :svg_or_png_present
  validate :validate_svg_extension

  validates :svg_file,
    content_type: [
      'image/svg+xml',
      'text/plain',
      'application/octet-stream'
    ],
    size: { less_than: 60.megabytes },
    if: -> { svg_file.attached? }

  validates :png_file,
    content_type: ['image/png'],
    size: { less_than: 10.megabytes },
    if: -> { png_file.attached? }

  private

  def validate_svg_extension
    return unless svg_file.attached?

    ext = File.extname(svg_file.filename.to_s).downcase

    unless [".svg"].include?(ext)
      errors.add(:svg_file, "はSVGファイルのみアップロード可能です")
    end
  end

  def svg_or_png_present
    if !svg_file.attached? && !png_file.attached?
      errors.add(:base, "SVGまたはPNGファイルを1つ以上アップロードしてください")
    end
  end
end
