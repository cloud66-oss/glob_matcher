module GlobMatcher
	class Matcher
		attr_reader :glob

		def initialize(glob)
			@glob = glob
		end

		# checks if the given value matches the pattern
		def is_match?(value)
			pattern_groups = group_patterns
			if pattern_groups[:negatives].empty?
				negatives = true
			else
				negatives = pattern_groups[:negatives].all? { |x| is_single_match?(x, value) }
			end

			if pattern_groups[:positives].empty?
				positives = true
			else
				positives = pattern_groups[:positives].any? { |x| is_single_match?(x, value) }
			end

			return false if pattern_groups[:positives].empty? && pattern_groups[:negatives].empty?
			return positives && negatives
		end

		private

		# groups patterns into 2 groups: negatives
		# and positives.
		def group_patterns
			patterns = @glob.split(' ')
			negatives = []
			positives = []
			patterns.each do |x|
				if is_negative?(x)
					negatives << x
				else
					positives << x
				end
			end

			return { negatives: negatives, positives: positives }
		end

		def is_negative?(pattern)
			pattern.start_with? '!'
		end

		def is_single_match?(pattern, value)
			if is_negative?(pattern)
				# this will allow escaping of !
				!File.fnmatch?(pattern[1..-1], value, File::FNM_EXTGLOB)
			else
				File.fnmatch?(pattern, value, File::FNM_EXTGLOB)
			end
		end
	end
end
