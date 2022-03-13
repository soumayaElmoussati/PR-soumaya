require "application_system_test_case"

class BookingsTest < ApplicationSystemTestCase
  setup do
    @booking = bookings(:one)
  end

  test "visiting the index" do
    visit bookings_url
    assert_selector "h1", text: "Bookings"
  end

  test "creating a Booking" do
    visit bookings_url
    click_on "New Booking"

    fill_in "Arrival Date", with: @booking.arrival_date
    fill_in "Client", with: @booking.client_id
    fill_in "Departure Date", with: @booking.departure_date
    fill_in "Offer", with: @booking.offer_id
    fill_in "People Count", with: @booking.people_count
    fill_in "Status", with: @booking.status
    fill_in "Total", with: @booking.total
    click_on "Create Booking"

    assert_text "Booking was successfully created"
    click_on "Back"
  end

  test "updating a Booking" do
    visit bookings_url
    click_on "Edit", match: :first

    fill_in "Arrival Date", with: @booking.arrival_date
    fill_in "Client", with: @booking.client_id
    fill_in "Departure Date", with: @booking.departure_date
    fill_in "Offer", with: @booking.offer_id
    fill_in "People Count", with: @booking.people_count
    fill_in "Status", with: @booking.status
    fill_in "Total", with: @booking.total
    click_on "Update Booking"

    assert_text "Booking was successfully updated"
    click_on "Back"
  end

  test "destroying a Booking" do
    visit bookings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Booking was successfully destroyed"
  end
end
