# frozen_string_literal: true

require 'stimulus'
require 'browser'
require 'browser/effects.rb'

class SlideshowController < Stimulus::Controller #:nodoc:
  has_targets :slide
  after_initialize :show_first_slide

  def incrementer
    @data[:incrementer].to_i
  end

  def incrementer=(index)
    @data[:incrementer] = index
    show_slide
  end

  def show_first_slide
    show_slide
  end

  def next
    self.incrementer = if incrementer == slide_targets.length - 1
                         0
                       else
                         incrementer + 1
                       end
  end

  def previous
    self.incrementer = if incrementer.zero?
                         slide_targets.length - 1
                       else
                         incrementer - 1
                       end
  end

  def show_slide
    slide_targets.each_with_index do |target, index|
      element = Browser::DOM::Element.new(target.to_n)
      index == incrementer ? element.show : element.hide
    end
  end
end

application = Stimulus::Application.new
[SlideshowController].each do |controller|
  application.register_controller controller
end
