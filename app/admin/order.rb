ActiveAdmin.register Order do
  actions :index, :show

  index do
    id_column
    column :title
    column :amount
    actions
    column(:pay) { |order| order.unpaid? ? link_to(I18n.t('.pay'), pay_admin_order_path(order)) : I18n.t('.paid')}
  end

  member_action :pay, :method => :get do
    card = resource.user&.card_token
    return redirect_to :back, notice: I18n.t('.not_found', instance: I18n.t('.card')) unless card
    Stripe::Charge.create(amount: resource.in_cents, currency: 'usd', customer: card)
    resource.paid!
    redirect_to :back, notice: I18n.t('.success')
  end
end
