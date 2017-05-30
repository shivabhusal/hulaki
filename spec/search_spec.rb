require 'spec_helper'

describe Hulaki::SearchEngine do
  context "successfully finds the contact" do
    it "returns the details of entered value" do
      search_engine = Hulaki::SearchEngine.new
      response = search_engine.perform("yubraj")
      expect(response[0][0]['name']).to eq("Yubraj Acharya")
      expect(response[0][0]['first_name']).to eq("Yubraj")
      expect(response[0][0]['last_name']).to eq("Acharya")
    end

    it "returns the details of entered value" do
      search_engine = Hulaki::SearchEngine.new
      response = search_engine.perform("shivasal")
      expect(response[0][0]['name']).to eq("Shiva Bhusal")
      expect(response[0][0]['first_name']).to eq("Shiva")
      expect(response[0][0]['last_name']).to eq("Bhusal")
    end
  end

  context "cannot find the contact" do
    it "should return an error" do
      search_engine = Hulaki::SearchEngine.new
      response = search_engine.perform("something not in database")
      expect(response).to eq([])
    end
  end
end
