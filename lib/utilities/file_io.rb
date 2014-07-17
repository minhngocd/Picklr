
class FileIO

  def self.write_create_json content_hash, filepath
    FileUtils.mkdir_p File.dirname(filepath) unless File.exists?(filepath)
    File.open(filepath, 'w') do |f|
      f.puts content_hash.to_json unless content_hash.nil?
    end
  end

  def self.load_create_json filepath
    FileUtils.mkdir_p File.dirname(filepath) unless File.exists?(filepath)
    begin
      JSON.parse File.open(filepath,'a+').read
    rescue JSON::ParserError
      []
    end
  end

  def self.append_create_json content_hash, filepath
    new_body = load_create_json(filepath) << content_hash
    write_create_json new_body, filepath
  end

  def self.merge_create_json(content_hash, filepath)
    new_body = load_create_json(filepath).merge content_hash
    write_create_json new_body, filepath
  end

end
