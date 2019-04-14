class Api::ReservationsController < Api::ApiController
	protect_from_forgery with: :null_session
  def commit
    Reservation.transaction do
      params = JSON.parse(request.body.read)

      customer_params = params['customer']
      reservation_params = params['reservation']
      #customer作成
      #新規会員かつ、非会員による予約のケース

      #すでに同じemailで登録済みなら新規登録でなく更新する
      customer = Customer.find_by(email: customer_params['email'], has_membership: false)
      if (!customer) then
        isNew = true
        customer = Customer.new
        customer.email = customer_params['email']
        customer.first_visit_store_id = params['shop_id']
        customer.has_membership = false
      end
      customer.tel = customer_params['tel']
      customer.last_visit_store_id = params['shop_id']
      customer.first_name = customer_params['first_name']
      customer.last_name = customer_params['last_name']
      customer.first_kana = customer_params['first_kana']
      customer.last_kana = customer_params['last_kana']
      customer.can_receive_mail = customer_params['can_receive_mail']

      #reservation作成
      reservation = Reservation.new
      reservation.reservation_comment = reservation_params['reservation_comment']
      reservation.pregnant_state_id = reservation_params['pregnant_state_id']
      reservation.children_count = reservation_params['children_count']
      startTime = Time.strptime(reservation_params['start_time'], "%Y%m%d %H")
      reservation.reservation_date = startTime
      reservation.start_time = startTime
      reservation.end_time = startTime + 60 * reservation_params['total_minutes']
      #予約日をcustomerにも設定
      customer.first_visited_at = startTime
      customer.last_visited_at = startTime

      customer.save!

      reservation.customer_id = customer.id
      reservation.save!

      #reservation_detail作成
      menus_params = reservation_params['menus']
      menus_params.each do |menu|
        reservation_detail = ReservationDetail.new
        reservation_detail.reservation_id = reservation.id
        reservation_detail.menu_id = menu['id']
        reservation_detail.save!

        options_params = menu['options']
        options_params.each do |option|
          reservation_option = ReservationOption.new
          reservation_option.reservation_id = reservation.id #reservation_detailと紐付けるべき？
          reservation_option.option_id = option['id']
          reservation_option.count = option['count']
          reservation_option.save!
        end
      end
      #reservation_coupon作成
      couponsParams = reservation_params['coupons']
      couponsParams.each do |coupon|
        reservation_coupon = ReservationCoupon.new
        reservation_coupon.reservation_id = reservation.id
        reservation_coupon.coupon_id = coupon['id']
        reservation_coupon.save!
      end
      #TODO reservationとshiftの紐づけ

      #reservation_option作成
    end
      self.render_response_ok
    # rescue => e
    #   self.render_response_error
  end

  def menus
    render json: Store.find(params[:id]).to_shop_menus
  end

  def dates
    render json: {}
  end
end
