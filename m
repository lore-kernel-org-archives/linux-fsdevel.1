Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205525;
	b=FkvcvuOCgSAz/B9yWoU4mehnNm9jTgjN2i/MPA3v04bSl3i4NfRyTSZBnO7qN3r0xqSg
	 ++SAynWOznuEqUe+/ieR6MUZhWVdm6zNd/EIASVPhiZ/QCPHlOGXi/81AMoY559vD6Znr
	 MVllL1CjvlZQdoXdRqj4h3lzb1PjYjxcXwOKxw2LZ6e32G7KlI8XogVt2lIXnVzQ3/NiI
	 8r4UNyh1q/fNIju5DnP3RfZYjwLn+AB9OEUsNMjMV3fEv2GWf4r8/7dyOlZMpJ0fbDOcM
	 P65omQsyVKTNck23yTxYYt95mMKB6VJP4NXoZoaXv/JTmz4M62LZnXXPAImIQCRfxhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205525;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MkzrwFnG/lcGlHzjpYe1RkdpHO6VQy9tK8CD7EjZ//0=;
	b=uRjsa2CblN9EHcXaFF19mrkIMxzyopzMhTdFw04bH1IJ0BxZtRkeyNd0L4wWkIgYXNpl
	 1kATBORocDPJpCSXDh8sdvThX6yDU0zE4UPkm4VXxGm0ZO+wrObSORNn5S+otVTogusOK
	 Y8kJvk2+f0/ILBH+TdO/jKyzKjM59Jh16wPKzgrZLnazuQjwCrAL+mAiPZCTP4of2RbDR
	 x4j70QZ172YIpXEHdargumg9Xr5dOYfaK/KMp/kmYy5D1wcyGpHLmYD/sfiBA+9SvpH43
	 2g40Yx2+9JcLsgp0Ps4Ggyqt4ln7f4Qh4J4IErmG2jqLl3yHcAZ33Rz8B+TfvBeZk6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uauuUce0;
	arc=none smtp.remote-ip=95.215.58.122
Received: from mta1.migadu.com (out-122.mta1.migadu.com [95.215.58.122])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994BC606B28B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 994BC606B28B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uauuUce0
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EVCTuwWIrcinYfvYY/8XHBFMFVypS10fCIWhje7y1tU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205522; v=1; x=1793810322;
 b=uauuUce0G5VdYyukUE/yH+yGvgfLub+TSS1bzh+59Cfpf3HdI2m5Bw3bcgpUYPaA8vYyaE6p
 Yc3fMd53nyxfrq8Yt2tYalyPjv6ZCn9tu/qkOm844ufCK00wgH6RECEwkFrpjm0CkbsmtjPOPyV
 BAGHA6mH6XZ5tPXnLHvkcTaM=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9429332563f4f3c5;
	Wed, 28 Oct 2026 16:38:42 +0000
X-Mizu-Trace-ID: 9429332563f4f3c5
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 34/39] ipv4: move device sysctl context to priv
Date: Thu, 29 Oct 2026 00:35:13 +0800
Message-Id: <33fdcb47667bdb4f7358e0ffa703614bb001ea8e.1793204511.git.wen.yang@linux.dev>
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

Like addrconf, devinet needs the ipv4_devconf and the netns in each
handler, and the per-net ip_forward entry needs the all-devconf. Those
pointers currently share extra1/extra2 with the numeric bounds.

Put them in priv, keep data as the devconf field, and let registration
set only priv. The forwarding entry points data straight at the
all-devconf forwarding slot.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/ipv4/devinet.c | 53 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 1e9d988849c9..e1899b268a34 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2555,17 +2555,26 @@ static int devinet_conf_ifindex(struct net *net, struct ipv4_devconf *cnf)
 	}
 }
 
+/* Owned by the registered table; devconf and net outlive its handlers. */
+struct devinet_sysctl_ctx {
+	struct ipv4_devconf *devconf;
+	struct net *net;
+};
+
 static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int old_value = *(int *)ctl->data;
