require 'net/http'
require 'net/https'

class GetRemoteXML

  def initialize(*args)
    @options = args.extract_options!
  end

  def send_request
    print "Getting XML file from remote source ... "
    start_processing_time = Time.now
    if @options[:url] && @options[:username] && @options[:password]
      url = URI.parse(@options[:url])
      http = Net::HTTP.new(url.host, url.port)
      if url.scheme == 'https'
        http.use_ssl = (url.scheme == 'https')
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      request = Net::HTTP::Get.new(url.path)
      request.basic_auth(@options[:username], @options[:password])
      response = http.start { |http| http.request(request) }
      doc = Nokogiri::XML(response.body)
    else
      response = Net::HTTP.get(URI.parse(@options[:url]))
      doc = Nokogiri::XML(response)
    end
    print "completed in #{Time.now - start_processing_time} seconds\n".yellow
    doc
  end

  ## for dev purpose
  def get_local_xml
    xml_file = File.open(Rails.root + "public/jobadder-feed.xml")
    doc = Nokogiri::XML(xml_file)
    doc
  end
end