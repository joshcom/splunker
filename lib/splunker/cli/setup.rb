require "rubygems"
require 'pp'
require 'irb/ext/save-history'
require 'splunker'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.splunker-history"


IRB.conf[:AUTO_INDENT]=true
IRB.conf[:PROMPT][:SPLUNKER]= {
  :PROMPT_I => "Splunker:%03n:%i> ",
  :PROMPT_S => "Splunker:%03n:%i%l ",
  :PROMPT_C => "Splunker:%03n:%i* ",
  :RETURN => "%s\n"
} 

IRB.conf[:PROMPT_MODE] = :SPLUNKER
