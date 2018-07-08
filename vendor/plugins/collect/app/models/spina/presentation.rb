module Spina
  class Presentation < ApplicationRecord
    belongs_to :spina_conference, class_name: 'Spina::Conference', dependent: :destroy, required: true
    has_and_belongs_to_many :spina_delegates, class_name: 'Spina::Delegate', required: true
    validates_presence_of :title, :start_time, :abstract
    # validates :start_time, numericality: { greater_than_or_equal_to: }
  end
end
