class PropertiesController < ApplicationController
  def index
    # Load the first property with all its associations
    @property = Property.includes(:contractors, :lawyers, :documents).first

    # Also load documents for contractors and lawyers
    if @property
      @property.contractors.each { |c| c.documents.load }
      @property.lawyers.each { |l| l.documents.load }
    end
  end
end
