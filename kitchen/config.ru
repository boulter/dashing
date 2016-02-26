require 'dashing'
require './configuration'

configure do
  set :auth_token, 'YOUR_AUTH_TOKEN'

  helpers do
    def protected!
     # Put any authentication code you want in here.
     # This method is run before accessing any resource.
      unless authorized?
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      if request.cookies and request.cookies['p'] == WEB_PASSWORD
        return true
      end
      if request['p'] == WEB_PASSWORD
        response.set_cookie("p", :value => WEB_PASSWORD)
        return true
      end
      return false
    end
  end
end

map Sinatra::Application.assets_prefix do
  run Sinatra::Application.sprockets
end

run Sinatra::Application
