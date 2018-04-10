require("pry-byebug")
require_relative("./models/bounties.rb")

Bounty.delete_all()

bounty1 = Bounty.new({
    "name" => "Greedo",
    "species" => "Rodian",
    "bounty_value" => 10,
    "weapon" => "Blaster Pistol"
})

bounty1.save()

bounty2 = Bounty.new({
    "name" => "Darth Maul",
    "species" => "Dathomirian",
    "bounty_value" => 90,
    "weapon" => "Dual Lightsaber"
})

bounty2.save()

binding.pry
nil