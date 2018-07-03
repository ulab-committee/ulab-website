::Spina::Theme.register do |theme|

  theme.name = 'ulab'
  theme.title = 'ULAB Theme'

  theme.page_parts = [{
                          name:           'line',
                          title:          'Line',
                          partable_type:  'Spina::Line'
                      }, {
                          name:           'alert',
                          title:          'Alert',
                          partable_type:  'Spina::Line'
                      }, {
                          name:           'text',
                          title:          'Text',
                          partable_type:  'Spina::Text'
                      }, {
                          name:           'institution',
                          title:          'Institution',
                          partable_type:  'Spina::Line'
                      }, {
                          name:           'location',
                          title:          'Location',
                          partable_type:  'Spina::Line'
                      }, {
                          name:           'image',
                          title:          'Image',
                          partable_type:  'Spina::Image'
                      }, {
                          name:           'gallery',
                          title:          'Gallery',
                          partable_type:  'Spina::ImageCollection'
                      }, {
                          name:           'constitution',
                          title:          'Constitution',
                          partable_type:  'Spina::Attachment'
                      }, {
                          name:           'minutes',
                          title:          'Minutes',
                          partable_type:  'Spina::AttachmentCollection'
                      }, {
                          name:           'partner_societies',
                          title:          'Partner societies',
                          partable_type:  'Spina::Structure'
                      }, {
                          name:           'contact',
                          title:          'Contact',
                          partable_type:  'Spina::Text'
                      }, {
                          name:           'start_date',
                          title:          'Start date',
                          partable_type:  'Spina::Date'
                      }, {
                          name:           'end_date',
                          title:          'End date',
                          partable_type:  'Spina::Date'
                      }]

  theme.structures = [{
                          name: 'partner_societies',
                          structure_parts: [{
                                                name:           'name',
                                                title:          'Name',
                                                partable_type:  'Spina::Line'
                                            }, {
                                                name:           'description',
                                                title:          'Description',
                                                partable_type:  'Spina::Text'
                                            }, {
                                                name:           'website',
                                                title:          'Website',
                                                partable_type:  'Spina::Url'
                                            }, {
                                                name:           'email_address',
                                                title:          'Email address',
                                                partable_type:  'Spina::EmailAddress'
                                            }]
                      }]

  theme.view_templates = [{
                              name: 'homepage',
                              title: 'Homepage',
                              page_parts: ['text', 'alert', 'gallery'],
                          }, {
                              name: 'conference',
                              title: 'Conference',
                              usage: 'Use for a conference',
                              page_parts: ['text', 'institution', 'location', 'start_date', 'end_date']
                          }, {
                              name: 'conference_list',
                              title: 'Past Conferences',
                              page_parts: ['text', 'gallery'],
                          },{
                              name: 'information',
                              title: 'Information',
                              description: 'Contains general information',
                              page_parts: ['text']
                          },{
                              name: 'about',
                              title: 'About',
                              description: 'Contains information about the society',
                              page_parts: ['constitution', 'minutes', 'partner_societies', 'contact']
                          }]

  theme.custom_pages = [{
                            name:           'homepage',
                            title:          'Homepage',
                            deletable:      false,
                            view_template:  'homepage'
                        },{
                            name:           'conference_list',
                            title:          'Past Conferences',
                            deletable:      false,
                            view_template:  'conference_list'
                        }]

end
