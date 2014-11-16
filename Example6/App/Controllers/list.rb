require "App/Controllers/base"

class List < Base
  def create
    @items = Item.all
    render "test"
  end
end

