module TaskPermission
	def permitted_to_estimate_by?(user)
		user.admin_for?(story.project) || self.new_record?
	end

	def permitted_to_enter_time_by?(user)
		self.assigned_to == user
	end

	def permitted_to_edit_by?(user)
		user.admin_for?(story.project) || self.assigned_to == user || self.new_record?
	end

	def permitted_to_delete_by?(user)
		user.admin_for?(story.project) || self.assigned_to == user
	end
end