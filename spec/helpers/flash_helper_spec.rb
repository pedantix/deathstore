require "rails_helper"

describe FlashesHelper, type: :helper do
  class FakeFlash
    attr_accessor :hash
    def initialize
      self.hash = HashWithIndifferentAccess.new
    end

    def to_hash
      hash
    end
  end

  let(:flash) { FakeFlash.new }

  describe "mocked object" do
    let!(:fake_hash) do
      { fake: :hash }.tap { |fake| flash.hash = fake }
    end

    it "should simulate the interface" do 
      expect(flash.to_hash).to be fake_hash
    end
  end

  describe "transforming common rails flashes to foundation friendly" do
    let(:alert) { "alert" }
    let(:error) { "error" }
    let(:notice) { "notice" }
    let(:success) { "success" }

    before do
      flash.hash[:alert] = alert
      flash.hash[:error] = error
      flash.hash[:notice] = notice
      flash.hash[:success] = success
    end

    it "should map values" do 
      {
        "alert" => alert,
        "warning" => error,
        "primary" => notice,
        "success" => success
      }.each do |key, value|
        expect(user_facing_flashes[key]).to eq value
      end

      expect(user_facing_flashes.keys.count).to eq 4
    end
  end
end
