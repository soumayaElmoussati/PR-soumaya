require 'test_helper'

class BookingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @booking = bookings(:one)
  end

  test "should get index" do
    get bookings_url
    assert_response :success
  end

  test "should get new" do
    get new_booking_url
    assert_response :success
  end

  test "should create booking" do
    assert_difference('Booking.count') do
      post bookings_url, params: { booking: { arrival_date: @booking.arrival_date, client_id: @booking.client_id, departure_date: @booking.departure_date, offer_id: @booking.offer_id, people_count: @booking.people_count, status: @booking.status, total: @booking.total } }
    end

    assert_redirected_to booking_url(Booking.last)
  end

  test "should show booking" do
    get booking_url(@booking)
    assert_response :success
  end

  test "should get edit" do
    get edit_booking_url(@booking)
    assert_response :success
  end

  test "should update booking" do
    patch booking_url(@booking), params: { booking: { arrival_date: @booking.arrival_date, client_id: @booking.client_id, departure_date: @booking.departure_date, offer_id: @booking.offer_id, people_count: @booking.people_count, status: @booking.status, total: @booking.total } }
    assert_redirected_to booking_url(@booking)
  end

  test "should destroy booking" do
    assert_difference('Booking.count', -1) do
      delete booking_url(@booking)
    end

    assert_redirected_to bookings_url
  end
end
