module Transactionable
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../../../../app/views/transactionable/', __FILE__)
    desc "Copies shared transactionable views to your application."

    def copy_shared_partials
      directory "shared/", "app/views/transactionable/shared/"
    end
  end
end
