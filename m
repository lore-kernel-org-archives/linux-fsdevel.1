Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEA947DF94;
	Wed, 26 Aug 2026 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773433; cv=none; b=Hcb++t05XdjVNF4SW7X3+c5mEY2jThfOLU705bDMtWMp2wwkdyPTJvdPKKbPdl3WxxVe7BWtDLwBGzIs44++8Z9FaU9gAc4yd5DaUyMIzh8bqz4dFSp+k7Zy0iglf9NgqxmQ3ed+n3sttDNTrBUvb3porOFFiGWw3japSbSFXQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773433; c=relaxed/simple;
	bh=f60mGXZB5sOOAvs8dzQ8a/eDEHQPACtKzhOdDaS1h9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbJM3tLcBigSKI4dBjHuRbQpIcmLTcCNlWJ5rzSdEF+Qd9ijImRbqvFEcqpXxr6YdOB1bJuqEiVg86lnPh+2s9T4gA3ImjgXgWKtJMV9VHT1Gh+c4JGsZsxND+Yr6KryzSHCvlXyGMIas2TieNR5KJRbYTIwUx9QOpFm+oFfwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeVEqwiV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeVEqwiV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC8C1F00ACA;
	Wed, 26 Aug 2026 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787773421;
	bh=eyiu7udLv5i61/LYwpyP28r6MVmV7R66+h84SznAt8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SeVEqwiVGGNTtrRhwHQlKlwZ1uwtpNumSE/6KBOOLXJrU9Np48uZRcVyZ+BLD7gOs
	 OjsKngV/uFXvEFsDTIYY7ZrP+VoPqtSW2EPQhxDWXGX6vO9dw6mFVtmtOV9WWgB5sR
	 iZDvhC+VVof0+98IhQNV8AknbfOIjw3rk6eQBo+QpuKfZ6C36HuBBpUgtgudiuHzrj
	 N2Qf4MjlGWvdRDKbSItX3LikYUxUzICiGZb30w6nmzq3OOuutf07iUwIv0USzCvugn
	 NqWYMpS6bbgujMs8A6Mx39PQ5uPRPnqD7O1sJymgU8V4MBuzAL+bAnRhEQ6fxd9Kaf
	 n57r1acT5qSNQ==
From: Alexey Gladkov <legion@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <kees@kernel.org>,
	Joel Granados <joel.granados@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH v1 17/30] sysctl: net: use sysctl_field in SCTP sysctls
Date: Wed, 26 Aug 2026 21:42:21 +0200
Message-ID: <2391afcdd59dc43e287c3992a54541a23a35c1c0.1787771905.git.legion@kernel.org>
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

The SCTP per-net sysctl table is cloned for every network namespace so
that all data pointers can be shifted from init_net to the namespace
being registered. A few entries then rely on table indexes to patch
cross-field limits such as rto_min/rto_max and pf_retrans/ps_retrans.

Use sysctl_field descriptors for the per-net SCTP sysctls instead. The
data and limit pointers are derived from the registration context, so
the table can stay const and the per-net allocation, offset arithmetic,
index-based patching, and free path are no longer needed.

Keep the special validation inside the custom handlers that need it.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 net/sctp/sysctl.c | 505 ++++++++++++++++------------------------------
 1 file changed, 169 insertions(+), 336 deletions(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 15e7db9a3ab2..a3577683b9b9 100644
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
@@ -51,8 +51,10 @@ static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write, void *bu
 				size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write, void *buffer,
 				 size_t *lenp, loff_t *ppos);
-static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
-				   void *buffer, size_t *lenp, loff_t *ppos);
+static int proc_sctp_do_alpha(const struct ctl_table *ctl, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos);
+static int proc_sctp_do_beta(const struct ctl_table *ctl, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos);
 static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
