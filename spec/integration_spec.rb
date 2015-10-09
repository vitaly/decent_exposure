require "spec_helper"
require "support/rails_app"
require "rspec/rails"

describe BirdsController, type: :controller do
  context "when finding a collection of birds" do
    let(:mockingbird) { double("Mockingbird") }
    let(:rockinrobin) { double("Rockin Robin") }

    before do
      expect(Bird).to receive(:all).once.and_return([mockingbird, rockinrobin])
    end

    it "" do
      get :index
      expect(controller.birds).to eq([mockingbird, rockinrobin])
    end
  end

  context "finds bird by id" do
    let(:mockingbird){ double("Bird") }
    before{ expect(Bird).to receive(:find).with("mockingbird").once.and_return(mockingbird) }
    after{ expect(controller.bird).to eq(mockingbird) }

    it "finds model by id" do
      get :show, id: "mockingbird"
    end

    it "finds model by bird_id" do
      get :show, bird_id: "mockingbird"
    end
  end

  it "builds bird if id is not provided" do
    bird = double("Bird")
    expect(Bird).to receive(:new).and_return(bird)
    get :show
    expect(controller.bird).to eq(bird)
  end

  context "when using a plural as a scope" do
    it "build exposure from scope" do
      bird = double("Bird")
      expect(Bird).to receive(:new).and_return(bird)
      get :show
      expect(controller.special_bird).to eq(bird)
      end
  end
end
