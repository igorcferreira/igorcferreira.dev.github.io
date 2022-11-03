task "assets:precompile" do
  exec("bundle exec jekyll build")
end

task :launch do
  exec("bundle exec jekyll build && bundle exec puma -t 8:32 -w 3 -p ${PORT:-4000}")
end

task :default => "assets:precompile"