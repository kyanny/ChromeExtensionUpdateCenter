xml.instruct!

@extensions.each do |extension|
  xml.gupdate(xmlns: 'http://www.google.com/update2/response', protocol: '2.0') do
    xml.app(appid: extension.appid) do
      xml.updatecheck(codebase: crx_extension_url(extension, v: extension.version), version: extension.version)
    end
  end
end
