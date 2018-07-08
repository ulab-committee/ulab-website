module Spina
  class Delegate < ApplicationRecord
    has_and_belongs_to_many :spina_conferences, class_name: 'Spina::Conference', required: true
    has_and_belongs_to_many :spina_presentations, class_name: 'Spina::Presentation'
    validates_presence_of :first_name, :last_name, :email_address
    validates :email_address, email_address: true, unless: proc { |a| a.email_address.blank? }

    def full_name
      "#{first_name} #{last_name}"
    end
    def full_name_and_institution
      full_name + ", #{institution}"
    end
  end
end
