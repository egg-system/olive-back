class Api::ApiController < ApplicationController
	skip_before_action :authenticate_staff!
end
