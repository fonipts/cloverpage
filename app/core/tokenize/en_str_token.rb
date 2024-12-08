require_relative '../../config/token_char'
require_relative '../../utility/crypt'
class EnStrToken
  def initialize(content)
    @content = content
  end

  def convert
    raw_char = []

    @content.split('') do |char|
      is_update = false
      TokenChar.token_list.each do |ob_key, _ob_val|
        next unless is_update == false && char.match(ob_key.regex)

        raw_char.append(('[%:' + ob_key.name.to_s + '%]'))

        is_update = true
      end
      raw_char.append(char) if is_update == false
    end

    raw_char.join('')
  end

  def convert_strip_qoute
    raw_char = []
    counte = ''
    ref_dist_var = {}
    ref_type = ''

    TokenChar.token_qoute_clean.each do |ob_key, _ob_val|
      @content = @content.gsub(ob_key.regex, '[%:' + ob_key.name.to_s + '%]')
    end
    @content.split('') do |char|
      is_update = false
      TokenChar.token_qoute_list.each do |ob_key, _ob_val|
        next unless is_update == false && char.match(ob_key.regex)

        if ref_type == ''
          ref_type = ob_key.name.to_s
          counte = uniqid(25)
          ref_dist_var[counte] = {
            "type": ob_key.name.to_s,
            "char": [char]
          }
          raw_char.append('[@@:' + counte.to_s + '@@%]')
        elsif ref_type == ob_key.name.to_s
          ref_type = ''
          ref_dist_var[counte]['char'.to_sym].push(char)
          ref_dist_var[counte]['char'.to_sym] = ref_dist_var[counte]['char'.to_sym].clone.join('')

        end

        is_update = true
      end
      if is_update == false
        if ref_type != ''

          ref_dist_var[counte]['char'.to_sym].push(char)
        else
          raw_char.append(char)
        end

      end
    end

    {
      "word": raw_char.join(''),
      "ref_key": ref_dist_var
    }
  end
end
