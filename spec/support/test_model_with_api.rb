require 'id/http'

class TestModelWithApi
  include Id::Model
  include Id::Http

  field :id
  field :name

  resource :find, 'test-model-api/:id'
  resources :for_name, 'test-model-api/name/:name'
end
