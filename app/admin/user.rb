ActiveAdmin.register User do
  permit_params :name, :number, :exp_month, :exp_year, :cvc

  index do
    id_column
    column :name
    column(:card) { |user| user.card_token ? I18n.t('.attached') : I18n.t('.missing') }
    actions
  end

  controller do
    def update
      token = Stripe::Customer.create(source: params[:user][:card].merge(object: 'card')) unless no_card_applied?
      if resource.update(name: params[:user][:name], card_token: token ? token[:id] : nil)
        flash[:notice] = token ? I18n.t('.card_attached') : I18n.t('.not_attached')
        render :index
      else
        render :edit
      end
    end

    def no_card_applied?
      params[:user][:card].map(&:second).include?('')
    end
  end

  form do |f|
    input :name
    inputs for: :card do |card|
      card.input :number
      card.input :exp_month
      card.input :exp_year
      card.input :cvc
    end
    f.actions
  end


end
