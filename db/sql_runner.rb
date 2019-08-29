require("pg")

class SqlRunner

  def self.run(sql, values = [])
    begin
      # db = PG.connect({dbname: "gym", host: "localhost"})
      db = PG.connect({dbname: "d6355m8o3oeoel",
        host: "ec2-54-221-212-126.compute-1.amazonaws.com",
        port: "5432",
        user: "uuhuykbufwwhyj",
        password: "2688e1753a76ad7b52da2f09066b0a953b34a3fc5a0f91ab0a86c757ea7e8a7d"})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close if db != nil
    end
    return result
  end

end
