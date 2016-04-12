require 'google/api_client'
require 'google_drive'

class GoogleDriveService
  def initialize
    @session = GoogleDrive.saved_session("config/g_drive_config.json")
  end

  def read_mails
    ws = @session.spreadsheet_by_key(ENV["DRIVE_TESTERS"]).worksheets[0]
    return ws.rows.map{ |r| r[0] }
  end

  def stock_mail(mail)
    ws = @session.spreadsheet_by_key(ENV["DRIVE_MAILS"]).worksheets[0]
    ws[ws.num_rows+1, 1] = mail
    ws.save
  end
end
