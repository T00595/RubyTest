# frozen_string_literal: true

require 'base64'

# Before para acessar a pagina do linkedin
Before('@linkedin') do
  visit '/'
end

Before do
  # Comando para maximizar a tela antes da execução dos testes
  page.driver.browser.manage.window.maximize
  # Aqui deve ser instanciado todas as Pages criadas.
  # Exemplo:
  @Login_Linkdin = LoginPage.new
end

# Método responsável por realizar a captura da tela após a execução de cada teste.
After do
  Kernel.puts 'PASEI AQUI OOOOOOO=-------'
  capture_screenshot = page.save_screenshot('log/screenshot.png')
  screenshot = Base64.encode64(File.open(capture_screenshot, 'rb').read)
  embed(screenshot, 'image/png', 'Evidência_de_teste') # Anexa o Screenshot no relatório.
  driver.quit
end

Around do |_scenario, block|
  retries = 3
  begin
    Timeout.timeout(30) do
      block.call
    end
  rescue Timeout::Error => e
    raise e
  # Manually set to failed
    #failed = Cucumber::Core::Test::Result::Failed.new(0, e)
    #_scenario.instance_variable_set(:@result, failed)
  #  next
  end
end
