require 'net/ssh'

devices = [
  { ip: "10.10.10.1", name: "mgmt-rtr" },
  { ip: "10.10.10.2", name: "reg-rtr" },
  { ip: "10.10.10.3", name: "ham-rtr" },
  { ip: "10.10.10.4", name: "mid-rtr" },
  { ip: "10.10.10.5", name: "mgmt-sw" },
  { ip: "10.10.10.6", name: "ham-sw" },
  { ip: "10.10.10.7", name: "mid-sw" }
]

username = ENV['CISCO_USER'] || 'student'
password = ENV['CISCO_PASS'] || 'Passw0rd!'

banner_message = "Welcome to your device - Managed by Chef!"

devices.each do |device|
  puts "[INFO] Connecting to #{device[:name]} (#{device[:ip]})..."
  Net::SSH.start(device[:ip], username, password: password, verify_host_key: :never) do |ssh|
    ssh.open_channel do |channel|
      channel.request_pty
      channel.send_channel_request("shell") do |ch, success|
        if success
          ch.send_data("enable\n")
          ch.send_data("#{password}\n")
          ch.send_data("conf t\n")
          ch.send_data("banner motd ^#{banner_message}^\n")
          ch.send_data("end\n")
          ch.send_data("wr mem\n")
          ch.send_data("exit\n")
        else
          puts "[ERROR] Failed to open shell on #{device[:name]}"
        end
      end
      ssh.loop
    end
  end
  puts "[INFO] Banner set on #{device[:name]}"
end
