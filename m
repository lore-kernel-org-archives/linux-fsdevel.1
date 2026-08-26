Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138B6481640;
	Wed, 26 Aug 2026 19:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773447; cv=none; b=mMAQETqZI+qc9FftlzYNfUgYtTPWRSq7LKnYrJRusq0I1bbPBifDs9c6bTN+kTt6H9UrRTlbNnjnbTUgeQfYK4bzW5Ueaxi0FzGEp1wY3L1IRqaTVUq0VM/lXMwdKCbiHGXkP+phW3n9rVed3pUShJ/cwjOoRzw9uMe49Wy0ynE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773447; c=relaxed/simple;
	bh=rMxwRVWH528QajS2+9MuzbRH7+YjD4wHmlQZQDWs4kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIiU0UV47Hzqu/pYAjOUnfVQMyWxJao32lRmI2iCa1ViMBfcdLI9tAuPYknw3rqs55U+MtYfisqXDbw7el6YJwbT00xGz3GSmFN0OS3zNoe0VZXZNzpLb1wBLPfb5v2LOlRKbFqpW6a2dA3QroS+4ZzDOKsN7E3biM5aD6r035M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW3f06yJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW3f06yJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6C31F00ADB;
	Wed, 26 Aug 2026 19:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773430;
	bh=2nZ4cM1hlFKAePjr/0iREmizxxfMB0gbnA9l8jPQ1Dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jW3f06yJW85qtaZu7LXyNgM6ErOPaDfT7AV8A0XsUV75NnSuHtmFrxp8izUJ2Pb03
	 2yxr9i/ubMnv/XI0OEu/fkgUhViHt+yvVkF2ag5w2hVu7KZgFRHLnjdoYdaWfeEfYF
	 HxtG1VhTFRlGecRKO1ynACHdEfcU73LZ7ONs7yuBf0qkcD2ADoYCFQcJDG7YgzelKn
	 il7QsNa9358+1KZpc3JD8gDBe33jYtGPUoI8c38EsbF3wqAhW4wejeJKK2LpnDEboQ
	 Sfuj9q1dS7kB2Svx70LAoMQxZFJ3/2CAgNDpFi681jgeIbgJSkxTmPO7yirq8jmwkr
	 28mudHjRMwtmQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 21/30] sysctl: net: use sysctl_field in VRF sysctls
Date: Wed, 26 Aug 2026 21:42:25 +0200
Message-ID: <5b30e0187a4369e0d97864d794c716301c8b1938.1787771905.git.legion@kernel.org>
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

VRF has a single per-net sysctl, but still clones its ctl_table so the
handler can receive the current net namespace through extra1. The copied
table then has to be kept until namespace teardown only to free it after
unregistering the sysctl.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 drivers/net/vrf.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 46209917ae4d..2155297f2f73 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1828,7 +1828,7 @@ static int vrf_strict_mode_change(struct vrf_map *vmap, bool new_mode)
 static int vrf_shared_table_handler(const struct ctl_table *table, int write,
 				    void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = (struct net *)table->extra1;
+	struct net *net = table->data;
 	struct vrf_map *vmap = netns_vrf_map(net);
 	int proc_strict_mode = 0;
 	struct ctl_table tmp = {
@@ -1852,35 +1852,25 @@ static int vrf_shared_table_handler(const struct ctl_table *table, int write,
 	return ret;
 }
 
-static const struct ctl_table vrf_table[] = {
-	{
-		.procname	= "strict_mode",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= vrf_shared_table_handler,
-		/* set by the vrf_netns_init */
-		.extra1		= NULL,
-	},
+static void *vrf_strict_mode_data(const struct sysctl_context *ctx)
+{
+	return ctx->ns.net_ns;
+}
+
+static const struct sysctl_field vrf_table[] = {
+	SYSCTL_FIELD_CUSTOM("strict_mode", 0644, 0, vrf_strict_mode_data,
+			 vrf_shared_table_handler),
 };
 
 static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 {
-	struct ctl_table *table;
-
-	table = kmemdup(vrf_table, sizeof(vrf_table), GFP_KERNEL);
-	if (!table)
-		return -ENOMEM;
-
-	/* init the extra1 parameter with the reference to current netns */
-	table[0].extra1 = net;
-
-	nn_vrf->ctl_hdr = register_net_sysctl_sz(net, "net/vrf", table,
-						 ARRAY_SIZE(vrf_table));
-	if (!nn_vrf->ctl_hdr) {
-		kfree(table);
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
+	nn_vrf->ctl_hdr = register_sysctl_fields(&net->sysctls, "net/vrf",
+						 vrf_table, &ctx);
+	if (!nn_vrf->ctl_hdr)
 		return -ENOMEM;
-	}
 
 	return 0;
 }
@@ -1888,11 +1878,8 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 static void vrf_netns_exit_sysctl(struct net *net)
 {
 	struct netns_vrf *nn_vrf = net_generic(net, vrf_net_id);
-	const struct ctl_table *table;
 
-	table = nn_vrf->ctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(nn_vrf->ctl_hdr);
-	kfree(table);
 }
 #else
 static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
-- 
2.55.0

