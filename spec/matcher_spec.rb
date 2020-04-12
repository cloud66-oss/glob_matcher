RSpec.describe ::GlobMatcher::Matcher do
	context 'with a glob_matcher' do
		it 'should match a single pattern' do
			expect(::GlobMatcher::Matcher.new('').is_match?('abc')).not_to be_truthy
			expect(::GlobMatcher::Matcher.new('*').is_match?('abc')).to be_truthy
			expect(::GlobMatcher::Matcher.new('xy*').is_match?('xyzpq')).to be_truthy
			expect(::GlobMatcher::Matcher.new('xy*').is_match?('abc')).not_to be_truthy
			expect(::GlobMatcher::Matcher.new('a*d').is_match?('abcd')).to be_truthy
			expect(::GlobMatcher::Matcher.new('a\*d').is_match?('a*d')).to be_truthy
			expect(::GlobMatcher::Matcher.new('a{x,y}d').is_match?('abc')).not_to be_truthy
			expect(::GlobMatcher::Matcher.new('a{x,y}d').is_match?('axc')).not_to be_truthy
		end

		it 'should match multiple patterns' do
			expect(::GlobMatcher::Matcher.new('dev master').is_match?('dev')).to be_truthy
			expect(::GlobMatcher::Matcher.new('dev').is_match?('DEV')).not_to be_truthy
			expect(::GlobMatcher::Matcher.new('dev master').is_match?('master')).to be_truthy
			expect(::GlobMatcher::Matcher.new('dev master feature/*').is_match?('master')).to be_truthy
			expect(::GlobMatcher::Matcher.new('dev master feature/*').is_match?('feature/foo')).to be_truthy
			expect(::GlobMatcher::Matcher.new('dev master feature/*').is_match?('hotfix/foo')).not_to be_truthy
		end

		it 'should match single negative' do
			expect(::GlobMatcher::Matcher.new('!master').is_match?('master')).not_to be_truthy
			expect(::GlobMatcher::Matcher.new('!master').is_match?('dev')).to be_truthy
			expect(::GlobMatcher::Matcher.new('!a*').is_match?('abc')).not_to be_truthy
			expect(::GlobMatcher::Matcher.new('!a*').is_match?('xyz')).to be_truthy
			expect(::GlobMatcher::Matcher.new('!master').is_match?('!master')).to be_truthy
			expect(::GlobMatcher::Matcher.new('\!master').is_match?('!master')).to be_truthy
		end

		it 'should match multiple mixed' do
			expect(::GlobMatcher::Matcher.new('!master !dev !abc').is_match?('xyz')).to be_truthy
			expect(::GlobMatcher::Matcher.new('!master !dev !abc').is_match?('abc')).not_to be_truthy
			expect(::GlobMatcher::Matcher.new('master feature/* !dev !abc').is_match?('abc')).not_to be_truthy
			expect(::GlobMatcher::Matcher.new('master feature/* !dev !abc').is_match?('master')).to be_truthy
			expect(::GlobMatcher::Matcher.new('master feature/* !dev !abc').is_match?('feature/foo')).to be_truthy
		end

	end
end
