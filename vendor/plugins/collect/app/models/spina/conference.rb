module Spina
  class Conference < ApplicationRecord
    has_many :presentations, class_name: 'Spina::Presentation', foreign_key: 'spina_conference_id', dependent: :destroy
    has_and_belongs_to_many :delegates, class_name: 'Spina::Delegate', foreign_key: 'spina_conference_id', association_foreign_key: 'spina_delegate_id'

    validates_presence_of :institution, :city, :start_date, :finish_date
    validates :finish_date, finish_date: true, unless: proc { |a| a.finish_date.blank? || a.start_date.blank? }

    def institution_and_year
      "#{institution} #{start_date.year}"
    end

    def dates
      (start_date..finish_date).to_a
    end
  end
end
