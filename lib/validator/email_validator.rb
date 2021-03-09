# メールアドレスのバリデーションチェック
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # サイズ
    max = 255
    record.errors.add(attribute, :too_long, count: max) if value.present? && value.length > max
    # フォーマット
    # \w 単語構成文字 [a-zA-Z0-9_]
    # * 0回以上
    # + 1回以上
    # ? 0回もしくは1回
    # メタ文字（-や+）は最初か最後に書くのであればエスケープ文字は不要
    # 
    # \A\w+           : 先頭は[a-zA-Z0-9_]から始まる
    # ([-+.]\w+)*     : 「-か+か.から始まり、[a-zA-Z0-9_]が1文字以上」の組み合わせが0回以上
    # @
    # \w+             : [a-zA-Z0-9_]が1回以上
    # ([-.]\w+)*      : 「-か.から始まり、[a-zA-Z0-9_]が1文字以上」の組み合わせが０回以上
    # \.
    # \w+             : [a-zA-Z0-9_]が1回以上
    # ([-.]\w+)*\z    : 「-か.から始まり、[a-zA-Z0-9_]が1文字以上」の組み合わせが０回以上で終わる
    format = /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/
    record.errors.add(attribute, :invalid) unless format =~ value
  end
end