class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  # タグを削除してもフォントデザインは残す
  has_many :font_designs, dependent: :nullify
  has_many :font_design_tags, dependent: :destroy
  has_many :font_designs, through: :font_design_tags 
end
