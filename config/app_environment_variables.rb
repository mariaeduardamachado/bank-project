if Rails.env.development?
# variáveis de produção especificas para a maquina local na rede interna.
#
  ENV["PayPal_URL"] = "https://api.sandbox.paypal.com/"
  ENV['API_TOKEN'] = "AS1NFEKdkWLpegrPMgo4LvXmZY2sQwMxMHOxBhkttegx6LlytKoJjbEhiwPO0DWm8vlzkZw16IYyTuLT"
  ENV["PayPal_PASSWORD"] = "EP-0VTjAuesXT6ofmuxG0fO1fveoBuotHWLFWZxR2b1-otTi1qkF3Fsgz-v7-PHWc77YEDvWnymO_OxG"
end

if Rails.env.production?
  ENV["PayPal_URL"] = "https://api.paypal.com"
  ENV['API_TOKEN'] = "AS1NFEKdkWLpegrPMgo4LvXmZY2sQwMxMHOxBhkttegx6LlytKoJjbEhiwPO0DWm8vlzkZw16IYyTuLT"
  ENV["PayPal_PASSWORD"] = "EP-0VTjAuesXT6ofmuxG0fO1fveoBuotHWLFWZxR2b1-otTi1qkF3Fsgz-v7-PHWc77YEDvWnymO_OxG"
end
  ENV["PayPal_URL"] = "https://api.sandbox.paypal.com/"
  ENV['API_TOKEN'] = "AS1NFEKdkWLpegrPMgo4LvXmZY2sQwMxMHOxBhkttegx6LlytKoJjbEhiwPO0DWm8vlzkZw16IYyTuLT"
  ENV["PayPal_PASSWORD"] = "EP-0VTjAuesXT6ofmuxG0fO1fveoBuotHWLFWZxR2b1-otTi1qkF3Fsgz-v7-PHWc77YEDvWnymO_OxG"