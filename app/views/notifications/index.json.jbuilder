json.array! @notifications do |notification|
  json.id notification.id
  json.template render partial: "notifications/#{notification.notifiable_type.underscore.pluralize}/#{notification}", locals: {notification: notification}, formats: [:html]
end
