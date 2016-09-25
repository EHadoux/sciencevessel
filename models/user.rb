class User < Sequel::Model
  one_to_many :news
  one_to_many :papers

  def own?(paper)
    paper.owner == self || self.admin
  end
end