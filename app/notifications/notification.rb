require 'rest-client'

class Notification
  include NotificationCompat
  include NotificationI18N


  def initialize
    @url=ENV["NOTIFICATION_HOST"]
    @headers={
        content_type: :json, accept: :json,
        Authorization: ENV["NOTIFICATION_KEY"]
    }
    @obj={app_id:ENV["NOTIFICATION_APP_ID"], template_id:MESSAGE_TEMPLATE}
    @obj[:android_group]=MESSAGE_GROUP
  end

  def template(t)
    @obj[:template_id]=t
    self
  end

  def contents(c)
    @obj[:contents]=c
    self
  end

  def heading(h)
    @obj[:headings]=h
    self
  end

  def data(data)
    @obj[:data]=data
    self
  end


  def email(e)
    @obj[:filters]=[{field:"email",  relation: "=", value:e}]
    self
  end

  def group(g)
    @obj[:android_group]=g
    self
  end

  def group_message(m)
    @obj[:android_group_message]=m
    self
  end

  def send
    begin
      response= RestClient.post(@url, @obj.to_json, @headers)
      p @obj
    rescue RestClient::ExceptionWithResponse => e
      p e.response
    end

    response
  end

end