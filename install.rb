require 'fileutils'

puts "[Bigindex-Solr] Copying example config file to your RAILS_ROOT...\n"

config_dir = File.join(RAILS_ROOT, "config")
source = File.join(File.dirname(__FILE__), "examples", "bigindex.yml")
target = File.join(config_dir, "bigindex.yml")
alternate_target = File.join(config_dir, "bigindex.yml.sample")

if !File.exist?(target)
  FileUtils.cp(source, target)
else
  puts "[Bigindex-Solr] RAILS_ROOT/config/bigindex.yml file already exists. Copying it as bigindex.yml.sample for reference."
  FileUtils.cp(source, alternate_target)
end

FileUtils.mkdir_p(File.join(RAILS_ROOT, "solr"))
