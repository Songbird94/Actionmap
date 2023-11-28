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
      rep = Representative.find_or_create_by!(
        {
          name:            official.name,
          ocdid:           ocdid_temp,
          title:           title_temp,
          address: address&.line1,
          # address2: address&.line2,
          city:     address&.city,
          state:    address&.state,
          zip:      address&.zip,
          political_party:    official.party,
          photo_url:    official.photo_url.present? ? official.photo_url[0] : nil
        }
      )
      # rep.assign_attributes(
      #   address: address&.line1,
      #   city:     address&.city,
      #   state:    address&.state,
      #   zip:      address&.zip,
      #   political_party:    official.party,
      #   photo_url:    official.urls.present? ? official.urls[0] : nil
      # )

      reps.push(rep)
    end

    reps
  end
end
