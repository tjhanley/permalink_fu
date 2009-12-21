namespace :permalink_fu do
   desc "Generate slugs in batches for exsiting rows in a model (arg: ModelName)"
   task :create_slugs => :environment do
        if ENV['model'].blank?
            puts "Please specifiy the model you would like to create permalinks for."
            puts "eg:\t$> rake permalink_fu:create_slugs model=Post"
            exit
        end
        puts "Generating permalinks for #{ENV['model']} model"
        require 'permalink_tasks'
        
        Permalink::Tasks.make_slugs(ENV['model']) do |m|
          puts "%s('%s') permalink_fu'd to '%s'" % [m.class.to_s, m.id, eval("m.#{ENV['model']}.permalink_field")]
        end
   end 
end