-	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
-	int new_value = *(int *)ctl->data;
+	const struct devinet_sysctl_ctx *ctx = ctl->priv;
+	int old_value, ret, new_value;
+
+	old_value = *(int *)ctl->data;
+	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
+	new_value = *(int *)ctl->data;
 
 	if (write) {
-		struct ipv4_devconf *cnf = ctl->extra1;
+		struct ipv4_devconf *cnf = ctx->devconf;
 		int i = (int *)ctl->data - cnf->data;
-		struct net *net = ctl->extra2;
+		struct net *net = ctx->net;
 		int ifindex;
 
 		/* These attributes are bypassing the tracking state,
@@ -2597,7 +2606,8 @@ static int devinet_conf_proc(const struct ctl_table *ctl, int write,
 static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = ctl->extra2;
+	const struct devinet_sysctl_ctx *ctx = ctl->priv;
+	struct net *net = ctx->net;
 	int *valp = ctl->data;
 	int val = *valp;
 	int ret;
@@ -2617,7 +2627,7 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 			if (valp == &IPV4_DEVCONF_ALL(net, FORWARDING)) {
 				inet_forward_change(net);
 			} else {
-				struct ipv4_devconf *cnf = ctl->extra1;
+				struct ipv4_devconf *cnf = ctx->devconf;
 				struct in_device *idev =
 					container_of(cnf, struct in_device, cnf);
 				if (*valp)
@@ -2647,7 +2657,6 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 		.maxlen		= sizeof(int), \
 		.mode		= mval, \
 		.proc_handler	= proc, \
-		.extra1		= &ipv4_devconf, \
 	}
 
 #define DEVINET_SYSCTL_RW_ENTRY(attr, name) \
@@ -2662,6 +2671,7 @@ static int devinet_sysctl_forward(const struct ctl_table *ctl, int write,
 static struct devinet_sysctl_table {
 	struct ctl_table_header *sysctl_header;
 	struct ctl_table devinet_vars[IPV4_DEVCONF_MAX];
+	struct devinet_sysctl_ctx contexts[IPV4_DEVCONF_MAX];
 } devinet_sysctl = {
 	.devinet_vars = {
 		DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING, "forwarding",
@@ -2725,8 +2735,12 @@ static int __devinet_sysctl_register(struct net *net, char *dev_name,
 
 	for (i = 0; i < ARRAY_SIZE(t->devinet_vars); i++) {
 		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
-		t->devinet_vars[i].extra1 = p;
-		t->devinet_vars[i].extra2 = net;
+		if (t->devinet_vars[i].proc_handler == devinet_conf_proc ||
+		    t->devinet_vars[i].proc_handler == devinet_sysctl_forward) {
+			t->contexts[i].devconf = p;
+			t->contexts[i].net = net;
+			t->devinet_vars[i].priv = &t->contexts[i];
+		}
 	}
 
 	snprintf(path, sizeof(path), "net/ipv4/conf/%s", dev_name);
@@ -2786,6 +2800,11 @@ static void devinet_sysctl_unregister(struct in_device *idev)
 	neigh_sysctl_unregister(idev->arp_parms);
 }
 
+struct devinet_forward_table {
+	struct ctl_table table[1];
+	struct devinet_sysctl_ctx context;
+};
+
 static const struct ctl_table ctl_forward_entry[] = {
 	{
 		.procname	= "ip_forward",
@@ -2794,8 +2813,6 @@ static const struct ctl_table ctl_forward_entry[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= devinet_sysctl_forward,
-		.extra1		= &ipv4_devconf,
-		.extra2		= &init_net,
 	},
 };
 #endif
@@ -2805,6 +2822,7 @@ static __net_init int devinet_init_net(struct net *net)
 #ifdef CONFIG_SYSCTL
 	struct ctl_table_header *forw_hdr;
 	struct ctl_table *tbl;
+	struct devinet_forward_table *forward;
 #endif
 	struct ipv4_devconf *all, *dflt;
 	int err;
@@ -2825,13 +2843,16 @@ static __net_init int devinet_init_net(struct net *net)
 		goto err_alloc_dflt;
 
 #ifdef CONFIG_SYSCTL
-	tbl = kmemdup(ctl_forward_entry, sizeof(ctl_forward_entry), GFP_KERNEL);
-	if (!tbl)
+	forward = kmalloc(sizeof(*forward), GFP_KERNEL);
+	if (!forward)
 		goto err_alloc_ctl;
 
+	tbl = forward->table;
+	memcpy(tbl, ctl_forward_entry, sizeof(ctl_forward_entry));
+	forward->context.devconf = all;
+	forward->context.net = net;
 	tbl[0].data = &all->data[IPV4_DEVCONF_FORWARDING - 1];
-	tbl[0].extra1 = all;
-	tbl[0].extra2 = net;
+	tbl[0].priv = &forward->context;
 #endif
 
 	if (!net_eq(net, &init_net)) {
-- 
2.25.1

