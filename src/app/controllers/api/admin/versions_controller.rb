module ::Api
  module Admin
    class VersionsController < ::ApplicationController
      # versionが更新されたか確認
      def index
        render plain: Rails.version
      end
    end
  end
end
