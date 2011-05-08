class ContactMessage < NonPersistentRecord

  column :id, :integer
  column :mrs, :string
  column :name, :string
  column :surname, :string
  column :company, :string
  column :street, :string
  column :city, :string
  column :author_phone, :string
  column :author_fax, :string
  column :author_email, :string
  column :cc_email, :string
  column :subject, :string
  column :body, :string

  validates_presence_of :mrs, :name, :surname, :author_email, :subject, :body

end
