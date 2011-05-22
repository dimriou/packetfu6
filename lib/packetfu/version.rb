module PacketFu

	# Version 1.0.0 was released July 31, 2010
	# Version 1.0.1 is unreleased.
	VERSION = "1.0.2" 

	def self.version
		VERSION
	end

	# Returns the version in a binary format for easy comparisons.
	def self.binarize_version(str)
		if(str.respond_to?(:split) && str =~ /^[0-9]+(\.([0-9]+)(\.[0-9]+)?)?$/)
			bin_major,bin_minor,bin_teeny = str.split(/\x2e/).map {|x| x.to_i}
			bin_version = (bin_major.to_i << 16) + (bin_minor.to_i << 8) + bin_teeny.to_i
		else
			raise ArgumentError, "Compare version malformed. Should be \x22x.y.z\x22"
		end
	end

	# Returns true if the version is equal to or greater than the compare version.
	# If the current version of PacketFu is "0.3.1" for example:
	#
	#   PacketFu.at_least? "0"     # => true 
	#   PacketFu.at_least? "0.2.9" # => true 
	#   PacketFu.at_least? "0.3"   # => true 
	#   PacketFu.at_least? "1"     # => true after 1.0's release
	#   PacketFu.at_least? "1.12"  # => false
	#   PacketFu.at_least? "2"     # => false 
	def self.at_least?(str)
		this_version = binarize_version(self.version)
		ask_version = binarize_version(str)
		this_version >= ask_version
	end

	# Returns true if the current version is newer than the compare version.
	def self.newer_than?(str)
		return false if str == self.version
		!self.older_than?(str)
	end

end
