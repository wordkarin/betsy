require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # Rating must be present
  # Rating must be between 1 and 5
  test "Creates a review with a rating that is an integer" do
    review = Review.new(rating: 4)
    assert review.valid?
  end

  test "Cannot create a review without a rating" do
    review = Review.new(title: "Awesome Product")
    assert_not review.valid?
  end

  # Rating must be an integer
  test "Cannot create a review with a rating that is not and integer" do
    review = Review.new(rating: "five stars")
    assert_not review.valid?
  end

  # Rating must be between 1 and 5
  test "Cannot create a review with a rating that is > 5" do
    review = Review.new(rating: 6)
    assert_not review.valid?
  end

  test "Cannot create a review with a rating that is < 1" do
    review = Review.new(rating: 0)
    assert_not review.valid?
  end

  
end
