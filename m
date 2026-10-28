Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205344;
	b=5T1KuFix/rQlpnqL+2A+KIvCG70nZqNh3R3lUFfi2t6DRE6ISs1CmVlLYNiCKQ6EGyoo
	 4dcetyVnPVai3amOhg0H3qWebR9tzNntduNtFuM+KEREaXW4f2wcoqM9QyTq1f8A1azie
	 SSh7cJamd/YOjlBfuGVVdnw7HKJ2eqK/cO8s7taZvi8HToYun2j13yUNVfaH3nv4TpmII
	 MWQyNeiPvPltvuEqEw14NBPOHD/iI5Z7G85peOUlwFqMyti+edVJD9QOGlJDR3Grp2EBW
	 zLNDi9Nj7oVtCBAkPpxyH6wfawxI1N1uJa677xXEGSsOgcfCBkf2MRSaxEZKUGpI2fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205344;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9JdEUPGbMCE1fktlIdBKPOWawov4kHBB2ChElaJdAZA=;
	b=TRzSMMyXZtjdWBGcdrz6k6BXqqjsdf4/2mVozTBNzohJ6aI740LTKgFcUlzImOTIldd3
	 nuaET/uqbRtlaXuVjCIVlIsaHOnX1OnKbv3KuZAzu6XFJdcIyK4L4eogSdwv6aB3ja5je
	 VS1K497vzFMrYkoRioCEmNa1i4rdSHBxMPGklWPWuEU89F8AwAOKXVW21DotmMweFJcvX
	 gPz3T9FNP/2PSaMSr0WbUe6LtAeZHxmTiQQOAyKZPWjHx3EPLt2fbfuD2DM5Zn2xvNR8X
	 gWX5PKWVFzfiGQi6zcj7bEeHp9s43TFk79EWiVxu87lUkkyzgWkXLWCR5uaCx9uX/gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="noexL/9i";
	arc=none smtp.remote-ip=95.215.58.213
