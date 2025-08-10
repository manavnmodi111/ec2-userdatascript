#!/bin/bash
# Update system
apt update -y && apt upgrade -y

# Install Apache
apt install -y apache2 curl

# Start & enable Apache
systemctl start apache2
systemctl enable apache2

# Create a modern HTML page with live IP fetching
cat <<'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hello EC2 Instance</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #2b5876, #4e4376);
            color: white;
            text-align: center;
            padding-top: 15%;
        }
        h1 {
            font-size: 3em;
            margin-bottom: 0.2em;
        }
        p {
            font-size: 1.5em;
            color: #ffd700;
        }
        .card {
            background: rgba(255, 255, 255, 0.1);
            padding: 2em;
            border-radius: 15px;
            display: inline-block;
            box-shadow: 0 4px 30px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>🚀 Hello EC2 Instance</h1>
        <p>Your Public IP: <strong id="ip">Loading...</strong></p>
    </div>

    <script>
        fetch('https://checkip.amazonaws.com')
            .then(response => response.text())
            .then(ip => document.getElementById('ip').innerText = ip.trim())
            .catch(() => document.getElementById('ip').innerText = "Unavailable");
    </script>
</body>
</html>
EOF

# Restart Apache
systemctl restart apache2
