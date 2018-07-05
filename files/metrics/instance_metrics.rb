#!/usr/bin/env ruby

instances = {}
uuid_output = `cd /etc/libvirt/qemu; grep -H '<uuid>' instance-*.xml`
uuid_output.split("\n").each do |line|
  output = []
  line.gsub!(/<\/?uuid>/, '')
  line.gsub!(/\s+/, '')
  line.gsub!(/\.xml/, '')
  (instance, uuid) = line.split(':')

  # Instance ID
  output << "#{uuid} instance instance:#{instance}"

  # Get CPU time and memory usage
  cpu_time = 0
  dominfo_output = %x{ virsh dominfo #{instance} 2> /dev/null }
  if $? == 0
    dominfo = {}
    dominfo_output.split("\n").each do |dominfo_line|
      (dominfo_key, dominfo_value) = dominfo_line.downcase.split(/:\s+/)
      dominfo[dominfo_key] = dominfo_value
    end

    next if dominfo['state'] != 'running'

    cpu_time = dominfo['cpu time'].gsub('s', '')
    available = dominfo['max memory'].gsub(' kib', '')
    used = dominfo['used memory'].gsub(' kib', '')
    output << "#{uuid} memory available:#{available} used:#{used}"
  else
    output << "#{uuid} memory available:0 used:0"
  end

  # Get CPU usage
  pid = %x{ pgrep -o -f #{instance} 2> /dev/null }.chomp
  if $? == 0
    cpu_command = "ps -p #{pid} -o %cpu h"
    cpu = %x{ #{cpu_command} 2> /dev/null }.gsub!(/\s+/, '')
    output << "#{uuid} cpu cpu_usage:#{cpu.to_i} cpu_time:#{cpu_time}"
  else
    output << "#{uuid} cpu cpu_usage:0 cpu_time:0"
  end

  # Get first interface usage
  iflist_output = %x{ virsh domiflist #{instance} | grep -m 1 tap | cut -d' ' -f1 2> /dev/null }.chomp
  if $? == 0
    ifstat_output = %x{ virsh domifstat #{instance} #{iflist_output} 2> /dev/null }
    if $? == 0
      ifstats = []
      ifstat_output.split("\n").each do |ifstat_line|
        (interface, metric, value) = ifstat_line.split(/\s+/)
        ifstats << "#{metric}:#{value}"
      end
      output << "#{uuid} interface interface:eth0 #{ifstats.join(' ')}"
    end
  end

  # Get storage usage
  blkstats = {}
  {'disk' => 'vda', 'disk.local' => 'vdb'}.each do |disk, blk|
    disk_path = nil
    blkstats[blk] = []
    if File.exists?("/var/lib/nova/instances/#{instance}/#{disk}")
      disk_path = "/var/lib/nova/instances/#{instance}/#{disk}"
    elsif File.exists?("/var/lib/nova/instances/#{uuid}/#{disk}")
      disk_path = "/var/lib/nova/instances/#{uuid}/#{disk}"
    end

    if disk_path

      blkstats[blk] = []
      blkstat_output = %x{ virsh domblkstat #{instance} #{blk} 2> /dev/null }.chomp
      if $? == 0
        blkstat_output.split("\n").each do |blkstat_line|
          (blk, metric, value) = blkstat_line.split(/\s+/)
          blkstats[blk] << "#{metric}:#{value}"
        end

        qemu_output = %x{ qemu-img info #{disk_path} | grep ^disk | cut -d' ' -f3 2> /dev/null }.chomp
        if $? == 0
          if qemu_output =~ /K/
            qemu_output.gsub!('K', '')
            qemu_output = qemu_output.to_i * 1024
          end

          if qemu_output =~ /M/
            qemu_output.gsub!('M', '')
            qemu_output = qemu_output.to_i * 1024 * 1024
          end

          if qemu_output =~ /G/
            qemu_output.gsub!('G', '')
            qemu_output = qemu_output.to_i * 1024 * 1024 * 1024
          end
          blkstats[blk] << "bytes_used:#{qemu_output}"
        end
      end
    end
  end
  blkstats.each do |drive, stats|
    output << "#{uuid} disk disk:#{drive} #{stats.join(' ')}"
  end

  puts output.join("\n")

end
