cache [@latest.number, params[:latest]]  do
  atom_feed do |feed|
    cache 'header' do
      feed.link :href => @settings[:base_url], rel: 'alternate'
      feed.title @settings[:title]
      feed.subtitle @settings[:description]
      feed.author { |f| f.name @settings[:author] }
      feed.updated @latest.updated_at
      feed.icon "http://www.malvados.com.br/favicon.ico"
      feed.generator @settings[:developer], uri: @settings[:project]
    end

    @strips.each do |strip|
      feed.entry strip, url: strip.url do |entry|
        entry.title strip.title
        entry.content strip.content, type: 'html'
      end
    end
  end
end
