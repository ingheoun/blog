
base_url = "http://#{request.host_with_port}"
xml.instruct! :xml, :version=>'1.0'
xml.tag! 'urlset', 'xmlns' => 'http://www.sitemaps.org/schemas/sitemap/0.9' do
  xml.url{
      xml.loc("http://ingheoun.link")
      xml.changefreq("weekly")
      xml.priority(1.0)
  }
  xml.url{
      xml.loc("http://ingheoun.link/blog/index")
      xml.changefreq("daily")
      xml.priority(0.9)
  }
  @posts.each do |p|
    xml.url {
      xml.loc("http://ingheoun.link/blog/show/#{p.id.to_s}")
      xml.changefreq("daily")
      xml.priority(0.5)
    }
  end
end