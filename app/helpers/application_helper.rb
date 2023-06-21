module ApplicationHelper
  def header_links
    if user_signed_in?
      render "layouts/shared/logged_in_header"
    else
      render "layouts/shared/logged_out_header"
    end
  end
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
