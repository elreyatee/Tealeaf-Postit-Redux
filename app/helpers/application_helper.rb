module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def fix_date(date)
    date.getlocal.strftime("%m/%d/%Y at %l:%M%P %Z")
  end
end
