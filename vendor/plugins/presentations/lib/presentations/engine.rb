require 'spina'

module Presentations
  class Engine < ::Rails::Engine
    initializer 'spina.plugin.register.presentations', before: :load_config_initializers do
      ::Spina::Plugin.register do |plugin|
        plugin.name       = 'Presentations'
        plugin.namespace  = 'presentations'
      end
    end
  end
end
