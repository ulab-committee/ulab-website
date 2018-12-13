# frozen_string_literal: true

::Spina::Theme.register do |theme|
  theme.name = 'ulab_conference'
  theme.title = 'ULAB Conference theme'

  theme.page_parts = [{
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
    name: 'partner_societies',
    title: 'Partner societies',
    partable_type: 'Spina::Structure'
  }, {
    name: 'minutes',
    title: 'Minutes',
    partable_type: 'Spina::Structure'
  }, {
    name: 'contact',
    title: 'Contact',
    partable_type: 'Spina::Text'
  }, {
    name: 'socials',
    title: 'Socials',
    partable_type: 'Spina::Structure'
  }, {
    name: 'meetings',
    title: 'Meetings',
    partable_type: 'Spina::Structure'
  }, {
    name: 'submission_url',
    title: 'Submission URL',
    partable_type: 'Spina::Conferences::UrlPart'
  }, {
    name: 'submission_date',
    title: 'Submission date',
    partable_type: 'Spina::Conferences::DatePart'
  }, {
    name: 'submission_text',
    title: 'Submission text',
    partable_type: 'Spina::Line'
  }, {
    name: 'committee_bios',
    title: 'Committee bios',
    partable_type: 'Spina::Structure'
  }]

  theme.layout_parts = [{
    name: 'current_conference_alert',
    title: 'Alert',
    partable_type: 'Spina::Line'
  }]

  theme.structures = [{
    name: 'partner_societies',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'logo',
      title: 'Logo',
      partable_type: 'Spina::Image'
    }, {
      name: 'description',
      title: 'Description',
      partable_type: 'Spina::Text'
    }, {
      name: 'website',
      title: 'Website',
      partable_type: 'Spina::Conferences::UrlPart'
    }, {
      name: 'email_address',
      title: 'Email address',
      partable_type: 'Spina::Conferences::EmailAddressPart'
    }]
  }, {
    name: 'minutes',
    structure_parts: [{
      name: 'date',
      title: 'Date',
      partable_type: 'Spina::Conferences::DatePart'
    }, {
      name: 'attachment',
      title: 'Attachment',
      partable_type: 'Spina::Attachment'
    }]
  }, {
    name: 'socials',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'start_time',
      title: 'Time',
      partable_type: 'Spina::Conferences::TimePart'
    }, {
      name: 'location',
      title: 'Location',
      partable_type: 'Spina::Line'
    }, {
      name: 'description',
      title: 'Description',
      partable_type: 'Spina::Text'
    }]
  }, {
    name: 'meetings',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'start_time',
      title: 'Time',
      partable_type: 'Spina::Conferences::TimePart'
    }, {
      name: 'location',
      title: 'Location',
      partable_type: 'Spina::Line'
    }, {
      name: 'description',
      title: 'Description',
      partable_type: 'Spina::Text'
    }]
  }, {
    name: 'committee_bios',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'role',
      title: 'Role',
      partable_type: 'Spina::Line'
    }, {
      name: 'bio',
      title: 'Bio',
      partable_type: 'Spina::Text'
    }, {
      name: 'profile_picture',
      title: 'Profile picture',
      partable_type: 'Spina::Image'
    }, {
      name: 'facebook_profile',
      title: 'Facebook profile',
      partable_type: 'Spina::Conferences::UrlPart'
    }, {
      name: 'twitter_profile',
      title: 'Twitter profile',
      partable_type: 'Spina::Conferences::UrlPart'
    }]
  }]

  theme.view_templates = [{
    name: 'homepage',
    title: 'Homepage',
    page_parts: %w[text current_conference_alert gallery]
  }, {
    name: 'information',
    title: 'Information',
    description: 'Contains general information',
    page_parts: %w[text]
  }, {
    name: 'about',
    title: 'About',
    description: 'Contains information about the society',
    page_parts: %w[text constitution minutes partner_societies contact]
  }, {
    name: 'conference',
    title: 'Conference',
    description: 'Contains information and content for a conference',
    page_parts: %w[text submission_url submission_date submission_text
                   gallery socials meetings]
  }, {
    name: 'presentation',
    title: 'Presentation',
    description: 'Contains content for a presentation',
    page_parts: %w[]
  }, {
    name: 'committee',
    title: 'Committee',
    description: 'Contains information about committee',
    page_parts: %w[text committee_bios]
  }, {
    name: 'conferences',
    title: 'Conferences',
    description: 'List of conferences',
    page_parts: %w[]
  }]

  theme.custom_pages = [{
    name: 'homepage',
    title: 'Homepage',
    deletable: false,
    view_template: 'homepage'
  }, {
    name: 'conferences',
    title: 'Conferences',
    deletable: false,
    view_template: 'conferences'
  }, {
    name: 'about',
    title: 'About',
    deletable: false,
    view_template: 'about'
  }]

  theme.navigations = [{
    name: 'main',
    label: 'Main navigation',
    auto_add_pages: true
  }, {
    name: 'footer',
    label: 'Footer'
  }]

  theme.plugins = ['conferences']
end
