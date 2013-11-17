module AuditTrail
  module ClassMethods
    def track(options = {})
      meta = options[:meta]
      self.after_save do
        sanitized_changes = self.changes.clone
        sanitized_changes.delete :updated_at
        sanitized_changes.delete :created_at
        sanitized_changes = sanitized_changes.delete_if { |attr, change| change[0] == change[1] }
        logger.debug "self.changes :: #{sanitized_changes}"
        unless sanitized_changes.empty?
          meta_attrs = Hash[(meta || {}).collect { |k, v| [k, v.is_a?(Symbol) ? self.send(v) : v.call(self)] }]
          logger.debug "meta_attrs :: #{meta_attrs.inspect}"
          version = Version.new({event: 'save', object: self.attributes})
          version.trackable = self
          sanitized_changes.each do |field, changes|
            version.version_changes.build(field: field, was: changes[0], now: changes[1])
          end
          ap version.version_changes
          version.save!
        end
      end
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
  end
end

ActiveSupport.on_load(:active_record) do
  include AuditTrail
end