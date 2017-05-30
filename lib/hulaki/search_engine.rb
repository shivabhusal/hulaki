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
    result = search_result(data).select { |x| x[1] > 1 } # setting threshold
    # Sort data keeping data with higer degree of similarity at the top
    # i.e. having lowest value of percentage at the bottom
    result.sort { |x, y| y[1] <=> x[1] }
  end

  def search_result(data)
    downcased_data = data.downcase
    @csv_data.map do |row|
      pt = 0.0
      # searched_cols = 0.0
      row.each do |k, v|
        keys_to_search.each do |key|
          if k.to_s.downcase.match(key.to_s)
            # searched_cols += 1
            pt += PairDistance.new(v.to_s.downcase).match(downcased_data)
          end
        end
      end

      # weight = pt / searched_cols
      # percentage = weight * 100.0
      [row, pt]
    end
  end

  def keys_to_search
    ['name', 'email', 'phone']
  end
end
