module Api
  module V1
    class Invoices::MerchantsController < ApiController
       def show
         respond_with Invoice.find(params[:id]).merchant
       end
    end
  end
end
