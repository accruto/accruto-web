require 'net/http'
require 'net/https'

class GetRemoteXML

  def initialize(*args)
    @options = args.extract_options!
  end

  def send_request
    print "Getting XML file from remote source ... "
    start_processing_time = Time.now
    if @options[:url]
      url = URI.parse(@options[:url])
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = (url.scheme == 'https')
      request = Net::HTTP::Get.new(url.path)
      if @options[:username].present? && @options[:password].present?
        request.basic_auth(@options[:username], @options[:password])
      end
      response = http.start { |http| http.request(request) }
      doc = Nokogiri::XML(response.body)
    end
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
    doc
  end

  ## for dev purpose
  def get_local_xml
    xml_file = File.open(Rails.root + "public/jobadder-feed-small.xml")
    doc = Nokogiri::XML(xml_file)
    doc
  end
end