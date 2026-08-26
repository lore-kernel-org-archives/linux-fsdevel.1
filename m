Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE0481679;
	Wed, 26 Aug 2026 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773452; cv=none; b=N8i5S8TLaRQLOs4gAMLu/3fjSf2PCnbPOa4fbx0owwud7BlMi+Yp3GkuBMbNahZZrmi/KMijDaKa/wmo0+oYefCPEqoY7M/sUwqYbkjtRR6iS82wNHR8iBp7gSIpEDadHJK038ZAhDDR2RbuRtgj+ZpSg1qbzeiI06ysecNRFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773452; c=relaxed/simple;
	bh=Ro3w3EDfRH1jNshK9lxK2IGwzcNz2IdIqzYK2yUpFoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFB7q+T7mTLUGWMZmwvgQQjYiRebvmZLdQxZwsonS7dzRFzIQOsL9dZCb2xXwVanR12LdN0Q0ERoN+q2/5MYXaEses7dm5h7kgCuX2h6/QM8YR5qP2L+g9hergJoIrOjX/y1CsdpUgAqUl3hq0GJDg1Hppr/AzCwLvxH9aTiMAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBKwhZ/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBKwhZ/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7971F00ADE;
	Wed, 26 Aug 2026 19:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773432;
	bh=xloEoEd/0DOxxxwVFZlmFnNBDux5+ivipajIt/kl0Y0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iBKwhZ/uJrTXGFH6tjtoP7K/FuWQg9poloHeS1gWgFhhA/Q594OL9UYSuSWD3TeYm
	 R3PbdX5qysnvaRkQNUFjtpT3orWGtwq0DCtkPED2LCXBoyBI+ISCXfDL48zn5125Wn
	 UauleMVCxbEI57oFs7hNdiWqn/QhkA/T9vwYEsi3B6vYDaCroD1btc8hsbKXws62EC
	 OyE+fj+YVLTSCEEGZprf6YB41OMP5Bs5hipW4x/CDzB820JZeS4zYwvNWbPAk1OjeH
	 cZKC57IMMG0/99Mk9vO9tyqgqV/P8RIi+R+89jrXRE0AdF69VbCzkQEaojCjBFcH+S
	 8ysGo3JCcj/kQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 22/30] sysctl: net: use sysctl_field in RDS sysctls
Date: Wed, 26 Aug 2026 21:42:26 +0200
Message-ID: <18251f7eac243d91180462539e3b68391059b7ff.1787771905.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787771905.git.legion@kernel.org>
References: <cover.1787771905.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RDS TCP clones its sysctl table for every non-init network namespace so
that the per-net buffer limits can be patched into the ctl_table
entries. The handlers also rely on the ctl_table data pointer to
recover the owning RDS per-net state.

Use sysctl_field descriptors instead and resolve the per-net data from
the sysctl context at registration time. This keeps the RDS TCP sysctl
layout static, removes the per-net table allocation, and avoids binding
the code to fixed ctl_table indexes.

Pass the per-entry minimum and the RDS per-net state through the custom
field callbacks so both buffer sysctls can share one handler.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/rds/tcp.c | 129 ++++++++++++++++++++++++--------------------------
 net/rds/tcp.h |   1 -
 2 files changed, 63 insertions(+), 67 deletions(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 5830b31a1f37..2504221ec592 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/in.h>
 #include <linux/module.h>
+#include <linux/sysctl.h>
 #include <net/tcp.h>
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
@@ -61,33 +62,60 @@ static atomic_t rds_tcp_unloading = ATOMIC_INIT(0);
 
 static struct kmem_cache *rds_tcp_conn_slab;
 
-static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
-				  void *buffer, size_t *lenp, loff_t *fpos);
-static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
-				  void *buffer, size_t *lenp, loff_t *fpos);
+static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
+				 void *buffer, size_t *lenp, loff_t *fpos);
 
 static int rds_tcp_min_sndbuf = SOCK_MIN_SNDBUF;
 static int rds_tcp_min_rcvbuf = SOCK_MIN_RCVBUF;
 
