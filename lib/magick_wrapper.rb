class MagickWrapper
  def initialize(filename)
    @filename=filename
    @img=Magick::Image.read(filename).first

  end

  def thumbnail(size)
    result=Hash.new
    thumbnail_file=@filename.sub(".", "_#{size}.")

    @img.thumbnail(size, size).write(thumbnail_file)

    thumbnail_file
  end
end