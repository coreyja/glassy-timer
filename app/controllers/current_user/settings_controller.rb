module CurrentUser
  class SettingsController < ApplicationController
    before_action :require_login

    def show
      render
    end
  end
end
