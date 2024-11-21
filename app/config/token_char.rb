require_relative '../support/schema/token_char_struct'

module TokenChar
  @token_list = [
    TokenCharStruct.new('nwl', /\n/, "\n"),
    TokenCharStruct.new('dbl_qte', /"/, '"'),
    TokenCharStruct.new('sng_qte', /'/, "'"),
    TokenCharStruct.new('bck_qte', /`/, '`'),
    TokenCharStruct.new('spc', /\s/, "\s"),
    TokenCharStruct.new('tb', /\t/, "\t")
  ]

  def self.token_list
    @token_list
  end
end
