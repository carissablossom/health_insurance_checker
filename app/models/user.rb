require 'httparty'
require 'pry-remote'
require 'eligible'

class User
  include HTTParty
  BASE_URI = "https://gds.eligibleapi.com/v1.5"
  API_KEY = "oK7ORxVQ-lYPu9uw1JAgkAM0gYadnJb__bGh"

  def initialize(first_name, last_name, birthday, insurance_provider, insurance_member_id)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @insurance_provider = insurance_provider
    @insurance_member_id = insurance_member_id
  end

  def verify_insurance
    p API_KEY
    options = {
      api_key: API_KEY,
      member_first_name: @first_name,
      member_last_name: @last_name,
      member_dob: @birthday,
      payer_id: get_payer_id,
      provider_npi: "0123456789",
      member_id: @insurance_member_id,
      service_type: 30
    }
    response = HTTParty.get(BASE_URI + '/coverage/all.json', options)
  end

  def get_payer_id
    payers = HTTParty.get("https://eligible.com/resources/payers/eligibility.json")
    payer_id = "00000"
    payers.each do |payer|
      if payer["names"] = @insurance_provider || payer["names"].include?(@insurance_provider)
        payer_id = payer["payer_id"]
      end
    end
    puts "payer id: #{payer_id}"
    return payer_id
  end

  def get_verification_results(response)
    plan_name = response["plan"]["plan_name"]
    plan_start = response["plan"]["dates"].first["date_value"]
    plan_end = response["plan"]["dates"].last["date_value"]

    well_visit = get_visit_coverate(resp["services"].select{|service| service["type"] == "BZ"})
    sick_visit = get_visit_coverate(resp["services"].select{|service| service["type"] == "BY"})

    return {
      plan_name: plan_name,
      plan_start: plan_start,
      plan_end: plan_end,
      well_visit: well_visit,
      sick_vist: sick_visit
    }
  end

  def get_visit_coverage(visit)
    if visit.keys.include?('financials')
      in_network = visit["financials"]["coinsurance"]["percents"]["in_network"][0]["percent"]
      out_network = visit["financials"]["coinsurance"]["percents"]["out_network"][0]["percent"]
      visit_result = "#{in_network}% (in network), #{out_network}% (out network)"
    else
      visit_result = visit["coverage_status_label"]
    end
    return visit_result
  end
end
