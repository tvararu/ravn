require "test_helper"

class TeamTest < ActiveSupport::TestCase
  test ".personal scope returns personal teams" do
    scope = Team.personal
    assert_includes scope, teams(:alices_team)
    assert_includes scope, teams(:bobs_team)
    refute_includes scope, teams(:bobs_work_team)
  end

  test ".editable scope returns non-personal teams" do
    scope = Team.editable
    assert_includes scope, teams(:bobs_work_team)
    refute_includes scope, teams(:alices_team)
    refute_includes scope, teams(:bobs_team)
  end
end
