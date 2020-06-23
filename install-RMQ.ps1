


# Deploy RabbitMQ 3.8.5 and Erlang/OTP 23.0

$otpbin = "http://erlang.org/download/otp_win64_23.0.exe"
Invoke-WebRequest -Uri $otpbin -OutFile ".\otp_win64_23.0.exe"

$rmqbin = "https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-3.8.5.exe"
Invoke-WebRequest -Uri $rmqbin -OutFile ".\rabbitmq-server-3.8.5.exe"

.\otp_win64_23.0.exe
.\rabbitmq-server-3.8.5.exe
