shared_examples "invalid attributes length" do |*attrs|
  attrs.each do |attr|
    it "is invalid with #{attr[:param].to_s} longer than #{attr[:length]}" do
      subject.send("#{attr[:param].to_s}=", Faker::Lorem.characters(attr[:length] + 1))
      expect(subject).to_not be_valid
    end
  end
end


