# coding: utf-8

namespace :project do
  desc "project tasks"
  task :tasks do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
    #Rake::Task["db:add_permissions"].invoke
    #Rake::Task["assets:precompile"].invoke
    #Rake::Task["kindeditor:assets"].invoke
    Rake::Task["db:import_subunits"].invoke
    Rake::Task["db:import_icons"].invoke
    Rake::Task["db:create_color_library"].invoke
    Rake::Task["db:create_image_library"].invoke
  end
end
