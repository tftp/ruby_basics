module Company_name
  
  def input_name_company (name)
    @name_company = name
  end
  
  def output_name_company
    @name_company
  end

  private

  attr_accessor :name_company
  
end
