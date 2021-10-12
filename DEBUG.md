from https://community.graylog.org/t/syslog-from-ubiquiti-edgerouter/12546/2

1. Linux should work out of box, if you configure as described in manual:
   [https://docs.graylog.org/en/3.1/pages/sending_data.html#sending-syslog-from-linux-hosts **27**](https://docs.graylog.org/en/3.1/pages/sending_data.html#sending-syslog-from-linux-hosts)
2. Cisco don’t follow syslog standard. Use some content pack or create own extraction rules.
   [https://marketplace.graylog.org/addons?search=catalyst](https://marketplace.graylog.org/addons?search=catalyst)
   Also read this great blogpost:
   [https://jalogisch.de/2018/working-with-cisco-asa-nexus-on-graylog/ **3**](https://jalogisch.de/2018/working-with-cisco-asa-nexus-on-graylog/)
3. Your syslog message from ubiquity is definitelly not RFC5424, but older RFC3164 (BSD).
   [https://help.ubnt.com/hc/en-us/articles/204975904-EdgeRouter-Remote-Syslog-Server-for-System-Logs **97**](https://help.ubnt.com/hc/en-us/articles/204975904-EdgeRouter-Remote-Syslog-Server-for-System-Logs)
   RFC524 syslog message would be:
   `<22>1 2019-10-30T13:18:27.876855+01:00 server postfix 11925 - - connect from abc`
4. Graylog can’t listen on port 514 (lower than 1024) by default, because it isn’t running as root, but normal user. Please don’t try to run graylog service as root, it is not secure at all. So, either use redirect to port 514 using iptables, or setup graylog input on port higher than 1024 and setup your ubiquity firewall to send syslog to this configured port.
   [https://docs.graylog.org/en/3.1/pages/faq.html#how-can-i-start-an-input-on-a-port-below-1024 **17**](https://docs.graylog.org/en/3.1/pages/faq.html#how-can-i-start-an-input-on-a-port-below-1024)
5. If you want to send syslog on different port (than 514) in EdgeRouter configuration, use IP:port
   [https://help.ubnt.com/hc/en-us/articles/204975904-EdgeRouter-Remote-Syslog-Server-for-System-Logs **97**](https://help.ubnt.com/hc/en-us/articles/204975904-EdgeRouter-Remote-Syslog-Server-for-System-Logs)[https://community.ui.com/questions/Sending-firewall-logs-to-remote-syslog-on-non-standard-port/dfec1181-57af-4b0b-bb9b-637389e957e9#answer/198ef4bc-9c50-4d16-b691-0d07fac6177b **36**](https://community.ui.com/questions/Sending-firewall-logs-to-remote-syslog-on-non-standard-port/dfec1181-57af-4b0b-bb9b-637389e957e9#answer/198ef4bc-9c50-4d16-b691-0d07fac6177b)
6. Check your timezone… Usually device send message in another timezone, so graylog record message, but can’t find it. Try to change Search interval for longer time (8 hours or so), or change from Relative to asbolute and setup whole day (for example from today to tomorrow). Check also your timezone settings in /etc/graylog/server/server.conf, parameter root_timezone to your real timezone.
   [https://docs.graylog.org/en/3.1/pages/configuration/server.conf.html **3**](https://docs.graylog.org/en/3.1/pages/configuration/server.conf.html)
7. Use some extractor from marketplace, if you wan to parse messages:
   [https://marketplace.graylog.org/addons?search=edgerouter **48**](https://marketplace.graylog.org/addons?search=edgerouter)
