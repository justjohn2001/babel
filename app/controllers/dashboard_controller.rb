class DashboardController < ApplicationController
  def index
    @user_count = User.count
    @question_count = Question.count
    @answer_count = Answer.count

# despite documentation saying Tenants.left_outer_joins should work, it doesn't
# I inspected the methods of Tenant and verified there was no such method.
    @tenants = Tenant.joins("left outer join tenant_stats on tenants.id = tenant_stats.tenant_id").select("name", "ifnull(request_count, 0) request_count").all
  end

end
