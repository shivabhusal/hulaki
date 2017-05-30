# Its important to keep ENV setting lines at the top
ENV['template_path'] = File.expand_path('../../lib/hulaki/config/sample.template.html.erb', __FILE__)
ENV['mode'] = 'test'

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'hulaki'
require 'pry'


Hulaki::ContactParser.default_file_path = File.expand_path('../fixtures/contact1.csv',__FILE__)
Hulaki::Config.config_file_path = Hulaki::Config::SampleConfigPath

class Mail::TestMailer
  alias deliver deliver!
end
