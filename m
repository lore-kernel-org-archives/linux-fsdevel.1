Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F764854EF;
	Wed, 26 Aug 2026 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773460; cv=none; b=kngdJ5o46H119o96FuN2LFdKBANtH+E2HtI7AePNdlYbt1fZToj2nkwnhEcfMugllZz8EUG1v9vjBwyCo1+4zzm7Z02rChXGjcrbBlWNPVvOkiXa2Fk/gHYg6Z0q6NKVzYMvy3b+xmc05DljwIfmbmNd58VAcsqexKP9IrXptvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773460; c=relaxed/simple;
	bh=lp2MIkm1duRxRgJSbYyY2GDxaZeDRu5hUtmAFpMK/OQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gb4pU8G7hQUZBhuFFSD3QjVCm9x4GmVaKD+N7FIm4+BpDcjiJV3j0i41SOWhvV+mLFlO5SUgqCq/KsrCfyflJdsGhxwa1YPilRV1kBqAfbhfsRTQuiVcVhPIV3ECSTSL3wqP6TKAk7W6mLEZPSQBWo+9WAyuk8F2MMzarOw2Xf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I66ailtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I66ailtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E851F00ACA;
	Wed, 26 Aug 2026 19:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773440;
	bh=RoqT0QkW0P7BOEHGFbCqJiPBYBkUAG2mOl2EmpOjcZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I66ailtxaTAtYvNIKRLmqE8JUEGJ0XOG/UhOxvGUHBhY2w/krzPR80dddeTqsTvS3
	 sEQQzaZK9enOhyn1XxRpKwB7nSEMDjo9PKOq/wnxesQ9ozOf7mDZKMDRTRjBVdwFxY
	 pkKQJ1fp0HBPoEDa+/we5CHNhC8j5dqHIJrjI2dxekxXm52REnk24x3q0zS7tJT1Og
	 FTQn1+bp/dxo7cFkZMrmo/+qReH5tztYA5NpUAK7M0gZBsSOJbJra1CswRtyh/3FTV
	 aG00+Y3D1sg+2ayUP2cC6omCLeQQFFeFPAwrkPG/5zs6egsgEbFp82u3aRRpeBkKMw
	 IqIMK78R0WD0A==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 26/30] sysctl: net: use sysctl_field for MPLS sysctls
Date: Wed, 26 Aug 2026 21:42:30 +0200
Message-ID: <190a3b46399c24eb176b8d46a246ad574d0e5d33.1787771905.git.legion@kernel.org>
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

MPLS clones both its per-net and per-device sysctl tables so
registration can turn offset-based entries into pointers to the
corresponding network namespace or MPLS device. These mutable copies
then have to remain allocated until the sysctls are unregistered.

Use sysctl_field accessors to resolve per-net data from struct sysctl_context,
and embed that context in an MPLS device-specific wrapper for the
per-device table. This allows both descriptor arrays to remain static
and const while preserving access to the network namespace and mpls_dev
state.

Remove the per-instance table clones, offset arithmetic, and matching
unregister-time frees.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/sysctl.h |   4 ++
 net/mpls/af_mpls.c     | 154 ++++++++++++++++-------------------------
 2 files changed, 62 insertions(+), 96 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index bbdb0fcfbcd4..6cf2ef4f13e8 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -486,6 +486,10 @@ struct ctl_table_root {
 	__register_sysctl_fields(set, path, fields, ARRAY_SIZE(fields),	\
 				 (ctx), sizeof(*(ctx)))
 
+#define register_sysctl_fields_ctx(set, path, fields, ctx)		\
+	__register_sysctl_fields(set, path, fields, ARRAY_SIZE(fields),	\
+				 (&(ctx)->context), sizeof(*(ctx)))
+
 #ifdef CONFIG_SYSCTL
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 26340a7306b5..5b58fea375e7 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1387,74 +1387,62 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 	return err;
 }
 
-#define MPLS_PERDEV_SYSCTL_OFFSET(field)	\
-	(&((struct mpls_dev *)0)->field)
+struct mpls_dev_ctl_context {
+	struct sysctl_context context;
+	struct mpls_dev *mdev;
+};
+
+static void *mpls_dev_data(const struct sysctl_context *ctx)
+{
+	const struct mpls_dev_ctl_context *mpls_ctx =
+		container_of(ctx, struct mpls_dev_ctl_context, context);
+
+	return mpls_ctx->mdev;
+}
 
 static int mpls_conf_proc(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	int oval = *(int *)ctl->data;
-	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
+	struct mpls_dev *mdev = ctl->data;
+	int oval = mdev->input_enabled;
+	struct ctl_table tmp = *ctl;
+	int ret;
 
-	if (write) {
-		struct mpls_dev *mdev = ctl->extra1;
-		int i = (int *)ctl->data - (int *)mdev;
-		struct net *net = ctl->extra2;
-		int val = *(int *)ctl->data;
+	tmp.data = &mdev->input_enabled;
+	ret = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 
-		if (i == offsetof(struct mpls_dev, input_enabled) &&
-		    val != oval) {
-			mpls_netconf_notify_devconf(net, RTM_NEWNETCONF,
-						    NETCONFA_INPUT, mdev);
-		}
-	}
+	if (write && ret == 0 && mdev->input_enabled != oval)
+		mpls_netconf_notify_devconf(dev_net(mdev->dev), RTM_NEWNETCONF,
+					    NETCONFA_INPUT, mdev);
 
 	return ret;
 }
 
