module CandidatesHelper
  def candidate_label_class(label)
    positive_details = [
      'Australian Residency or Citizenship',
      'Valid Work Visa',
      'Immediately',
      'After 1 week',
      'After 1 month',
      'Actively looking',
      'Available immediately'
    ]
    if positive_details.any? { |w| label[w] }
      return 'tag-yellow'
    end
  end

  def status_filter_options
    return Candidate::STATUS_OPTIONS
  end

  def visa_filter_options
    return Candidate::VISA_OPTIONS
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