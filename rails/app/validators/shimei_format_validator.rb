# frozen_string_literal: true

class ShimeiFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # 名字＋半角スペース+名前の形式であるかを判定する
    return if value.blank?

    return if value =~ /^[^ ]+ [^ ]+$/

    record.errors.add(attribute, (options[:message] || "氏名が不正なフォーマットです：#{value}"))
  end
end