@@ -82,306 +84,138 @@ static struct ctl_table sctp_table[] = {
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
-		.procname	= "rto_min",
-		.data		= &init_net.sctp.rto_min,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_rto_min,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &init_net.sctp.rto_max
-	},
-	[SCTP_RTO_MAX_IDX] =  {
-		.procname	= "rto_max",
-		.data		= &init_net.sctp.rto_max,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_rto_max,
-		.extra1         = &init_net.sctp.rto_min,
-		.extra2         = &timer_max
-	},
-	[SCTP_PF_RETRANS_IDX] = {
-		.procname	= "pf_retrans",
-		.data		= &init_net.sctp.pf_retrans,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &init_net.sctp.ps_retrans,
-	},
-	[SCTP_PS_RETRANS_IDX] = {
-		.procname	= "ps_retrans",
-		.data		= &init_net.sctp.ps_retrans,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &init_net.sctp.pf_retrans,
-		.extra2		= &ps_retrans_max,
-	},
-	{
-		.procname	= "rto_initial",
-		.data		= &init_net.sctp.rto_initial,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
-	},
-	{
-		.procname	= "rto_alpha_exp_divisor",
-		.data		= &init_net.sctp.rto_alpha,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_alpha_beta,
-		.extra1		= &rto_alpha_min,
-		.extra2		= &rto_alpha_max,
-	},
-	{
-		.procname	= "rto_beta_exp_divisor",
-		.data		= &init_net.sctp.rto_beta,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_alpha_beta,
-		.extra1		= &rto_beta_min,
-		.extra2		= &rto_beta_max,
-	},
-	{
-		.procname	= "max_burst",
-		.data		= &init_net.sctp.max_burst,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "cookie_preserve_enable",
-		.data		= &init_net.sctp.cookie_preserve_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "cookie_hmac_alg",
-		.data		= &init_net.sctp.cookie_auth_enable,
-		.maxlen		= 8,
-		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_hmac_alg,
-	},
-	{
-		.procname	= "valid_cookie_life",
-		.data		= &init_net.sctp.valid_cookie_life,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
-	},
-	{
-		.procname	= "sack_timeout",
-		.data		= &init_net.sctp.sack_timeout,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = &sack_timer_min,
-		.extra2         = &sack_timer_max,
-	},
-	{
-		.procname	= "hb_interval",
-		.data		= &init_net.sctp.hb_interval,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1         = SYSCTL_ONE,
-		.extra2         = &timer_max
-	},
-	{
-		.procname	= "association_max_retrans",
-		.data		= &init_net.sctp.max_retrans_association,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "path_max_retrans",
-		.data		= &init_net.sctp.max_retrans_path,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "max_init_retransmits",
-		.data		= &init_net.sctp.max_retrans_init,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_INT_MAX,
-	},
-	{
-		.procname	= "sndbuf_policy",
-		.data		= &init_net.sctp.sndbuf_policy,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "rcvbuf_policy",
-		.data		= &init_net.sctp.rcvbuf_policy,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "default_auto_asconf",
-		.data		= &init_net.sctp.default_auto_asconf,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "addip_enable",
-		.data		= &init_net.sctp.addip_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "addip_noauth_enable",
-		.data		= &init_net.sctp.addip_noauth,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "prsctp_enable",
-		.data		= &init_net.sctp.prsctp_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "reconf_enable",
-		.data		= &init_net.sctp.reconf_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "auth_enable",
-		.data		= &init_net.sctp.auth_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_auth,
-	},
-	{
-		.procname	= "intl_enable",
-		.data		= &init_net.sctp.intl_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "ecn_enable",
-		.data		= &init_net.sctp.ecn_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "plpmtud_probe_interval",
-		.data		= &init_net.sctp.probe_interval,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_probe_interval,
-	},
-	{
-		.procname	= "udp_port",
-		.data		= &init_net.sctp.udp_port,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_sctp_do_udp_port,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &udp_port_max,
-	},
-	{
-		.procname	= "encap_port",
-		.data		= &init_net.sctp.encap_port,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &udp_port_max,
-	},
-	{
-		.procname	= "addr_scope_policy",
-		.data		= &init_net.sctp.scope_policy,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &addr_scope_max,
-	},
-	{
-		.procname	= "rwnd_update_shift",
-		.data		= &init_net.sctp.rwnd_upd_shift,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &rwnd_scale_max,
-	},
-	{
-		.procname	= "max_autoclose",
-		.data		= &init_net.sctp.max_autoclose,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= &proc_doulongvec_minmax,
-		.extra1		= &max_autoclose_min,
-		.extra2		= &max_autoclose_max,
-	},
+static int *sctp_ps_retrans_max_data(const struct sysctl_context *ctx)
+{
+	return &ps_retrans_max;
+}
+
+#define SCTP_DATA(type, field)						\
+static type *sctp_ ## field ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->sctp.field;				\
+}
+
+#define SCTP_CUSTOM_DATA(field)						\
+static void *sctp_ ## field ## _data(const struct sysctl_context *ctx)	\
+{									\
+	return &ctx->ns.net_ns->sctp.field;				\
+}
+
+SCTP_CUSTOM_DATA(rto_min)
+SCTP_CUSTOM_DATA(rto_max)
+SCTP_DATA(int, pf_retrans)
+SCTP_DATA(int, ps_retrans)
+SCTP_DATA(unsigned int, rto_initial)
+SCTP_CUSTOM_DATA(rto_alpha)
+SCTP_CUSTOM_DATA(rto_beta)
+SCTP_DATA(int, max_burst)
+SCTP_DATA(int, cookie_preserve_enable)
+SCTP_CUSTOM_DATA(cookie_auth_enable)
+SCTP_DATA(unsigned int, valid_cookie_life)
+SCTP_DATA(unsigned int, sack_timeout)
+SCTP_DATA(unsigned int, hb_interval)
+SCTP_DATA(int, max_retrans_association)
+SCTP_DATA(int, max_retrans_path)
+SCTP_DATA(int, max_retrans_init)
+SCTP_DATA(int, sndbuf_policy)
+SCTP_DATA(int, rcvbuf_policy)
+SCTP_DATA(int, default_auto_asconf)
+SCTP_DATA(int, addip_enable)
+SCTP_DATA(int, addip_noauth)
+SCTP_DATA(int, prsctp_enable)
+SCTP_DATA(int, reconf_enable)
+SCTP_CUSTOM_DATA(auth_enable)
+SCTP_DATA(int, intl_enable)
+SCTP_DATA(int, ecn_enable)
+SCTP_CUSTOM_DATA(probe_interval)
+SCTP_CUSTOM_DATA(udp_port)
+SCTP_DATA(int, encap_port)
+SCTP_DATA(int, scope_policy)
+SCTP_DATA(int, rwnd_upd_shift)
+SCTP_DATA(unsigned long, max_autoclose)
+SCTP_DATA(int, pf_enable)
+SCTP_DATA(int, pf_expose)
 #ifdef CONFIG_NET_L3_MASTER_DEV
