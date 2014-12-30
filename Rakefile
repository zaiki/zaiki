require 'rake/clean'
CLEAN.include("html/*.html")
CLEAN.include("html/*.css")

source_files = Rake::FileList["src/*.md"]

task :default => [ "html", "html/index.html", :css, :main]

file "html" do
    sh "mkdir html"
end

file "html/index.html" => "src/p006_目次.txt" do
    sh "src/get_index.rb > html/index.html"
end

task :css => ["html/style.css", "html/style_index.css"]
file "html/style.css" => "src/style.css" do
    sh "cp src/style.css html/"
end
file "html/style_index.css" => "src/style_index.css" do
    sh "cp src/style_index.css html/"
end

source_files.each do |sf|
    tf = sf.sub(%r{src/(p\d\d\d)_.*},'html/\1.html')
    task :main => tf
    file tf => sf do
        sh "pandoc -s -c ./style.css #{sf} -o #{tf}"
    end
end