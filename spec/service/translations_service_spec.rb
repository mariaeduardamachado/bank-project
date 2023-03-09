require 'rails_helper' 

RSpec.describe Translations::TranslationsService, type: :service do
  describe "when the translation service is credit analysis" do
    let(:current_user) {create(:user)}
   
    context "when the situation is a deposit type" do
      let(:params) {build(:translation)}

      it "deposit made successfully" do 
        described_class.run(params, current_user)
        expect(params.save).to eq(true)
      end
    end

    context "when situation is a deposit reproved" do
      let(:params) {build(:translation, password_translation:nil)}
      it "deposit made not made" do
        described_class.run(params, current_user)
        expect(params.save).to eq(false)
      end

      context "when the situation is a withdraw type" do
        let(:params) {build(:translation)}
  
        it "withdraw made successfully" do 
          described_class.run(params, current_user)
          expect(params.save).to eq(true)
        end
      end
      
      context "when situation is a transfer reproved" do
        let(:params) {build(:translation, password_translation:nil)}
        it "transfer made not made" do
          described_class.run(params, current_user)
          expect(params.save).to eq(false)
        end
      end
    end
  end
end
