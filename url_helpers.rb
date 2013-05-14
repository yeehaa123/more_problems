module UrlHelpers

  def new_problem_path
    "/problems/new"
  end

  def problem_path(problem)
    "/problems/#{problem.id}"
  end

  def edit_problem_path(problem)
    "/problems/#{problem.id}/edit"
  end

  def problems_path
    "/problems"
  end

  def link_to(text, path, options = {})
    %Q{<a href="#{path}" class="#{options[:class]}" data-method='#{options[:method]}'>#{text}</a>}
  end

end
