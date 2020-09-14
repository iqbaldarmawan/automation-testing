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

  def replace_random(text)
    # expecting randomisable text in the format of xxxxx<random:identifier>xxxx
    matching_groups = text.match(/.*<(random:(.*))>.*$/)

    unless matching_groups.nil?
      raise 'Invalid random text format detected.  Expected format is xxxxx<random:identifier>xxxxxxx' if matching_groups.length < 2
      identifier = matching_groups[2]
      random = @randomizer.last_or_new_random(identifier)
      text = text.gsub(/<random.*>/, "-#{random}")
      $random_text = text
    end
  end

  def to_element_coordinate(element_name)
    element_coordinate = element_coordinates[element_name]
    raise "Unable to find element coordinates for '#{element_name}'. Please make sure it exists in element_coordinates_#{$environment.platform_name}.yml " unless element_selectors
    element_coordinate
  end

  def to_email_selector(element_name)
    email_selector = @email_selectors[element_name]
    raise "Unable to find email selector for #{element_name}" if email_selector.nil?
    email_selector
  end


  def load_mapper
    current_dir = File.dirname(__FILE__)
    if $environment.on_web?
      @element_selectors = YAML.load_file("#{current_dir}/element_selectors_web.yml")
      # elsif @environment.on_mweb?
      #   @element_selectors = YAML.load_file("#{current_dir}/element_selectors_mweb.yml")
    end
  end

  alias :reload_mapper :load_mapper
  alias :reload :load_mapper
end