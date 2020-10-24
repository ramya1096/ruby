require 'yaml'

$const_url = "https://fhir-open.devcerner.com/"
$fhir_version = "r4"
$tenant_key = "/2c400054-42d8-4e74-87b7-80b5bd5fde9f/"
$data = YAML.load(File.open('capabilities.yml'))
      #puts data

class Capabilities
    
    
    def getkeys    #to get keys in parameters
       return $data["actions"]["search"]["parameters"].keys 
    end   

    def getcount    #to count the size of keys inside parameters.
       return  $data["actions"]["search"]["parameters"].length
    end   
                              

    def innerhash        #to get inner hash for each keys in parameters.
        count=$data["actions"]["search"]["parameters"]   
        count.each do |key, value|
        return "#{key} => #{value}"
        end
    end

    def getvalues
        $data.each do |key,value|
            if key == "resource"
                 $resource_name=value+"?"
            end

            if key == "actions"
                $patient_id=value["search"]["parameters"]["patient"]["display"]+"=084752"
                $category=value["search"]["parameters"]["category"]["display"]+"=access-plan"
            end
           
        end
         uri = URI("#{$const_url}"+"#{$fhir_version}"+"#{$tenant_key}"+"#{$resource_name}" + "#{$patient_id}" + "#{$category}" )
        return uri
        
    
    end

end

obj = Capabilities.new
obj.getkeys
#obj.getcount
obj.innerhash
puts "\n"
obj.getvalues
   


