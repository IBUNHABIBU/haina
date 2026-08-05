SitemapGenerator::Sitemap.default_host = "https://kilimarvellous.com/"

SitemapGenerator::Sitemap.create do
  add '/', changefreq: 'daily', priority: 1.0
  add '/tours', changefreq: 'weekly'
  TravelTour.find_each do |tour|
    add travel_tour_path(tour), lastmod: tour.updated_at
  end
end