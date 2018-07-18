module Spina
  class Delegate < ApplicationRecord
    has_and_belongs_to_many :conferences, class_name: 'Spina::Conference', foreign_key: 'spina_delegate_id', association_foreign_key: 'spina_conference_id', required: true
    has_and_belongs_to_many :presentations, class_name: 'Spina::Presentation', foreign_key: 'spina_delegate_id', association_foreign_key: 'spina_presentation_id'

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
