# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

module Spina
  Account.first_or_create name: 'ULAB', theme: 'conference'
  User.first_or_create name: 'Joe', email: 'someone@someaddress.com', password: 'password', admin: true
  module Conferences
    def self.conference_parts
      conference = Conference.new
      model_parts(Conference).collect { |part| conference.part(part) }
    end

    def self.presentation_parts
      presentation = Presentation.new
      model_parts(Presentation).collect { |part| presentation.part(part) }
    end

    def self.model_parts(klass)
      current_theme = ::Spina::THEMES.find { |theme| theme.name == ::Spina::Account.first.theme }
      current_theme.page_parts.select { |part| part[:name].in? current_theme.models[klass.to_s.to_sym][:parts] }
    end

    Institution.create! name: 'University of Atlantis', city: 'Atlantis',
                        rooms: [Room.new(building: 'Lecture block', number: '2'),
                                Room.new(building: 'Lecture block', number: '3'),
                                Room.new(building: 'Lecture block', number: 'entrance')]
    Institution.create! name: 'University of Shangri-La', city: 'Shangri-La',
                        rooms: [Room.new(building: 'Medical school', number: 'G.14'),
                                Room.new(building: 'Medical school', number: 'G.152'),
                                Room.new(building: 'Medical school', number: 'G.16')]
    Conference.create! institution: Institution.find_by(name: 'University of Atlantis'), start_date: '2017-04-07',
                       finish_date: '2017-04-09', parts: conference_parts,
                       rooms: Room.includes(:institution).where(
                         spina_conferences_institutions: { name: 'University of Atlantis' }
                       )
    Conference.create! institution: Institution.find_by(name: 'University of Shangri-La'), start_date: '2018-04-09',
                       finish_date: '2018-04-11', parts: conference_parts,
                       rooms: Room.includes(:institution).where(
                         spina_conferences_institutions: { name: 'University of Shangri-La' }
                       )
    PresentationType.create! [{
      name: 'Plenary', minutes: 80, conference: Conference.includes(:institution).find_by(
        spina_conferences_institutions: { name: 'University of Atlantis' }
      ), room_possessions: RoomPossession.includes(:room, :institution).where(
        spina_conferences_institutions: { name: 'University of Atlantis' },
        spina_conferences_rooms: { building: 'Lecture block', number: '3' }
      )
    }, {
      name: 'Poster', minutes: 30, conference: Conference.includes(:institution).find_by(
        spina_conferences_institutions: { name: 'University of Atlantis' }
      ), room_possessions: RoomPossession.includes(:room, :institution).where(
        spina_conferences_institutions: { name: 'University of Atlantis' },
        spina_conferences_rooms: { building: 'Lecture block', number: 'entrance' }
      )
    }, {
      name: 'Talk', minutes: 20, conference: Conference.includes(:institution).find_by(
        spina_conferences_institutions: { name: 'University of Atlantis' }
      ), room_possessions: RoomPossession.includes(:room, :institution).where(
        spina_conferences_institutions: { name: 'University of Atlantis' },
        spina_conferences_rooms: { building: 'Lecture block', number: %w[2 3] }
      )
    }, {
      name: 'Plenary', minutes: 80, conference: Conference.includes(:institution).find_by(
        spina_conferences_institutions: { name: 'University of Shangri-La' }
      ), room_possessions: RoomPossession.includes(:room, :institution).where(
        spina_conferences_institutions: { name: 'University of Shangri-La' },
        spina_conferences_rooms: { building: 'Medical school', number: 'G.152' }
      )
    }, {
      name: 'Poster', minutes: 30, conference: Conference.includes(:institution).find_by(
        spina_conferences_institutions: { name: 'University of Shangri-La' }
      ), room_possessions: RoomPossession.includes(:room, :institution).where(
        spina_conferences_institutions: { name: 'University of Shangri-La' },
        spina_conferences_rooms: { building: 'Medical school', number: 'G.14' }
      )
    }, {
      name: 'Talk', minutes: 20, conference: Conference.includes(:institution).find_by(
        spina_conferences_institutions: { name: 'University of Shangri-La' }
      ), room_possessions: RoomPossession.includes(:room, :institution).where(
        spina_conferences_institutions: { name: 'University of Shangri-La' },
        spina_conferences_rooms: { building: 'Medical school', number: %w[G.152 G.16] }
      )
    }]
    Delegate.create! first_name: 'Joe', last_name: 'Bloggs', email_address: 'someone@someaddress.com',
                     institution: Institution.find_by(name: 'University of Atlantis'),
                     dietary_requirements: [DietaryRequirement.new(name: 'Pescetarian')],
                     conferences: Conference.includes(:institution).where(
                       spina_conferences_institutions: { name: ['University of Atlantis', 'University of Shangri-La'] }
                     )
    Presentation.create! title: 'The Asymmetry and Antisymmetry of Syntax', date: '2017-04-07', start_time: '10:00',
                         abstract: 'Lorem ipsum', presenters: Delegate.where(first_name: 'Joe', last_name: 'Bloggs'),
                         parts: presentation_parts,
                         room_use: RoomUse.includes(:room, :presentation_type, :institution).find_by(
                           spina_conferences_rooms: { building: 'Lecture block', number: '2' },
                           spina_conferences_presentation_types: { name: 'Talk' },
                           spina_conferences_institutions: { name: 'University of Atlantis' }
                         )
  end
end
