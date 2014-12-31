require 'rake/clean'
CLEAN.include("html/*.html")
CLEAN.include("html/*.css")

source_files = Rake::FileList["src/*.md"]

task :default => [ "html", "html/index.html", "html/p557.html", :css, :main]

file "html" do
    sh "mkdir html"
end

file "html/index.html" => "src/p006_目次.txt" do
    sh "src/get_index.rb > html/index.html"
end

file "html/p557.html" => "src/p557_年表.txt" do
    sh "src/get_chrono.rb > html/p557.html"
end

csslist = %w[style.css style_index.css style_chrono.css]
csslist.each do |css|
    htmlcss = File.join("html",css)
    srccss = File.join("src",css)
    task :css => htmlcss
    file htmlcss => srccss do
        sh "cp #{srccss} #{htmlcss}"
    end
end

source_files.each do |sf|
    tf = sf.sub(/src\/(p\d{3})_.*/,'html/\1.html')
    task :main => tf
    file tf => sf do
        sh "pandoc -s -c ./style.css #{sf} -o #{tf}"
    end
end