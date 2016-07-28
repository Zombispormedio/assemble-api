class ImageHelper

  cattr_reader :FULL
  @@FULL=160

  cattr_reader :LARGE
  @@LARGE=80

  cattr_reader :MEDIUM
  @@MEDIUM=40

  cattr_reader :THUMB
  @@THUMB=20

  def initialize(filename, bucket_name)
    @bucket_name=bucket_name
    @magic= MagickWrapper.new(filename)
    @s3=S3Wrapper.new
  end

  def clear
    @s3.clear(@bucket_name)
  end

  def full
    up @magic.thumbnail @@FULL
  end

  def large
    up @magic.thumbnail @@LARGE
  end

  def medium
    up @magic.thumbnail @@MEDIUM

  end

  def thumb
    up @magic.thumbnail @@THUMB

  end

  private

  def up(path)
    basename= File.basename(path)
    @s3.upload @bucket_name, basename, path
  end




end