-static struct ctl_table rds_tcp_sysctl_table[] = {
-#define	RDS_TCP_SNDBUF	0
-	{
-		.procname       = "rds_tcp_sndbuf",
-		/* data is per-net pointer */
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = rds_tcp_sndbuf_handler,
-		.extra1		= &rds_tcp_min_sndbuf,
-	},
-#define	RDS_TCP_RCVBUF	1
-	{
-		.procname       = "rds_tcp_rcvbuf",
-		/* data is per-net pointer */
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = rds_tcp_rcvbuf_handler,
-		.extra1		= &rds_tcp_min_rcvbuf,
-	},
+static void *rds_tcp_sndbuf_data(const struct sysctl_context *ctx)
+{
+	struct rds_tcp_net *rtn = net_generic(ctx->ns.net_ns, rds_tcp_netid);
+
+	return &rtn->sndbuf_size;
+}
+
+static void *rds_tcp_rcvbuf_data(const struct sysctl_context *ctx)
+{
+	struct rds_tcp_net *rtn = net_generic(ctx->ns.net_ns, rds_tcp_netid);
+
+	return &rtn->rcvbuf_size;
+}
+
+static void *rds_tcp_net_data(const struct sysctl_context *ctx)
+{
+	return net_generic(ctx->ns.net_ns, rds_tcp_netid);
+}
+
+static void *rds_tcp_min_sndbuf_data(const struct sysctl_context *ctx)
+{
+	return &rds_tcp_min_sndbuf;
+}
+
+static void *rds_tcp_min_rcvbuf_data(const struct sysctl_context *ctx)
+{
+	return &rds_tcp_min_rcvbuf;
+}
+
+#define RDS_TCP_SKBUF_ENTRY(_name, _data, _min)				\
+	{								\
+		.procname	= (_name),				\
+		.mode		= 0644,					\
+		.type		= SYSCTL_FIELD_CUSTOM,			\
+		.ctl_custom	= {					\
+			.proc_handler	= rds_tcp_skbuf_handler,	\
+			.data		= (_data),			\
+			.extra1		= (_min),			\
+			.extra2		= rds_tcp_net_data,		\
+			.maxlen		= sizeof(int),			\
+		},							\
+	}
+
+static const struct sysctl_field rds_tcp_sysctl_table[] = {
+	RDS_TCP_SKBUF_ENTRY("rds_tcp_sndbuf", rds_tcp_sndbuf_data,
+			    rds_tcp_min_sndbuf_data),
+	RDS_TCP_SKBUF_ENTRY("rds_tcp_rcvbuf", rds_tcp_rcvbuf_data,
+			    rds_tcp_min_rcvbuf_data),
 };
 
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc)
@@ -542,36 +570,28 @@ void rds_tcp_accept_work(struct rds_tcp_net *rtn)
 static __net_init int rds_tcp_init_net(struct net *net)
 {
 	struct rds_tcp_net *rtn = net_generic(net, rds_tcp_netid);
-	struct ctl_table *tbl;
 	int err = 0;
 
 	memset(rtn, 0, sizeof(*rtn));
 
 	mutex_init(&rtn->rds_tcp_accept_lock);
 
+#if IS_ENABLED(CONFIG_SYSCTL)
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
+
 	/* {snd, rcv}buf_size default to 0, which implies we let the
 	 * stack pick the value, and permit auto-tuning of buffer size.
 	 */
-	if (net == &init_net) {
-		tbl = rds_tcp_sysctl_table;
-	} else {
-		tbl = kmemdup(rds_tcp_sysctl_table,
-			      sizeof(rds_tcp_sysctl_table), GFP_KERNEL);
-		if (!tbl) {
-			pr_warn("could not set allocate sysctl table\n");
-			return -ENOMEM;
-		}
-		rtn->ctl_table = tbl;
-	}
-	tbl[RDS_TCP_SNDBUF].data = &rtn->sndbuf_size;
-	tbl[RDS_TCP_RCVBUF].data = &rtn->rcvbuf_size;
-	rtn->rds_tcp_sysctl = register_net_sysctl_sz(net, "net/rds/tcp", tbl,
-						     ARRAY_SIZE(rds_tcp_sysctl_table));
+	rtn->rds_tcp_sysctl = register_sysctl_fields(&net->sysctls, "net/rds/tcp",
+						     rds_tcp_sysctl_table, &ctx);
 	if (!rtn->rds_tcp_sysctl) {
 		pr_warn("could not register sysctl\n");
 		err = -ENOMEM;
 		goto fail;
 	}
+#endif
 
 #if IS_ENABLED(CONFIG_IPV6)
 	rtn->rds_tcp_listen_sock = rds_tcp_listen_init(net, true);
@@ -598,8 +618,6 @@ static __net_init int rds_tcp_init_net(struct net *net)
 	return 0;
 
 fail:
-	if (net != &init_net)
-		kfree(tbl);
 	return err;
 }
 
