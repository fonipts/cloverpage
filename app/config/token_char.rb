require_relative '../support/schema/token_char_struct'

module TokenChar
  @token_list = [
    TokenCharStruct.new('nwl', /\n/, '\n'),
    TokenCharStruct.new('dbl_qte', /"/, '"'),
    TokenCharStruct.new('sng_qte', /'/, "'"),
    TokenCharStruct.new('bck_qte', /`/, '`'),
    TokenCharStruct.new('spc', /\s/, "\s"),
    TokenCharStruct.new('tb', /\t/, "\t")
  ]

  @token_qoute_list = [
    TokenCharStruct.new('double_qte_open_close', /"/, '"'),
    TokenCharStruct.new('single_qte_open_close', /'/, "'")
  ]

  @token_qoute_clean = [
    TokenCharStruct.new('double_qte_w_slash', /\\"/, '\"'),
    TokenCharStruct.new('single_qte_w_slash', /\\'/, "\'")
  ]

  def self.token_list
    @token_list
  end

  def self.token_qoute_list
    @token_qoute_list
  end

  def self.token_qoute_clean
    @token_qoute_clean
  end
end
