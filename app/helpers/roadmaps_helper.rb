module RoadmapsHelper
  def title(roadmap)
    start = "Mon voyage"

    details = roadmap.details
    case details[:kind]
    when :city
      return "#{start} à #{details[:where]}"
    when :country
      return "#{start} #{(details[:where][-1] == 's') ? 'aux' : 'en'} #{details[:where]}"
    when :continent
      return "#{start} en #{details[:where]}"
    when :bicontinent
      return "#{start} #{details[:where]}"
    when :global
      return "#{start} autour du globe"
    else
      return "#{start}"
    end
  end
end
