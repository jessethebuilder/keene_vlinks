require 'dropbox'

class FilesController < ApplicationController
  def index
    @folder = dropbox_folder
  end

  def show
    @file = file_from(dropbox_folder, params[:id])
    # send_file dropbox.download(@file.path_lower)[1].stream!
    # send_file
    @body = dropbox.download(@file.path_lower)[1]
    send_data @body, filename: @file.name, type: 'video/quicktime'
  end

  private

  def file_from(folder, slug)
    folder.each do |file|
      if file.name =~ /#{slug.gsub('-', ' ')}/i
        return file
      end
    end

    raise ArgumentError, "#{slug} is not a recognized file."
  end

  def dropbox
    @dropbox ||= Dropbox::Client.new(ENV['DROPBOX_TOKEN'])
  end

  def dropbox_folder
    @dropbox_folder ||= dropbox.list_folder("/#{ENV['DROPBOX_FOLDER']}")
  end
end
