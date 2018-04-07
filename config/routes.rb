Rails.application.routes.draw do
  root "lotto#index"
  get 'lotto/index'
  get 'lotto/result' => 'lotto#pick_and_check'
end
