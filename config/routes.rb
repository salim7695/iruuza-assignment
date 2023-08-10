require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, controllers: {
    sessions: 'admin_users/sessions'
  }, skip: %w[registrations]

  root to: 'application#redirect_to_sign_in'

  resources :admin_users, only: %w[#<WebFront:0x00007ffa4cf05750>]

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resource :user_bookings, only: :create
      resources :books, only: :index
    end
  end

  namespace :dashboard do
    # TODO: customizable table name
    devise_for :admin_users, controllers: {
      sessions: 'dashboard/admin_users/sessions',
      passwords: 'dashboard/admin_users/passwords'
    }, skip: %w[registrations]

    resources :admin_users, only: %w[index show]
  end

  get '*path' => redirect('/')

  unless Rails.env.development?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      admin_username = ENV['SIDEKIQ_DASHBOARD_USERNAME']
      admin_password = ENV['SIDEKIQ_DASHBOARD_PASSWORD']
      ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(username),
        ::Digest::SHA256.hexdigest(admin_username)
      ) && ActiveSupport::SecurityUtils.secure_compare(
        ::Digest::SHA256.hexdigest(password),
        ::Digest::SHA256.hexdigest(admin_password)
      )
    end
  end
  mount Sidekiq::Web => '/sidekiq'
end
