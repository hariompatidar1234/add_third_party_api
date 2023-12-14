class CategoryDatatable < AjaxDatatablesRails::ActiveRecord
 def view_columns
    @view_columns ||= {
      id: { source: "Category.id" },
      name: { source: "Category.name",cond: :like, searchable: true, orderable: true  },
      show: { source: "Category.id", searchable: false, orderable: false }
    }
  end
  def data
    records.map do |record|
      [
        id: record.id,
        name: record.name,
        show: link_to("show", category_path(record), class: 'btn btn-primary')
      ]
    end
  end
  def get_raw_records
    Category.all
  end
end
