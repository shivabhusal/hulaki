class Hulaki::Presenter
  def initialize(data)
    @data = [data].flatten
  end

  def display
    puts '~' * 100
    puts 'Search Results'
    puts '~' * 100
    @data[0..5].each do |row|
      email = row.fetch('e_mail_1___value', 'N/A') rescue 'N/A'
      phone_number = row.fetch('phone_1___value', 'N/A') rescue 'N/A'
      puts "name: #{row['name']}, phone: #{phone_number}, email: #{email}" rescue nil
    end
    puts '~' * 100
  end
end
