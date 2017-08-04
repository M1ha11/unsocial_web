shared_examples "assign variables" do |*variables|
  variables.each do |var|
    it "cancan authorize @#{var.to_s}" do
      request_exec
      expect(assigns(var)).to eq(send(var))
    end
  end
end

shared_examples "not assign variables" do |*variables|
  variables.each do |var|
    it "cancan isn't authorize @#{var.to_s}" do
      request_exec
      expect(assigns(var)).to eq(nil)
    end
  end
end
