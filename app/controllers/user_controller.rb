class UserController < ApplicationController
  before_action :new

  def new
    @user ||= User.new(params[:first_name], params[:last_name], params[:birthday], params[:insurance_provider], params[:member_id])
  end

  def index
    p "&" * 80
    p params
  end

  def results
    result = @user.verify_insurance
    if result != nil && result.body != "Could not authenticate you. Please re-try with a valid API key."
      binding.pry_remote
      @results = get_verification_results(JSON.parse(result.body))
    else
      @results = nil
    end
    render :partial => 'results' 

  end

end