-static const struct ctl_table mpls_dev_table[] = {
-	{
-		.procname	= "input",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= mpls_conf_proc,
-		.data		= MPLS_PERDEV_SYSCTL_OFFSET(input_enabled),
-	},
+static const struct sysctl_field mpls_dev_table[] = {
+	SYSCTL_FIELD_CUSTOM("input", 0644, sizeof(int), mpls_dev_data,
+			 mpls_conf_proc),
 };
 
 static int mpls_dev_sysctl_register(struct net_device *dev,
 				    struct mpls_dev *mdev)
 {
 	char path[sizeof("net/mpls/conf/") + IFNAMSIZ];
-	size_t table_size = ARRAY_SIZE(mpls_dev_table);
 	struct net *net = dev_net(dev);
-	struct ctl_table *table;
-	int i;
-
-	table = kmemdup(&mpls_dev_table, sizeof(mpls_dev_table), GFP_KERNEL);
-	if (!table)
-		goto out;
-
-	/* Table data contains only offsets relative to the base of
-	 * the mdev at this point, so make them absolute.
-	 */
-	for (i = 0; i < table_size; i++) {
-		table[i].data = (char *)mdev + (uintptr_t)table[i].data;
-		table[i].extra1 = mdev;
-		table[i].extra2 = net;
-	}
+	struct mpls_dev_ctl_context ctx = {
+		.context.ns.net_ns = net,
+		.mdev = mdev,
+	};
 
 	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
 
-	mdev->sysctl = register_net_sysctl_sz(net, path, table, table_size);
+	mdev->sysctl = register_sysctl_fields_ctx(&net->sysctls, path,
+						  mpls_dev_table, &ctx);
 	if (!mdev->sysctl)
-		goto free;
+		goto out;
 
 	mpls_netconf_notify_devconf(net, RTM_NEWNETCONF, NETCONFA_ALL, mdev);
 	return 0;
 
-free:
-	kfree(table);
 out:
 	mdev->sysctl = NULL;
 	return -ENOBUFS;
@@ -1464,14 +1452,11 @@ static void mpls_dev_sysctl_unregister(struct net_device *dev,
 				       struct mpls_dev *mdev)
 {
 	struct net *net = dev_net(dev);
-	const struct ctl_table *table;
 
 	if (!mdev->sysctl)
 		return;
 
-	table = mdev->sysctl->ctl_table_arg;
 	unregister_net_sysctl_table(mdev->sysctl);
-	kfree(table);
 
 	mpls_netconf_notify_devconf(net, RTM_DELNETCONF, 0, mdev);
 }
@@ -2705,43 +2690,35 @@ static int mpls_platform_labels(const struct ctl_table *table, int write,
 	return ret;
 }
 
-#define MPLS_NS_SYSCTL_OFFSET(field)		\
-	(&((struct net *)0)->field)
+#define MPLS_DATA(type, field)						\
+static type *mpls_ ## field ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->mpls.field;				\
+}
 
-static const struct ctl_table mpls_table[] = {
-	{
-		.procname	= "platform_labels",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= mpls_platform_labels,
-	},
-	{
-		.procname	= "ip_ttl_propagate",
-		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "default_ttl",
-		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &ttl_max,
-	},
+static void *mpls_net_data(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns;
+}
+
+MPLS_DATA(int, ip_ttl_propagate)
+MPLS_DATA(int, default_ttl)
+
+static const struct sysctl_field mpls_table[] = {
+	SYSCTL_FIELD_CUSTOM("platform_labels", 0644, sizeof(int),
+			 mpls_net_data, mpls_platform_labels),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("ip_ttl_propagate", 0644,
+				    mpls_ip_ttl_propagate_data, SYSCTL_ZERO,
+				    SYSCTL_ONE),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("default_ttl", 0644, mpls_default_ttl_data,
+				    SYSCTL_ONE, &ttl_max),
 };
 
 static __net_init int mpls_net_init(struct net *net)
 {
-	size_t table_size = ARRAY_SIZE(mpls_table);
-	struct ctl_table *table;
-	int i;
-
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
 	mutex_init(&net->mpls.platform_mutex);
 	seqcount_mutex_init(&net->mpls.platform_label_seq, &net->mpls.platform_mutex);
 
@@ -2750,23 +2727,11 @@ static __net_init int mpls_net_init(struct net *net)
 	net->mpls.ip_ttl_propagate = 1;
 	net->mpls.default_ttl = 255;
 
-	table = kmemdup(mpls_table, sizeof(mpls_table), GFP_KERNEL);
-	if (table == NULL)
+	net->mpls.ctl = register_sysctl_fields(&net->sysctls, "net/mpls",
+					       mpls_table, &ctx);
+	if (!net->mpls.ctl)
 		return -ENOMEM;
 
-	/* Table data contains only offsets relative to the base of
-	 * the mdev at this point, so make them absolute.
-	 */
-	for (i = 0; i < table_size; i++)
-		table[i].data = (char *)net + (uintptr_t)table[i].data;
-
-	net->mpls.ctl = register_net_sysctl_sz(net, "net/mpls", table,
-					       table_size);
-	if (net->mpls.ctl == NULL) {
-		kfree(table);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
@@ -2774,12 +2739,9 @@ static __net_exit void mpls_net_exit(struct net *net)
 {
 	struct mpls_route __rcu **platform_label;
 	size_t platform_labels;
-	const struct ctl_table *table;
 	unsigned int index;
 
-	table = net->mpls.ctl->ctl_table_arg;
 	unregister_net_sysctl_table(net->mpls.ctl);
-	kfree(table);
 
 	/* An rcu grace period has passed since there was a device in
 	 * the network namespace (and thus the last in flight packet)
-- 
2.55.0

