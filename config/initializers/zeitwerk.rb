Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect('api' => 'API')
  autoloader.inflector.inflect('cfpropertybundle' => 'CFPropertyBundle')
end
