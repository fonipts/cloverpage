require_relative './crypt'

class StringLiteralUtil
  def initialize(data)
    @data = data
    @ref = {}
  end

  def endode_string_literal(type)
    if type == 'single_qoute'
      strip_single_qoute
      strip_double_qoute
    end
    if type == 'double_qoute'
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

  def strip_single_qoute
    regexp_qoute = /('{1})(.*)('{1})/
    @ref['single_qoute'] = {}
    readline = @data.clone.to_s.gsub(regexp_qoute) do |m|
      idq = uniqid(20)
      @ref['single_qoute'][idq] = m.to_s
      "{@#{idq}@}"
    end
    @data = readline
  end

  def strip_double_qoute
    regexp_qoute = /(\"{1})(.*?)(\"{1})/
    @ref['double_qoute'] = {}
    readline = @data.clone.to_s.gsub(regexp_qoute) do |m|
      idq = uniqid(20)
      @ref['double_qoute'][idq] = m.to_s
      "{@#{idq}@}"
    end
    @data = readline
  end
end
