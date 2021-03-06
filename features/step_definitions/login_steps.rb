# frozen_string_literal: true

Dado('que acesso o Linkedin') do
  visit '/'
end

Quando('informo o usuário {string} e senha {string}') do |email, senha|
  @Login_Linkdin.login_view.button_entrar.click
  @Login_Linkdin.login_view.sendkeys_email_senha(email, senha)
  while true
    Kernel.puts "vamo dale #{Time.now}"
    sleep 10
  end
end

Então('devo receber a mensagem de {string}') do |expect_mensage|
  expect(@Login_Linkdin.login_view.result_test.text).to have_content expect_mensage
end
