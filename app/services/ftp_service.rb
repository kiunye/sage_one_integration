require 'net/sftp'

class FtpService
  def self.download_files
    Net::SFTP.start(ENV['FTP_HOST'], ENV['FTP_USERNAME'], password: ENV['FTP_PASSWORD']) do |sftp|
      sftp.dir.foreach('/path/to/ftp/folder') do |entry|
        next unless entry.name.end_with?('.csv')

        remote_path = "/path/to/ftp/folder/#{entry.name}" # Change this to match the actual name of the folder and the file name
        local_path = Rails.root.join('tmp', entry.name)

        sftp.download!(remote_path, local_path)
        process_file(local_path)
      end
    end
  end

  private

  def self.process_file(file_path)
    # Process the CSV file and send data to Sage One API
    SageOneService.send_data(file_path)
  end
end