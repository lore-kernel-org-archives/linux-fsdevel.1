Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205521;
	b=ea/27BR2K4vSf6ACo3xMM7ozn1F9d6cS6Ql9Ujh/X4z4MmP0RXEAhXFvEseQcZ54+5Xk
	 3jGg8TxfwJ5DucVImKuTjTMkbEMWf+KuprMf2JUtm5Mgj0btbMHB6JHEme8EZznIiNvCr
	 pN4X9pfI87avY6yM24ZXqdyxQSvhNglLHvK8EN+6S0/69WUOahrIgrV2D/z/ad1uF73aT
	 FFPMIkfYK6Oi54TSw3Up30bLLst3fB366SdgmWgLG203lyk3aJwzq88HimOoNG5FAOlAC
	 0yYsVffmh3xQpS1TG0BgjsO8jo3GE39x/pv23jmx8ZZiLvvRX4VRBTXyuQf66Iab/AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205521;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ctDgxBKeQRmnsWXtDCltFBNRZ+gc4xHP6A2xofWD2B8=;
	b=033uAY4BofvsPWtr8vJmtyPv+GqBWtJ8V+xTdGZ7PTio+VhCD1ZIFLs6Bb1x2ILRq9/k
	 V42sMxaqVCp1yQ25uzHIvO4Tu0ABUCtRFeBZhb4W1dwjz3arnld1uxx5vmZg9wyt5+CLY
	 t61RsdPskb5n5Ms5GM8g9jCWgHhwWZrJC17Q7QCZy5FJsuQLOAPAeuJLf7CWKgXSs61p+
	 slcz/HX7fwN5jdO4cFl8maG6L8BR7DQ96qO9QaC93oGDnV5b1qAlrWytln9FcTWLuW8wk
	 FwEJWrI3ryTnwmHwCY9/NXAQ8isa1NVk1hBY3DbvGC4HkSSbpUAR4p9MhUYw/FHxoKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qzr8XdJN;
	arc=none smtp.remote-ip=95.215.58.118
Received: from mta1.migadu.com (out-118.mta1.migadu.com [95.215.58.118])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E260A2602
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C1E260A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qzr8XdJN
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nk1M5DbW77BkqF8r8/I4lCn/AObB443DJD7bbZz9C7U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205518; v=1; x=1793810318;
 b=qzr8XdJNRjylG8/WHx1HWnQYy4WsDxmDioYKbE3mrNmp/pAqvhCioQRvg84L1nJhBb1r+x5N
 xX+yEKbq7VFzpOsxE0eZ9hWLDuWJk329CwalU+wEJ38xNXBTM4GtVKjeiHA9yQVjx+Q5/T0xLMt
 U7y/+9K7PU/ikXdgwRHyTKPs=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 2fc8e0f74cc3aa68;
	Wed, 28 Oct 2026 16:38:38 +0000
X-Mizu-Trace-ID: 2fc8e0f74cc3aa68
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 33/39] ipv6: move address sysctl context to priv
Date: Thu, 29 Oct 2026 00:35:12 +0800
Message-Id: <5b5d841386d36162784ee9095786627853346e81.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

addrconf's handlers need the inet6_dev and the netns to find the devconf
field and to notify after a change. The table carries them in extra1 and
extra2, next to the numeric bounds in the same two fields, so every
handler has to know which meaning applies.

Carry the pair in priv instead, leave extra1/extra2 to the bounds, and
let the handlers use data as the devconf field directly. Registration
only fills priv, so it can no longer overwrite a value pointer or a
range.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/ipv6/addrconf.c | 163 +++++++++++++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 64 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c8c0dd04982d..27eaa95f1f21 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -806,6 +806,12 @@ static int inet6_netconf_dump_devconf(struct sk_buff *skb,
 }
 
 #ifdef CONFIG_SYSCTL
+/* Owned by the sysctl allocation; idev (if any) and net outlive it. */
+struct addrconf_sysctl_ctx {
+	struct inet6_dev *idev;
+	struct net *net;
+};
+
 static void dev_forward_change(struct inet6_dev *idev)
 {
 	struct net_device *dev;
@@ -873,9 +879,10 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 	}
 }
 
