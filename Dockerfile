FROM ruby:latest as builder

RUN apt-get update && \
    apt-get install -y build-essential  && \
    apt-get install -y zlib1g-dev && \
    gem install jekyll jekyll-paginate jekyll-tagging jekyll-sitemap webrick bundler html-proofer && \
    mkdir /var/jekyll

WORKDIR /var/jekyll
ADD . /var/jekyll
RUN jekyll build

FROM nginx:alpine
COPY --from=builder /var/jekyll/_site/ /etc/nginx/html
#ADD nginx.conf
