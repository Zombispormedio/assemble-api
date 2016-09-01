class ImageHelper

  cattr_reader :FULL
  @@FULL=256

  cattr_reader :LARGE
  @@LARGE=128

  cattr_reader :MEDIUM
  @@MEDIUM=64

  cattr_reader :THUMB
  @@THUMB=32

  def initialize(filename, bucket_name)
    @filename=filename
    @bucket_name=bucket_name
    @magic= MagickWrapper.new(filename)
    @s3=S3Wrapper.new
  end

  def clear_remote
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

  def clean
    p FileUtils.rm_rf File.dirname(@filename)
  end

  private

  def up(path)
    basename= File.basename(path)

    @s3.upload @bucket_name, basename, path
  end




end