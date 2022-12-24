# SSL/TLS 証明書

- [プロフェッショナルSSL/TLS – 技術書出版と販売のラムダノート](https://www.lambdanote.com/products/tls)
- [図解 X.509 証明書](https://qiita.com/TakahikoKawasaki/items/4c35ac38c52978805c69)
- [RSA鍵、証明書のファイルフォーマットについて](https://qiita.com/kunichiko/items/12cbccaadcbf41c72735)
- [OpenSSL CSR Tool - Create Your CSR Faster | DigiCert.com](https://www.digicert.com/easy-csr/openssl.htm)

## CSRと秘密鍵を作成する

```sh
openssl req -new -newkey rsa:2048 -nodes -out foo_example_com.csr -keyout foo_example_com.key -subj "/C=JP/ST=hoge/L=buzz/O=foo/OU=fizz/CN=foo.example.com"
```

## CSRの中身をテキストで表示する

```sh
$ openssl req -text -noout -in ./foo_example_com.csr
Certificate Request:
    Data:
        Version: 0 (0x0)
        Subject: C=JP, ST=hoge, L=buzz, O=foo, OU=fizz, CN=foo.example.com
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:d1:26:db:93:20:65:42:f4:0f:7e:3b:1f:be:95:
                    92:12:d5:65:10:4f:4a:1c:d4:c9:cd:5a:f1:96:e9:
                    // ...
                    ec:99:cb:85:9f:70:ee:33:6a:9b:e3:a4:b9:ff:db:
                    bc:87
                Exponent: 65537 (0x10001)
        Attributes:
            a0:00
    Signature Algorithm: sha256WithRSAEncryption
         77:e2:34:6c:01:41:84:19:44:57:8a:6e:06:11:c9:ce:20:75:
         f0:5a:17:58:64:78:30:e7:4c:83:9b:4e:6d:aa:63:e3:c2:ca:
         // ...
         d6:72:72:50:ef:c0:e9:cb:2f:bb:43:3c:38:d3:9a:18:d4:69:
         13:c1:72:29
```

## 秘密鍵の中身をテキストで表示する

```sh
$ openssl rsa -text -noout -in ./foo_example_com.key
RSA Private-Key: (2048 bit)
modulus:
    00:d1:26:db:93:20:65:42:f4:0f:7e:3b:1f:be:95:
    92:12:d5:65:10:4f:4a:1c:d4:c9:cd:5a:f1:96:e9:
    // ...
    da:44:e9:d8:46:e9:68:a6:4a:b2:29:04:e1:03:a5:
    ec:99:cb:85:9f:70:ee:33:6a:9b:e3:a4:b9:ff:db:
    bc:87
publicExponent: 65537 (0x10001)
privateExponent:
    00:87:83:b4:db:64:2f:18:2d:88:68:52:a8:a3:d4:
    c7:9b:9a:56:6c:35:e3:a0:40:a3:2c:82:53:6c:63:
    // ...
    2b:00:a1:be:bf:4c:61:02:d3:a7:7d:80:aa:42:58:
    68:19
prime1:
    00:ee:60:fb:a1:7c:df:b4:03:a4:f6:a3:44:1d:b6:
    fc:91:3e:78:79:70:07:a8:06:1f:a1:0f:0d:3a:77:
    // ...
    a7:4c:49:7d:40:fb:af:d4:54:85:d7:4e:01:ff:bb:
    49:6d:a2:e6:51:ea:27:66:c5
prime2:
    00:e0:9c:ca:37:cd:7a:b9:f9:b3:04:c3:fa:47:72:
    8f:24:d6:86:52:46:30:8d:7e:e0:08:21:94:40:19:
    // ...
    03:6c:ee:9c:a5:5a:4b:ba:f8:6e:50:07:1a:90:1c:
    92:94:80:02:43:0c:c8:aa:db
exponent1:
    50:87:ba:fa:67:31:3b:a3:2f:8b:92:c4:64:35:79:
    45:a8:11:13:15:61:c0:c5:b0:d1:bc:3f:ff:cc:53:
    // ...
    11:a2:f4:bc:f1:b7:7f:d1:a0:66:1a:9a:77:c6:34:
    92:75:11:37:6e:cf:8b:af:b2:37:76:46:fe:99:ca:
    c8:9b:0b:ac:08:aa:9e:f1
exponent2:
    5d:1d:82:d3:a9:72:a4:60:b8:ef:53:d3:91:05:14:
    04:a0:8e:a4:d3:06:53:d2:72:4b:cc:a7:e9:fe:c9:
    // ...
    af:65:28:39:80:7a:7e:b3:78:ff:e2:42:07:d6:60:
    8a:01:9b:6e:72:81:4a:1b
coefficient:
    00:ec:d0:cc:38:e5:cb:ae:4a:74:b1:a0:a6:81:2e:
    24:02:a7:cb:95:2b:c0:00:6d:12:94:60:48:ea:3a:
    // ...
    f7:e8:1d:76:c8:b0:fe:9f:a3:ff:70:78:2a:ae:70:
    19:3e:45:75:e6:8d:a1:f4:40
```

## ネットワーク経由で証明書を取得する

```sh
$ echo | openssl s_client -connect example.com:443 |  openssl x509 -text -noout -inform pem -in /dev/stdin
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root CA
verify return:1
depth=1 C = US, O = DigiCert Inc, CN = DigiCert TLS RSA SHA256 2020 CA1
verify return:1
depth=0 C = US, ST = California, L = Los Angeles, O = Internet\C2\A0Corporation\C2\A0for\C2\A0Assigned\C2\A0Names\C2\A0and\C2\A0Numbers, CN = www.example.org
verify return:1
DONE
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            0f:aa:63:10:93:07:bc:3d:41:48:92:64:0c:cd:4d:9a
    Signature Algorithm: sha256WithRSAEncryption
        Issuer: C=US, O=DigiCert Inc, CN=DigiCert TLS RSA SHA256 2020 CA1
        Validity
            Not Before: Mar 14 00:00:00 2022 GMT
            Not After : Mar 14 23:59:59 2023 GMT
        Subject: C=US, ST=California, L=Los Angeles, O=Internet\xC2\xA0Corporation\xC2\xA0for\xC2\xA0Assigned\xC2\xA0Names\xC2\xA0and\xC2\xA0Numbers, CN=www.example.org
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                RSA Public-Key: (2048 bit)
                Modulus:
                    00:95:5d:96:63:9a:e5:1a:7d:5f:a7:0b:ee:06:18:
                    f4:9d:50:5c:37:10:b1:90:75:06:fe:92:46:e0:7b:
                    // ...
                    55:b6:76:40:ca:ae:85:a5:9f:30:14:ae:a3:e0:e3:
                    30:33
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Authority Key Identifier:
                keyid:B7:6B:A2:EA:A8:AA:84:8C:79:EA:B4:DA:0F:98:B2:C5:95:76:B9:F4

            X509v3 Subject Key Identifier:
                F7:2A:09:D0:24:5B:11:71:EE:BA:BE:F4:3E:1C:3D:56:12:88:16:BB
            X509v3 Subject Alternative Name:
                DNS:www.example.org, DNS:example.net, DNS:example.edu, DNS:example.com, DNS:example.org, DNS:www.example.com, DNS:www.example.edu, DNS:www.example.net
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage:
                TLS Web Server Authentication, TLS Web Client Authentication
            X509v3 CRL Distribution Points:

                Full Name:
                  URI:http://crl3.digicert.com/DigiCertTLSRSASHA2562020CA1-4.crl

                Full Name:
                  URI:http://crl4.digicert.com/DigiCertTLSRSASHA2562020CA1-4.crl

            X509v3 Certificate Policies:
                Policy: 2.23.140.1.2.2
                  CPS: http://www.digicert.com/CPS

            Authority Information Access:
                OCSP - URI:http://ocsp.digicert.com
                CA Issuers - URI:http://cacerts.digicert.com/DigiCertTLSRSASHA2562020CA1-1.crt

            X509v3 Basic Constraints:
                CA:FALSE
            1.3.6.1.4.1.11129.2.4.2:
                ...h.f.u..>..>..52.W(..k......k..i.w}m..n.......u.....F0D. 1x.S.F..2S=Z..l...B4.*........... Gt0...!`.~..%..2j.....a<.6..E.s..u.5.....lW...LmB...' &Q.?.*....;.L.......|.....F0D. ;)O.$P.D..>".Mc....1..<......$.\. ..5.........6...\.....O..:.....X.v..sw...P.c.......Jy-.g.......y6...............G0E. ).....o...........e.U_.<.@m.[ZN..!..v..D..........rv.RB.Xd.).......
    Signature Algorithm: sha256WithRSAEncryption
         aa:9f:be:5d:91:1b:ad:e4:4e:4e:cc:8f:07:64:44:35:b4:ad:
         3b:13:3f:c1:29:d8:b4:ab:f3:42:51:49:46:3b:d6:cf:1e:41:
         // ...
         23:a7:63:f3:b5:43:fa:56:8c:50:17:7b:1c:1b:4e:10:6b:22:
         0e:84:52:94
```
