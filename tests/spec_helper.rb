# frozen_string_literal: true

require 'rspec'
require_relative '../lib/seafile-api'
RSpec.configure do |config|
  config.after(:all) do
    test_dir = begin
      Dropbox::Spec.instance.find(Dropbox::Spec.test_dir)
    rescue StandardError
      nil
    end
    test_dir.destroy if test_dir && !test_dir.is_deleted?
  end
end

email = 'kos646tero@fcode.com'
password = 'Gfhj44346456'
host = 'http://oc5556ofcertode.com'
repo = '03b865a46'
$another_email = 'alexand46hfgh@erofcode.com'
SF = SeafileApi::Connect.new(email, password, host, repo)
