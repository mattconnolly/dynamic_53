require "dynamic_53/version"
require "aws-sdk"
require "net/http"

class Dynamic53

  DEFAULT_TTL = 3600 # 1 hour

  attr :zone
  attr :hostname
  attr :options

  # Initializes an object for updating the Route 53 hostname with the machine's
  # current public IP address.
  def initialize(zone, hostname, options={})
    @zone = zone
    @hostname = hostname
    @options = options
  end

  # perform the Route 53 update, returning the AWS SDK changelist object for the change.
  def update
    record_set.ttl = options[:ttl] || DEFAULT_TTL
    record_set.resource_records = [{:value => ip_address}]
    result = record_set.update
    $stdout.puts "Record updated" if options[:verbose]
    result
  end

  # fetch the current machine's public IP address.
  def ip_address
    @ip_address ||=
        begin
          ip_address = Net::HTTP.get("bot.whatismyipaddress.com", "/")
          $stdout.puts "Public IP Address: #{ip_address}" if options[:verbose]
          ip_address
        end
  end

  # Fetches the AWS Route53 zone id for the specified zone.
  def zone_id
    route_53_client.
        list_hosted_zones[:hosted_zones].
        each.
        select { |z| z[:name] == zone }.
        map {|z| z[:id] }.
        first
  end

  # Fetch a record set object for the given hostname in the Route 53 zone specified.
  def record_set
    @record_set ||= AWS::Route53::HostedZone.new(zone_id).rrsets[hostname, 'A']
  end

  # A client for making Route 53 API requests.
  def route_53_client
    @route_53_client ||= AWS::Route53.new.client
  end
end
