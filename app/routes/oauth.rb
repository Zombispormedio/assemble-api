module Routes
  module API
    module V1
      class OAuth < Base
        include Endpoint
        namespace self.prefix do
          get "/h" do
            "dfsdff"
          end

          get do
            "Hey"
          end



      end


      end
    end
  end
end