# frozen_string_literal: true

source "https://rubygems.org"

gemspec

group :test do
  gem "html-proofer", "~> 4.4"
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
gem "http_parser.rb", "~> 0.6.0", :platforms => [:jruby]

# 메타 태그들을 자동: 페이지 제목/설명, Canonical URL, 오픈 그래프 제목, 설명, Twitter 요약 카드 메타 데이터 등
gem 'jekyll-seo-tag'
# 자동으로 생성 날짜를 사용하여 태그를 채워줍니다.
gem 'jekyll-sitemap'
# A Jekyll plugin to generate an Atom (RSS-like) feed of your Jekyll posts
gem 'jekyll-feed'