Received: from mta1.migadu.com (out-213.mta1.migadu.com [95.215.58.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CA606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9CA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=noexL/9i
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QcGuSWYx3XdSFSNOEQdWQ08MXw6ala3dY6ClqK65UZ4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205341; v=1; x=1793810141;
 b=noexL/9iu8YcUKjv7O6aWxxAX/sOe2j/b8Rmb8AS3euIM1nWyfpXg6yeGE+DoP3DK/BFNtYK
 C9Otl5KQXCY3mTyvHEkQLAHapz5e6BUiWBe/lkOnPGskLhza/kFO0zAkz5ZEgPwNZJJqJbTapEi
 N3p3oYXuxnWtyo6UWzvOAD+A=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 27a1a60eb98862bf;
	Wed, 28 Oct 2026 16:35:40 +0000
X-Mizu-Trace-ID: 27a1a60eb98862bf
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/39] sysctl: replace overloaded extra pointers with typed bounds and context
Date: Thu, 29 Oct 2026 00:34:40 +0800
Message-Id: <fec089bb7a3ea62a5e2006cf578b1efec2df4aff.1793204511.git.wen.yang@linux.dev>
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

struct ctl_table has two untyped misc pointers, extra1 and extra2, whose
meaning depends on the handler that reads them. In-tree use has grown to
cover at least seven unrelated jobs: a fixed bound, a bound read through a
pointer on every call, an object or namespace pointer, a small integer
cookie encoded into the pointer, a lock signal, NULL standing for "no
bound", and a value the core itself casts to unsigned int while validating
a u8 range. Nothing in the entry says which job applies, so readers and
writers have to infer it from the handler, and the core itself gets it
wrong where it treats extra1 as an unsigned int.

The overloading is also a memory-safety hazard. An entry that stores
handler context in data cannot be handed to a standard handler without
first restoring the real storage, because proc_dointvec() writes through
data. Every call site has to remember the restore, and one that forgets
turns a user-supplied integer into a write over a kernel pointer. nf_log
reaches the same problem from the other side: it replaces data with a
local buffer inside a single handler, so data means two things within one
function.

Replace both jobs with two fields that cannot be confused:

  - min/max hold numeric bounds by value. Signed handlers read them as
    signed longs; an absent endpoint is the type limit, not NULL, so zero
    stays a real bound. A range that changes at run time is refreshed
    before every call instead of being snapshotted at registration.

  - priv holds handler context. The core never reads it, standard handlers
    never touch it, and registration rejects it on a standard handler so
    context cannot be silently ignored. data and maxlen keep the meaning
    their handler gives them, including proc_dostring() name lengths and
    proc_do_large_bitmap() bit counts.

The range converters read min/max whenever extra1 and extra2 are both
clear, and keep reading the pointers while they are set. That lets callers
migrate one subsystem at a time without renaming handlers or adding a
parallel API: the existing proc_*_minmax entry points keep their names and
gain numeric semantics as entries drop their extras. Entries that already
relied on NULL meaning "no bound" now state their type limits explicitly,
so their behaviour does not change and the meaning of zero stays
unambiguous.

This patch is the refactor itself. The next patch converts the debug test
module to numeric bounds as the first user, and the KUnit suite after it
makes the contract executable; everything after those is migration of
existing users and adds no new semantics: fixed bounds become numeric
values, run-time bounds are refreshed per call, context moves off data, and
the extra pointers and the compatibility read are removed once the last
user is gone. Owners that can still be recovered from data keep using
container_of(); priv is only for entries where no derivation exists.

Replacing the two pointers with unsigned long min/max follows Eric
Biederman's suggestion; priv is added here because the same pair of fields
also carries handler context, which a numeric bound cannot express.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 arch/powerpc/platforms/pseries/mobility.c |  3 +
 arch/x86/kernel/setup.c                   |  3 +
 fs/aio.c                                  |  5 ++
 fs/pipe.c                                 |  5 ++
 fs/proc/proc_sysctl.c                     | 44 +++++++++----
 include/linux/sysctl.h                    | 11 ++--
 ipc/ipc_sysctl.c                          |  5 ++
 kernel/sysctl.c                           | 36 ++++++-----
 lib/test_sysctl.c                         |  3 +
 mm/util.c                                 |  5 ++
 net/ieee802154/6lowpan/reassembly.c       |  5 ++
 net/ipv4/ip_fragment.c                    |  5 ++
 net/ipv4/sysctl_net_ipv4.c                | 79 +++++++++++++++++++++++
 net/ipv6/icmp.c                           |  7 ++
 net/ipv6/netfilter/nf_conntrack_reasm.c   |  5 ++
 net/ipv6/reassembly.c                     |  5 ++
 net/ipv6/sysctl_net_ipv6.c                | 13 ++++
 net/mptcp/ctrl.c                          |  5 ++
 net/netfilter/ipvs/ip_vs_ctl.c            |  3 +
 net/netfilter/nf_conntrack_standalone.c   |  3 +
 net/rds/ib_sysctl.c                       |  3 +
 net/sctp/sysctl.c                         |  3 +
 net/tipc/sysctl.c                         |  5 ++
 23 files changed, 230 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index b5c2abd12432..294897f3fbb5 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "mobility: " fmt
 
 #include <linux/cpu.h>
+#include <linux/limits.h>
 #include <linux/kernel.h>
 #include <linux/kobject.h>
 #include <linux/nmi.h>
@@ -61,6 +62,8 @@ static const struct ctl_table nmi_wd_lpm_factor_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
+		.min		= 0,
+		.max		= UINT_MAX,
 	},
 };
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index e352e46ef2e5..91c49c9eeaed 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -6,6 +6,7 @@
  * parts of early kernel initialization.
  */
 #include <linux/acpi.h>
+#include <linux/limits.h>
 #include <linux/bootconfig.h>
 #include <linux/console.h>
 #include <linux/cpu.h>
@@ -199,6 +200,8 @@ static const struct ctl_table x86_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 #endif
 };
