# :nocov:
class Avo::Resources::User < Avo::BaseResource
  self.title = :email
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :email, as: :text
    field :memberships, as: :has_many
    field :teams, as: :has_many, through: :memberships
  end
end
