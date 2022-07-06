Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions, registrations: :registrations, invitations: :invitations },
                     path_names: { sign_in: :login, sign_out: :logout }

  mount API => "/"
  get '/user/signup/invitation' => 'invitations#accept_invitation', as: :user_accept_invitation
end
