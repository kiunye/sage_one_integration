require "csv"
require "httparty"

class SageOneService
  API_BASE_URL = ENV["SAGE_ONE_API_URL"]
  HEADERS = {
    "Authorization" => "Bearer #{ENV["SAGE_ONE_API_KEY"]}",
    "Content-Type" => "application/json"
  }

  def self.send_data(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      payload = transform_csv_row_to_payload(row)
      response = HTTParty.post("#{API_BASE_URL}/endpoint", headers: HEADERS, body: payload.to_json)

      if response.success?
        puts "Data sent successfully: #{response.body}"
      else
        puts "Failed to send data: #{response.body}"
      end
    end
  end

  private

  def self.transform_csv_row_to_payload(row)
    {
      # Map CSV columns to Sage One API fields
      field1: row["column1"],
      field2: row["column2"]
      # Add more fields as needed
    }
  end
end
