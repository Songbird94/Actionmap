# frozen_string_literal: true

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all
  # serialize :contact_address, Array

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include? index
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      address = official.address&.at(0)
      rep = find_rep(official, ocdid_temp, title_temp, address)

      reps.push(rep)
    end

    reps
  end

  def self.find_rep(official, ocdid, title, address)
    address = official.address&.at(0)
    Representative.find_or_create_by!(
      {
        name:            official.name,
        ocdid:           ocdid,
        title:           title,
        address:         address&.line1,
        # address2: address&.line2,
        city:            address&.city,
        state:           address&.state,
        zip:             address&.zip,
        political_party: official.party,
        photo_url:       official.photo_url.present? ? official.photo_url[0] : nil
      }
    )
  end
end
