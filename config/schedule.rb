every 1.hour do
    runner "FetchFtpFilesJob.perform_later"
  end
