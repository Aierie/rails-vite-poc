require "test_helper"

class PropertyTest < ActiveSupport::TestCase
  test "should have many contractors" do
    property = Property.create!(name: "Test Property", address: "123 Test St", description: "Test")
    contractor1 = property.contractors.create!(name: "Contractor 1", specialty: "Plumbing")
    contractor2 = property.contractors.create!(name: "Contractor 2", specialty: "Electrical")

    assert_equal 2, property.contractors.count
    assert_includes property.contractors, contractor1
    assert_includes property.contractors, contractor2
  end

  test "should have many lawyers" do
    property = Property.create!(name: "Test Property", address: "123 Test St", description: "Test")
    lawyer1 = property.lawyers.create!(name: "Lawyer 1", firm: "Firm A")
    lawyer2 = property.lawyers.create!(name: "Lawyer 2", firm: "Firm B")

    assert_equal 2, property.lawyers.count
    assert_includes property.lawyers, lawyer1
    assert_includes property.lawyers, lawyer2
  end

  test "should have many documents through polymorphic association" do
    property = Property.create!(name: "Test Property", address: "123 Test St", description: "Test")
    doc1 = property.documents.create!(title: "Document 1", content: "Content 1", document_type: "contract")
    doc2 = property.documents.create!(title: "Document 2", content: "Content 2", document_type: "legal")

    assert_equal 2, property.documents.count
    assert_includes property.documents, doc1
    assert_includes property.documents, doc2
    assert_equal "Property", doc1.documentable_type
    assert_equal property.id, doc1.documentable_id
  end

  test "destroying property should destroy associated records" do
    property = Property.create!(name: "Test Property", address: "123 Test St", description: "Test")
    contractor = property.contractors.create!(name: "Contractor 1", specialty: "Plumbing")
    lawyer = property.lawyers.create!(name: "Lawyer 1", firm: "Firm A")
    document = property.documents.create!(title: "Document 1", content: "Content 1", document_type: "contract")

    contractor_id = contractor.id
    lawyer_id = lawyer.id
    document_id = document.id

    property.destroy

    assert_nil Contractor.find_by(id: contractor_id)
    assert_nil Lawyer.find_by(id: lawyer_id)
    assert_nil Document.find_by(id: document_id)
  end
end
