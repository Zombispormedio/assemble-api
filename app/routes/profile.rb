module Routes
  class Profile < Authenticable
   include ProfileController
   namespace "/profile" do

     patch "/avatar" do
       resolve upload_avatar params["avatar"]
     end

     patch "/username" do
        body=bind_body
        resolve change_username body["username"]
     end

     patch "/bio" do
       body=bind_body
       resolve change_bio body["bio"]
     end

     patch "/location" do
       body=bind_body
       resolve change_location body["location"]
     end


     patch "/birth_date" do
       body=bind_body
       resolve change_birth_date body["birth_date"]
     end

   end


  end
end