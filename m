Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A22411A02;
	Sat, 29 Aug 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020126; cv=none; b=Hpsrj4+o+f3qktf1WfRjLf7tJNpqtrm+MQLu/e+yOHdtxA9LwC/vfiK/c4X6WiauwC95SEzxy+cfl2YU78KqTF4OReB0zc7DBNEf8homYfmLiyQNO11MdCKaXqsUsnWMZ2ra/lddDp6tSk1gUw1HnjnzN4r9cl6T5V0mYB5+O/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020126; c=relaxed/simple;
	bh=nanfMwRE/IKSShu7CFppH81Mn6jSoU1IlAP538LR6Es=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEQcDbCq3l935zGUI97gJrW/n9udbr1XiPmgTEENjjYnfAHh6NdumWToKnhFZsiwZJmD61YLdup6VObXUiFZ+QI1rxucYUurKIJQ9YWO53d4QqqoG0q3kfKrCK6pLSYNY5xqRjFz8umxzW1P6npwEw2qEesMb5c9rWlOumZ6u6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDQtE2p5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDQtE2p5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACB11F00A3F;
	Sat, 29 Aug 2026 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788020120;
	bh=m1190EdxwG365mAF3KQkH5WDytB+5RdamlixdoE/Ep8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jDQtE2p55n+70v7EzpdUfezLLE5u6FzHW5tPkTh6IxQPKEkLouvGTQVyrZjjF3h5R
	 /EL5hxIDEB/k39Jcxg3OoFUM6a/NKfbaHaBroOcPLdiIkno0+SktrYRpwtRP2KDain
	 3GY9as/akTpkzlUNsXTDgabpXNK0QQ7wtbwXc0sZAfXDJ4ssWzeEuJcDcNTnWrgzAA
	 GVbrvX33w/TsNfA0cIHHb8ExBs6I1Xt22dUYgMygqt9NQ3Lf/cPoTlPVma8jYMVEHK
	 DGuTzpXMVGsv+JLYs7jIejDMIdGu3X+nBj248Rlsu0j23VKo8WQKybD1a3QTVGYBrr
	 yCljMETmMwz+g==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 3/4] sctp: use typed fields for per-net sysctls
Date: Sat, 29 Aug 2026 18:14:46 +0200
Message-ID: <d7cbadc5907b32e418109d906a68b58482289664.1788018958.git.legion@kernel.org>
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

SCTP clones its sysctl table for every network namespace and rewrites
entries by index to install namespace data and dynamic limits. The index
fixups depend on the table order and retain a full ctl_table allocation
per namespace.

Replace the cloned table with static ctl_field descriptors using
checked offsets into struct net. Keep the specialized handlers for
values whose bounds depend on other SCTP settings, and let them
construct the temporary ctl_table arguments required by the existing
proc helpers.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/sctp/sysctl.c | 398 ++++++++++++++++++++++++----------------------
 1 file changed, 206 insertions(+), 192 deletions(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 15e7db9a3ab2..030c7924be05 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -25,9 +25,9 @@
 #include <net/sctp/sctp.h>
 #include <linux/sysctl.h>
 
-static int timer_max = 86400000; /* ms in one day */
-static int sack_timer_min = 1;
-static int sack_timer_max = 500;
+static unsigned int timer_max = 86400000; /* ms in one day */
+static unsigned int sack_timer_min = 1;
+static unsigned int sack_timer_max = 500;
 static int addr_scope_max = SCTP_SCOPE_POLICY_MAX;
 static int rwnd_scale_max = 16;
 static int rto_alpha_min = 0;
@@ -49,10 +49,18 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write, void *buffer,
 				size_t *lenp, loff_t *ppos);
+static int proc_sctp_do_pf_retrans(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos);
+static int proc_sctp_do_ps_retrans(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write, void *buffer,
 				 size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos);
+static int proc_sctp_do_alpha(const struct ctl_table *ctl, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos);
+static int proc_sctp_do_beta(const struct ctl_table *ctl, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
@@ -82,305 +90,285 @@ static struct ctl_table sctp_table[] = {
 	},
 };
 
