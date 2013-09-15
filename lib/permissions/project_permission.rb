module ProjectPermission
	def permitted_to_manage_members_by?(user)
		user.admin_for?(self)
	end

	def permitted_to_manage_by?(user)
		user.admin_for?(self)
	end
end