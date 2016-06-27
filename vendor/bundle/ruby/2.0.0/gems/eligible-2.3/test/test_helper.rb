$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'eligible'

module Eligible
  @mock_rest_client = nil

  def self.mock_rest_client=(mock_client)
    @mock_rest_client = mock_client
  end

  def self.execute_request(opts)
    get_params = (opts[:headers] || {})[:params]
    post_params = opts[:payload]
    case opts[:method]
    when :get then @mock_rest_client.get opts[:url], get_params, post_params
    when :post then @mock_rest_client.post opts[:url], get_params, post_params
    when :delete then @mock_rest_client.delete opts[:url], get_params, post_params
    end
  end
end

def test_response(body, code=200)
  # When an exception is raised, restclient clobbers method_missing.  Hence we
  # can't just use the stubs interface.
  body = MultiJson.dump(body) if !(body.kind_of? String)
  m = mock
  m.instance_variable_set('@eligible_values', { :body => body, :code => code })
  def m.body; @eligible_values[:body]; end
  def m.code; @eligible_values[:code]; end
  m
end  

def test_invalid_api_key_error
  { "error" => [ { "message" => "Could not authenticate you. Please re-try with a valid API key.", "code" => 1 }] }
end

def test_plan_missing_params
  {"timestamp"=>"2013-02-01T13:25:58", "eligible_id"=>"A4F4E1D6-7DC3-4B20-87CE-B59F48811290", "mapping_version"=>"plan/all$Revision:6$$Date:13-01-110:18$", "error"=>{"response_code"=>"Y", "response_description"=>"Yes", "agency_qualifier_code"=>"", "agency_qualifier_description"=>"", "reject_reason_code"=>"41", "reject_reason_description"=>"Authorization/AccessRestrictions", "follow-up_action_code"=>"C", "follow-up_action_description"=>"PleaseCorrectandResubmit"}}
end

def test_plan
  {"timestamp"=>"2013-01-14T20:39:57", "eligible_id"=>"B97BC91A-3E84-40A9-AA5C-D416CAE5CDB1", "mapping_version"=>"plan/all$Revision:6$$Date:13-01-110:18$", "primary_insurance"=>{"name"=>"Aetna", "id"=>"00002", "group_name"=>"TOWERGROUPCOMPANIES", "plan_begins"=>"2010-01-01", "plan_ends"=>"", "comments"=>["AetnaChoicePOSII"]}, "type"=>"30", "coverage_status"=>"1", "precertification_needed"=>"", "exclusions"=>"", "deductible_in_network"=>{"individual"=>{"base_period"=>"500", "remaining"=>"500", "comments"=>["MedDent", "MedDent"]}, "family"=>{"base_period"=>"1000", "remaining"=>"1000", "comments"=>["MedDent", "MedDent"]}}, "deductible_out_network"=>{"individual"=>{"base_period"=>"1250", "remaining"=>"1250", "comments"=>["MedDent", "MedDent"]}, "family"=>{"base_period"=>"3750", "remaining"=>"3750", "comments"=>["MedDent", "MedDent"]}}, "stop_loss_in_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"2000", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"4000", "comments"=>[]}}, "stop_loss_out_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"3000", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"6000", "comments"=>[]}}, "balance"=>"", "comments"=>[], "additional_insurance"=>{"comments"=>[]}}
end

def test_service_missing_params
  {"timestamp"=>"2013-02-04T17:23:12", "eligible_id"=>"7EEA40A7-58C5-4EBC-A450-10C37CA2D252", "mapping_version"=>"service/all$Revision:4$$Date:12-12-280:13$", "error"=>{"response_code"=>"Y", "response_description"=>"Yes", "agency_qualifier_code"=>"", "agency_qualifier_description"=>"", "reject_reason_code"=>"41", "reject_reason_description"=>"Authorization/AccessRestrictions", "follow-up_action_code"=>"C", "follow-up_action_description"=>"PleaseCorrectandResubmit"}}
