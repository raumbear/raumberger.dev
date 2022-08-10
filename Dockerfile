FROM ruby:latest as builder

RUN apt-get update && \
    apt-get install -y build-essential  && \
    apt-get install -y zlib1g-dev && \
    gem install jekyll jekyll-paginate jekyll-tagging jekyll-sitemap webrick bundler html-proofer && \
    mkdir /var/jekyll

WORKDIR /var/jekyll
ADD . /var/jekyll
RUN jekyll build

FROM nginx
COPY --from=builder /var/jekyll/_site/ /usr/share/nginx/html
