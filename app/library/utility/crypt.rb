def uniqid(limit)
  o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map(&:to_a).flatten
  (0...limit).map { o[rand(o.length)] }.join
end
