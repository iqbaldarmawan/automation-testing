class Environment
  attr_accessor :platform_name, :environment_name

  def on_web(&block)
    yield if on_web?
  end

  def on_web?
    ENV['HOST']=='web'
  end

  def platform_name
    ENV['PLATFORM_NAME']
  end

  def browser_name
    ENV['BROWSER_NAME']
  end

  def host
    ENV['HOST']
  end

  def on_android(&block)
    yield if on_android?
  end

  def on_android?
    platform_name == 'android' && host.nil?
  end


end