# frozen_string_literal: true

module SeafileApi
  class Connect
    private

    def get_sf_token
      return token if token

      token_url = "#{host}/api2/auth-token/)"
      res = Curl::Easy.new(token_url)
      p_data = { username: user_name, password: password }.map do |key, value|
        Curl::PostField.content(key, value)
      end
      res.http_post(p_data)
      JSON.parse(res.body)['token']
    end

    # curl -H 'Authorization: Token f2210dacd3606d94ff8e61d99b477fd' -H 'Accept: application/json; charset=utf-8; indent=4' https://cloud.seafile.com/api2/repos/dae8cecc-2359-4d33-aa42-01b7846c4b32/file/revision/?p=/foo.c\&commit_id=a1ec20709675f4dc8db825cdbca296be245d189b
    def get_link_file_revision(filename, commit_id, repo)
      http = curl_get("repos/#{repo}/file/revision/?p=#{filename}&commit_id=#{commit_id}")
      result(cl_body_str(http))
    end

    # !!! get file link method
    # maybe Errors
    # 400 Path is missing
    # 404 File not found
    # 520 Operation failed.
    def get_file_link(filename, repo)
      http = curl_get("repos/#{repo}/file/?p=#{filename}")
      result(cl_body_str(http))
    end

    def get_block(repo)
      http = curl_get("repos/#{repo}/upload-blks-link/")
      result(cl_body_str(http))
    end

    # curl -H 'Authorization: Token f2210dacd3606d94ff8e61d99b477fd' -H 'Accept: application/json; charset=utf-8; indent=4' https://cloud.seafile.com/api2/repos/dae8cecc-2359-4d33-aa42-01b7846c4b32/file/detail/?p=/foo.c
    # get file description
    def get_description(filename, repo)
      http = curl_get("repos/#{repo}/file/detail/?p=#{filename}")

      JSON.parse(http.body_str)
    end

    # curl -H 'Authorization: Token f2210dacd3606d94ff8e61d99b477fd' -H 'Accept: application/json; charset=utf-8; indent=4' https://cloud.seafile.com/api2/repos/dae8cecc-2359-4d33-aa42-01b7846c4b32/file/history/?p=/foo.c
    # get file History
    def get_history(filename, repo)
      http = curl_get("repos/#{repo}/file/history/?p=#{filename}")
      JSON.parse(http.body_str)
    end
  end
end
