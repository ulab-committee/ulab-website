# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' },
#                          { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

module Spina
  Account.first_or_create name: 'Conferences', theme: 'ulab_conference'
  User.first_or_create name: 'Joe', email: 'someone@someaddress.com', password: 'password', admin: true
  module Conferences
    Institution.create [{ name: 'University of Atlantis', city: 'Atlantis' },
                        { name: 'University of Shangri-La', city: 'Shangri-La' }]
    Room.create [{ institution_id: 1, building: 'Lecture block', number: '2' },
                 { institution_id: 1, building: 'Lecture block', number: '3' },
                 { institution_id: 1, building: 'Lecture block', number: 'entrance' },
                 { institution_id: 2, building: 'Medical school', number: 'G.14' },
                 { institution_id: 2, building: 'Medical school', number: 'G.152' },
                 { institution_id: 2, building: 'Medical school', number: 'G.16' }]
    Conference.create [{ institution_id: 1, start_date: '2017-04-07', finish_date: '2017-04-09', room_ids: [1, 2, 3] },
                       { institution_id: 2, start_date: '2018-04-09', finish_date: '2018-04-11', room_ids: [4, 5, 6] }]
    PresentationType.create [{ conference_id: 1, name: 'Plenary', minutes: 80, room_possession_ids: [2] },
                             { conference_id: 1, name: 'Poster', minutes: 30, room_possession_ids: [3] },
                             { conference_id: 1, name: 'Oral', minutes: 20, room_possession_ids: [1, 2] },
                             { conference_id: 2, name: 'Plenary', minutes: 80, room_possession_ids: [5] },
                             { conference_id: 2, name: 'Poster', minutes: 30, room_possession_ids: [4] },
                             { conference_id: 2, name: 'Oral', minutes: 20, room_possession_ids: [5, 6] }]
    DietaryRequirement.create name: 'Pescetarian'
    Delegate.create first_name: 'Joe', last_name: 'Bloggs', institution_id: 1, email_address: 'someone@someaddress.com',
                    conference_ids: [1, 2], dietary_requirement_ids: 1
    Presentation.create title: 'The Asymmetry and Antisymmetry of Syntax', room_use_id: 3, date: '2017-04-07',
                        start_time: '10:00', abstract: 'Lorem ipsum', presenter_ids: [1]
  end
end
