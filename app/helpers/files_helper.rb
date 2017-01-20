module FilesHelper
  def file_name(file)
    file.name.split('.')[0].titlecase
  end

  def file_slug(file)
    file.name.split('.')[0].parameterize
  end
end
