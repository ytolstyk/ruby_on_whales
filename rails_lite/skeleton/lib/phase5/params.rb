require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    def initialize(req, route_params = {})
      @req = req
      @route_params = route_params
      @params = @route_params
      if req.query_string
        @query_params = parse_www_encoded_form(req.query_string) 
        @params = @route_params.merge(@query_params)
      else
        @params = @route_params
      end
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      return if www_encoded_form.nil?
      array = URI::decode_www_form(www_encoded_form)
      hash = Hash.new

      array.each do |query|
        rec_hash = recur_hash(parse_key(query.first), query.last)
        hash = hash.deep_merge(rec_hash)
      end

      hash
    end

    def recur_hash(keys, value)
      return { keys.first => value } if keys.length == 1
      return { keys.shift => recur_hash(keys, value) }
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      array = key.split("[")
      array.map do |i| 
        if i.include?("]") 
          i.chop
        else
          i
        end
      end
    end
  end
end
