module Spina
  class Presentation < ApplicationRecord
    belongs_to :conference, class_name: 'Spina::Conference', foreign_key: 'spina_conference_id'
    has_and_belongs_to_many :delegates, class_name: 'Spina::Delegate', foreign_key: 'spina_presentation_id', association_foreign_key: 'spina_delegate_id'

    validates_presence_of :title, :start_time, :abstract
    validates :date, conference_date: true, unless: proc { |a| a.date.blank? }

    def start_datetime
      if date && start_time
        date + start_time.hour.hours + start_time.min.minutes
      end
    end
  end
end
