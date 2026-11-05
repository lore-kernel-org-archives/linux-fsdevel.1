Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892519;
	b=URzR2Wos3JU7Sg9GKuiRmfmkxIBd4H1hBZdLvIY84yVr6hP0JFIM65iVo9noXsXSuevZ
	 PQRpSsirgC66jbpTHhrEX4dRkNZY4MMVlE5vlMJVsQWSTiYPatJMaE6c2bA/zgWJ/enGY
	 T5jIaeYXAe6fUA2BSHPKxPVDUSoIq4U6uK+9Fw3ypZ/0qOyZ7k9QjZepGkWrtGcvUw5XX
	 s4GblOpiXISunoD4fzkAjJf1GG0/f8ty/ZUuQ52lM7b1xIILWtLh25RdruggUssCzHfhT
	 zeCmX1UTBWX+5pmEjU/T13ceTbaIyi36m/QjLBTEFrCQguoua054RbNjxUnR46KvfeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=KLPcNV9aUbDLiPnscawDJ9DlhHyhT9MXerP8+aTsTTg=;
	b=CEQOKsXtzKjMpkKDAxU3gAyUys+9IaIYRpCoSNCOOP/gQ8yblEy3WMPCASjvYpn/GiSl
	 NAVDOAeMgooTbpRaSMAK2rVjOR4gIi8IUB5f7BgQEU8yv7HgoLm6v2+RmnwZTihbWjqF4
	 bCDvi+hN6u/grxqa0oNBlhTLdD4AWAf9qvD74JhAtoQsrr6O16s+CAu152rSLm4lpQqqG
	 4TEWe3Z1nKituOSOmHWjLN3hM0S6ZC4sGET9QJ6g6LES1XOJbRhNr3kkC103V2JqT7DCr
	 G59bgCrWT4woYVcecjKbLPUOp70wLkuJiZRpg/BEOtIjubfmCLjoWckgqbwHINmWjHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nDvoAKD7;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731A606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 15:28:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E731A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nDvoAKD7
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533861a59b8so20213341cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793892518; x=1794497318; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KLPcNV9aUbDLiPnscawDJ9DlhHyhT9MXerP8+aTsTTg=;
        b=nDvoAKD74JrwtH/SpvIvR9HqdawNMNOudq2c1aLjeVyQHb8kYx/T5JZEbF1CoSCdG/
         phXlTdkY9vJ63j6mmfIUMXlLMA4fdMj3u6ECqUP+gF4Q7ByuKobzxu4TSvbZgQ+/B41r
         tqPZYtKXcx0/LOt2JTRdVx9Qf+O9DQngL7PY0n0NHyOhb+4VXHWhua8rRFwKU2xewmxZ
         ll2Vfw+VYzZJQkY4jrtdUWtkYLgKpQtQzzSCUAW/BjS35Q5enP4TrLJ2P3uSVP2p9kaI
         uIk8NNxPHzeQ93xmb4QYJCC60EcTEpJ02CRhh6jktWnBr5Ydo0A0f0oGYSVbebbDxpU0
         vSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793892518; x=1794497318;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KLPcNV9aUbDLiPnscawDJ9DlhHyhT9MXerP8+aTsTTg=;
        b=0FagvzKkup+LTZT+DWN/MLQrI75ptmeYo3TIRYlVKpmlwtxkDD3M7DC1oPoVqcPXN+
         o/dh362tXo4TCgxpflPpmzxVr/ExgVhttjmC7VzCcfveMaWkJvmWUnx4HlmEpOOe0QPq
         sq7UU7qunUIszi/uJQ7sgSWxaF32CCQsGjS6dCTsTieK7LXl4yZ6E51OSx94RmtjYi90
         5u4cAeEOjKDfJIsn4b1LvkqTGJffGpZzDUQKm7dplExV51x7ZUCKxQWMAVNKnoxMAFpI
         7X40mJ3sHaK6qfpgRs4XYgLduiK7ieLHE7SwP8o1EwtnDOFqO9AMMehF/+Vf/r3bfwta
         +ffQ==
X-Gm-Message-State: APuU4Z8cwTrvue/Br4Sion/ayIY3wlrIA1ASz/Ae/hj1Q2InU6UjCGY5
	pZakY7NJ/Q7caFr+YA/40bHwViaPZgAM3iALrp8IwGPnqwkA+1tnoaWhNWTmhOuWe7U=
X-Gm-Gg: AYBFou37l/XRGAk4G1XdBdOJLwh+w0dN4qfUDXdBZIxcYnU1qAW3HEYMv2GVPxwYo9n
	mYsf+SjaFk+FqASBLNCju9g+3ImLR4lhmrVlCzgrtNG531/9jgn1ZEozH1BcRliH7u1Lj6Smm+O
	B/TrR3of9MlM2bZqAx3+gmDWjrxEVq7/lAhpMQvKaPEC6pWWZkfhz54+nD/b0XUjE64N6vvzre2
	altpkkiE2H1tux/njnUu+OvElc2wxtv5sKVQBWKaRPWUy4ed0PMwsuTRb9B54vF5HUZiB8wmsxZ
	yX+THhFCDRul6UAR1eWiVaQxNs7PQmLWXxI+V6QfzD76WGziTH4WxdKLQMKgYYi/nBY05IGXYMJ
	pna5lVC/PTU33Gl8ZqYgofPE4i0K5WH1Uo+I6+xiYcyxq22zRfE4YwrJpPkdQfuj5QJHbarNwd4
	fRyq2Ruf3KkViBQw0PAyLP8DTcmVIdvXCfoupWfvfVR+VOOuAVYba7yjMdAqAYtfGffkzCG8Ojp
	mIx37W8zXVkmbCrUmVlHqyytlLLUkiOjGXg5Zu6Wj/7fHtsFZtvaJgXJoGtJW6M7E0obnPKMAth
	UE3e/wrDfC1thmOUm4RgNo7LseD7zWGq8x0F/asHu0a/6Q==
