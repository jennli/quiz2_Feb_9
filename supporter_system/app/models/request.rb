class Request < ActiveRecord::Base

  self.per_page = 7

  validates :name, presence:true
  validates :department, presence:true
  validates :message, presence: true, uniqueness: {scope: :name}

  def self.search(str)
    where("name ILIKE ? OR email ILIKE ? OR department ILIKE ? OR message ILIKE ?", "%#{str}%", "%#{str}%","%#{str}%","%#{str}%")
  end

end
