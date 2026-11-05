Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892605;
	b=G06C0IWgFg74X2v2BPIttGtQQ3InYYTH91usIB9xsEl4/vTeo18BigWcNbJ/PYKddGBJ
	 H4mlvQC9tfYTasGvVib3+is4+oX4RQe6fYH2883k1lIroB0VrtDiq2IYUHWYlXmWyuj5X
	 x6IhZPpul3kLWTRQp11RD6tBUBmcBAMXe1n4F4C4TlSUqHpTdUehwWfZJlzyR/JcLgLgh
	 vtacsQgHk8QfdsKCYBJezD9CVuD1GkfQ4bUcd5di4uMPaQeg6L9sEQCqgOxY6upNcrjuY
	 Bqt+HlgLugGG+dmZBvMSaqN19OCUBd9mvETWpxCAnbcJiMjg9Ei4uPnmurubKph57gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=H7D7yhropaYIP0/pL9q+MsUBGzWnLUACI4oHFA7OPZE=;
	b=5ETzxifJ1w4elfCrZqD/EhMlAMMTwsHo8NpLRQUSxLddnq+WuOU9qXx9uNGD0Anpfzpd
	 hVlU4uYRvmiB6DiDPs8C0ke1rI71ZR1oNYd1HBW++6aUwN7++dc5lLVrGzjRcYR+LAVqO
	 CUmH6jzLO0wxDKP5roblyd4xrbcOcC9kdLGmLbW9TIBJPOFGeUHQ5E+PvANaxh1kfLvXe
	 r8gpHOPqCEsqov/z5h1zvjf933TzfRgrr2scHOm8fLArsct0g8Kinb94/9MmkMj3+fsie
	 biW3WnikdEQJ0V1F9O4oCF4sePqqC3zb+CC9BNtR2JXF9MOCirkEn5glM5OxxUZhUIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=iGXHVwdK;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A88606D835
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4A88606D835
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=iGXHVwdK
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9906c85122cso622727241.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892604; x=1794497404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7D7yhropaYIP0/pL9q+MsUBGzWnLUACI4oHFA7OPZE=;
        b=iGXHVwdK2OyUuEwtigKed6XUtBXEKdT+3EtKeX0rNHKNR++WsFzSY7NMkcfCXeU00V
         K8DwTOnEnGKnNeg/VKgGYBzML07Q0jeoZ0tKU0z2CTsdL3YXVsVCgTax4hbO3fT93K39
         n4BSUKC920c5bMCqSevbL6uK+8BaSjQfUol6/pMo6YJo8DDo/FpuNLdWj9DMyY8T404u
         9llPU3/5AOk9kMD9zPMR4mq5GrsYJE1yxcFxUkj2wNR4mQ0qHgbtE7rCKmDz0SzMUiqP
         QcKecp+nfCPFGAt9jFhqcDQ3hEsy3EASWT9XOrHlcaxbdVKQOuVpobNF8PRyX/+VU6JD
         nx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892604; x=1794497404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7D7yhropaYIP0/pL9q+MsUBGzWnLUACI4oHFA7OPZE=;
        b=BKI8JVwHMLERvoarLksqzJfcd2vKR2I9N1mUl/rIjhrEgyttaJRU96HEmbjVPSz0as
         BGLESxd7Evg0n2jLD+SCVP6GTOVexkNMLKVJ4f9lpPGDH8xodXy/+y+UBv2UELgBYejV
         AyEZxMdBQzslapMz+dv2NuSCfWUOTagntoIuRO3xrtIubpH3wGHgLwvfRGPL72vh7A2V
         onvJUoua2lpFcDl5H+fdJN6eaE8fiLNLkF9Ksv+oLpywve2f2Ck0kUojwhJ1tUqWqv1i
         oBFO9+FwnzKSJZgHotPLRrC4ZOwTNnSmtfcvXLkvT1pNAajAWB730QerWk/+xF2E14wn
         MNCg==
