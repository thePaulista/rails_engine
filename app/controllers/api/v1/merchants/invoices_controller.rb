module Api
  module V1
    class Merchants::InvoicesController < ApplicationController
      respond_to :json

      def index
        respond_with Merchant.find(params[:id]).invoices
      end
    end
  end
end
