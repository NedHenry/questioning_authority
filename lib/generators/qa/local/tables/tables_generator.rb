require 'rails/generators/active_record/migration'
module Qa::Local
  class TablesGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    include ActiveRecord::Generators::Migration

    def migrations
      generate "model qa/local_authority name:string:uniq"
      generate "model qa/local_authority_entry local_authority:references label:string uri:string:uniq"
      message = "Rails doesn't support functional indexes in migrations, so you'll have to add this manually:\n" \
    "CREATE INDEX \"index_qa_local_authority_entries_on_lower_label\" ON \"qa_local_authority_entries\" (local_authority_id, lower(label))\n" \
    "   OR on Sqlite: \n" \
    "CREATE INDEX \"index_qa_local_authority_entries_on_lower_label\" ON \"qa_local_authority_entries\" (local_authority_id, label collate nocase)\n"
      say_status("info", message, :yellow)
    end

  end
end

