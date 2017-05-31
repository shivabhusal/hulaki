require 'amatch'

class Hulaki::SearchEngine
  include Amatch

  def initialize
    contact_parser = Hulaki::ContactParser.new
    @csv_data = contact_parser.perform
  end

  def perform(search_data)
    unless @csv_data.nil?
      search(search_data)
    end
  end

  private

  def search(data)
    result = search_result(data).select { |x| x[1] > 0.4 } # setting threshold
    # Sort data keeping data with higer degree of similarity at the top
    # i.e. having lowest value of percentage at the bottom
    result.sort { |x, y| y[1] <=> x[1] }
  end

  def search_result(data)
    downcased_data = data.downcase.gsub(' ', '')
    @csv_data.map do |row|
      max_point = 0.0
      row.each do |col_head, v|
        keys_to_search.each do |key, weight|
          if col_head.to_s.downcase == key
            point = PairDistance.new(v.to_s.downcase).match(downcased_data)*weight
            max_point = point if max_point < point
            # puts "#{key} #{col_head} #{point} #{v} #{downcased_data}"
          end
        end
      end

      [row, max_point]
    end
  end

  def keys_to_search
    {
      'name'        => 2, 'first_name'  => 3, 'last_name'        => 3, 'given_name' => 3,
      'family_name' => 3, 'email'     => 0.6, 'phone_1___value'=> 0.5, 'phone_2___value' => 0.5
    }
  end
end