-/* The following index defines are used in sctp_sysctl_net_register().
- * If you add new items to the sctp_net_table, please ensure that
- * the index values of these defines hold the same meaning indicated by
- * their macro names when they appear in sctp_net_table.
- */
-#define SCTP_RTO_MIN_IDX       0
-#define SCTP_RTO_MAX_IDX       1
-#define SCTP_PF_RETRANS_IDX    2
-#define SCTP_PS_RETRANS_IDX    3
-
-static struct ctl_table sctp_net_table[] = {
-	[SCTP_RTO_MIN_IDX] = {
+static const struct sysctl_field sctp_net_table[] = {
+	{
 		.procname	= "rto_min",
-		.data		= &init_net.sctp.rto_min,
-		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_UINT,
 		.proc_handler	= proc_sctp_do_rto_min,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &init_net.sctp.rto_max
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct net, sctp.rto_min),
 	},
-	[SCTP_RTO_MAX_IDX] =  {
+	{
 		.procname	= "rto_max",
-		.data		= &init_net.sctp.rto_max,
-		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_UINT,
 		.proc_handler	= proc_sctp_do_rto_max,
-		.extra1         = &init_net.sctp.rto_min,
-		.extra2         = &timer_max
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct net, sctp.rto_max),
 	},
-	[SCTP_PF_RETRANS_IDX] = {
+	{
 		.procname	= "pf_retrans",
-		.data		= &init_net.sctp.pf_retrans,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &init_net.sctp.ps_retrans,
+		.type		= SYSCTL_FIELD_INT,
+		.proc_handler	= proc_sctp_do_pf_retrans,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.pf_retrans),
 	},
-	[SCTP_PS_RETRANS_IDX] = {
+	{
 		.procname	= "ps_retrans",
-		.data		= &init_net.sctp.ps_retrans,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &init_net.sctp.pf_retrans,
-		.extra2		= &ps_retrans_max,
+		.type		= SYSCTL_FIELD_INT,
+		.proc_handler	= proc_sctp_do_ps_retrans,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.ps_retrans),
 	},
 	{
 		.procname	= "rto_initial",
-		.data		= &init_net.sctp.rto_initial,
-		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct net, sctp.rto_initial),
+		.uint_limits = {
+			.min_value	= SYSCTL_UINT_ONE,
+			.max_value	= &timer_max,
+		},
 	},
 	{
 		.procname	= "rto_alpha_exp_divisor",
-		.data		= &init_net.sctp.rto_alpha,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_alpha_beta,
-		.extra1		= &rto_alpha_min,
-		.extra2		= &rto_alpha_max,
+		.type		= SYSCTL_FIELD_INT,
+		.proc_handler	= proc_sctp_do_alpha,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.rto_alpha),
 	},
 	{
 		.procname	= "rto_beta_exp_divisor",
-		.data		= &init_net.sctp.rto_beta,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_alpha_beta,
-		.extra1		= &rto_beta_min,
-		.extra2		= &rto_beta_max,
+		.type		= SYSCTL_FIELD_INT,
+		.proc_handler	= proc_sctp_do_beta,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.rto_beta),
 	},
 	{
 		.procname	= "max_burst",
-		.data		= &init_net.sctp.max_burst,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.max_burst),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= SYSCTL_INT_MAX,
+		},
 	},
 	{
 		.procname	= "cookie_preserve_enable",
-		.data		= &init_net.sctp.cookie_preserve_enable,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.cookie_preserve_enable),
 	},
 	{
 		.procname	= "cookie_hmac_alg",
-		.data		= &init_net.sctp.cookie_auth_enable,
-		.maxlen		= 8,
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_INT,
 		.proc_handler	= proc_sctp_do_hmac_alg,
+		.maxlen		= 8,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.cookie_auth_enable),
 	},
 	{
 		.procname	= "valid_cookie_life",
-		.data		= &init_net.sctp.valid_cookie_life,
-		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct net, sctp.valid_cookie_life),
+		.uint_limits = {
+			.min_value	= SYSCTL_UINT_ONE,
+			.max_value	= &timer_max,
+		},
 	},
 	{
 		.procname	= "sack_timeout",
-		.data		= &init_net.sctp.sack_timeout,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &sack_timer_min,
-		.extra2         = &sack_timer_max,
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct net, sctp.sack_timeout),
+		.uint_limits = {
+			.min_value	= &sack_timer_min,
+			.max_value	= &sack_timer_max,
+		},
 	},
 	{
 		.procname	= "hb_interval",
-		.data		= &init_net.sctp.hb_interval,
-		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
+		.type		= SYSCTL_FIELD_UINT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct net, sctp.hb_interval),
+		.uint_limits = {
+			.min_value	= SYSCTL_UINT_ONE,
+			.max_value	= &timer_max,
+		},
 	},
 	{
 		.procname	= "association_max_retrans",
-		.data		= &init_net.sctp.max_retrans_association,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.max_retrans_association),
+		.int_limits = {
+			.min_value	= SYSCTL_ONE,
+			.max_value	= SYSCTL_INT_MAX,
+		},
 	},
 	{
 		.procname	= "path_max_retrans",
-		.data		= &init_net.sctp.max_retrans_path,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.max_retrans_path),
+		.int_limits = {
+			.min_value	= SYSCTL_ONE,
+			.max_value	= SYSCTL_INT_MAX,
+		},
 	},
 	{
 		.procname	= "max_init_retransmits",
-		.data		= &init_net.sctp.max_retrans_init,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.max_retrans_init),
+		.int_limits = {
+			.min_value	= SYSCTL_ONE,
+			.max_value	= SYSCTL_INT_MAX,
+		},
 	},
 	{
 		.procname	= "sndbuf_policy",
-		.data		= &init_net.sctp.sndbuf_policy,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.sndbuf_policy),
 	},
 	{
 		.procname	= "rcvbuf_policy",
-		.data		= &init_net.sctp.rcvbuf_policy,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.rcvbuf_policy),
 	},
 	{
 		.procname	= "default_auto_asconf",
-		.data		= &init_net.sctp.default_auto_asconf,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.default_auto_asconf),
 	},
 	{
 		.procname	= "addip_enable",
-		.data		= &init_net.sctp.addip_enable,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.addip_enable),
 	},
 	{
 		.procname	= "addip_noauth_enable",
-		.data		= &init_net.sctp.addip_noauth,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.addip_noauth),
 	},
 	{
 		.procname	= "prsctp_enable",
-		.data		= &init_net.sctp.prsctp_enable,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.prsctp_enable),
 	},
 	{
 		.procname	= "reconf_enable",
-		.data		= &init_net.sctp.reconf_enable,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.reconf_enable),
 	},
 	{
 		.procname	= "auth_enable",
-		.data		= &init_net.sctp.auth_enable,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_INT,
 		.proc_handler	= proc_sctp_do_auth,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.auth_enable),
 	},
 	{
 		.procname	= "intl_enable",
-		.data		= &init_net.sctp.intl_enable,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.intl_enable),
 	},
 	{
 		.procname	= "ecn_enable",
-		.data		= &init_net.sctp.ecn_enable,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.ecn_enable),
 	},
 	{
 		.procname	= "plpmtud_probe_interval",
-		.data		= &init_net.sctp.probe_interval,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_UINT,
 		.proc_handler	= proc_sctp_do_probe_interval,
+		.data_offset	= SYSCTL_FIELD_UINT_OFFSET(struct net, sctp.probe_interval),
 	},
 	{
 		.procname	= "udp_port",
-		.data		= &init_net.sctp.udp_port,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.type		= SYSCTL_FIELD_INT,
 		.proc_handler	= proc_sctp_do_udp_port,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &udp_port_max,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.udp_port),
 	},
 	{
 		.procname	= "encap_port",
-		.data		= &init_net.sctp.encap_port,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &udp_port_max,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.encap_port),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= &udp_port_max,
+		},
 	},
 	{
 		.procname	= "addr_scope_policy",
-		.data		= &init_net.sctp.scope_policy,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &addr_scope_max,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.scope_policy),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= &addr_scope_max,
+		},
 	},
 	{
 		.procname	= "rwnd_update_shift",
-		.data		= &init_net.sctp.rwnd_upd_shift,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &rwnd_scale_max,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.rwnd_upd_shift),
+		.int_limits = {
+			.min_value	= SYSCTL_ONE,
+			.max_value	= &rwnd_scale_max,
+		},
 	},
 	{
 		.procname	= "max_autoclose",
-		.data		= &init_net.sctp.max_autoclose,
-		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
-		.proc_handler	= &proc_doulongvec_minmax,
-		.extra1		= &max_autoclose_min,
-		.extra2		= &max_autoclose_max,
+		.type		= SYSCTL_FIELD_ULONG_MINMAX,
+		.data_offset	= SYSCTL_FIELD_ULONG_OFFSET(struct net, sctp.max_autoclose),
+		.ulong_limits = {
+			.min_value	= &max_autoclose_min,
+			.max_value	= &max_autoclose_max,
+		},
 	},
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	{
 		.procname	= "l3mdev_accept",
-		.data		= &init_net.sctp.l3mdev_accept,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.l3mdev_accept),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= SYSCTL_ONE,
+		},
 	},
 #endif
 	{
 		.procname	= "pf_enable",
-		.data		= &init_net.sctp.pf_enable,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.type		= SYSCTL_FIELD_INT,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.pf_enable),
 	},
 	{
 		.procname	= "pf_expose",
-		.data		= &init_net.sctp.pf_expose,
-		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &pf_expose_max,
+		.type		= SYSCTL_FIELD_INT_MINMAX,
+		.data_offset	= SYSCTL_FIELD_INT_OFFSET(struct net, sctp.pf_expose),
+		.int_limits = {
+			.min_value	= SYSCTL_ZERO,
+			.max_value	= &pf_expose_max,
+		},
 	},
 };
 
