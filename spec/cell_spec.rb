require_relative '../lib/cell'

RSpec.describe Cell do
  describe "#alive?" do
    it "returns false" do
      cell = Cell.new
      expect(cell.alive?).to eq(false)
    end
  end
  describe "#revive" do
    it "returns true" do
      cell = Cell.new
      expect(cell.revive).to eq(true)
    end
  end
  describe "#kill" do
    it "returns true" do
      cell = Cell.new
      expect(cell.kill).to eq(false)
    end
  end
end