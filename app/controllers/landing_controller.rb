class LandingController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_policy_scoped
  def index
    if current_user
      redirect_to trips_path
    end
  end
end
