require_relative './crypt'

class StringLiteralUtil
  def initialize(data)
    @data = data
    @ref = {}
    @list_uniqid = []
  end

  def endode_string_literal(type)
    if type == 'single_qoute'
      strip_dobule_slash('double_qoute')
      strip_single_qoute
      strip_double_qoute
    end
    if type == 'double_qoute'
      strip_dobule_slash('single_qoute')
      strip_double_qoute
      strip_single_qoute
    end

    {
      'data': @data,
      'ref': @ref
    }
  end

  def decode_string_literal(type); end

  private

  def strip_dobule_slash(type)
    regexp_qoute = %r{(/{1})(.*)(/{1})}
    @ref[type] = {}
    readline = @data.clone.to_s.gsub(regexp_qoute) do |m|
      idq = uniqid(20)
      reg_str = "\{@(#{@list_uniqid.join('|')})@\}"
      match_exist_count = m.to_s.scan(Regexp.new(reg_str))
      if match_exist_count.count.zero?
        @list_uniqid.append(idq)
        @ref[type][idq] = m.to_s
        "{@#{idq}@}"
      else
        m.to_s
      end
    end
    @data = readline
  end

  def strip_single_qoute
    regexp_qoute = /('{1})(.*)('{1})/
    @ref['single_qoute'] = {}
    readline = @data.clone.to_s.gsub(regexp_qoute) do |m|
      idq = uniqid(20)
      reg_str = "\{@(#{@list_uniqid.join('|')})@\}"
      match_exist_count = m.to_s.scan(Regexp.new(reg_str))
      if match_exist_count.count.zero?
        @list_uniqid.append(idq)
        @ref['single_qoute'][idq] = m.to_s
        "{@#{idq}@}"
      else
        m.to_s
      end
    end
    @data = readline
  end

  def strip_double_qoute
    regexp_qoute = /("{1})(.*?)("{1})/
    @ref['double_qoute'] = {}
    readline = @data.clone.to_s.gsub(regexp_qoute) do |m|
      idq = uniqid(20)
      reg_str = "\{@(#{@list_uniqid.join('|')})@\}"
      match_exist_count = m.to_s.scan(Regexp.new(reg_str))
      if match_exist_count.count.zero?
        @list_uniqid.append(idq)
        @ref['double_qoute'][idq] = m.to_s
        "{@#{idq}@}"
      else
        m.to_s
      end
    end
    @data = readline
  end
end
