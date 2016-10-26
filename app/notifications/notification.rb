require 'rest-client'

class Notification
  include NotificationI18N


  def initialize
    @url=ENV["NOTIFICATION_HOST"]
    @headers={
        content_type: :json, accept: :json,
        Authorization: ENV["NOTIFICATION_KEY"]
    }
    @obj={app_id:ENV["NOTIFICATION_APP_ID"], data:Hash.new}

  end

  def template(t)
    t.each{|k, v| @obj[k]=v}
    self
  end

  def contents(c)
    @obj[:contents]={en:c}
    self
  end

  def format_contents(elems)
    contents=@obj[:contents]
    @obj[:contents]=contents.reduce(contents)do |h,(k, v)|
      h[k]=v%elems
      h
    end
    self
  end

  def heading(h)
    @obj[:headings]={en:h}
    self
  end
  def type(t)
    @obj[:data][:type]=t;
  end
  def data(data)
    data.each{|k, v| @obj[:data][k]=v}
    self
  end


  def email(e)
    @obj[:filters]=[{field:"email",  value:e}]
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