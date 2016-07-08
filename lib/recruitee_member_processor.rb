class RecruiteeMemberProcessor
  def initialize(candidates)
    @candidates = candidates
  end

  def create_profiles!
    @candidates.each do |candidate|
      candidate_data = data(candidate)
      RecruiteeClient.new.post_candidate(candidate_data)
    end
  end

  private

  def data(candidate)
    {
      candidate: {
        name: candidate[:name],
        email: "meetup+#{candidate[:id]}@springest.com",
        phone: "000-0000000",
        remote_cv_url: "http://files.meetup.com/893746/Posting%20Events%20to%20Meetup(Opt1).pdf",
        cover_letter: candidate[:meetup_profile]
      }
    }
  end
end
