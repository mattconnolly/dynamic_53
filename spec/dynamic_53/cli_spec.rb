require 'spec_helper'
require 'dynamic_53/cli'

describe Dynamic53::CLI do
  let(:args) { [] }
  subject { Dynamic53::CLI.new(args) }
  context "#parse_options!" do
    context "with required arguments" do
      let(:args) { %w[-z my_zone -h my_host] }
      it do
        subject.parse_options!
        expect(subject.options[:zone]).to eq("my_zone")
      end
      it do
        subject.parse_options!
        expect(subject.options[:hostname]).to eq("my_host")
      end
    end
    context "--wrong" do
      let(:args) { %w[--wrong] }
      it { expect { subject.parse_options! }.to raise_error }
    end
  end
end
