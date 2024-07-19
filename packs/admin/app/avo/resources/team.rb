# :nocov:
class Avo::Resources::Team < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :memberships, as: :has_many
    field :users, as: :has_many, through: :memberships
  end
end
