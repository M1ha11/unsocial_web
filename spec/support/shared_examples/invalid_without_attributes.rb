shared_examples "invalid without attributes" do |*attrs|
  attrs.each do |attr|
    it "is invalid without #{attr.to_s}" do
      subject.send("#{attr.to_s}=", nil)
      expect(subject).to_not be_valid
    end
  end
end