X-Gm-Message-State: APuU4Z/crcjsa2fZS8CK79BhY7BYKUf9K5TM6gjCVOeF/8VkstE3T/m1
	zqok323FntYBXYHKl0rTRGlnBC+9B+uY6WJzai9Vw41EY7e1d1SPc9xaJcy5AAeWAzA=
X-Gm-Gg: AYBFou1jHJVnfMbZ2zoQr6E4ao88QD9JikYj+Jm6nNeR0pj+Ahc1CaQPjG/ER9AmNpw
	ZyOFIsKM88IVACLJpDuBs18clGXioH1bnaH7ufp1OSHN0AZV15/YOtMnyfKpPpXy0K71CS5HqAx
	S/tXNm5JgIqiHZ4bWYTUTeSfD3qDxycnN6NYpT3FjczwP2iYxw9pAk2XTEjPFQTyabZ0HK8suOK
	qZtnIlLnR6DGdpFqwCBIj6wb72lVx0tNJ+1jL0/WKqoJlHL5LU2rqnMgEhNpBIGPp/C6jO5o2pL
	7c5MDmEYjN1Bg5jQc/yym+kyjg/wuKk2WIGc3Rtrk7pSQdOuMCTBwLctv4ITbvGjlP05rQQtwAP
	o8XBarCwUlice7Kkg0cClvNTTb61+kAMkafs5mEQwpHxxUV4+WOSkAILS/Q4AW2AG4sjbOsBxaB
	Ldhm57Xil6NCwtQn8Rj25kvLe4k1P+rzuK5ta0r3meF63eoazRbS15pk6WON+C0wESd/oD6lubO
	47GrxDUpvULmx91ixPr8YwDP3w2GD38RZpKH9yM+PTueTtcblVVil1AXHeg9mUP7xPNpq1nDKNe
	Pa+uDpHM1MNPMZVPkzblrYhfPTJPb1o=
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id ada2fe7eead31-7d072baa484mr7972673137.9.1793892603471;
        Thu, 05 Nov 2026 07:30:03 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d775aesm4495753e0c.4.2026.11.05.07.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:30:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:13 +0000
Subject: [PATCH RFC v3 81/90] net: use net_may() for privileged socket
 options
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-b4-cells-v3-81-bc9095937a84@toxicpanda.com>
References: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
In-Reply-To: <20261105-b4-cells-v3-0-bc9095937a84@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 Andrew Halaney <andrew@amutable.com>, Jeremy Bingham <jbingham@gmail.com>, 
 Tahera Fahimi <taherafahimi@linux.microsoft.com>, 
 Serge Hallyn <sergeh@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=4991;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eW6u9uQ0Wsmh3Os08bQUEqftrsYKdy1N88JIsBJuoEc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QL8/5Krgo+1D1BousniGNKt/9o0yYC27T0CQ8djI/9gfhK/kChE2x/kdhPQZeiWy4jXRQ+tiqJP
 duiCL/Mg9SQY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Some socket options affect how the network namespace treats packets, not
just the socket, and require a capability. Convert their checks.

These accept CAP_NET_ADMIN or CAP_NET_RAW today, and now accept
NET_RIGHT_SOCKOPT or NET_RIGHT_RAW: SO_MARK, both as an option and as a
control message, SO_PRIORITY outside of the unprivileged range,
IP_TRANSPARENT and IPV6_TRANSPARENT.

This one requires CAP_NET_ADMIN, and now NET_RIGHT_SOCKOPT: SO_TXTIME with
a clock other than CLOCK_MONOTONIC.

These require CAP_NET_RAW, and now NET_RIGHT_RAW: SO_BINDTODEVICE on a
socket that is already bound to a device, and the IPv6 hop-by-hop and
destination options.

