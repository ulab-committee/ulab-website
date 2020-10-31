# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# frozen_string_literal: true

module Spina
  Account.first_or_create name: 'ULAB', theme: 'conferences_primer_theme'
  User.first_or_create name: 'Joe', email: 'someone@someaddress.com', password: 'password', admin: true
  module Admin
    module Conferences
      university_of_atlantis, university_of_shangri_la =
        Institution.create! [{ name: 'University of Atlantis', city: 'Atlantis' },
                             { name: 'University of Shangri-La', city: 'Shangri-La' }]
      lecture_block2, _lecture_block3, _lecture_block_entrance =
        Room.create! [{ building: 'Lecture block', number: '2', institution: university_of_atlantis },
                      { building: 'Lecture block', number: '3', institution: university_of_atlantis },
                      { building: 'Lecture block', number: 'entrance', institution: university_of_atlantis }]
      _medical_school_g14, _medical_school_g152, _medical_school_g16 =
        Room.create! [{ building: 'Medical school', number: 'G.14', institution: university_of_shangri_la },
                      { building: 'Medical school', number: 'G.152', institution: university_of_shangri_la },
                      { building: 'Medical school', number: 'G.16', institution: university_of_shangri_la }]
      uoa_conference, uos_conference =
        Conference.create! [{ start_date: '2017-04-07', finish_date: '2017-04-09', name: 'University of Atlantis 2017' },
                            { start_date: '2018-04-09', finish_date: '2018-04-11', name: 'University of Shangri-La 2018' }]
      _plenary1, _poster1, talk1, _plenary2, _poster2, _talk2 =
        PresentationType.create! [{ name: 'Plenary', minutes: 80, conference: uoa_conference },
                                  { name: 'Poster', minutes: 30, conference: uoa_conference },
                                  { name: 'Talk', minutes: 20, conference: uoa_conference },
                                  { name: 'Plenary', minutes: 80, conference: uos_conference },
                                  { name: 'Poster', minutes: 30, conference: uos_conference },
                                  { name: 'Talk', minutes: 20, conference: uos_conference }]
      session = Session.create! presentation_type: talk1, room: lecture_block2, name: 'Session'
      joe_bloggs = Delegate.create! first_name: 'Joe', last_name: 'Bloggs', email_address: 'someone@someaddress.com',
                                    institution: university_of_atlantis,
                                    dietary_requirements: [DietaryRequirement.new(name: 'Pescetarian')],
                                    conferences: [uoa_conference, uos_conference]
      Presentation.create! title: 'The Asymmetry and Antisymmetry of Syntax', date: '2017-04-07', start_time: '10:00',
                           abstract: 'Lorem ipsum', presenters: [joe_bloggs],
                           session: session
    end
  end
end
