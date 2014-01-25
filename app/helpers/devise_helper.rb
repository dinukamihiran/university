module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-error alert-block" style="padding-left: 5%;">
      <button type="button" class="close" data-dismiss="alert">x</button>
      <h5>#{sentence}
      #{messages}</h5>
    </div>
    HTML

    html.html_safe
  end
end