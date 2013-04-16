ChromeExtensionUpdateCenter::Application.routes.draw do
  resources :extensions do
    collection do
      get '/updates.xml' => 'extensions#updates', format: :xml
    end

    member do
      get '/crx' => 'extensions#crx'
    end
  end

  root :to => redirect('/extensions')
end
