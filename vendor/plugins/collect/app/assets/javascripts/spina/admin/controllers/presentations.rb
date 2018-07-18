Document.ready? do
  conference_id_element = Element.find('#presentation_spina_conference_id')
  conference_id_element.on :change do
    HTTP.get("conference_dates", data: { conference_id: conference_id_element.value }) do |response|
      presentation_date_element = Element.find('#presentation_date')
      presentation_date_element.children.remove
      response.json.each do |date|
        presentation_date_element.append Element.new(:option).text(date[:label]).attr(:value, date[:date])
      end
    end
  end
end
