class Showcase::Path
  class Tree < Struct.new(:id, :paths)
    def name
      root? ? "Pages" : id
    end

    def root?
      id == "."
    end
  end

  def self.tree
    all.group_by(&:dirname).map { Tree.new _1, _2 }
  end

  def self.all
    Showcase.filenames.map { new _1 }.sort_by!(&:id)
  end

  attr_reader :id, :dirname, :basename

  def initialize(path)
    @id = path.split(".").first
    @dirname, @basename = File.split(@id)
  end

  def page_for(view_context)
    Showcase::Page.new(view_context, id: id, title: basename.titleize)
  end
end