X-Received: by 2002:a05:622a:4209:b0:536:6488:e7e4 with SMTP id d75a77b69052e-542b6a72b3cmr336045591cf.13.1793892517845;
        Thu, 05 Nov 2026 07:28:37 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54d970216f6sm6703391cf.25.2026.11.05.07.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 07:28:37 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 05 Nov 2026 15:03:09 +0000
Subject: [PATCH RFC v3 77/90] net: use net_may() in the configuration
 ioctls
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
Message-Id: <20261105-b4-cells-v3-77-bc9095937a84@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793890936; l=4548;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=aroO3MBSFDs6m6+Du222Gk5S4GUIEG4XnIpJZgS36no=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJO6v6Qow2FGiwDal0iPWoEjeBVIuqkZgWf6GgjIBBErGi0Ifpq9yV4cmB+MsCBn1G+9E/WNMVW
 SnRZ1e7wHMgA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The ioctls that predate rtnetlink have their own CAP_NET_ADMIN checks.
Convert them:

  NET_RIGHT_LINK   the device ioctls in dev_ioctl(), and SIOCSIFFLAGS in
                   devinet_ioctl()
  NET_RIGHT_ADDR   the address ioctls in devinet_ioctl(), and
                   addrconf_add_ifaddr() and addrconf_del_ifaddr()
  NET_RIGHT_ROUTE  SIOCADDRT and SIOCDELRT for IPv4 and IPv6, and SIOCSARP
                   and SIOCDARP

No functional change.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/dev_ioctl.c    | 4 ++--
 net/ipv4/arp.c          | 2 +-
 net/ipv4/devinet.c      | 4 ++--
 net/ipv4/fib_frontend.c | 2 +-
 net/ipv6/addrconf.c     | 4 ++--
 net/ipv6/route.c        | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index f6029f60c1dc..caec8909b0c2 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -757,7 +757,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	case SIOCGMIIREG:
 	case SIOCSIFNAME:
 		dev_load(net, ifr->ifr_name);
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!net_may(net, NET_RIGHT_LINK))
 			return -EPERM;
 
 		rtnl_net_lock(net);
@@ -799,7 +799,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:
 	case SIOCSHWTSTAMP:
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!net_may(net, NET_RIGHT_LINK))
 			return -EPERM;
 		fallthrough;
 	case SIOCBONDSLAVEINFOQUERY:
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 1ca4ced280ae..934eead1dc51 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1285,7 +1285,7 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 	switch (cmd) {
 	case SIOCDARP:
 	case SIOCSARP:
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!net_may(net, NET_RIGHT_ROUTE))
 			return -EPERM;
 		fallthrough;
 	case SIOCGARP:
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 1e9d988849c9..ec57948ffbb3 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1088,7 +1088,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 
 	case SIOCSIFFLAGS:
 		ret = -EPERM;
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!net_may(net, NET_RIGHT_LINK))
 			goto out;
 		break;
 	case SIOCSIFADDR:	/* Set interface address (and family) */
@@ -1096,7 +1096,7 @@ int devinet_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr)
 	case SIOCSIFDSTADDR:	/* Set the destination address */
 	case SIOCSIFNETMASK: 	/* Set the netmask for the interface */
 		ret = -EPERM;
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!net_may(net, NET_RIGHT_ADDR))
 			goto out;
 		ret = -EINVAL;
 		if (sin->sin_family != AF_INET)
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8c123b111b3d..67d1eb7f8b7a 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -651,7 +651,7 @@ int ip_rt_ioctl(struct net *net, unsigned int cmd, struct rtentry *rt)
 	switch (cmd) {
 	case SIOCADDRT:		/* Add a route */
 	case SIOCDELRT:		/* Delete a route */
-		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+		if (!net_may(net, NET_RIGHT_ROUTE))
 			return -EPERM;
 
 		rtnl_net_lock(net);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c8c0dd04982d..3699e5410992 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3185,7 +3185,7 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 	struct in6_ifreq ireq;
 	int err;
 
-	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+	if (!net_may(net, NET_RIGHT_ADDR))
 		return -EPERM;
 
 	if (copy_from_user(&ireq, arg, sizeof(struct in6_ifreq)))
@@ -3212,7 +3212,7 @@ int addrconf_del_ifaddr(struct net *net, void __user *arg)
 	struct in6_ifreq ireq;
 	int err;
 
-	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+	if (!net_may(net, NET_RIGHT_ADDR))
 		return -EPERM;
 
 	if (copy_from_user(&ireq, arg, sizeof(struct in6_ifreq)))
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 616b86f89f63..f458a3cae13a 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -4578,7 +4578,7 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 
 	if (cmd != SIOCADDRT && cmd != SIOCDELRT)
 		return -EINVAL;
-	if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
+	if (!net_may(net, NET_RIGHT_ROUTE))
 		return -EPERM;
 
 	rtmsg_to_fib6_config(net, rtmsg, &cfg);

-- 
2.55.0

