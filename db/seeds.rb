require "net/http"

movies_html = Net::HTTP.get URI("https://www.galaxycine.vn/phim-dang-chieu")
movies_doc = Nokogiri::HTML movies_html
movies = []

movies_doc.css(".watchmovie-item").each_with_index do |movie, index|
  movie_link = movie.css(".article-watchmovie").css("a").first.attr("href")
  movie_link = "https://www.galaxycine.vn#{movie_link}"

  movie_html = Net::HTTP.get URI(movie_link)
  movie_doc = Nokogiri::HTML movie_html
  movie_attributes = {image: "", title: "", actors: "", country: "", category: "", producer: "", publish_day: ""}

  image = movie_doc.css(".detail-feat-img").css("img").first.attr("src")
  movie_attributes[:image] = image

  title = movie_doc.css(".details").css(".detail-title").first.text
  movie_attributes[:title] = title

  movie_doc.css(".detail-info").css(".detail-info-row").each do |info|
    info_type = info.css("label").text
    info_value = info.css(".detail-info-right").last.text

    movie_attributes[:country] = info_value if info_type.include?("Quốc gia")
    movie_attributes[:category] = info_value if info_type.include?("Thể loại")
    movie_attributes[:producer] = info_value if info_type.include?("Nhà sản xuất")
    movie_attributes[:actors] = info_value if info_type.include?("Diễn viên")
    movie_attributes[:publish_day] = info_value if info_type.include?("Ngày")
  end

  movies << movie_attributes
end

Movie.import movies