-static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int newf)
+static int addrconf_fixup_forwarding(const struct addrconf_sysctl_ctx *ctx,
+				     int *p, int newf)
 {
-	struct net *net = (struct net *)table->extra2;
+	struct net *net = ctx->net;
 	int old;
 
 	if (!rtnl_net_trylock(net))
@@ -911,7 +918,7 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
 	} else if ((!newf) ^ (!old))
-		dev_forward_change((struct inet6_dev *)table->extra1);
+		dev_forward_change(ctx->idev);
 	rtnl_net_unlock(net);
 
 	if (newf)
@@ -940,9 +947,10 @@ static void addrconf_linkdown_change(struct net *net, __s32 newf)
 	}
 }
 
-static int addrconf_fixup_linkdown(const struct ctl_table *table, int *p, int newf)
+static int addrconf_fixup_linkdown(const struct addrconf_sysctl_ctx *ctx,
+				   int *p, int newf)
 {
-	struct net *net = (struct net *)table->extra2;
+	struct net *net = ctx->net;
 	int old;
 
 	if (!rtnl_net_trylock(net))
@@ -969,7 +977,7 @@ static int addrconf_fixup_linkdown(const struct ctl_table *table, int *p, int ne
 						     net->ipv6.devconf_all);
 	} else {
 		if (!newf ^ !old) {
-			struct inet6_dev *idev = table->extra1;
+			struct inet6_dev *idev = ctx->idev;
 
 			inet6_netconf_notify_devconf(net,
 						     RTM_NEWNETCONF,
@@ -6389,6 +6397,7 @@ static void ipv6_ifa_notify(int event, struct inet6_ifaddr *ifp)
 static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
 	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
@@ -6406,20 +6415,20 @@ static int addrconf_sysctl_forward(const struct ctl_table *ctl, int write,
 		return ret;
 
 	if (write)
-		ret = addrconf_fixup_forwarding(ctl, valp, val);
+		ret = addrconf_fixup_forwarding(ctx, valp, val);
 	return ret;
 }
 
 static int addrconf_sysctl_mtu(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct inet6_dev *idev = ctl->extra1;
-	int min_mtu = IPV6_MIN_MTU;
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
+	struct inet6_dev *idev = ctx->idev;
 	struct ctl_table lctl;
 
 	lctl = *ctl;
-	lctl.extra1 = &min_mtu;
-	lctl.extra2 = idev ? &idev->dev->mtu : NULL;
+	lctl.min = IPV6_MIN_MTU;
+	lctl.max = idev ? READ_ONCE(idev->dev->mtu) : INT_MAX;
 
 	return proc_dointvec_minmax(&lctl, write, buffer, lenp, ppos);
 }
@@ -6455,9 +6464,10 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 	}
 }
 
-static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf)
+static int addrconf_disable_ipv6(const struct addrconf_sysctl_ctx *ctx,
+				 int *p, int newf)
 {
-	struct net *net = (struct net *)table->extra2;
+	struct net *net = ctx->net;
 	int old;
 
 	if (p == &net->ipv6.devconf_dflt->disable_ipv6) {
@@ -6475,7 +6485,7 @@ static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf
 		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
 	} else if ((!newf) ^ (!old)) {
-		dev_disable_change((struct inet6_dev *)table->extra1);
+		dev_disable_change(ctx->idev);
 	}
 
 	rtnl_net_unlock(net);
@@ -6485,6 +6495,7 @@ static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf
 static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
 	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
@@ -6502,14 +6513,15 @@ static int addrconf_sysctl_disable(const struct ctl_table *ctl, int write,
 		return ret;
 
 	if (write)
-		ret = addrconf_disable_ipv6(ctl, valp, val);
+		ret = addrconf_disable_ipv6(ctx, valp, val);
 	return ret;
 }
 
 static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = ctl->extra2;
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
+	struct net *net = ctx->net;
 	int *valp = ctl->data;
 	int old, new;
 	int ret;
@@ -6533,7 +6545,7 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
 		} else {
-			struct inet6_dev *idev = ctl->extra1;
+			struct inet6_dev *idev = ctx->idev;
 
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
 						     NETCONFA_PROXY_NEIGH,
@@ -6551,10 +6563,11 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 					 void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
 	int ret = 0;
 	u32 new_val;
-	struct inet6_dev *idev = (struct inet6_dev *)ctl->extra1;
-	struct net *net = (struct net *)ctl->extra2;
+	struct inet6_dev *idev = ctx->idev;
+	struct net *net = ctx->net;
 	struct ctl_table tmp = {
 		.data = &new_val,
 		.maxlen = sizeof(new_val),
@@ -6618,16 +6631,18 @@ static int addrconf_sysctl_stable_secret(const struct ctl_table *ctl, int write,
 					 void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
 	int err;
 	struct in6_addr addr;
 	char str[IPV6_MAX_STRLEN];
-	struct ctl_table lctl = *ctl;
-	struct net *net = ctl->extra2;
+	struct ctl_table lctl;
+	struct net *net = ctx->net;
 	struct ipv6_stable_secret *secret = ctl->data;
 
 	if (&net->ipv6.devconf_all->stable_secret == ctl->data)
 		return -EIO;
 
+	lctl = *ctl;
 	lctl.maxlen = IPV6_MAX_STRLEN;
 	lctl.data = str;
 
@@ -6669,7 +6684,7 @@ static int addrconf_sysctl_stable_secret(const struct ctl_table *ctl, int write,
 			}
 		}
 	} else {
-		struct inet6_dev *idev = ctl->extra1;
+		struct inet6_dev *idev = ctx->idev;
 
 		WRITE_ONCE(idev->cnf.addr_gen_mode,
 			   IN6_ADDR_GEN_MODE_STABLE_PRIVACY);
@@ -6687,6 +6702,7 @@ int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 						size_t *lenp,
 						loff_t *ppos)
 {
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
 	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
@@ -6703,7 +6719,7 @@ int addrconf_sysctl_ignore_routes_with_linkdown(const struct ctl_table *ctl,
 		return ret;
 
 	if (write)
-		ret = addrconf_fixup_linkdown(ctl, valp, val);
+		ret = addrconf_fixup_linkdown(ctx, valp, val);
 	return ret;
 }
 
@@ -6749,9 +6765,10 @@ void addrconf_disable_policy_idev(struct inet6_dev *idev, int val)
 }
 
 static
-int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
+int addrconf_disable_policy(const struct addrconf_sysctl_ctx *ctx,
+			    int *valp, int val)
 {
-	struct net *net = (struct net *)ctl->extra2;
+	struct net *net = ctx->net;
 	struct inet6_dev *idev;
 
 	if (valp == &net->ipv6.devconf_dflt->disable_policy) {
@@ -6773,7 +6790,7 @@ int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 				addrconf_disable_policy_idev(idev, val);
 		}
 	} else {
-		idev = (struct inet6_dev *)ctl->extra1;
+		idev = ctx->idev;
 		addrconf_disable_policy_idev(idev, val);
 	}
 
@@ -6784,6 +6801,7 @@ int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
 	struct ctl_table lctl;
 	int *valp = ctl->data;
 	int val = *valp;
@@ -6796,7 +6814,7 @@ static int addrconf_sysctl_disable_policy(const struct ctl_table *ctl, int write
 		return ret;
 
 	if (write && (*valp != val))
-		ret = addrconf_disable_policy(ctl, valp, val);
+		ret = addrconf_disable_policy(ctx, valp, val);
 
 	return ret;
 }
@@ -6823,16 +6841,17 @@ static void addrconf_force_forward_change(struct net *net, __s32 newf)
 static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int write,
 					    void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct inet6_dev *idev = ctl->extra1;
+	const struct addrconf_sysctl_ctx *ctx = ctl->priv;
+	struct inet6_dev *idev = ctx->idev;
 	struct ctl_table tmp_ctl = *ctl;
-	struct net *net = ctl->extra2;
+	struct net *net = ctx->net;
 	int *valp = ctl->data;
 	int new_val = *valp;
 	int old_val = *valp;
 	int ret;
 
-	tmp_ctl.extra1 = SYSCTL_ZERO;
-	tmp_ctl.extra2 = SYSCTL_ONE;
+	tmp_ctl.min = 0;
+	tmp_ctl.max = 1;
 	tmp_ctl.data = &new_val;
 
 	ret = proc_douintvec_minmax(&tmp_ctl, write, buffer, lenp, ppos);
@@ -6867,10 +6886,6 @@ static int addrconf_sysctl_force_forwarding(const struct ctl_table *ctl, int wri
 	return ret;
 }
 
-static int minus_one = -1;
-static const int two_five_five = 255;
-static u32 ioam6_if_id_max = U16_MAX;
-
 static const struct ctl_table addrconf_sysctl[] = {
 	{
 		.procname	= "forwarding",
@@ -6885,8 +6900,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&two_five_five,
+		.min		= 1,
+		.max		= 255,
 	},
 	{
 		.procname	= "mtu",
@@ -6929,7 +6944,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &minus_one,
+		.min		= (unsigned long)(long)-1,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "router_solicitation_interval",
@@ -7037,7 +7053,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(u32),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
+		.min		= 1,
+		.max		= UINT_MAX,
 	},
 	{
 		.procname	= "accept_ra_min_hop_limit",
@@ -7066,8 +7083,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "ra_honor_pio_pflag",
@@ -7075,8 +7092,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 #ifdef CONFIG_IPV6_ROUTER_PREF
 	{
@@ -7284,8 +7301,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)&two_five_five,
+		.min		= 0,
+		.max		= 255,
 	},
 	{
 		.procname	= "rpl_seg_enabled",
@@ -7293,8 +7310,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "ioam6_enabled",
@@ -7302,8 +7319,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "ioam6_id",
@@ -7311,8 +7328,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(u32),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)&ioam6_if_id_max,
+		.min		= 0,
+		.max		= U16_MAX,
 	},
 	{
 		.procname	= "ioam6_id_wide",
@@ -7327,8 +7344,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "accept_untracked_na",
@@ -7336,8 +7353,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "force_forwarding",
@@ -7348,27 +7365,45 @@ static const struct ctl_table addrconf_sysctl[] = {
 	},
 };
 
+struct addrconf_sysctl_table {
+	struct ctl_table table[ARRAY_SIZE(addrconf_sysctl)];
+	struct addrconf_sysctl_ctx contexts[ARRAY_SIZE(addrconf_sysctl)];
+};
+
+static bool addrconf_sysctl_uses_context(proc_handler *handler)
+{
+	return handler == addrconf_sysctl_forward ||
+	       handler == addrconf_sysctl_mtu ||
+	       handler == addrconf_sysctl_disable ||
+	       handler == addrconf_sysctl_proxy_ndp ||
+	       handler == addrconf_sysctl_addr_gen_mode ||
+	       handler == addrconf_sysctl_stable_secret ||
+	       handler == addrconf_sysctl_ignore_routes_with_linkdown ||
+	       handler == addrconf_sysctl_disable_policy ||
+	       handler == addrconf_sysctl_force_forwarding;
+}
+
 static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 		struct inet6_dev *idev, struct ipv6_devconf *p)
 {
 	size_t table_size = ARRAY_SIZE(addrconf_sysctl);
 	int i, ifindex;
+	struct addrconf_sysctl_table *t;
 	struct ctl_table *table;
 	char path[sizeof("net/ipv6/conf/") + IFNAMSIZ];
 
-	table = kmemdup(addrconf_sysctl, sizeof(addrconf_sysctl), GFP_KERNEL_ACCOUNT);
-	if (!table)
+	t = kmalloc(sizeof(*t), GFP_KERNEL_ACCOUNT);
+	if (!t)
 		goto out;
 
+	table = t->table;
+	memcpy(table, addrconf_sysctl, sizeof(addrconf_sysctl));
 	for (i = 0; i < table_size; i++) {
 		table[i].data += (char *)p - (char *)&ipv6_devconf;
-		/* If one of these is already set, then it is not safe to
-		 * overwrite either of them: this makes proc_dointvec_minmax
-		 * usable.
-		 */
-		if (!table[i].extra1 && !table[i].extra2) {
-			table[i].extra1 = idev; /* embedded; no ref */
-			table[i].extra2 = net;
+		if (addrconf_sysctl_uses_context(table[i].proc_handler)) {
+			t->contexts[i].idev = idev;
+			t->contexts[i].net = net;
+			table[i].priv = &t->contexts[i];
 		}
 	}
 
-- 
2.25.1

