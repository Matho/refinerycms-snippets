class AddDeletableToSnippets < ActiveRecord::Migration

  def change
    add_column ::Refinery::Snippet.table_name, :deletable, :boolean, :default=> true, :null=>false
  end
end
