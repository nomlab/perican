#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

ENV["BUNDLE_GEMFILE"] = File.expand_path("../../../../Gemfile", __FILE__)

require 'rubygems'
require 'bundler/setup'
require 'mail'
require 'net/imap'
require 'yaml'

yml_data = YAML.load_file('./setting.yml')
imap = Net::IMAP.new('imap.gmail.com', 993, true)
imap.login(yml_data["address"], yml_data["password"])

imap.select('INBOX')
ids = imap.search(["ALL"])
imap.fetch(ids, "RFC822").each do |mail|
  m = Mail.new(mail.attr["RFC822"])

  puts "Date: " + m.date.to_s
  puts "To: " + m.to.to_s
  puts "From: " + m.from.to_s
  puts "Subject: " + m.subject.to_s
  puts "\n"

end
