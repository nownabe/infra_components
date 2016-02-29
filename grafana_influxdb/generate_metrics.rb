require "active_support/core_ext/numeric/time"
require "influxdb"

db =
  InfluxDB::Client.new(
    "mytest",
    host: ENV["INFLUXDB"],
    username: "mytest",
    password: "mytest"
  )

groups = %w(api ctrl worker sensu db)

hosts = []

groups.each do |group|
  3.times do |i|
    hosts.push(
      hostname: "dev-#{group}-%02d" % i,
      group: group,
      stage: "dev"
    )
  end
end

base_time = Time.now
series = "cpu"

1000.times do |i|
  timestamp = (base_time - i.minutes).to_i

  hosts.each do |host|
    usages = {
      user: rand(500) / 10.0,
      system: rand(500) / 10.0
    }
    usages[:idle] = 100.0 - usages[:user] - usages[:system]

    usages.each do |type, usage|
      data = {
        values: { value: usage },
        tags: host.merge(cpu_type: type),
        timestamp: timestamp
      }
      db.write_point(series, data)
    end
  end
end
