require "test_helper"

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:valid_book)
  end

  test "valid product" do
    assert @product.valid?
  end

  test "invalid without title" do
    @product.title = ''
    refute @product.valid?, 'saved product without a title'
    assert_equal ["can't be blank"], @product.errors[:title]
  end

  test "invalid with a taken title" do
    same_title = Product.new(title: @product.title, description: 'description', price: 1)
    refute same_title.valid?, 'saved product without a title'
    assert_equal ['has already been taken'], same_title.errors[:title]
  end

  test "invalid without description" do
    @product.description = nil
    refute @product.valid?, 'saved product without a description'
    assert_equal ["can't be blank"], @product.errors[:description]
  end

  test "invalid without image" do
    without_image = Product.new(title: "My Book Title", description: "yyy", price: 1)
    refute without_image.valid?, 'saved product without an image'
    assert_equal ["can't be blank"], without_image.errors[:image]
  end

  test "invalid without price" do
    @product.price = nil
    refute @product.valid?, 'saved product without a price'
    assert_equal ['is not a number'], @product.errors[:price]
  end

  test "invalid with NaN price" do
    @product.price = 'price'
    refute @product.valid?, 'saved product price with string'
    assert_equal ['is not a number'], @product.errors[:price]
  end

  test "invalid with price <= 0" do
    @product.price = 0
    refute @product.valid?, 'saved product price with 0'
    assert_equal ['must be greater than or equal to 0.01'], @product.errors[:price]
  end

  def test_avatar
    avatar = @product.image

    assert avatar.attached?
    assert_not_nil avatar.download
  end
end
