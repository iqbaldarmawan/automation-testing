class Mapper
  attr :element_selectors, :element_coordinates

  def initialize(environment)
    @environment = environment
    load_mapper
  end

  def to_element_selector(element_name)
    element_selector = element_selectors[element_name]
    element_selector || element_name
  end

  def to_element_coordinate(element_name)
    element_coordinate = element_coordinates[element_name]
    raise "Unable to find element coordinates for '#{element_name}'. Please make sure it exists in element_coordinates_#{$environment.platform_name}.yml " unless element_selectors
    element_coordinate
  end

  def load_mapper
    current_dir = File.dirname(__FILE__)
    if $environment.on_web?
      @element_selectors = YAML.load_file("#{current_dir}/element_selectors_web.yml")
      elsif @environment.on_android?
      @element_selectors = YAML.load_file("#{current_dir}/element_selectors_android.yml")
    end
  end

  alias :reload_mapper :load_mapper
  alias :reload :load_mapper
end