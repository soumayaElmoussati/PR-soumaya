class FarmerIncome < ApplicationRecord
  belongs_to :offer
  before_save :update_calculus

  enum state: [
    :pending,
    :confirme,
    :payed
  ], _prefix: :incomes

  def stay_count_calculus
    return self.offer.bookings.where(status: [4,5,12]).size
  end

  def expenses_balance_calculs
    expenses = self.offer.expenses
    arr = []

    expenses.where(state: 2).each do |expense|
      if expense.expense_date <= self.end_date && expense.expense_date >= self.start_date
        arr << expense.total_ttc
      end
    end
    return arr.sum
  end

  def lodging_income_balance_calculus
    bookings = self.offer.bookings
    arr = []

    bookings.where(status: [4,5,12]).each do |booking|
      if booking.arrival_date <= self.end_date && booking.arrival_date >= self.start_date
        arr << booking.lodging_cost
      end
    end
    return arr.sum
  end

  def expense_farmer_calculus
    expenses = self.offer.expenses
    arr = []

    expenses.where(state: 2, responsable: "Agriculteur").each do |expense|
      if expense.expense_date <= self.end_date && expense.expense_date >= self.start_date
        arr << expense.total_ttc
      end
    end
    return arr.sum
  end

  def housework_income_balance_calculus
    nb = 0
    bookings = self.offer.bookings

    bookings.where(status: [4,5,12]).each do |booking|
      if booking.arrival_date <= self.end_date && booking.arrival_date >= self.start_date && !booking.housework
        nb += 1
      end
    end
    return nb * 4500
  end

  def total_farmer_calculus
    p self.farmer_balance
    p self.housework_income_balance
    p self.farmer_expenses
    return self.farmer_balance + self.housework_income_balance + self.farmer_expenses
  end

  def offer_income_calculus
    bookings = self.offer.bookings
    arr = []

    bookings.where(status: [4,5,12]).each do |booking|
      if booking.arrival_date <= self.end_date && booking.arrival_date >= self.start_date
        arr << booking.sub_total
      end
    end
    return arr.sum - self.housework_income_balance
  end

  def annexes_incomes_calculus
    bookings = self.offer.bookings
    arr = []

    bookings.where(status: [4,5,12]).each do |booking|
      if booking.arrival_date <= self.end_date && booking.arrival_date >= self.start_date
        arr << booking.annexe_services_total
      end
    end

    return arr.sum

  end

  def farmer_balance_calculus

    if self.offer.inverseur_percentage != nil
      p "FARMER BALANCE CALCULUS"
      p self.total_offer_income
      p self.expenses_balance
      p self.offer.inverseur_percentage
      return (self.total_offer_income - self.expenses_balance) * (self.offer.inverseur_percentage / 100)
    end

  end

  private

  def update_calculus
    self.expenses_balance = expenses_balance_calculs
    self.lodging_income_balance = lodging_income_balance_calculus
    self.farmer_expenses = expense_farmer_calculus
    self.housework_income_balance = housework_income_balance_calculus
    self.stay_count = stay_count_calculus
    self.total_farmer_balance = total_farmer_calculus
    self.annexes_incomes_balance = annexes_incomes_calculus
    self.total_offer_income = offer_income_calculus
    self.farmer_balance = farmer_balance_calculus
  end

end
