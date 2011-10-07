def post_resource(post_path, resource, hashes)
  hashes.each do |attributes|
    post post_path, :format => :json, resource => attributes  
  end
end

def put_resource(put_path, resource, hashes)
  hashes.each do |attributes|
    put put_path, :format => :json, resource => attributes  
  end
end

def delete_resource(delete_path)
  delete delete_path, :format => :json
end

def if_exists(hash, key) 
  value = hash.delete(key)
  return {} unless value && value != ""
  {key => yield(value)} if block_given?
end

def parse_if_exists(hash, key, klass)
  if_exists(hash, key) { |s| klass.parse(s) }
end

def adjust_expected_response(row)
  f = row.delete('finished_on')

  row.
    merge({'finished_on' => f.nil? || f == "" ? nil : DateTime.parse(f).strftime('%Y-%m-%dT00:00:00Z') }).
    merge(if_exists(row, 'started_on') { |s| DateTime.parse(s).strftime('%Y-%m-%dT00:00:00Z') }).
    merge(if_exists(row, 'size') { |s| s.to_i }).
    merge(if_exists(row, 'waiting_time') { |s| s.to_f }).
    merge(if_exists(row, 'blocked_time') { |s| s.to_f })
end