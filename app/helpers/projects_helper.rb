module ProjectsHelper
  def phase_width(phase_count)
    width = 100.0 / phase_count
    {style: sprintf("width: %5.2f%", width)}
  end

  def card_size(card)
    card.size.blank? ? '0' : card.size
  end
end
