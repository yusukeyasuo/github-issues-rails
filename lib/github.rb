require 'net/http'
require 'json'

class Github
  def self.get_issues(repo_url, page = 1, per_page = 5)
    res_csv = ''
    res = Net::HTTP.get(URI.parse("#{repo_url}?page=#{page}&per_page=#{per_page}"))
    issues = JSON.parse(res)
    issues.each do |i|
      res_csv += "#{i['title'].slice(0, 30)},#{i['body'].slice(0, 50).gsub(/(\r\n?|\n)/," ")},#{i['comments_url']}\n"
    end

    res_csv
  end
end
