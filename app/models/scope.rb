class Scope
  CURRENT = 'current'
  BACKLOG = 'backlog'
  
  def self.all
    [CURRENT, BACKLOG]
  end
end