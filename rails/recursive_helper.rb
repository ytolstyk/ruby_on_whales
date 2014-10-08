def recur_hash(keys, value)
  return { keys.first => value } if keys.length == 1
  return { keys.shift => recur_hash(keys, value) }
end

