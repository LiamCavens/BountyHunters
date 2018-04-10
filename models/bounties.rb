require("pg")

class Bounty

    attr_reader :id


    def initialize(options)
        @id = options["id"].to_i
        @name = options["name"]
        @species = options["species"]
        @bounty_value = options["bounty_value"].to_i
        @weapon = options["weapon"]
    end

    def save()
        db = PG.connect({ dbname: "bounties", host: "localhost"})
        sql = "INSERT INTO bounty (name, species, bounty_value, weapon) VALUES ($1, $2, $3, $4) RETURNING id"
        values = [@name, @species, @bounty_value, @weapon]
        db.prepare("save", sql)
        result = db.exec_prepared("save", values)
        db.close()
        @id = result[0]["id"].to_i
    end

    def update()
        db = PG.connect({dbname: "bounties", host: "localhost"})
        sql = "UPDATE bounty SET (name, species, bounty_value, weapon) = ($1, $2, $3, $4) WHERE id = $5"
        values = [@name, @species, @bounty_value, @weapon, @id]
        db.prepare("update", sql)
        db.exec_prepared("update", values)
        db.close()
    end

    def delete()
        db = PG.connect({dbname: "bounties", host: "localhost"})
        sql = "DELETE FROM bounty WHERE id = $1"
        values = [@id]
        db.prepare("delete", sql)
        db.exec_prepared("delete", values)
        db.close()
    end

    def Bounty.find_by_name(name)
        db = PG.connect({dbname: "bounties", host: "localhost"})
        sql = "SELECT * FROM bounty WHERE name = $1"
        values = [name]
        db.prepare("find_by_name", sql)
        bounty = db.exec_prepared("find_by_name", values)
        db.close()
        return bounty.map {|bounty| Bounty.new(bounty)}
    end

    def Bounty.find_by_id(id)
        db = PG.connect({dbname: "bounties", host: "localhost"})
        sql = "SELECT * FROM bounty WHERE id = $1"
        values = [id]
        db.prepare("find_by_id", sql)
        result = db.exec_prepared("find_by_id", values)
        db.close()
        return Bounty.new(result.first())
    end

    def Bounty.all()
        db = PG.connect({dbname: "bounties", host: "localhost"})
        sql = "SELECT * FROM bounty"
        db.prepare("all", sql)
        bounty = db.exec_prepared("all")
        db.close()
        return bounty.map {|bounty| Bounty.new(bounty)}
    end

    def Bounty.delete_all()
        db = PG.connect({dbname: "bounties", host: "localhost"})
        sql = "DELETE FROM bounty"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close()
    end
end