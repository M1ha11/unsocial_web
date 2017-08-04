shared_examples "assign variables" do |*variables|
  variables.each do |var|
    it "is get @#{var.to_s}" do
      request_exec
      expect(assigns(var)).to match_array(send(var))
    end
  end
end

shared_examples "not assign variables" do |*variables|
  variables.each do |var|
    it "is not get @#{var.to_s}" do
      request_exec
      expect(assigns(var)).to eq(nil)
    end
  end
end
