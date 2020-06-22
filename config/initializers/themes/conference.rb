# frozen_string_literal: true

theme = ::Spina::Theme.find_by_name('conference')
theme.view_templates << { name: 'committee',
                          title: 'Committee',
                          description: 'Contains committee bios',
                          page_parts: %w[text committee_bios] }
theme.resources = []
