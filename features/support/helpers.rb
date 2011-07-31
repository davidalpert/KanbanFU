def post_resource(post_path, resource, hashes)
  hashes.each do |attributes|
    post post_path, :format => :json, resource => attributes  
  end
end
