module CandidatesHelper
  def candidate_label_class(label)
    return label.downcase.split(" ").join("-")
  end
end