require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:valid_book)
  end

  test "visiting the index" do
    visit products_url
    assert_selector "h1", text: "book title"
  end

  test "should not create product" do
    visit products_url
    click_on "New product"

    click_on "Create Product"

    assert_text "errors prohibited this product from being saved"
    click_on "Back"
  end

  test "should create product" do
    visit products_url
    click_on "New product"

    fill_in "product_title", with: "new title"
    fill_in "product_description", with: "new description"
    fill_in "product_price", with: 10
    attach_file "product_image", "/test/fixtures/files/lorem.jpg"
    click_on "Create Product"

    assert_text "errors prohibited this product from being saved"
    click_on "Back"
  end

  test "should update Product" do
    visit product_url(@product)
    click_on "Edit this product", match: :first

    click_on "Update Product"

    assert_text "Product was successfully updated"
    click_on "Back"
  end

  test "should destroy Product" do
    visit product_url(@product)
    click_on "Destroy this product", match: :first

    assert_text "Product was successfully destroyed"
  end
end
