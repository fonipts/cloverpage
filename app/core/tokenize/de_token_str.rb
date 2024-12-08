require_relative '../../config/token_char'
require_relative '../../utility/crypt'
class DeTokenStr
  def initialize(content)
    @content = content
  end

  def convert
    content = @content[:content].to_s

    TokenChar.token_qoute_clean.each do |ob_key, _ob_val|
      content = content.gsub('[%:' + ob_key.name.to_s + '%]', ob_key.value.to_s)
    end

    TokenChar.token_list.each do |ob_key, _ob_val|
      content = content.gsub('[%:' + ob_key.name.to_s + '%]', ob_key.value.to_s)
    end

    if @content.key?('reference_key'.to_sym)
      @content[:reference_key].each do |ob_key, ob_val|
        content = content.gsub('[@@:' + ob_key.to_s + '@@%]', ob_val[:char].to_s)
      end
    end

    content
  end
end
