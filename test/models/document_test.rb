require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  test "document can belong to a property through polymorphic association" do
    property = Property.create!(name: "Test Property", address: "123 Test St", description: "Test")
    document = property.documents.create!(title: "Property Document", content: "Test content", document_type: "contract")

    assert_equal property, document.documentable
    assert_equal "Property", document.documentable_type
    assert_equal property.id, document.documentable_id
  end

  test "document can belong to a contractor through polymorphic association" do
    property = Property.create!(name: "Test Property", address: "123 Test St", description: "Test")
    contractor = property.contractors.create!(name: "Test Contractor", specialty: "Plumbing")
    document = contractor.documents.create!(title: "Contractor Document", content: "Test content", document_type: "contract")

    assert_equal contractor, document.documentable
    assert_equal "Contractor", document.documentable_type
    assert_equal contractor.id, document.documentable_id
  end

  test "document can belong to a lawyer through polymorphic association" do
    property = Property.create!(name: "Test Property", address: "123 Test St", description: "Test")
    lawyer = property.lawyers.create!(name: "Test Lawyer", firm: "Test Firm")
    document = lawyer.documents.create!(title: "Lawyer Document", content: "Test content", document_type: "legal")

    assert_equal lawyer, document.documentable
    assert_equal "Lawyer", document.documentable_type
    assert_equal lawyer.id, document.documentable_id
  end

  test "polymorphic association allows different documentable types" do
    property = Property.create!(name: "Test Property", address: "123 Test St", description: "Test")
    contractor = property.contractors.create!(name: "Test Contractor", specialty: "Plumbing")
    lawyer = property.lawyers.create!(name: "Test Lawyer", firm: "Test Firm")

    property_doc = property.documents.create!(title: "Property Doc", content: "Content", document_type: "contract")
    contractor_doc = contractor.documents.create!(title: "Contractor Doc", content: "Content", document_type: "permit")
    lawyer_doc = lawyer.documents.create!(title: "Lawyer Doc", content: "Content", document_type: "legal")

    # Verify each document is associated with the correct documentable type
    assert_instance_of Property, property_doc.documentable
    assert_instance_of Contractor, contractor_doc.documentable
    assert_instance_of Lawyer, lawyer_doc.documentable

    # Verify the documents are created correctly
    assert property_doc.persisted?
    assert contractor_doc.persisted?
    assert lawyer_doc.persisted?
  end
end
