ActiveAdmin.register Order do
  index do
    id_column
    column :title
    column :amount
    actions
    column(:pay) { |order| order.unpaid? ? link_to(I18n.t('.pay'), pay_admin_order_path(order)) : I18n.t('.paid')}
  end

  member_action :pay, :method => :get do
    order = Order.find_by(id: params[:id])
    return redirect_to :back, notice: I18n.t('.not_found', instance: I18n.t('.order')) unless order
    card = order.user.try(:card_token)
    return redirect_to :back, notice: I18n.t('.not_found', instance: I18n.t('.card')) unless card
    Stripe::Charge.create(amount: order.in_cents, currency: 'usd', customer: card)
    order.update(status: 'paid')
    redirect_to :back, notice: I18n.t('.success')
  end
end
