shared_examples :monetize_attr do |attr|
  it "matches model attribute without a '_cents' suffix by default" do
    is_expected.to monetize(attr)
  end

  it "matches model attribute specified by :as chain" do
    is_expected.to monetize(attr).as(attr)
  end

  it "matches nullable model attribute when tested instance has a non-nil value" do
    is_expected.not_to monetize(attr).allow_nil
  end
end