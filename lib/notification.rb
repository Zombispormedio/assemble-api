require 'rest-client'

class Notification
  def initialize
    @url=ENV["FIREBASE_HOST"]
    @headers={
        content_type: :json, accept: :json,
        Authorization: ENV["FIREBASE_KEY"]
    }
    @notification={icon: "logo", color: "#2196f3", sound: "default"}
  end

  def title_key(key)
    @notification[:title_loc_key]=key
    self
  end

  def body(b)
    @notification[:body]=b
    self
  end

  def click_action(c)
    @notification[:click_action]=c
    self
  end

  def user(token)
    @to=token
    self
  end

  def set_data(d)
    @data=d
    self
  end

  def send
    begin
     response= RestClient.post(@url, {
          to: @to,
          notification: @notification,
          data: @data
      }.to_json, @headers)

    rescue RestClient::ExceptionWithResponse => e
      p e.response
    end

    response
  end

end