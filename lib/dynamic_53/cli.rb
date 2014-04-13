require 'optparse'

class Dynamic53::CLI
  attr :options

  def initialize(argv)
    @argv = argv
    @options = {}
  end

  def parse_options!
    parser = options_parser
    parser.parse!(@argv)

    unless options[:hostname] && options[:zone]
      $stderr.puts "Error: both zone and hostname arguments must be provided."
      $stderr.puts parser.banner
      exit(1)
    end
  end

  def run
    parse_options!
    Dynamic53.new(options.delete(:zone), options.delete(:hostname), options).update
  end

  private

  def options_parser
    @options_parser ||= OptionParser.new do |opts|
      opts.banner = "Usage: dynamic_53 -z zone -h hostname [options]"

      opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
        options[:verbose] = v
      end
      opts.on("-z ZONE", "--zone ZONE", "Use the given zone ZONE in AWS Route53") do |arg|
        options[:zone] = arg
      end
      opts.on("-h HOSTNAME", "--hostname HOSTNAME",
              "Updates the IP address for the name HOSTNAME to the current machine's public IP address") do |arg|
        options[:hostname] = arg
      end
    end
  end
end
