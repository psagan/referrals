shared_examples :filterable do |factory|
  describe "filterable scopes" do

    let!(:partner) { FactoryGirl.create(:partner) }
    let!(:filtered_obj_1) { FactoryGirl.create(factory, partner: partner, created_at: 2.months.ago) }
    let!(:filtered_obj_2) { FactoryGirl.create(factory, partner: partner, created_at: 1.month.ago) }
    let!(:filtered_obj_3) { FactoryGirl.create(factory, partner: partner) }
    let(:date) { 1.month.ago }

    describe ".by_date_from" do
      context "when date_from provided" do
        it "returns proper data by date_from" do
          results = described_class.by_date_from(1.month.ago)

          expect(results).to eq([filtered_obj_2, filtered_obj_3])
        end
      end

      context "when date_from not provided" do
        it "returns all data" do
          results = described_class.by_date_from(nil)

          expect(results).to eq([filtered_obj_1, filtered_obj_2, filtered_obj_3])
        end
      end
    end

    describe ".by_date_to" do
      context "when date_to provided" do
        it "returns proper data by date_to" do
          results = described_class.by_date_to(1.month.ago)

          expect(results).to eq([filtered_obj_1, filtered_obj_2])
        end
      end

      context "when date_to not provided" do
        it "returns all data" do
          results = described_class.by_date_from(nil)

          expect(results).to eq([filtered_obj_1, filtered_obj_2, filtered_obj_3])
        end
      end
    end

    describe ".by_partner" do
      let!(:partner_2) { FactoryGirl.create(:partner) }
      let!(:filtered_obj_1) { FactoryGirl.create(factory, partner: partner) }
      let!(:filtered_obj_2) { FactoryGirl.create(factory, partner: partner_2) }
      let!(:filtered_obj_3) { FactoryGirl.create(factory, partner: partner) }

      it "returns data for partner" do
        result = described_class.by_partner(partner)

        expect(result).to eq([filtered_obj_1, filtered_obj_3])
      end
    end

  end
end