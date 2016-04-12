require 'google/api_client'
require 'google_drive'

class GoogleDriveService
  def initialize
    @session = GoogleDrive.saved_session("config.json")
  end

  def read_mails
    ws = @session.spreadsheet_by_key(ENV["DRIVE_TESTERS"]).worksheets[0]
    return ws.rows.map{ |r| r[0] }
  end

  def stock_mail(mail)
    ws = @session.spreadsheet_by_key(ENV["DRIVE_MAILS"]).worksheets[0]
    ws[0][ws.num_cols] = mail
    ws.save
  end
end
