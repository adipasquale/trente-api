Rails.application.routes.draw do
  namespace 'v1' do
    resources 'guests', only: [:index, :create, :destroy]
  end
end
