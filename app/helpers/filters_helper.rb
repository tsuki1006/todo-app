module FiltersHelper
  def add_active_class(current_type, type)
    '-active' if current_type == type
  end
end
