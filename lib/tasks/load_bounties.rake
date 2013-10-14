namespace 'accruto:bounties' do
  desc "Seed database with bounties" do
    task :seed => :environment do
      Bounty.create(name: 'Accruto Bounty', value: 858)
    end
  end
end