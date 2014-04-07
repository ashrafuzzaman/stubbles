module TaskActions
  def progress_done
    update_percent_completed 100
  end

  def restart_progress
    update_percent_completed 0
  end

  private
  def update_percent_completed(percent_completed, date = Date.current)
    time_entry = time_entry_for(User.current, date)
    time_entry.percent_completed = percent_completed
    time_entry.hours_spent ||= 0
    time_entry.save!
    ap time_entry
    ap self.reload
  end
end