require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest
   def setup
        @user = User.create(username: "testadmin", email: "testemail@hotmail.com", password: "adminpass12321", admin: true)
        
   end
   
    
    test "get new category form and create category" do
        sign_in_as(@user, "adminpass12321")
        get new_category_path
        assert_template 'categories/new'
        assert_difference 'Category.count', 1 do
            post categories_path, params: {category: {name: "sports"}}
            follow_redirect!
        end
        assert_template 'categories/index'
        assert_match "sports", response.body
    end
    
    test "invalid submission results in failure" do
        sign_in_as(@user, "adminpass12321")
        get new_category_path
        assert_template 'categories/new'
        assert_no_difference 'Category.count' do
            post categories_path, params: {category: {name: " "}}
        end
        assert_template 'categories/new'
        assert_select 'h2.alert-title'
        assert_select 'div.alert-body'
    end
    
end