module Olam
  class Api
    include HTTParty

    def search(term)
      request_body = {timestampajax: Time.now.to_i, seq: 6, ajax_type: 'definition', word: term}
      response = HTTParty.post('http://mashithantu.com/dictionary/ajaxdict.php', body: request_body)
      str = sanitize(response.to_s)
      (str.scan(/&nbsp;(\w+)<br>/) + str.scan(/&nbsp;([A-Za-z ]+)<br \/>/)).join('|')
    end

    private 

    def remove_non_ascii(x)
      x.split('').select{|x| x.ascii_only?}.join
    end

    def sanitize(x)
      x.gsub(",", '').gsub(".", '')
    end
  end
end


