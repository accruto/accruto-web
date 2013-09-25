module CandidatesHelper
  def candidate_label_class(label)
    return label.downcase.split(" ").join("-")
  end

  def status_filter_options
    return Candidate::STATUS
  end

  def visa_filter_options
    return Candidate::VISA
  end

  def updated_at_filter_options
    return [
      ["All", nil],
      ["Today", 1],
      ["Last 3 days", 3],
      ["Last 7 days", 7],
      ["Last 14 days", 14],
      ["Last 30 days", 30]
    ]
  end
end