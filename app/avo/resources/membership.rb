# :nocov:
class Avo::Resources::Membership < Avo::BaseResource
  self.includes = [:team, :user]
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :team_id, as: :number
    field :user_id, as: :number
    field :personal, as: :boolean
    field :team, as: :belongs_to
    field :user, as: :belongs_to
  end
end
