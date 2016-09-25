class New < Sequel::Model
  many_to_one :owner, class: :User, key: :ownerid
end