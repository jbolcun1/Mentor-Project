
#a record of a user from the database
class Users < Sequel::Model
    
    #.name returns the concatonated first and surname
    def name
      "#{first_name} #{surname}" 
    end
    
    #.getDescriptions returns a string array of all of the user's 
    #descriptions 
    def getDescriptions
        #retrieves a dataset from the database
        dataset = Description.where(id: id)
        descriptions = []
        
        #appends the description field from each record in the 
        #dataset to the descriptions array
        dataset.each do |record|
            descriptions << record.description
        end
        
        #returns an array of strings 
        descriptions
    end

    # def
    # end
end

class Description < Sequel::Model
end