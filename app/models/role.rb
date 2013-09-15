class Role
  ADMIN = 'admin'
  MEMBER = 'member'
  STAKEHOLDER = 'stakeholder'
  
  def self.all
    [ADMIN, MEMBER, STAKEHOLDER]
  end
end