class S3Wrapper

  def initialize
    @s3= Aws::S3::Resource.new(region: ENV["AWS_REGION"])
  end

  def upload(bucket_name, name, filename)
   bucket(bucket_name)
   obj = @s3.bucket(bucket_name).object(name)
   obj.upload_file(filename, {acl: "public-read"})
   obj.public_url
  end

  def clear(bucket_name)
    @s3.bucket(bucket_name).clear!
  end

  private
  def bucket(name)
    bucket=@s3.bucket(name)
    bucket.create unless bucket.exists?
  end

end