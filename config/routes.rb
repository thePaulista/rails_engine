Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :customers, only: [:index, :show] do
        collection do
          get "/find", to: "customers#find"
          get "/find_all", to: "customers#find_all"
          get "/random", to: "customers#random"
        end
      end

      get "customers/:id/invoices", to: "customers/invoices#index"
      get "customers/:id/transactions", to: "customers/transactions#index"
      get "customers/:id/favorite_merchant", to: "customers/favorite_merchants#show"

      resources :merchants, only: [:index, :show] do
        collection do
          get "/find", to: "merchants#find"
          get "/find_all", to: "merchants#find_all"
          get "/random", to: "merchants#random"
          get "/most_items", to: "merchants#most_items_index"
          get "/most_revenue", to: "merchants#top_merchants_index"
        end
      end
      get "merchants/:id/items", to: "merchants/items#index"
      get "merchants/:id/invoices", to: "merchants/invoices#index"
      get "merchants/:id/revenue", to: "merchants/revenues#show"
      get "merchants/:id/favorite_customer", to: "merchants/revenues#favorite_customer_show"
      get "merchants/:id/customers_with_pending_invoices", to: "merchants/revenues#customers_with_pending_invoices_show"
      get "merchants/revenues", to: "merchants/revenues#revenue_by_date_index"

      resources :invoices, only: [:index, :show] do
        collection do
          get "/find", to: "invoices#find"
          get "/find_all", to: "invoices#find_all"
          get "/random", to: "invoices#random"
        end
      end

      get "invoices/:id/transactions", to: "invoices/transactions#index"
      get "invoices/:id/invoice_items", to: "invoices/invoice_items#index"
      get "invoices/:id/items", to: "invoices/items#index"
      get "invoices/:id/customer", to: "invoices/customers#show"
      get "invoices/:id/merchant", to: "invoices/merchants#show"

      resources :items, only: [:index, :show] do
        collection do
          get "/find", to: "items#find"
          get "/find_all", to: "items#find_all"
          get "/random", to: "items#random"
        end
      end

      get "items/:id/invoice_items", to: "items/invoice_items#index"
      get "items/:id/merchant", to: "items/merchants#show"
      get "items/most_revenue", to: "items/revenues#show"
      get "items/:id/best_day", to: "items/revenues#best_day_show"

      resources :invoice_items, only: [:index, :show] do
        collection do
          get "/find", to: "invoice_items#find"
          get "/find_all", to: "invoice_items#find_all"
          get "/random", to: "invoice_items#random"
        end
      end

      get "invoice_items/:id/invoice", to: "invoice_items/invoices#show"
      get "invoice_items/:id/item", to: "invoice_items/items#show"

      resources :transactions, only: [:index, :show] do
        collection do
          get "find", to: "transactions#find"
          get "find_all", to: "transactions#find_all"
          get "random", to: "transactions#random"
        end
      end

      get "transactions/:id/invoice", to: "transactions/invoices#show"
    end
  end
end
