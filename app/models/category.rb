class Category < ActiveRecord::Base

    has_many :products,  :foreign_key => 'category_id', :class_name =>'Product'
    
end
