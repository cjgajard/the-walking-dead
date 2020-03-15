module Groupable
  def group
    @group ||= []
  end

  def index
    @index ||= 1
  end

  def next_index
    @index = index + 1
  end

  def register(item)
    group << item
    next_index
  end

  def unregister(item)
    group.delete(item)
  end

  def total
    group.length
  end
end

