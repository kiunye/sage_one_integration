class FetchFtpFilesJob < ApplicationJob
  queue_as :default

  def perform
    FtpService.download_files
    SolidCable.broadcast_to("file_updates", { message: "File processed successfully" })
  end
end