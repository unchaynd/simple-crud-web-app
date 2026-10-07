# encoding: ASCII-8BIT

module SafeString
	def self.lift(string) = string.b.gsub(/[^0-9a-z]/i) { "_#{$&.getbyte(0).to_s(16).upcase.rjust(2, '0')}" }.freeze
	def self.lower(string) = string.gsub(/_([0-9A-F]{2})/) { $1.to_i(16).chr }
end
