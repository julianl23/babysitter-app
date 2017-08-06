class SearchController < ApplicationController
  def index
    @featured_babysitters = User.where role_id: 2
  end
end