@@ -640,9 +658,6 @@ static void __net_exit rds_tcp_exit_net(struct net *net)
 
 	if (rtn->rds_tcp_sysctl)
 		unregister_net_sysctl_table(rtn->rds_tcp_sysctl);
-
-	if (net != &init_net)
-		kfree(rtn->ctl_table);
 }
 
 static struct pernet_operations rds_tcp_net_ops = {
@@ -685,16 +700,16 @@ static void rds_tcp_sysctl_reset(struct net *net)
 	spin_unlock_irq(&rds_tcp_conn_lock);
 }
 
-static int rds_tcp_skbuf_handler(struct rds_tcp_net *rtn,
-				 const struct ctl_table *ctl, int write,
+static int rds_tcp_skbuf_handler(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *fpos)
 {
+	struct rds_tcp_net *rtn = ctl->extra2;
+	int *min = ctl->extra1;
 	int err;
 
 	err = proc_dointvec_minmax(ctl, write, buffer, lenp, fpos);
 	if (err < 0) {
-		pr_warn("Invalid input. Must be >= %d\n",
-			*(int *)(ctl->extra1));
+		pr_warn("Invalid input. Must be >= %d\n", *min);
 		return err;
 	}
 
@@ -707,24 +722,6 @@ static int rds_tcp_skbuf_handler(struct rds_tcp_net *rtn,
 	return 0;
 }
 
-static int rds_tcp_sndbuf_handler(const struct ctl_table *ctl, int write,
-				  void *buffer, size_t *lenp, loff_t *fpos)
-{
-	struct rds_tcp_net *rtn = container_of(ctl->data, struct rds_tcp_net,
-					       sndbuf_size);
-
-	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
-}
-
-static int rds_tcp_rcvbuf_handler(const struct ctl_table *ctl, int write,
-				  void *buffer, size_t *lenp, loff_t *fpos)
-{
-	struct rds_tcp_net *rtn = container_of(ctl->data, struct rds_tcp_net,
-					       rcvbuf_size);
-
-	return rds_tcp_skbuf_handler(rtn, ctl, write, buffer, lenp, fpos);
-}
-
 static void rds_tcp_exit(void)
 {
 	rds_tcp_set_unloading();
diff --git a/net/rds/tcp.h b/net/rds/tcp.h
index 39c86347188c..266e1d765fd5 100644
--- a/net/rds/tcp.h
+++ b/net/rds/tcp.h
@@ -14,7 +14,6 @@ struct rds_tcp_net {
 	struct socket		*rds_tcp_accepted_sock;
 	struct work_struct	rds_tcp_accept_w;
 	struct ctl_table_header	*rds_tcp_sysctl;
-	const struct ctl_table	*ctl_table;
 	int			sndbuf_size;
 	int			rcvbuf_size;
 };
-- 
2.55.0

