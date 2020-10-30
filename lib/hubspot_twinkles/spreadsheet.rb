module HubspotTwinkles
  class Spreadsheet
    def add_deal(deal)
      row = [
        deal.properties["deal_company"],
        deal.properties["dealname"],
        deal.properties["amount_in_home_currency"],
        parse_timestamp(deal.properties["expected_start_date"])
      ]
      append_row(row)
    end

    def append_row(row)
      pos = num_rows + 1
      row.each_with_index do |cell, index|
        worksheet[pos, index + 1] = encode_cell(cell)
      end
      worksheet.save
    end

    private

    def parse_timestamp(date)
      return if date.blank?

      Time.at(date.to_i / 1000).to_date.to_s
    end

    def encode_cell(cell)
      cell.to_s.dup.force_encoding("UTF-8")
    end

    def num_rows
      worksheet.num_rows
    end

    def key
      @key ||= StringIO.new(ENV["GOOGLE_DRIVE_JSON_KEY"])
    end

    def session
      @session ||= GoogleDrive::Session.from_service_account_key(key)
    end

    def worksheet
      @worksheet ||= spreadsheet.worksheet_by_sheet_id(ENV["WORKSHEET_ID"])
    end

    def spreadsheet
      @spreadsheet ||= session.spreadsheet_by_key(ENV["SPREADSHEET_ID"])
    end
  end
end
