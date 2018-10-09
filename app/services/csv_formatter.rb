class CsvFormatter

  require 'csv'

  def self.format(file)
    hashed_rows = []
    CSV.parse file, headers: true, col_sep: ';', skip_blanks: true do |row|
      hashed_rows << row.to_h.delete_if { |key, value| key.nil? }
    end
    hashed_rows
  end
end
