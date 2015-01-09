require 'rake/clean'
CLEAN.include("html/*.html")
CLEAN.include("html/*.css")

markdown_files = FileList["src/*.md"]
css_files = FileList["src/*.css"]

task :default => [ "html", "html/index.html", "html/p557.html", :css, :main ]

directory "html"

file "html/index.html" => [ "src/p006_目次.txt", "src/get_index.rb" ] do
    sh "src/get_index.rb > html/index.html"
end

file "html/p557.html" => [ "src/p557_年表.txt", "src/get_chrono.rb" ] do
    sh "src/get_chrono.rb > html/p557.html"
end

css_files.each do |src_css|
    if %r'src/(style.*\.css)' =~ src_css
        html_css = "html/#{$1}"
        task :css => html_css
        file html_css => src_css do |t|
            cp t.prerequisites, 'html'
        end
    end
end

markdown_files.each do |sf|
    if %r'src/(p\d{3})_.*\.md' =~ sf
        tf = "html/#{$1}.html"
        task :main => tf
        file tf => sf do
            sh "pandoc -s -c ./style.css #{sf} -o #{tf}"
        end
    end
end