-	{
-		.procname	= "l3mdev_accept",
-		.data		= &init_net.sctp.l3mdev_accept,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
+SCTP_DATA(int, l3mdev_accept)
 #endif
-	{
-		.procname	= "pf_enable",
-		.data		= &init_net.sctp.pf_enable,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	},
-	{
-		.procname	= "pf_expose",
-		.data		= &init_net.sctp.pf_expose,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &pf_expose_max,
-	},
+
+static const struct sysctl_field sctp_net_table[] = {
+	SYSCTL_FIELD_CUSTOM("rto_min", 0644, sizeof(unsigned int),
+			 sctp_rto_min_data, proc_sctp_do_rto_min),
+	SYSCTL_FIELD_CUSTOM("rto_max", 0644, sizeof(unsigned int),
+			 sctp_rto_max_data, proc_sctp_do_rto_max),
+	SYSCTL_FIELD_INT_MINMAX("pf_retrans", 0644, sctp_pf_retrans_data,
+			     SYSCTL_ZERO, sctp_ps_retrans_data),
+	SYSCTL_FIELD_INT_MINMAX("ps_retrans", 0644, sctp_ps_retrans_data,
+			     sctp_pf_retrans_data, sctp_ps_retrans_max_data),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("rto_initial", 0644,
+				     sctp_rto_initial_data,
+				     SYSCTL_UINT_ONE, &timer_max),
+	SYSCTL_FIELD_CUSTOM("rto_alpha_exp_divisor", 0644, sizeof(int),
+			 sctp_rto_alpha_data, proc_sctp_do_alpha),
+	SYSCTL_FIELD_CUSTOM("rto_beta_exp_divisor", 0644, sizeof(int),
+			 sctp_rto_beta_data, proc_sctp_do_beta),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("max_burst", 0644, sctp_max_burst_data,
+				    SYSCTL_ZERO, SYSCTL_INT_MAX),
+	SYSCTL_FIELD_INT("cookie_preserve_enable", 0644,
+		      sctp_cookie_preserve_enable_data),
+	SYSCTL_FIELD_CUSTOM("cookie_hmac_alg", 0644, 8,
+			 sctp_cookie_auth_enable_data, proc_sctp_do_hmac_alg),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("valid_cookie_life", 0644,
+				     sctp_valid_cookie_life_data,
+				     SYSCTL_UINT_ONE, &timer_max),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("sack_timeout", 0644,
+				     sctp_sack_timeout_data,
+				     &sack_timer_min, &sack_timer_max),
+	SYSCTL_FIELD_STATIC_UINT_MINMAX("hb_interval", 0644,
+				     sctp_hb_interval_data,
+				     SYSCTL_UINT_ONE, &timer_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("association_max_retrans", 0644,
+				    sctp_max_retrans_association_data,
+				    SYSCTL_ONE, SYSCTL_INT_MAX),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("path_max_retrans", 0644,
+				    sctp_max_retrans_path_data,
+				    SYSCTL_ONE, SYSCTL_INT_MAX),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("max_init_retransmits", 0644,
+				    sctp_max_retrans_init_data,
+				    SYSCTL_ONE, SYSCTL_INT_MAX),
+	SYSCTL_FIELD_INT("sndbuf_policy", 0644, sctp_sndbuf_policy_data),
+	SYSCTL_FIELD_INT("rcvbuf_policy", 0644, sctp_rcvbuf_policy_data),
+	SYSCTL_FIELD_INT("default_auto_asconf", 0644,
+		      sctp_default_auto_asconf_data),
+	SYSCTL_FIELD_INT("addip_enable", 0644, sctp_addip_enable_data),
+	SYSCTL_FIELD_INT("addip_noauth_enable", 0644, sctp_addip_noauth_data),
+	SYSCTL_FIELD_INT("prsctp_enable", 0644, sctp_prsctp_enable_data),
+	SYSCTL_FIELD_INT("reconf_enable", 0644, sctp_reconf_enable_data),
+	SYSCTL_FIELD_CUSTOM("auth_enable", 0644, sizeof(int),
+			 sctp_auth_enable_data, proc_sctp_do_auth),
+	SYSCTL_FIELD_INT("intl_enable", 0644, sctp_intl_enable_data),
+	SYSCTL_FIELD_INT("ecn_enable", 0644, sctp_ecn_enable_data),
+	SYSCTL_FIELD_CUSTOM("plpmtud_probe_interval", 0644, sizeof(int),
+			 sctp_probe_interval_data,
+			 proc_sctp_do_probe_interval),
+	SYSCTL_FIELD_CUSTOM("udp_port", 0644, sizeof(int),
+			 sctp_udp_port_data, proc_sctp_do_udp_port),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("encap_port", 0644,
+				    sctp_encap_port_data,
+				    SYSCTL_ZERO, &udp_port_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("addr_scope_policy", 0644,
+				    sctp_scope_policy_data,
+				    SYSCTL_ZERO, &addr_scope_max),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("rwnd_update_shift", 0644,
+				    sctp_rwnd_upd_shift_data,
+				    SYSCTL_ONE, &rwnd_scale_max),
+	SYSCTL_FIELD_STATIC_ULONG_MINMAX("max_autoclose", 0644,
+				      sctp_max_autoclose_data,
+				      &max_autoclose_min, &max_autoclose_max),
+#ifdef CONFIG_NET_L3_MASTER_DEV
+	SYSCTL_FIELD_STATIC_INT_MINMAX("l3mdev_accept", 0644,
+				    sctp_l3mdev_accept_data,
+				    SYSCTL_ZERO, SYSCTL_ONE),
+#endif
+	SYSCTL_FIELD_INT("pf_enable", 0644, sctp_pf_enable_data),
+	SYSCTL_FIELD_STATIC_INT_MINMAX("pf_expose", 0644, sctp_pf_expose_data,
+				    SYSCTL_ZERO, &pf_expose_max),
 };
 
 static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
@@ -423,8 +257,6 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.rto_min);
-	unsigned int min = *(unsigned int *) ctl->extra1;
-	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -438,7 +270,7 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 
 	ret = proc_dointvec(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0) {
-		if (new_value > max || new_value < min)
+		if (new_value > (int) net->sctp.rto_max || new_value < 1)
 			return -EINVAL;
 
 		net->sctp.rto_min = new_value;
@@ -451,8 +283,6 @@ static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.rto_max);
-	unsigned int min = *(unsigned int *) ctl->extra1;
-	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -466,7 +296,8 @@ static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 
 	ret = proc_dointvec(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0) {
-		if (new_value > max || new_value < min)
+		if (new_value > (int) timer_max ||
+		    new_value < (int) net->sctp.rto_min)
 			return -EINVAL;
 
 		net->sctp.rto_max = new_value;
@@ -485,6 +316,28 @@ static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 	return proc_dointvec_minmax(ctl, write, buffer, lenp, ppos);
 }
 
+static int proc_sctp_do_alpha(const struct ctl_table *ctl, int write,
+			      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *ctl;
+
+	tmp.extra1 = &rto_alpha_min;
+	tmp.extra2 = &rto_alpha_max;
+
+	return proc_sctp_do_alpha_beta(&tmp, write, buffer, lenp, ppos);
+}
+
+static int proc_sctp_do_beta(const struct ctl_table *ctl, int write,
+			     void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *ctl;
+
+	tmp.extra1 = &rto_beta_min;
+	tmp.extra2 = &rto_beta_max;
+
+	return proc_sctp_do_alpha_beta(&tmp, write, buffer, lenp, ppos);
+}
+
 static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -520,8 +373,6 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = container_of(ctl->data, struct net, sctp.udp_port);
-	unsigned int min = *(unsigned int *)ctl->extra1;
-	unsigned int max = *(unsigned int *)ctl->extra2;
 	struct ctl_table tbl;
 	int ret, new_value;
 
@@ -537,7 +388,7 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 	if (write && ret == 0) {
 		struct sock *sk = net->sctp.ctl_sock;
 
-		if (new_value > max || new_value < min)
+		if (new_value > udp_port_max || new_value < 0)
 			return -EINVAL;
 
 		mutex_lock(&sctp_sysctl_mutex);
@@ -588,38 +439,20 @@ static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
 
 int sctp_sysctl_net_register(struct net *net)
 {
-	size_t table_size = ARRAY_SIZE(sctp_net_table);
-	struct ctl_table *table;
-	int i;
-
-	table = kmemdup(sctp_net_table, sizeof(sctp_net_table), GFP_KERNEL);
-	if (!table)
+	struct sysctl_context ctx = {
+		.ns.net_ns = net,
+	};
+	net->sctp.sysctl_header = register_sysctl_fields(&net->sysctls, "net/sctp",
+							 sctp_net_table, &ctx);
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