end

def test_service
  {"timestamp"=>"2013-02-01T15:28:16", "eligible_id"=>"FD8994B1-F977-459A-81AC-D182EA8FE66D", "mapping_version"=>"service/all$Revision:4$$Date:12-12-280:13$", "type"=>"33", "coverage_status"=>"1", "service_begins"=>"", "service_ends"=>"", "not_covered"=>[], "comments"=>["AetnaChoicePOSII"], "precertification_needed"=>"", "visits_in_network"=>{"individual"=>{"total"=>"", "remaining"=>"", "comments"=>[]}, "family"=>{"total"=>"", "remaining"=>"", "comments"=>[]}}, "visits_out_network"=>{"individual"=>{"total"=>"", "remaining"=>"", "comments"=>[]}, "family"=>{"total"=>"", "remaining"=>"", "comments"=>[]}}, "copayment_in_network"=>{"individual"=>{"amount"=>"", "comments"=>[]}, "family"=>{"amount"=>"35", "comments"=>["OFFCHIROVISI", "COPAYNOTINCLUDEDINOOP", "MANPULATNCHRO"]}}, "copayment_out_network"=>{"individual"=>{"amount"=>"", "comments"=>[]}, "family"=>{"amount"=>"0", "comments"=>["MANPULATNCHRO"]}}, "coinsurance_in_network"=>{"individual"=>{"percent"=>"", "comments"=>[]}, "family"=>{"percent"=>"0", "comments"=>["OFFCHIROVISI", "MANPULATNCHRO"]}}, "coinsurance_out_network"=>{"individual"=>{"percent"=>"", "comments"=>[]}, "family"=>{"percent"=>"30", "comments"=>["CHIROVSTEVAL", "COINSAPPLIESTOOUTOFPOCKET", "MANPULATNCHRO"]}}, "deductible_in_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"", "comments"=>[]}}, "deductible_out_network"=>{"individual"=>{"base_period"=>"", "remaining"=>"", "comments"=>[]}, "family"=>{"base_period"=>"", "remaining"=>"", "comments"=>[]}}, "additional_insurance"=>{"comments"=>[]}}
end

def test_demographic_missing_params
  {"timestamp"=>"2013-02-05T13:21:38", "eligible_id"=>"AE9F5EB3-B4BF-4B2E-92C5-6307CE91DB81", "mapping_version"=>"demographic/dob$Revision:1$$Date:12-12-2619:01$", "error"=>{"response_code"=>"Y", "response_description"=>"Yes", "agency_qualifier_code"=>"", "agency_qualifier_description"=>"", "reject_reason_code"=>"41", "reject_reason_description"=>"Authorization/AccessRestrictions", "follow-up_action_code"=>"C", "follow-up_action_description"=>"PleaseCorrectandResubmit"}}
end

def test_demographic
  {"timestamp"=>"2013-02-05T13:14:36", "eligible_id"=>"DCE2FFB3-179A-4825-ADA6-B8108FB5FB90", "mapping_version"=>"demographic/all$Revision:4$$Date:12-12-2622:25$", "last_name"=>"AUSTEN", "first_name"=>"JANE", "member_id"=>"R112114321", "group_id"=>"060801203300001", "group_name"=>"TOWERGROUPCOMPANIES", "dob"=>"1955-12-14", "gender"=>"M", "address"=>{"street_line_1"=>"123SOUTH7THSTREET", "street_line_2"=>"", "city"=>"CHICAGO", "state"=>"CA", "zip"=>"89701"}}
end

def test_claim_missing_params
  {"success"=>"false", "created_at"=>"2013-06-03T23:53:39Z", "error"=>{"type"=>"scrub", "message"=>"you forgot to include gender"}} 
end

def test_post_claim
  {"timestamp"=>"2012-12-30T22:41:10", "eligible_id"=>"DCE2FFB3-179A-4825-ADA6-B8108FB5FB90", "mapping_version"=>"claim/status$Revision:1$$Date:12-12-3022:10$", "referenced_transaction_trace_number"=>"970779644", "claim_status_category_code"=>"F0", "claim_status_category_description"=>"Finalized-Theclaim/encounterhascompletedtheadjudicationcycleandnomoreactionwillbetaken.", "claim_status_code"=>"1", "claim_status_description"=>"Formoredetailedinformation,seeremittanceadvice.", "status_information_effective_date"=>"2007-03-13", "total_claim_charge_amount"=>"172", "claim_payment_amount"=>"126.9", "adjudication_finalized_date"=>"2007-03-18", "remittance_date"=>"2007-03-19", "remittance_trace_number"=>"458787", "payer_claim_control_number"=>"4121476181852", "claim_service_begin_date"=>"2007-02-23", "claim_service_end_date"=>"2007-02-28"}
end

def test_coverage_missing_params
  {"created_at"=>"2013-06-11T12:21:47Z", "eligible_id"=>"57c320d8-2e14-68ed-73d0-41c3b23c0f43", "error"=>{"response_code"=>"Y", "response_description"=>"Yes", "agency_qualifier_code"=>"", "agency_qualifier_description"=>"", "reject_reason_code"=>"41", "reject_reason_description"=>"Authorization/Access Restrictions", "follow-up_action_code"=>"C", "follow-up_action_description"=>"Please Correct and Resubmit", "details"=>""}}  
end

def test_coverage
  {"created_at"=>"2013-05-09T22:42:40Z", "eligible_id"=>"3233a9a1-a286-2896-ba3d-9f171303428b", "demographics"=>{"subscriber"=>{"last_name"=>"FRANKLIN", "first_name"=>"BENJAMIN", "member_id"=>"TYA445554301", "group_id"=>"3207524", "group_name"=>"FOUNDING FATHERS", "dob"=>"1701-10-17", "gender"=>"M", "address"=>{"street_line_1"=>"2 FRANKLIN STREET", "street_line_2"=>"", "city"=>"SAN FRANCISCO", "state"=>"CA", "zip"=>"94102"}}, "dependent"=>{"last_name"=>"FRANKLIN", "first_name"=>"IDA", "member_id"=>"ZZZ445554301", "group_id"=>"3207524", "group_name"=>"FOUNDING FATHERS", "dob"=>"1701-12-12", "gender"=>"F", "address"=>{"street_line_1"=>"2 FRANKLIN STREET", "street_line_2"=>"", "city"=>"SAN FRANCISCO", "state"=>"CA", "zip"=>"94102"}}}, "primary_insurance"=>{"name"=>"CIGNA", "id"=>"00001", "contacts"=>[{"contact_type"=>"url", "contact_value"=>"cignaforhcp.cigna.com"}], "service_providers"=>{"physicians"=>[{"insurance_type"=>"HN", "insurance_type_label"=>"Health Maintenance Organization (HMO)", "primary_care"=>"true", "restricted"=>"TRUE", "contact_details"=>[{"last_name"=>"JEFFERSON", "first_name"=>"THOMAS", "indentification_type"=>"Centers for Medicare and Medicaid Services National Provider Identifier", "identification_code"=>"2222222222", "contacts"=>[], "address"=>{"street_line_1"=>"PO BOX 2222222", "street_line_2"=>"", "city"=>"SAN FRANCISCO", "state"=>"CA", "zip"=>"94105"}}], "dates"=>[{"date_type"=>"eligibility", "date_value"=>"2010-01-01"}], "comments"=>["HRA BALANCE"]}]}}, "plan"=>{"type"=>"30", "coverage_status"=>"1", "coverage_status_label"=>"ACTIVE COVERAGE", "coverage_basis"=>[], "plan_number"=>"43", "plan_name"=>"TRADITIONAL BLUE PPO 813 $15/ $15 COPAY", "group_name"=>"FOUNDING FATHERS", "dates"=>[{"date_type"=>"plan_begin", "date_value"=>"2010-01-01"}, {"date_type"=>"service", "date_value"=>"2013-05-24"}, {"date_type"=>"eligibility_begin", "date_value"=>"2007-02-01"}], "exclusions"=>{"noncovered"=>[{"type"=>"BZ", "type_label"=>"Physician Visit - Well", "time_period"=>"32", "time_period_label"=>"lifetime", "level"=>"INDIVIDUAL", "network"=>"OUT", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "dates"=>[], "contact_details"=>[], "comments"=>[]}], "pre_exisiting_condition"=>{"waiting_period"=>[]}}, "financials"=>{"deductible"=>{"remainings"=>{"in_network"=>[{"amount"=>"0", "level"=>"FAMILY", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}, {"amount"=>"0", "level"=>"INDIVIDUAL", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}], "out_network"=>[]}, "totals"=>{"in_network"=>[{"amount"=>"0", "time_period"=>"24", "time_period_label"=>"year_to_date", "level"=>"INDIVIDUAL", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}, {"amount"=>"0", "time_period"=>"23", "time_period_label"=>"calendar_year", "level"=>"INDIVIDUAL", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}, {"amount"=>"0", "time_period"=>"24", "time_period_label"=>"year_to_date", "level"=>"FAMILY", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}, {"amount"=>"0", "time_period"=>"23", "time_period_label"=>"calendar_year", "level"=>"FAMILY", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}], "out_network"=>[]}}, "stop_loss"=>{"remainings"=>{"in_network"=>[{"amount"=>"6490", "level"=>"INDIVIDUAL", "insurance_type"=>"HN", "insurance_type_label"=>"Health Maintenance Organization (HMO) - Medicare Risk", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}, {"amount"=>"0", "level"=>"FAMILY", "insurance_type"=>"HN", "insurance_type_label"=>"Health Maintenance Organization (HMO) - Medicare Risk", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}], "out_network"=>[]}, "totals"=>{"in_network"=>[{"amount"=>"210", "time_period"=>"24", "time_period_label"=>"year_to_date", "level"=>"INDIVIDUAL", "insurance_type"=>"HN", "insurance_type_label"=>"Health Maintenance Organization (HMO) - Medicare Risk", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}, {"amount"=>"210", "time_period"=>"24", "time_period_label"=>"year_to_date", "level"=>"FAMILY", "insurance_type"=>"HN", "insurance_type_label"=>"Health Maintenance Organization (HMO) - Medicare Risk", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}, {"amount"=>"0", "time_period"=>"23", "time_period_label"=>"calendar_year", "level"=>"FAMILY", "insurance_type"=>"HN", "insurance_type_label"=>"Health Maintenance Organization (HMO) - Medicare Risk", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}, {"amount"=>"6700", "time_period"=>"23", "time_period_label"=>"calendar_year", "level"=>"INDIVIDUAL", "insurance_type"=>"HN", "insurance_type_label"=>"Health Maintenance Organization (HMO) - Medicare Risk", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[], "comments"=>[]}], "out_network"=>[]}}, "spending_account"=>{"remaining"=>[]}, "coinsurance"=>{"percents"=>{"in_network"=>[], "out_network"=>[]}}, "copayment"=>{"amounts"=>{"in_network"=>[{"amount"=>"20", "time_period"=>"", "time_period_label"=>"", "level"=>"INDIVIDUAL", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "dates"=>[], "contact_details"=>[], "comments"=>[]}], "out_network"=>[{"amount"=>"40", "time_period"=>"", "time_period_label"=>"", "level"=>"INDIVIDUAL", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "dates"=>[], "contact_details"=>[], "comments"=>[]}]}}, "cost_containment"=>{"remainings"=>{"in_network"=>[], "out_network"=>[]}, "totals"=>{"in_network"=>[], "out_network"=>[]}}, "spend_down"=>{"remainings"=>{"in_network"=>[], "out_network"=>[]}, "totals"=>{"in_network"=>[], "out_network"=>[]}}, "limitations"=>{"amounts"=>[]}, "disclaimer"=>[], "other_sources"=>{"amounts"=>[]}}, "benefit_details"=>{"benefit_type_label"=>{"amounts"=>[]}, "managed_care"=>{"amounts"=>[]}, "unlimited"=>{"amounts"=>[]}}, "additional_insurance_policies"=>[{"insurance_type"=>"47", "insurance_type_label"=>"Medicare Secondary, Other Liability Insurance is Primary", "coverage_description"=>"", "reference"=>[{"reference_code"=>"IG", "reference_label"=>"Insurance Policy Number", "reference_number"=>"1232004008"}], "contact_details"=>[{"last_name"=>"CLAIMS MANAGEMENT INC", "first_name"=>"", "indentification_type"=>"", "identification_code"=>"", "contacts"=>[], "address"=>{"street_line_1"=>"PO BOX 2210", "street_line_2"=>"ATTN JANE AUSTEN", "city"=>"SAN FRANCISCO", "state"=>"CA", "zip"=>"941052312"}}], "dates"=>[{"date_type"=>"coordination_of_benefits", "date_value"=>"2005-02-12"}], "comments"=>[]}]}, "services"=>[{"type"=>"96", "type_label"=>"Physician Professional", "coverage_status"=>"11", "coverage_status_label"=>"generic inquiry provided no information for this service type. Retry by including service_type_code=96 for an explicit inquiry for this service type."}, {"type"=>"98", "type_label"=>"Professional Physician Visit - Office", "coverage_status"=>"1", "coverage_status_label"=>"active coverage", "authorization_required"=>"", "noncovered"=>[], "facility"=>{"amounts"=>[{"amount"=>"", "time_period"=>"26", "time_period_label"=>"EPISODE", "level"=>"INDIVIDUAL", "network"=>"Y", "insurance_type"=>"MA", "insurance_type_label"=>"MEDICARE PART A", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "contact_details"=>[], "dates"=>[{"date_type"=>"benefit_begin", "date_value"=>"2013-05-20"}], "comments"=>["Revocation Code - 0"]}]}, "benefit_details"=>{"benefit_type_label"=>{"amounts"=>[]}, "managed_care"=>{"amounts"=>[]}, "unlimited"=>{"amounts"=>[]}}, "financials"=>{"deductible"=>{}, "stop_loss"=>{}, "spending_account"=>{}, "coinsurance"=>{}, "copayment"=>{}, "cost_containment"=>{}, "spend_down"=>{}, "limitations"=>{}, "other_sources"=>{}}, "visits"=>{"amounts"=>{"in_network"=>[{"amount"=>"20", "time_period"=>"", "time_period_label"=>"", "level"=>"INDIVIDUAL", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "dates"=>[], "contact_details"=>[], "comments"=>[]}], "out_network"=>[{"amount"=>"40", "time_period"=>"", "time_period_label"=>"", "level"=>"INDIVIDUAL", "insurance_type"=>"", "insurance_type_label"=>"", "pos"=>"", "pos_label"=>"", "authorization_required"=>"", "dates"=>[], "contact_details"=>[], "comments"=>[]}]}}, "additional_insurance_policies"=>[{"insurance_type"=>"47", "insurance_type_label"=>"Medicare Secondary, Other Liability Insurance is Primary", "coverage_description"=>"", "reference"=>[{"reference_code"=>"IG", "reference_label"=>"Insurance Policy Number", "reference_number"=>"1232004008"}], "contact_details"=>[{"last_name"=>"CLAIMS MANAGEMENT INC", "first_name"=>"", "indentification_type"=>"", "identification_code"=>"", "contacts"=>[], "address"=>{"street_line_1"=>"PO BOX 2210", "street_line_2"=>"ATTN JANE AUSTEN", "city"=>"SAN FRANCISCO", "state"=>"CA", "zip"=>"941052312"}}], "dates"=>[{"date_type"=>"coordination_of_benefits", "date_value"=>"2005-02-12"}], "comments"=>[]}]}]} 
end

def test_enrollment_missing_params
  {"error" =>"Expeting enrollment_request_id or npis"}
end

def test_get_enrollment
  [{"enrollment_npi"=>{"address"=>"985 Snow Shoe Road", "city"=>"Sacramento", "created_at"=>"2013-04-24T21:47:31+00:00", "facility_name"=>"Quality", "npi"=>"987654321", "provider_name"=>"Jack Austen", "ptan"=>"54321", "state"=>"CA", "status"=>"rejected", "tax_id"=>"12345678", "updated_at"=>"2013-04-28T17:10:00+00:00", "zip"=>"94107", "enrollment_insurance_company"=>{"name"=>"Medicare", "payer_id"=>"00431"}}}, {"enrollment_npi"=>{"address"=>"985 Snow Shoe Road", "city"=>"Sacramento", "created_at"=>"2013-04-24T21:47:31+00:00", "facility_name"=>"Quality", "npi"=>"987654321", "provider_name"=>"Jack Austen", "ptan"=>"54321", "state"=>"CA", "status"=>"accepted", "tax_id"=>"12345678", "updated_at"=>"2013-04-28T22:51:43+00:00", "zip"=>"94107", "enrollment_insurance_company"=>{"name"=>"Kaiser North", "payer_id"=>"00282"}}}]
end

def test_post_enrollment
  {"enrollment_request"=>{"created_at"=>"2013-04-14T07:29:09-07:00", "id"=>5, "status"=>"pending", "updated_at"=>"2013-04-14T07:29:09-07:00", "enrollment_npis"=>[{"address"=>"125 Snow Shoe Road", "city"=>"Sacramento", "created_at"=>"2013-04-14T07:29:09-07:00", "facility_name"=>"Quality", "npi"=>"987654321", "provider_name"=>"Jane Austen", "ptan"=>"54321", "state"=>"CA", "status"=>"submitted", "tax_id"=>"12345678", "updated_at"=>"2013-04-14T07:29:09-07:00", "zip"=>"94107", "enrollment_insurance_company"=>{"name"=>"Medicare", "payer_id"=>"00431"}}, {"address"=>"125 Snow Shoe Road", "city"=>"Sacramento", "created_at"=>"2013-04-14T07:29:09-07:00", "facility_name"=>"Quality", "npi"=>"987654321", "provider_name"=>"Jane Austen", "ptan"=>"54321", "state"=>"CA", "status"=>"submitted", "tax_id"=>"12345678", "updated_at"=>"2013-04-14T07:29:09-07:00", "zip"=>"94107", "enrollment_insurance_company"=>{"name"=>"Medicare", "payer_id"=>"00431"}}, {"address"=>"125 Snow Shoe Road", "city"=>"Sacramento", "created_at"=>"2013-04-14T07:29:09-07:00", "facility_name"=>"Quality", "npi"=>"987654321", "provider_name"=>"Jane Austen", "ptan"=>"54321", "state"=>"CA", "status"=>"submitted", "tax_id"=>"12345678", "updated_at"=>"2013-04-14T07:29:09-07:00", "zip"=>"94107", "enrollment_insurance_company"=>{"name"=>"Kaiser Nort", "payer_id"=>"00282"}}, {"address"=>"125 Snow Shoe Road", "city"=>"Sacramento", "created_at"=>"2013-04-14T07:29:09-07:00", "facility_name"=>"Quality", "npi"=>"987654321", "provider_name"=>"Jane Austen", "ptan"=>"54321", "state"=>"CA", "status"=>"submitted", "tax_id"=>"12345678", "updated_at"=>"2013-04-14T07:29:09-07:00", "zip"=>"94107", "enrollment_insurance_company"=>{"name"=>"Kaiser Nort", "payer_id"=>"00282"}}]}} 
end