# This script deploy RabbitMQ with Chocolatey package tool
# Author: Kenneth Ma (Kenneth.Ma@dell.com)
# Last Update: 2020-06-21 

# Deploy Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; 
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; 
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Deploy RabbitMQ
choco install rabbitmq

cd "C:\Program Files\RabbitMQ Server\rabbitmq_server-3.8.4\sbin\"
.\rabbitmq-plugins.bat enable rabbitmq_management

# Default login "guest/guest" only allows access from localhost, 
# create a new user for remote access
.\rabbitmqctl.bat add_user rmqadmin '<NewPassword>'                                         # <------ Update here
.\rabbitmqctl.bat set_user_tags rmqadmin administrator


# Remove any previous created RabbitMQ Firewall Rules 
#Get-NetFirewallRule -Name Rabbit* | Remove-NetFirewallRule

# Open Firewall Port for remote management
New-NetFirewallRule -Name RabbitMQ_AMQP -DisplayName "RabbitMQ AMQP 0-9-1" `
  -Profile    Domain `
  -Direction  Inbound `
  -Action     Allow `
  -Protocol   TCP `
  -LocalPort  5672,5671 `
  -RemoteAddress LocalSubnet

New-NetFirewallRule -Name RabbitMQ_Management -DisplayName "RabbitMQ Web Management" `
  -Profile    Domain `
  -Direction  Inbound `
  -Action     Allow `
  -Protocol   TCP `
  -LocalPort  15672 `
  -RemoteAddress LocalSubnet

# Open Firewall port for clustering: epmd -> TCP4369
New-NetFirewallRule -Name RabbitMQ_EPMD -DisplayName "RabbitMQ epmd" `
  -Profile    Domain `
  -Direction  Inbound `
  -Action     Allow `
  -Protocol   TCP `
  -LocalPort  4369 `
  -RemoteAddress LocalSubnet

New-NetFirewallRule -Name RabbitMQ_CLI -DisplayName "RabbitMQ inter-node and CLI" `
  -Profile    Domain `
  -Direction  Inbound `
  -Action     Allow `
  -Protocol   TCP `
  -LocalPort  25672,35672-35682 `
  -RemoteAddress LocalSubnet

New-NetFirewallRule -Name RabbitMQ_PROMETHEUS -DisplayName "RabbitMQ Prometheus Plugin" `
  -Profile    Domain `
  -Direction  Inbound `
  -Action     Allow `
  -Protocol   TCP `
  -LocalPort  15692 `
  -RemoteAddress LocalSubnet

Get-NetFirewallRule -Name Rabbit* | ft

# Set System Environment Variables

# The following only set variable in current session
#$env:ERLANG_SERVICE_MANAGER_PATH = 'C:\Program Files\erl10.7\erts-10.7\bin'
#$env:Path += ";SomeRandomPath"

$erPath = 'c:\Program Files\erl-23.0\erts-11.0\bin'
[System.Environment]::SetEnvironmentVariable('ERLANG_HOME',$erPath,[System.EnvironmentVariableTarget]::Machine)

# Copy .erlang.cookie file from master node to other member node located:
# C:\WINDOWS\system32\config\systemprofile                                      # <----------- Need manaul work here


rabbitmq-service stop rabbitmqctl stop_app

rabbitmqctl start_app rabbitmq-service start

rabbitmqctl stop_app

rabbitmqctl join_cluster rabbit@RMQ1          # node name is Case Sensiteive



# Test Programs with Python Pika
#choco install python
#python -m pip install pika --upgrade