require 'rake/clean'

source_files = Rake::FileList["src/*.md"]

task :default => [ "html", "html/index.html", :css, :main]

task :configure do
    print "checking for pandoc... "
    if system("test -x $(which pandoc)") then
        puts "yes"
    else
        puts "no"
        puts "See http://johnmacfarlane.net/pandoc/installing.html"
    end
end

file "html" do
    sh "mkdir html"
end
CLEAN.include("html")

file "html/index.html" do
    sh "scripts/get_index.py > html/index.html"
end

task :css => ["html/style.css", "html/style_index.css"]
file "html/style.css" do
    sh "cp scripts/style.css html/"
end
file "html/style_index.css" do
    sh "cp scripts/style_index.css html/"
end

source_files.each do |sf|
    tf = sf.sub(%r{src/(p\d\d\d)_.*},'html/\1.html')
    task :main => tf do
    end
    file tf => sf do
        sh "pandoc -s -c ./style.css #{sf} -o #{tf}"
    end
end
    
#rule %r{html/.*\.html} => "src/%n.md" do |t|
#    filename = File.basename( t.name, '.html' )
#    sh "pandoc -s src/#{filename}.md -o html/$(echo #{filename} | sed -e 's/_.*//').html"
#end