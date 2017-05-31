require 'terminal-table'
class Hulaki::Presenter
  def initialize(data)
    no_of_results = Hulaki::Config['search'] && Hulaki::Config['search']['no_of_results'] || 10
    @data = data[0..(no_of_results - 1)]
  end

  def display
    data = @data.map(&:first).map.with_index do |row, index|
      [index+1, row['name'].bold, row['phone_1___value'].to_s.green, row['phone_2___value'], row['email']]
    end

    table = Terminal::Table.new :title    => "Hulaki #{Hulaki::VERSION}",
                                :headings => ['S.N', 'Name', 'Phone 1', 'Phone 2', 'Email'],
                                :rows     => data

    table.align_column(2, :right)
    table.align_column(3, :right)
    table.align_column(4, :right)

    puts table
  end
end
