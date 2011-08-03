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