Not converted: IP_IPSEC_POLICY, IP_XFRM_POLICY and their IPv6
counterparts, and SO_ATTACH_FILTER on a TCP socket.

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/sock.c          | 16 ++++++++--------
 net/ipv4/ip_sockglue.c   |  4 ++--
 net/ipv6/ipv6_sockglue.c |  7 +++----
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 352310066e35..ba870aa6b967 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -462,8 +462,8 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 static bool sk_set_prio_allowed(const struct sock *sk, int val)
 {
 	return ((val >= TC_PRIO_BESTEFFORT && val <= TC_PRIO_INTERACTIVE) ||
-		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) ||
-		sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN));
+		sockopt_net_may(sk, NET_RIGHT_RAW) ||
+		sockopt_net_may(sk, NET_RIGHT_SOCKOPT));
 }
 
 static bool sock_needs_netstamp(const struct sock *sk)
@@ -642,7 +642,7 @@ static int sock_bindtoindex_locked(struct sock *sk, int ifindex)
 
 	/* Sorry... */
 	ret = -EPERM;
-	if (sk->sk_bound_dev_if && !ns_capable(net->user_ns, CAP_NET_RAW))
+	if (sk->sk_bound_dev_if && !net_may(net, NET_RIGHT_RAW))
 		goto out;
 
 	ret = -EINVAL;
@@ -1540,8 +1540,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_MARK:
-		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		if (!sockopt_net_may(sk, NET_RIGHT_RAW) &&
+		    !sockopt_net_may(sk, NET_RIGHT_SOCKOPT)) {
 			ret = -EPERM;
 			break;
 		}
@@ -1649,7 +1649,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		 * scheduler has enough safe guards.
 		 */
 		if (sk_txtime.clockid != CLOCK_MONOTONIC &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
+		    !sockopt_net_may(sk, NET_RIGHT_SOCKOPT)) {
 			ret = -EPERM;
 			break;
 		}
@@ -3172,8 +3172,8 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 
 	switch (cmsg->cmsg_type) {
 	case SO_MARK:
-		if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+		if (!net_may(sock_net(sk), NET_RIGHT_RAW) &&
+		    !net_may(sock_net(sk), NET_RIGHT_SOCKOPT))
 			return -EPERM;
 		if (cmsg->cmsg_len != CMSG_LEN(sizeof(u32)))
 			return -EINVAL;
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index e06c1f48ecad..cc9e0bc952f2 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1008,8 +1008,8 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		inet_assign_bit(MC_ALL, sk, val);
 		return 0;
 	case IP_TRANSPARENT:
-		if (!!val && !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
+		if (!!val && !sockopt_net_may(sk, NET_RIGHT_RAW) &&
+		    !sockopt_net_may(sk, NET_RIGHT_SOCKOPT))
 			return -EPERM;
 		if (optlen < 1)
 			return -EINVAL;
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 4b3536571c98..d2880493d33b 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -304,12 +304,11 @@ static int ipv6_set_opt_hdr(struct sock *sk, int optname, sockptr_t optval,
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 	struct ipv6_opt_hdr *new = NULL;
-	struct net *net = sock_net(sk);
 	struct ipv6_txoptions *opt;
 	int err;
 
 	/* hop-by-hop / destination options are privileged option */
-	if (optname != IPV6_RTHDR && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW))
+	if (optname != IPV6_RTHDR && !sockopt_net_may(sk, NET_RIGHT_RAW))
 		return -EPERM;
 
 	/* remove any sticky options header with a zero option
@@ -405,8 +404,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 		inet_assign_bit(FREEBIND, sk, valbool);
 		return 0;
 	case IPV6_TRANSPARENT:
-		if (valbool && !sockopt_ns_capable(net->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (valbool && !sockopt_net_may(sk, NET_RIGHT_RAW) &&
+		    !sockopt_net_may(sk, NET_RIGHT_SOCKOPT))
 			return -EPERM;
 		if (optlen < sizeof(int))
 			return -EINVAL;

-- 
2.55.0

