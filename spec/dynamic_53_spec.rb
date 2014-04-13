require 'spec_helper'

describe Dynamic53 do

  let(:zone) { "example.com." }
  let(:hostname) { "dynamic.example.com." }
  subject { Dynamic53.new zone, hostname }

  it "has a version" do
    expect(Dynamic53::VERSION).not_to be_nil
  end

  context "#ip_address" do
    it "calls Net::HTTP.get" do
      Net::HTTP.should_receive(:get).and_return("1.2.3.4")
      expect(subject.ip_address).to match(/\d+\.\d+\.\d+\.\d+/)
    end
  end

  context "fetching zone_id" do
    let(:client) { double("client", :list_hosted_zones => {:hosted_zones => [{:id => "/some/id", :name => zone}]}) }
    before { subject.stub(:route_53_client).and_return(client) }
    it "fetches the zone id" do
      expect(subject.zone_id).to eq("/some/id")
    end
  end

  context "record_set" do
    let(:record_set) { double("record_set") }
    let(:rrsets) { double("rrsets", :[] => record_set)}
    let(:record_sets) { double("record sets", :rrsets => rrsets)}
    it do
      subject.stub(:zone_id => "/some/id")
      AWS::Route53::HostedZone.should_receive(:new).with("/some/id").and_return(record_sets)
      expect(subject.record_set).to eq(record_set)
    end
  end

  context "update" do
    let(:record_set) { double("record set") }
    it do
      subject.stub(:ip_address => "1.2.3.4")
      subject.stub(:record_set => record_set)
      record_set.should_receive(:ttl=).with(Dynamic53::DEFAULT_TTL)
      record_set.should_receive(:resource_records=).with([{:value => "1.2.3.4"}])
      record_set.should_receive(:update)
      subject.update
    end
  end
end
