# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
Document.destroy_all
Contractor.destroy_all
Lawyer.destroy_all
Property.destroy_all

puts "Creating properties with associations..."

# Create first property
property1 = Property.create!(
  name: "Sunset Plaza",
  address: "123 Main Street, Los Angeles, CA 90001",
  description: "A beautiful commercial property located in the heart of downtown. Features modern amenities and excellent location."
)

# Add contractors to property1
contractor1 = property1.contractors.create!(
  name: "John's Construction Co",
  specialty: "General Contracting"
)

contractor2 = property1.contractors.create!(
  name: "Elite Plumbing Services",
  specialty: "Plumbing"
)

contractor3 = property1.contractors.create!(
  name: "Bright Electrical Works",
  specialty: "Electrical"
)

# Add lawyers to property1
lawyer1 = property1.lawyers.create!(
  name: "Sarah Johnson",
  firm: "Johnson & Associates LLP"
)

lawyer2 = property1.lawyers.create!(
  name: "Michael Chen",
  firm: "Chen Legal Group"
)

# Add documents to property1 (polymorphic)
property1.documents.create!(
  title: "Purchase Agreement",
  content: "This agreement outlines the terms of purchase for Sunset Plaza...",
  document_type: "contract"
)

property1.documents.create!(
  title: "Property Deed",
  content: "Official deed for the property located at 123 Main Street...",
  document_type: "legal"
)

property1.documents.create!(
  title: "Inspection Report",
  content: "Full property inspection conducted on January 15, 2024...",
  document_type: "report"
)

# Add documents to contractor1 (polymorphic)
contractor1.documents.create!(
  title: "Construction Contract",
  content: "Contract between Sunset Plaza and John's Construction Co...",
  document_type: "contract"
)

contractor1.documents.create!(
  title: "Building Permit",
  content: "Permit #12345 issued for renovation work...",
  document_type: "permit"
)

# Add documents to lawyer1 (polymorphic)
lawyer1.documents.create!(
  title: "Legal Opinion Letter",
  content: "Legal opinion regarding zoning compliance for Sunset Plaza...",
  document_type: "legal"
)

# Create second property
property2 = Property.create!(
  name: "Riverside Apartments",
  address: "456 River Road, San Francisco, CA 94102",
  description: "Luxury residential complex with waterfront views. 50 units total with premium finishes."
)

property2.contractors.create!(
  name: "Bay Area HVAC Solutions",
  specialty: "HVAC"
)

property2.lawyers.create!(
  name: "Emily Rodriguez",
  firm: "Rodriguez & Partners"
)

property2.documents.create!(
  title: "Lease Agreement Template",
  content: "Standard lease agreement for Riverside Apartments units...",
  document_type: "contract"
)

# Create third property
property3 = Property.create!(
  name: "Tech Hub Office Park",
  address: "789 Innovation Drive, Austin, TX 78701",
  description: "Modern office space designed for tech companies. Features high-speed internet and flexible layouts."
)

property3.contractors.create!(
  name: "Network Infrastructure Inc",
  specialty: "IT Infrastructure"
)

property3.contractors.create!(
  name: "Modern Interiors",
  specialty: "Interior Design"
)

property3.lawyers.create!(
  name: "David Martinez",
  firm: "Tech Law Advisors"
)

property3.documents.create!(
  title: "Tenant Handbook",
  content: "Complete guide for tenants of Tech Hub Office Park...",
  document_type: "guide"
)

puts "Seed data created successfully!"
puts "Properties: #{Property.count}"
puts "Contractors: #{Contractor.count}"
puts "Lawyers: #{Lawyer.count}"
puts "Documents: #{Document.count}"