diff --git a/fs/aio.c b/fs/aio.c
index 8a62b770a70e..2ae0fcc00f78 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/time.h>
@@ -243,6 +244,8 @@ static const struct ctl_table aio_sysctls[] = {
 		.maxlen		= sizeof(aio_nr),
 		.mode		= 0444,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "aio-max-nr",
@@ -250,6 +253,8 @@ static const struct ctl_table aio_sysctls[] = {
 		.maxlen		= sizeof(aio_max_nr),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 };
 
diff --git a/fs/pipe.c b/fs/pipe.c
index 4fa69192e6fb..c41ab753c893 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/limits.h>
 #include <linux/file.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
@@ -1604,6 +1605,8 @@ static const struct ctl_table fs_pipe_sysctls[] = {
 		.maxlen		= sizeof(pipe_user_pages_hard),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "pipe-user-pages-soft",
@@ -1611,6 +1614,8 @@ static const struct ctl_table fs_pipe_sysctls[] = {
 		.maxlen		= sizeof(pipe_user_pages_soft),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 };
 #endif
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c0859c66563..3e65d75710df 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1132,6 +1132,13 @@ static int sysctl_check_table_array(const char *path, const struct ctl_table *ta
 		}
 	}
 
+	/* Numeric bounds are validated alongside the legacy pointer form. */
+	if (table->proc_handler == proc_dou8vec_minmax) {
+		if (table->min > 255U || table->max > 255U)
+			err |= sysctl_err(path, table,
+					 "range value too large for proc_dou8vec_minmax");
+	}
+
 	if (table->proc_handler == proc_dobool) {
 		if (table->maxlen != sizeof(bool))
 			err |= sysctl_err(path, table, "array not allowed");
@@ -1140,31 +1147,44 @@ static int sysctl_check_table_array(const char *path, const struct ctl_table *ta
 	return err;
 }
 
+/* Standard handlers only interpret data, maxlen and min/max. */
+static bool sysctl_is_standard_handler(proc_handler *handler)
+{
+	return handler == proc_dostring ||
+	       handler == proc_dobool ||
+	       handler == proc_dointvec ||
+	       handler == proc_douintvec ||
+	       handler == proc_dointvec_jiffies ||
+	       handler == proc_dointvec_userhz_jiffies ||
+	       handler == proc_dointvec_ms_jiffies ||
+	       handler == proc_dointvec_minmax ||
+	       handler == proc_douintvec_minmax ||
+	       handler == proc_doulongvec_minmax ||
+	       handler == proc_dou8vec_minmax ||
+	       handler == proc_doulongvec_ms_jiffies_minmax;
+}
+
 static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 {
 	const struct ctl_table *entry;
+	bool standard;
 	int err = 0;
 	list_for_each_table_entry(entry, header) {
 		if (!entry->procname)
 			err |= sysctl_err(path, entry, "procname is null");
-		if ((entry->proc_handler == proc_dostring) ||
-		    (entry->proc_handler == proc_dobool) ||
-		    (entry->proc_handler == proc_dointvec) ||
-		    (entry->proc_handler == proc_douintvec) ||
-		    (entry->proc_handler == proc_douintvec_minmax) ||
-		    (entry->proc_handler == proc_dointvec_minmax) ||
-		    (entry->proc_handler == proc_dou8vec_minmax) ||
-		    (entry->proc_handler == proc_dointvec_jiffies) ||
-		    (entry->proc_handler == proc_dointvec_userhz_jiffies) ||
-		    (entry->proc_handler == proc_dointvec_ms_jiffies) ||
-		    (entry->proc_handler == proc_doulongvec_minmax) ||
-		    (entry->proc_handler == proc_doulongvec_ms_jiffies_minmax)) {
+		standard = sysctl_is_standard_handler(entry->proc_handler);
+		if (standard) {
 			if (!entry->data)
 				err |= sysctl_err(path, entry, "No data");
 			if (!entry->maxlen)
 				err |= sysctl_err(path, entry, "No maxlen");
 			else
 				err |= sysctl_check_table_array(path, entry);
+			/* priv belongs to custom handlers; catching this
+			 * early keeps context from being silently ignored.
+			 */
+			if (entry->priv)
+				err |= sysctl_err(path, entry, "priv requires a custom handler");
 		}
 		if (!entry->proc_handler)
 			err |= sysctl_err(path, entry, "No proc_handler");
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e5d7226ab6f5..225c07faf2c9 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -221,13 +221,16 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys */
-	void *data;
-	int maxlen;
+	void *data;			/* Value or buffer; handler-defined */
+	int maxlen;			/* Length; handler-defined */
 	umode_t mode;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-	void *extra1;
-	void *extra2;
+	void *extra1;			/* Deprecated; being removed */
+	void *extra2;			/* Deprecated; being removed */
+	unsigned long min;
+	unsigned long max;
+	void *priv;			/* Handler context, never used by the core */
 } __randomize_layout;
 
 struct ctl_node {
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index d038d944257f..e02e2ea70907 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/limits.h>
 #include <linux/ipc.h>
 #include <linux/nsproxy.h>
 #include <linux/sysctl.h>
@@ -80,6 +81,8 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmax),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "shmall",
@@ -87,6 +90,8 @@ static const struct ctl_table ipc_sysctls[] = {
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlall),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "shmmni",
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index f5145b32f6be..7d0bcd2b24ef 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -423,11 +423,15 @@ int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
 		ret = user_to_kern(u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if ((tbl->extra1 &&
-		     *(uint *)tbl->extra1 > tmp_k) ||
-		    (tbl->extra2 &&
-		     *(uint *)tbl->extra2 < tmp_k))
+		if (tbl->extra1 || tbl->extra2) {
+			if ((tbl->extra1 &&
+			     *(uint *)tbl->extra1 > tmp_k) ||
+			    (tbl->extra2 &&
+			     *(uint *)tbl->extra2 < tmp_k))
+				return -ERANGE;
+		} else if (tbl->min > tmp_k || tbl->max < tmp_k) {
 			return -ERANGE;
+		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(u_ptr, k_ptr);
@@ -543,17 +547,19 @@ int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
 		ret = user_to_kern(negp, u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
-		    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
+		if (tbl->extra1 || tbl->extra2) {
+			if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
+			    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
+				return -EINVAL;
+		} else if ((long)tbl->min > tmp_k || (long)tbl->max < tmp_k) {
 			return -EINVAL;
+		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(negp, u_ptr, k_ptr);
 	return 0;
 }
 
-
-
 static int sysctl_user_to_kern_int_conv(const bool *negp, const ulong *u_ptr,
 					int *k_ptr)
 {
@@ -985,7 +991,7 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 			void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table tmp;
-	unsigned int min = 0, max = 255U, val;
+	unsigned int val;
 	u8 *data = table->data;
 	int res;
 
@@ -997,10 +1003,6 @@ int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
 
 	tmp.maxlen = sizeof(val);
 	tmp.data = &val;
-	if (!tmp.extra1)
-		tmp.extra1 = (unsigned int *) &min;
-	if (!tmp.extra2)
-		tmp.extra2 = (unsigned int *) &max;
 
 	val = READ_ONCE(*data);
 	res = proc_douintvec_minmax(&tmp, dir, buffer, lenp, ppos);
@@ -1045,9 +1047,13 @@ int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
 		ret = user_to_kern(u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if ((tbl->extra1 && *(ulong *)tbl->extra1 > tmp_k) ||
-		    (tbl->extra2 && *(ulong *)tbl->extra2 < tmp_k))
+		if (tbl->extra1 || tbl->extra2) {
+			if ((tbl->extra1 && *(ulong *)tbl->extra1 > tmp_k) ||
+			    (tbl->extra2 && *(ulong *)tbl->extra2 < tmp_k))
+				return -ERANGE;
+		} else if (tbl->min > tmp_k || tbl->max < tmp_k) {
 			return -ERANGE;
+		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(u_ptr, k_ptr);
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 65ce42346170..eed2cc1bea82 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -15,6 +15,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
+#include <linux/limits.h>
 #include <linux/jiffies.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -217,6 +218,8 @@ static const struct ctl_table test_table_unregister[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
+		.min		= INT_MIN,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/mm/util.c b/mm/util.c
index 8acfe2148ba5..2f2bc521868a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/mm.h>
+#include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/compiler.h>
@@ -880,6 +881,8 @@ static const struct ctl_table util_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_user_reserve_kbytes),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "admin_reserve_kbytes",
@@ -887,6 +890,8 @@ static const struct ctl_table util_sysctl_table[] = {
 		.maxlen		= sizeof(sysctl_admin_reserve_kbytes),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 };
 
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index ddb6a5817d09..a2167f76ecc3 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -10,6 +10,7 @@
 #define pr_fmt(fmt) "6LoWPAN: " fmt
 
 #include <linux/net.h>
+#include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
 #include <linux/random.h>
@@ -332,12 +333,16 @@ static struct ctl_table lowpan_frags_ns_ctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "6lowpanfrag_low_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "6lowpanfrag_time",
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index c790d2f49487..75bc675e5579 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -24,6 +24,7 @@
 #define pr_fmt(fmt) "IPv4: " fmt
 
 #include <linux/compiler.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/mm.h>
@@ -551,12 +552,16 @@ static struct ctl_table ip4_frags_ns_ctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "ipfrag_low_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "ipfrag_time",
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index e3760daa3470..2ed9f59ea747 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/sysctl.h>
+#include <linux/limits.h>
 #include <linux/seqlock.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -564,6 +565,8 @@ static struct ctl_table ipv4_table[] = {
 		.data		= &sysctl_tcp_mem,
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "tcp_low_latency",
@@ -614,6 +617,8 @@ static struct ctl_table ipv4_table[] = {
 		.maxlen		= sizeof(sysctl_udp_mem),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "fib_sync_mem",
@@ -778,6 +783,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "ip_early_demux",
@@ -785,6 +792,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname       = "udp_early_demux",
@@ -792,6 +801,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
+		.min           = 0,
+		.max           = U8_MAX,
 	},
 	{
 		.procname       = "tcp_early_demux",
@@ -799,6 +810,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
+		.min           = 0,
+		.max           = U8_MAX,
 	},
 	{
 		.procname       = "nexthop_compat_mode",
@@ -845,6 +858,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "ip_forward_use_pmtu",
@@ -852,6 +867,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "ip_forward_update_priority",
@@ -868,6 +885,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "ip_autobind_reuse",
@@ -884,6 +903,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_fwmark_accept",
@@ -891,6 +912,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	{
@@ -909,6 +932,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_base_mss",
@@ -956,6 +981,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "igmp_max_memberships",
@@ -1013,6 +1040,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_keepalive_intvl",
@@ -1036,6 +1065,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 #ifdef CONFIG_SYN_COOKIES
 	{
@@ -1044,6 +1075,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 #endif
 	{
@@ -1078,6 +1111,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_orphan_retries",
@@ -1085,6 +1120,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_fin_timeout",
@@ -1212,6 +1249,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_window_scaling",
@@ -1219,6 +1258,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_timestamps",
@@ -1226,6 +1267,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_early_retrans",
@@ -1242,6 +1285,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname       = "tcp_thin_linear_timeouts",
@@ -1249,6 +1294,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
+		.min           = 0,
+		.max           = U8_MAX,
 	},
 	{
 		.procname	= "tcp_slow_start_after_idle",
@@ -1256,6 +1303,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_retrans_collapse",
@@ -1263,6 +1312,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_stdurg",
@@ -1270,6 +1321,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_rfc1337",
@@ -1277,6 +1330,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_abort_on_overflow",
@@ -1284,6 +1339,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_fack",
@@ -1291,6 +1348,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_max_reordering",
@@ -1306,6 +1365,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_app_win",
@@ -1331,6 +1392,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_no_metrics_save",
@@ -1338,6 +1401,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_no_ssthresh_metrics_save",
@@ -1354,6 +1419,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_rcvbuf_low_rtt",
@@ -1370,6 +1437,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_workaround_signed_windows",
@@ -1377,6 +1446,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_limit_output_bytes",
@@ -1406,6 +1477,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "tcp_min_rtt_wlen",
@@ -1472,6 +1545,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "tcp_comp_sack_rtt_percent",
@@ -1488,6 +1563,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "tcp_comp_sack_nr",
@@ -1601,6 +1678,8 @@ static const struct ctl_table ipv4_net_table[] = {
 		.maxlen         = sizeof(u8),
 		.mode           = 0644,
 		.proc_handler   = proc_dou8vec_minmax,
+		.min           = 0,
+		.max           = U8_MAX,
 	},
 	{
 		.procname       = "tcp_plb_cong_thresh",
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a95b0351824f..1ba2ff759075 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -28,6 +28,7 @@
 #define pr_fmt(fmt) "IPv6: " fmt
 
 #include <linux/module.h>
+#include <linux/limits.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/socket.h>
@@ -1388,6 +1389,8 @@ static const struct ctl_table ipv6_icmp_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler = proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "echo_ignore_multicast",
@@ -1395,6 +1398,8 @@ static const struct ctl_table ipv6_icmp_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler = proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "echo_ignore_anycast",
@@ -1402,6 +1407,8 @@ static const struct ctl_table ipv6_icmp_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler = proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "ratemask",
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index be72c4346f8b..1f3ba85f6dca 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt) "IPv6-nf: " fmt
 
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/net.h>
@@ -55,12 +56,16 @@ static struct ctl_table nf_ct_frag6_sysctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "nf_conntrack_frag6_high_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 };
 
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index a7964125c764..70c845385744 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -26,6 +26,7 @@
 #define pr_fmt(fmt) "IPv6: " fmt
 
 #include <linux/errno.h>
+#include <linux/limits.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/socket.h>
@@ -427,12 +428,16 @@ static struct ctl_table ip6_frags_ns_ctl_table[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "ip6frag_low_thresh",
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "ip6frag_time",
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 1a0a36dcdabc..c870a364de60 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/mm.h>
+#include <linux/limits.h>
 #include <linux/sysctl.h>
 #include <linux/in6.h>
 #include <linux/ipv6.h>
@@ -68,6 +69,8 @@ static const struct ctl_table ipv6_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "anycast_src_echo_reply",
@@ -75,6 +78,8 @@ static const struct ctl_table ipv6_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "flowlabel_consistency",
@@ -82,6 +87,8 @@ static const struct ctl_table ipv6_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "auto_flowlabels",
@@ -97,6 +104,8 @@ static const struct ctl_table ipv6_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "idgen_retries",
@@ -118,6 +127,8 @@ static const struct ctl_table ipv6_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "ip_nonlocal_bind",
@@ -125,6 +136,8 @@ static const struct ctl_table ipv6_table_template[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	{
 		.procname	= "flowlabel_reflect",
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 63c5747f0f63..e5a5995c5753 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -6,6 +6,7 @@
 
 #ifdef CONFIG_SYSCTL
 #include <linux/sysctl.h>
+#include <linux/limits.h>
 #endif
 
 #include <net/net_namespace.h>
@@ -317,6 +318,8 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.maxlen = sizeof(unsigned int),
 		.mode = 0644,
 		.proc_handler = proc_douintvec_minmax,
+		.min = 0,
+		.max = UINT_MAX,
 	},
 	{
 		.procname = "pm_type",
@@ -356,6 +359,8 @@ static struct ctl_table mptcp_sysctl_table[] = {
 		.maxlen = sizeof(u8),
 		.mode = 0644,
 		.proc_handler = proc_dou8vec_minmax,
+		.min = 0,
+		.max = U8_MAX,
 	},
 	{
 		.procname = "path_manager",
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index ce9fe20d6106..6c29a901d139 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -16,6 +16,7 @@
 #define pr_fmt(fmt) "IPVS: " fmt
 
 #include <linux/module.h>
+#include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/capability.h>
@@ -2778,6 +2779,8 @@ static struct ctl_table vs_vars[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "sync_sock_size",
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index d88a10230862..561db3aecada 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
+#include <linux/limits.h>
 #include <linux/netfilter.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -821,6 +822,8 @@ static const struct ctl_table nf_ct_sysctl_table[] = {
 		.maxlen		= sizeof(u8),
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
+		.min		= 0,
+		.max		= U8_MAX,
 	},
 	[NF_SYSCTL_CT_PROTO_TIMEOUT_UDP] = {
 		.procname	= "nf_conntrack_udp_timeout",
diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
index 2af678e71e3c..b7757f31001c 100644
--- a/net/rds/ib_sysctl.c
+++ b/net/rds/ib_sysctl.c
@@ -31,6 +31,7 @@
  *
  */
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/sysctl.h>
 #include <linux/proc_fs.h>
 
@@ -95,6 +96,8 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.maxlen         = sizeof(unsigned long),
 		.mode           = 0644,
 		.proc_handler   = proc_doulongvec_minmax,
+		.min           = 0,
+		.max           = ULONG_MAX,
 	},
 	{
 		.procname	= "flow_control",
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 2b94c211427d..59c6f22337ea 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -24,6 +24,7 @@
 #include <net/sctp/structs.h>
 #include <net/sctp/sctp.h>
 #include <linux/sysctl.h>
+#include <linux/limits.h>
 
 static int timer_max = 86400000; /* ms in one day */
 static int sack_timer_min = 1;
@@ -65,6 +66,8 @@ static struct ctl_table sctp_table[] = {
 		.maxlen		= sizeof(sysctl_sctp_mem),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "sctp_rmem",
diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
index 30d2e06e3d8c..8352c790c8fe 100644
--- a/net/tipc/sysctl.c
+++ b/net/tipc/sysctl.c
@@ -38,6 +38,7 @@
 #include "crypto.h"
 #include "bcast.h"
 #include <linux/sysctl.h>
+#include <linux/limits.h>
 
 static struct ctl_table_header *tipc_ctl_hdr;
 
@@ -64,6 +65,8 @@ static struct ctl_table tipc_table[] = {
 		.maxlen         = sizeof(sysctl_tipc_sk_filter),
 		.mode           = 0644,
 		.proc_handler   = proc_doulongvec_minmax,
+		.min           = 0,
+		.max           = ULONG_MAX,
 	},
 #ifdef CONFIG_TIPC_CRYPTO
 	{
@@ -90,6 +93,8 @@ static struct ctl_table tipc_table[] = {
 		.maxlen		= sizeof(sysctl_tipc_bc_retruni),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 };
 
-- 
2.25.1