@@ -423,8 +411,6 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.rto_min);
-	unsigned int min = *(unsigned int *) ctl->extra1;
-	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -438,7 +424,7 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 
 	ret = proc_dointvec(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0) {
-		if (new_value > max || new_value < min)
+		if (new_value > net->sctp.rto_max || new_value < 1)
 			return -EINVAL;
 
 		net->sctp.rto_min = new_value;
@@ -451,8 +437,6 @@ static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.rto_max);
-	unsigned int min = *(unsigned int *) ctl->extra1;
-	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -466,7 +450,7 @@ static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 
 	ret = proc_dointvec(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0) {
-		if (new_value > max || new_value < min)
+		if (new_value > timer_max || new_value < net->sctp.rto_min)
 			return -EINVAL;
 
 		net->sctp.rto_max = new_value;
@@ -475,6 +459,30 @@ static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static int proc_sctp_do_pf_retrans(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = container_of(ctl->data, struct net, sctp.pf_retrans);
+	struct ctl_table table = *ctl;
+
+	table.extra1 = SYSCTL_ZERO;
+	table.extra2 = &net->sctp.ps_retrans;
+
+	return proc_dointvec_minmax(&table, write, buffer, lenp, ppos);
+}
+
+static int proc_sctp_do_ps_retrans(const struct ctl_table *ctl, int write,
+				   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct net *net = container_of(ctl->data, struct net, sctp.ps_retrans);
+	struct ctl_table table = *ctl;
+
+	table.extra1 = &net->sctp.pf_retrans;
+	table.extra2 = &ps_retrans_max;
+
+	return proc_dointvec_minmax(&table, write, buffer, lenp, ppos);
+}
+
 static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -485,6 +493,28 @@ static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 	return proc_dointvec_minmax(ctl, write, buffer, lenp, ppos);
 }
 
