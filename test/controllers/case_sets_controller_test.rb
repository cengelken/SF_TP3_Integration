require 'test_helper'

class CaseSetsControllerTest < ActionController::TestCase
  setup do
    @case_set = case_sets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:case_sets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create case_set" do
    assert_difference('CaseSet.count') do
      post :create, case_set: {  }
    end

    assert_redirected_to case_set_path(assigns(:case_set))
  end

  test "should show case_set" do
    get :show, id: @case_set
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @case_set
    assert_response :success
  end

  test "should update case_set" do
    patch :update, id: @case_set, case_set: {  }
    assert_redirected_to case_set_path(assigns(:case_set))
  end

  test "should destroy case_set" do
    assert_difference('CaseSet.count', -1) do
      delete :destroy, id: @case_set
    end

    assert_redirected_to case_sets_path
  end
end
