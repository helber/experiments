#!/bin/bash
echo -n "Saving debug log to /var/log/letsencrypt/letsencrypt.log
Plugins selected: Authenticator manual, Installer None
Obtaining a new certificate
Performing the following challenges:
dns-01 challenge for example.com.br
dns-01 challenge for console.example.com.br
dns-01 challenge for metrics.example.com.br
dns-01 challenge for logs.example.com.br
dns-01 challenge for node.example.com.br

-------------------------------------------------------------------------------
NOTE: The IP of this machine will be publicly logged as having requested this
certificate. If you're running certbot in manual mode on a machine that is not
your server, please ensure you're okay with that.

Are you OK with your IP being logged?
-------------------------------------------------------------------------------
(Y)es/(N)o: "
read -r input

echo -n "
-------------------------------------------------------------------------------
Please deploy a DNS TXT record under the name
_acme-challenge.example.com.br with the following value:

OP3xHdUaRtLB6ou3UQ878UfuZ0zo_i0wAW7sWdSNqSw

Before continuing, verify the record is deployed.
-------------------------------------------------------------------------------
Press Enter to Continue"
read -r input

echo -n "
-------------------------------------------------------------------------------
Please deploy a DNS TXT record under the name
_acme-challenge.console.example.com.br with the following value:

k-wVRRiv5aBt7RhSFsmq2N6Qa-qU5Ykj5LoIsrk2rM4

Before continuing, verify the record is deployed.
-------------------------------------------------------------------------------
Press Enter to Continue"
read -r input

echo -n "
-------------------------------------------------------------------------------
Please deploy a DNS TXT record under the name
_acme-challenge.metrics.example.com.br with the following value:

IHsh4SiyYrsQF0mh__Lg2hGA0rlot02VguROLn07plM

Before continuing, verify the record is deployed.
-------------------------------------------------------------------------------
Press Enter to Continue"
read -r input

echo -n "
-------------------------------------------------------------------------------
Please deploy a DNS TXT record under the name
_acme-challenge.logs.example.com.br with the following value:

Z-Vn6VfLAHIlZBqmP92SOjY6afB1Lu5yM5110qwEeAE

Before continuing, verify the record is deployed.
-------------------------------------------------------------------------------
Press Enter to Continue"
read -r input

echo -n "
-------------------------------------------------------------------------------
Please deploy a DNS TXT record under the name
_acme-challenge.node.example.com.br with the following value:

VurKbQclijCZwGJl9sXDlrx4LABr2gU2BL_OiPmaUzw

Before continuing, verify the record is deployed.
-------------------------------------------------------------------------------
Press Enter to Continue"
read -r input

echo -n "Waiting for verification...
Cleaning up challenges

IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at:
   /etc/letsencrypt/live/example.com.br/fullchain.pem
   Your key file has been saved at:
   /etc/letsencrypt/live/example.com.br/privkey.pem
   Your cert will expire on 2018-03-11. To obtain a new or tweaked
   version of this certificate in the future, simply run certbot
   again. To non-interactively renew *all* of your certificates, run
   \"certbot renew\"
 - If you like Certbot, please consider supporting our work by:

   Donating to ISRG / Let's Encrypt:   https://letsencrypt.org/donate
   Donating to EFF:                    https://eff.org/donate-le
"