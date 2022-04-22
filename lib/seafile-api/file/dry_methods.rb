# frozen_string_literal: true

module SeafileApi
  class Connect
    private

    def result(result)
      if !result.scan('File not found').empty?
        'File not found'
      elsif !result.scan('Path is missing').empty?
        'Path is missing'
      elsif !result.scan('Operation failed').empty?
        'Operation failed'
      elsif !result.scan('http').empty?
        result.to_s
      else
        result.to_s
      end
    end

    def is_http?(http)
      !http.body_str.gsub('"', '').scan('http').empty?
    end

    def cl_body_str(http)
      http.body_str.gsub('"', '')
    end

    def format_url(url)
      url = "#{host}/api2/#{url}" unless url.starts_with?('http')
      req = url.split('?')
      request_url = []
      request_url << req.first
      request_url << CGI.escape(req[1..].join('?')).to_s
      request_url.reject(&:blank?).join('?')
    end

    def curl_post(url, data = {})
      request_url = format_url(url)
      c = Curl::Easy.new(request_url)
      c.multipart_form_post = true
      c.headers['Authorization'] = "Token #{fetch_sf_token}"
      data.delete_if { |_key, value| value.nil? }
      p_data = data.map do |key, value|
        if key != 'file'
          Curl::PostField.content(key, value)
        else
          Curl::PostField.file(key, value)
        end
      end
      c.http_post(p_data)
      c
    end

    def curl_get(url)
      request_url = format_url(url)
      Curl.get(request_url) do |http|
        http.headers['Authorization'] = "Token #{fetch_sf_token}"
      end
    end

    def curl_put(url, data = {})
      request_url = format_url(url)
      c = Curl::Easy.new(request_url)
      c.headers['Authorization'] = "Token #{fetch_sf_token}"
      c.headers['Content-Type'] = 'application/json'
      data.delete_if { |_key, value| value.nil? }
      # c.put_data= data.to_json
      c.http_put(data.to_json)
      c
    end

    def curl_delete(url, data = {})
      request_url = format_url(url)
      c = Curl::Easy.new(request_url)
      c.headers['Authorization'] = "Token #{fetch_sf_token}"
      c.headers['Content-Type'] = 'application/json'

      c.put_data = data.to_json unless data == ''
      c.http_delete
      c
    end
  end
end
