module Api
  module V1
    class Merchants::ItemsController < ApplicationController
      respond_to :json

      def index
        respond_with Merchant.find(params[:id]).items
      end
    end
  end
end
