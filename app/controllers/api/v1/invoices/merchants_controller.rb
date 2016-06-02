module Api
  module V1
    class Invoices::MerchantsController < ApiController
       respond_to :json

       def show
         respond_with Invoice.find(params[:id]).merchant
       end
    end
  end
end
