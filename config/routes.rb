TruckMileageEstimator::Application.routes.draw do

  root to: "static#home"
  resources :estimates, only: [:create]

end
