class Strip
  include Mongoid::Document
  include Mongoid::Timestamps::Updated

  field :number, type: Integer
  field :image, type: String
  field :header, type: String
  field :previous, type: Integer

  index({ number: 1 }, unique: true)

  validates_presence_of :number, :image, :previous
  validates_uniqueness_of :number, :previous

  def self.latest
    find_by number: max(:number)
  end

  def title
    "Tirinha número #{number}"
  end

  def url
    "http://www.malvados.com.br/index#{number}.#{extension}"
  end

  def content
    %Q{
      <p>
        <img src="#{header}" alt="#{title}" />
      </p>
      <p>
        <a href="#{url}">
          <img src="#{image}" alt="#{title}" />
        </a>
      </p>
    }
  end

  private

  def extension
    number == 123 ? 'htm' : 'html'
  end
end
