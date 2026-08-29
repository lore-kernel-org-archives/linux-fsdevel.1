Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D56412C12;
	Sat, 29 Aug 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020127; cv=none; b=Qfp1NJaudvs6pAMWHUfQer4W4h0huUrQ6FTO97mG0+dMY/F//q8454+tDmRlKKnAM6iUD7Fn6aMPm/WgdjRPnc1Ug2M4oFq9bmc1YUVETfWXIoYtxET/G0LXbSQ4eLW8dGNutxWRR8t4Hn7djpcwFz5qCwPM0Iyl5sBDzI9xuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020127; c=relaxed/simple;
	bh=mVIZpsFJaT6rvVjXfohwRj/jQyIilfMgqQotNJAsrbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eliNSZv8cQEOISv1P0jFoA6QHoroZkTODTcEHF+AgyewNXoxvO1P0xt6x3OrqusmtLG7G9GpI2PYFhEU1yuHh1qBiS7g+calEmABlBf2Ms3F/J/kzzluCugF5MHS/dUUXNG4arGfLBC00kuSxo49hiXRQToRsjPsFsZjnd5Yn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HihRQpYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HihRQpYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64FA1F00AC4;
	Sat, 29 Aug 2026 16:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788020122;
	bh=jY2Y2UsgI9FyRNkJHUiF014TX0cvic1HZjkjK+wNcgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HihRQpYjDCNYXc8PVX0wvGF8yDD9vM0G6HmNjlCtQv1PcpAl0II8d5DhIrwiQizxn
	 j54BZyn945q5YbYay3NTdM5rjlCWasibX5sQX1VqCeQIu5+ikSvv6gW3EnjGXvgJGa
	 5ap+RtjYp5UbRZxah3vwIMcz/+UISdnlmI56IsLk1MfWObjyqPtW4D5kIlr9xQOK//
	 yJewbhH6HZL6yn92xo9I1yzkPHAGaAgkRSnl+9WWTRmmXC6daIxcARxOJvxys+fIjV
	 L3jEyS24g70oVyGqGYM+iZ8hAob0hpwwqyJdALviP4iGXA55q5OFZvnB4eal0+86E5
	 RzOz6VzhO3LIQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 4/4] mpls: use typed fields for per-device sysctls
Date: Sat, 29 Aug 2026 18:14:47 +0200
Message-ID: <6d770bbaf1897da04973019cf201f0d872261599.1788018958.git.legion@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788018958.git.legion@kernel.org>
References: <cover.1788018958.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPLS clones its device sysctl table and converts relative data pointers
into mpls_dev addresses at registration time. It also stores the device
and network namespace in extra1 and extra2 for the handler.

Use a context wrapper to retain both objects and select mpls_dev as the
backing object for typed field offsets. The static field table can then
be shared by all devices without allocating and rewriting a ctl_table
array.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/mpls/af_mpls.c | 66 ++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 26340a7306b5..725df199cf1d 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1387,8 +1387,18 @@ static int mpls_netconf_dump_devconf(struct sk_buff *skb,
 	return err;
 }
 
-#define MPLS_PERDEV_SYSCTL_OFFSET(field)	\
-	(&((struct mpls_dev *)0)->field)
+struct mpls_dev_sysctl_context {
+	struct sysctl_context context;
+	struct mpls_dev *mdev;
+};
+
+static void *mpls_dev_sysctl_object(const struct sysctl_context *ctx)
+{
+	const struct mpls_dev_sysctl_context *mpls_ctx;
+
+	mpls_ctx = container_of(ctx, struct mpls_dev_sysctl_context, context);
+	return mpls_ctx->mdev;
+}
 
 static int mpls_conf_proc(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
@@ -1397,14 +1407,12 @@ static int mpls_conf_proc(const struct ctl_table *ctl, int write,
 	int ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
 
 	if (write) {
-		struct mpls_dev *mdev = ctl->extra1;
-		int i = (int *)ctl->data - (int *)mdev;
-		struct net *net = ctl->extra2;
+		struct mpls_dev *mdev;
 		int val = *(int *)ctl->data;
 
-		if (i == offsetof(struct mpls_dev, input_enabled) &&
-		    val != oval) {
-			mpls_netconf_notify_devconf(net, RTM_NEWNETCONF,
+		mdev = container_of(ctl->data, struct mpls_dev, input_enabled);
+		if (val != oval) {
+			mpls_netconf_notify_devconf(dev_net(mdev->dev), RTM_NEWNETCONF,
 						    NETCONFA_INPUT, mdev);
 		}
 	}
@@ -1412,13 +1420,13 @@ static int mpls_conf_proc(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static const struct ctl_table mpls_dev_table[] = {
+static const struct sysctl_field mpls_dev_table[] = {
 	{
 		.procname	= "input",
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_INT,
 		.proc_handler	= mpls_conf_proc,
-		.data		= MPLS_PERDEV_SYSCTL_OFFSET(input_enabled),
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct mpls_dev, input_enabled),
 	},
 };
 
@@ -1426,35 +1434,27 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
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
+	struct mpls_dev_sysctl_context ctx = {
+		.context = {
+			.object_size = sizeof(*mdev),
+			.object = mpls_dev_sysctl_object,
+		},
+		.mdev = mdev,
+	};
 
 	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
 
-	mdev->sysctl = register_net_sysctl_sz(net, path, table, table_size);
+	mdev->sysctl =
+		__register_sysctl_fields(&net->sysctls, path, mpls_dev_table,
+					 ARRAY_SIZE(mpls_dev_table), &ctx.context,
+					 sizeof(ctx));
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
@@ -1464,14 +1464,10 @@ static void mpls_dev_sysctl_unregister(struct net_device *dev,
 				       struct mpls_dev *mdev)
 {
 	struct net *net = dev_net(dev);
-	const struct ctl_table *table;
-
 	if (!mdev->sysctl)
 		return;
 
-	table = mdev->sysctl->ctl_table_arg;
 	unregister_net_sysctl_table(mdev->sysctl);
-	kfree(table);
 
 	mpls_netconf_notify_devconf(net, RTM_DELNETCONF, 0, mdev);
 }
-- 
2.55.0

