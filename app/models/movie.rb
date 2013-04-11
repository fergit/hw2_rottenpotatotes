class Movie < ActiveRecord::Base

def self.ratings
	['G','PG','PG-13','R']
	#{'G' => true,'PG' => true,'PG-13' => true,'R' => true}	
end
end
