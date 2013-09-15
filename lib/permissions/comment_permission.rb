module CommentPermission
	def permitted_to_delete_by?(user)
		self.user == user
	end
end