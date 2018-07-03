class Spina::Presentation < ApplicationRecord
  validates :title, presence: true
  validates :email_address, email_address: true, unless: Proc.new { |a| a.email.blank? }
end
