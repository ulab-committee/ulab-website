module Spina
  class Conference < ApplicationRecord
    has_many :spina_presentations, class_name: 'Spina::Presentation', dependent: :destroy
    has_and_belongs_to_many :spina_delegates, class_name: 'Spina::Delegate'
    validates_presence_of :institution, :city, :start_date, :finish_date
    validates :finish_date, finish_date: true, unless: proc { |a| a.finish_date.blank? || a.start_date.blank? }

    def institution_and_year
      "#{institution} #{start_date.year}"
    end
  end
end
