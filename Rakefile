
require 'objective-j'
require 'objective-j/bundletask'

if !ENV['CONFIG']
    ENV['CONFIG'] = 'Debug'
end

ObjectiveJ::BundleTask.new(:corelocation) do |t|
    t.name          = 'corelocation'
    t.identifier    = 'com.yourcompany.corelocation'
    t.version       = '1.0'
    t.author        = 'Your Company'
    t.email         = 'feedback @nospam@ yourcompany.com'
    t.summary       = 'corelocation'
    t.sources       = FileList['*.j']
    t.resources     = FileList['Resources/*']
    t.index_file    = 'index.html'
    t.info_plist    = 'Info.plist'
    t.build_path    = File.join('Build', ENV['CONFIG'], 'corelocation')
    t.flag          = '-DDEBUG' if ENV['CONFIG'] == 'Debug'
    t.flag          = '-O' if ENV['CONFIG'] == 'Release'
end

task :default => [:corelocation]
