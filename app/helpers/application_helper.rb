module ApplicationHelper
  def class_for_flash(key)
    {
      alert: 'alert-danger',
      notice: 'alert-success'
    }.stringify_keys[key.to_s]
  end

  def flash_message
    flash.map do |key, message|
      concat(content_tag(:div, message, class: "alert #{class_for_flash(key)} alert-dismissible fade show mt-4", role: 'alert') do
        concat content_tag(:button, '',type: 'button', class: 'btn-close', data: { bs_dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end
end
