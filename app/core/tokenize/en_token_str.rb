require_relative '../../config/token_char'

class EnTokenStr
  def initialize(content)
    @content = content
  end

  def convert
    # p TokenChar.token_list
    raw_char = []

    @content.split('') do |char|
      is_update = false
      TokenChar.token_list.each do |ob_key, _ob_val|
        next unless is_update == false and char.match(ob_key.regex)

        raw_char.append(('[%:' + ob_key.name.to_s + '%]'))


        is_update = true
      end
      if is_update == false

        raw_char.append(char)

      end
    end

    raw_char.join('')
  end
end
