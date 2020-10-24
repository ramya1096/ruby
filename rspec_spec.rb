require 'rspec'
require './spec.rb'
require 'yaml'
$data = YAML.load(File.open('capabilities.yml'))
      #puts data

class Hash 
  def key
    b=$data["actions"]["search"]["parameters"] 
    b.each do |key, value|
    return "#{key} => #{value}"
    end 
  end
end  

class Url 
  def geturl
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



describe "Capabilities" do
  let(:capabilities) { Capabilities.new }

    describe "getkeys" do
        context "get parameters key" do
          it "gives keys of parameters" do 
            @a = $data["actions"]["search"]["parameters"].keys 
             
            expect(capabilities.getkeys()).to eql(@a)
          end
        end
    end

    describe "getcount" do
      context "get count" do
        it "gives keys of parameters" do  
          @a = $data["actions"]["search"]["parameters"].length
          expect(capabilities.getcount()).to eql(@a)
        end
      end
    end


   
   
   

    describe "innerhash" do
      context " get inner hash" do
        it " gives inner hash of parameters" do
          h = Hash.new
          h.key
          expect(capabilities.innerhash()).to eql(h.key)
        end
      end
    end


    describe "getvalues" do
      context " build url from key values" do
        it " builds the url" do
          url = Url.new
          url.geturl
          expect(capabilities.getvalues()).to eql(url.geturl)
        end
      end
    end

  
  
    

end
  