+static int proc_sctp_do_alpha(const struct ctl_table *ctl, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table table = *ctl;
+
+	table.extra1 = &rto_alpha_min;
+	table.extra2 = &rto_alpha_max;
+
+	return proc_sctp_do_alpha_beta(&table, write, buffer, lenp, ppos);
+}
+
+static int proc_sctp_do_beta(const struct ctl_table *ctl, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table table = *ctl;
+
+	table.extra1 = &rto_beta_min;
+	table.extra2 = &rto_beta_max;
+
+	return proc_sctp_do_alpha_beta(&table, write, buffer, lenp, ppos);
+}
+
 static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -520,8 +550,6 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.udp_port);
-	unsigned int min = *(unsigned int *)ctl->extra1;
-	unsigned int max = *(unsigned int *)ctl->extra2;
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -537,7 +565,7 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 	if (write && ret == 0) {
 		struct sock *sk = net->sctp.ctl_sock;
 
-		if (new_value > max || new_value < min)
+		if (new_value > udp_port_max || new_value < 0)
 			return -EINVAL;
 
 		mutex_lock(&sctp_sysctl_mutex);
@@ -588,38 +616,24 @@ static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
 
 int sctp_sysctl_net_register(struct net *net)
 {
-	size_t table_size = ARRAY_SIZE(sctp_net_table);
-	struct ctl_table *table;
-	int i;
-
-	table = kmemdup(sctp_net_table, sizeof(sctp_net_table), GFP_KERNEL);
-	if (!table)
+	struct sysctl_context ctx = {
+		.type = SYSCTL_CONTEXT_NET_NS,
+		.object_size = sizeof(init_net),
+		.ns.net_ns = net,
+	};
+
+	net->sctp.sysctl_header =
+		register_sysctl_fields(&net->sysctls, "net/sctp", sctp_net_table,
+				       &ctx);
+	if (!net->sctp.sysctl_header)
 		return -ENOMEM;
 
-	for (i = 0; i < table_size; i++)
-		table[i].data += (char *)(&net->sctp) - (char *)&init_net.sctp;
-
-	table[SCTP_RTO_MIN_IDX].extra2 = &net->sctp.rto_max;
-	table[SCTP_RTO_MAX_IDX].extra1 = &net->sctp.rto_min;
-	table[SCTP_PF_RETRANS_IDX].extra2 = &net->sctp.ps_retrans;
-	table[SCTP_PS_RETRANS_IDX].extra1 = &net->sctp.pf_retrans;
-
-	net->sctp.sysctl_header = register_net_sysctl_sz(net, "net/sctp",
-							 table, table_size);
-	if (net->sctp.sysctl_header == NULL) {
-		kfree(table);
-		return -ENOMEM;
-	}
 	return 0;
 }
 
 void sctp_sysctl_net_unregister(struct net *net)
 {
-	const struct ctl_table *table;
-
-	table = net->sctp.sysctl_header->ctl_table_arg;
 	unregister_net_sysctl_table(net->sctp.sysctl_header);
-	kfree(table);
 }
 
 static struct ctl_table_header *sctp_sysctl_header;
-- 
2.55.0

