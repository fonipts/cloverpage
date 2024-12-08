require_relative '../../config/token_char'
require_relative '../../utility/crypt'
class DeTokenStr
  def initialize(content)
    @content = content
  end

  def convert
    content = @content[:content].to_s
  #  puts @content
  #  puts ""
    TokenChar.token_qoute_clean.each do |ob_key, _ob_val|
   #   p ob_key
   #   puts '[%:' + ob_key.name.to_s + '%]'
   #   puts ob_key.value.to_s
      content = content.gsub('[%:' + ob_key.name.to_s + '%]', ob_key.value.to_s)
    end

    TokenChar.token_list.each do |ob_key, _ob_val|
        content = content.gsub('[%:' + ob_key.name.to_s + '%]', ob_key.value.to_s)
    end

    if @content.key?('reference_key'.to_sym)
      @content[:reference_key].each do |ob_key, ob_val|

       # puts ob_key
        #puts ob_val.to_s
       # puts "+++++++++++++++++++++++++++=="
        content = content.gsub('[@@:' + ob_key.to_s + '@@%]', ob_val[:char].to_s)
      end
    end

    #puts content
   # puts "content"
   content
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
