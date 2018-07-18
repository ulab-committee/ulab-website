# Opal

require 'opal'
require 'opal_ujs'

# Turbolinks

require 'turbolinks'

# Stimulus

require 'spina/stimulus.umd'

# File Upload

require 'activestorage'

# jQuery

require 'jquery.js'
require 'jquery_ujs'

# jQuery Plugins

require 'spina/jquery.ui'
require 'spina/jquery.nestable'
require 'spina/jquery.customfileinput'

# Misc Plugins

require 'spina/sortable'
require 'spina/trix'

# Spina's code

require 'spina/admin/switch'
require 'spina/admin/modal'
require 'spina/admin/tabs'
require 'spina/admin/forms'
require 'spina/admin/dropdown'
require 'spina/admin/galleryselect'
require 'spina/admin/navigation'
require 'spina/admin/notifications'
require 'spina/admin/media_gallery'

require 'spina/admin/account'
require 'spina/admin/confirm_delete'
require 'spina/admin/pages'

require 'spina/admin/trix'

require_tree './controllers'

# Scaffolding

require 'spina/admin/scaffold'
