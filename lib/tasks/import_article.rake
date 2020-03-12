require 'yaml'
require 'logger'

namespace 'db' do
  desc "import article"
  task(:import_articles => :environment) do
    import_articles
  end
end

def import_articles
  filename = "lib/tasks/data/coursefolder/foldername.txt"
  result = []
  File.open(filename, "r").each_line do |line|
    info = line.split("$%$%")
    name = info[0].strip
    vol = info[1].split(" ")[0].strip
    lang = info[3].strip
    address = info[4].strip
    ctg = File.read("lib/tasks/data/coursefolder/ctg/" + name + ".txt")

    @article = Article.where(:title =>  name)
    if @article.blank?
      Article.create(
        :title =>  name,
        :lang => lang,
        :vol => vol,
        :category => ctg,
        :address => address
      )
    else
      next
    end
  end
end
