namespace 'accruto:bounties' do
  desc "Seed database with bounties"
  task :seed => :environment do
    Bounty.create(name: 'Accruto Bounty', value: 858)
  end
end