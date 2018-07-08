::Spina::Theme.register do |theme|

  theme.name = 'conference'
  theme.title = 'Conference theme'

  theme.page_parts = [{
    name: 'alert',
    title: 'Alert',
    partable_type: 'Spina::Line'
  }, {
    name: 'text',
    title: 'Text',
    partable_type: 'Spina::Text'
  }, {
    name: 'gallery',
    title: 'Gallery',
    partable_type: 'Spina::ImageCollection'
  }, {
    name: 'constitution',
    title: 'Constitution',
    partable_type: 'Spina::Attachment'
  }, {
    name: 'minutes',
    title: 'Minutes',
    partable_type: 'Spina::AttachmentCollection'
  }, {
    name: 'partner_societies',
    title: 'Partner societies',
    partable_type: 'Spina::Structure'
  }, {
    name: 'contact',
    title: 'Contact',
    partable_type: 'Spina::Text'
  }]

  theme.structures = [{
    name: 'partner_societies',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'description',
      title: 'Description',
      partable_type: 'Spina::Text'
    }, {
      name: 'website',
      title: 'Website',
      partable_type: 'Spina::Url'
    }, {
      name: 'email_address',
      title: 'Email address',
      partable_type: 'Spina::EmailAddress'
    }]
  }]

  theme.view_templates = [{
    name: 'homepage',
    title: 'Homepage',
    page_parts: ['text', 'alert', 'gallery'],
  }, {
    name: 'information',
    title: 'Information',
    description: 'Contains general information',
    page_parts: ['text']
  }, {
    name: 'about',
    title: 'About',
    description: 'Contains information about the society',
    page_parts: ['constitution', 'minutes', 'partner_societies', 'contact']
  }]

  theme.custom_pages = [{
    name: 'homepage',
    title: 'Homepage',
    deletable: false,
    view_template: 'homepage'
  }]

  theme.plugins = ['Collect']

end
