Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205547;
	b=fK9DUcHKLKQbsnZJeeFEf8nyyyub2BH8qJpPGFOR+Ii1Ejt89XFfg0ffa2PV20635tuC
	 YrJ1XTrKgg2zkR/Nv3dGIk73k7FGKJrmf6HJz0VL5RaueGStuFbXwo6t1PDVfwt35cze9
	 Gy77Sy1H3zBcA9WcAWzGuFSdvWAlDPuc2HnKMTLLlHiVGgJjwiDgIEtxYdS82s1mUDL7c
	 p5c2soAOaHJgJql7DmNbGxkjCyBbCzrq1c1+FXCowm6XTCbTzrajCwMN9+lXvF9ZDhpHP
	 GjS3MFJ9SkoskBotJmm50V62bO5umRKq+1JVCVMjXBniRo8cfbieWx2J0b6KwA/nvUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205547;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FJEE2c6fP9+vbVlsO1bTu5Zo4jN7YBVTgORfgVG+93g=;
	b=OF8Vmk3cdbAC0K6ukveH3F2XSOFIn6pJ4cib1HUexS4LareD8bj9Ige2ilJudLxOaO7/
	 jg73ql7mwjuZWYdpDJ/T0ftzfprJroyUjQaaVMCF8viNiwQaZx7+MNYM3JAddBwQ7Qw9z
	 y1VyjPTECflmyep3R8mWz/VqoGSi0oYi6a5UOWGFBFJ63BH+ZcmxD2ERpfI5Vxhc66bC2
	 AK3mKn9J5Iyu2qU8bb5uEeX8YNlYCbTu3GHhBryynI/cQc2d76SuMV/C88JN78232pbar
	 myIGz67kgusJfChSqNWwLZA0vkQd0mDrqtK2J+0VBUGC99KE85VKIFSer1d01Pk4Rgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Ofi8Y/gZ";
	arc=none smtp.remote-ip=91.218.175.97
Received: from mta0.migadu.com (out-97.mta0.migadu.com [91.218.175.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01602606A5D5
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01602606A5D5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ofi8Y/gZ
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9nz2xhM4HVaiKvtJZUjKlU0KmR1aLdEGIfS80MTL+oU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205545; v=1; x=1793810345;
 b=Ofi8Y/gZVDgBRPjmaAtBt98Kwh4e32GseE3p0zu29UpaGeJ8OqQpgUkKvcC4VLFOjGPnfwbF
 DPmjCVrj7kwt9o4cuk3Y0Vt/nxjRvARposZHbhtniKTPwucJ+4LvgVSOffnUtytCJYyiQ0pId9e
 dAlZX0SRXGCxGmpJMp74E24I=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 3e398e7a4f6b45ca;
	Wed, 28 Oct 2026 16:39:05 +0000
X-Mizu-Trace-ID: 3e398e7a4f6b45ca
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 39/39] sysctl: remove the extra pointers and the compatibility bounds read
Date: Thu, 29 Oct 2026 00:35:18 +0800
Message-Id: <b6e4cbd509687301a8ee2106f19a3ac01e7671a6.1793204511.git.wen.yang@linux.dev>
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

Every entry now carries numeric min/max, so the pointer bounds have no
remaining users. Drop extra1 and extra2 from struct ctl_table, remove the
pointer branch from the range converters, and delete the shared pointer
constants that only existed to initialise those fields.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 fs/proc/proc_sysctl.c  | 26 ++++-------------
 include/linux/sysctl.h | 65 +++++++++++++++++++-----------------------
 kernel/sysctl.c        | 47 ++++++++----------------------
 kernel/time/jiffies.c  |  2 +-
 lib/test_sysctl.c      | 24 ++++++++--------
 5 files changed, 59 insertions(+), 105 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 3e65d75710df..dbbc94b61b71 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1105,7 +1105,6 @@ static int sysctl_err(const char *path, const struct ctl_table *table, char *fmt
 
 static int sysctl_check_table_array(const char *path, const struct ctl_table *table)
 {
-	unsigned int extra;
 	int err = 0;
 
 	if ((table->proc_handler == proc_douintvec) ||
@@ -1117,23 +1116,6 @@ static int sysctl_check_table_array(const char *path, const struct ctl_table *ta
 	if (table->proc_handler == proc_dou8vec_minmax) {
 		if (table->maxlen != sizeof(u8))
 			err |= sysctl_err(path, table, "array not allowed");
-
-		if (table->extra1) {
-			extra = *(unsigned int *) table->extra1;
-			if (extra > 255U)
-				err |= sysctl_err(path, table,
-						"range value too large for proc_dou8vec_minmax");
-		}
-		if (table->extra2) {
-			extra = *(unsigned int *) table->extra2;
-			if (extra > 255U)
-				err |= sysctl_err(path, table,
-						"range value too large for proc_dou8vec_minmax");
-		}
-	}
-
-	/* Numeric bounds are validated alongside the legacy pointer form. */
-	if (table->proc_handler == proc_dou8vec_minmax) {
 		if (table->min > 255U || table->max > 255U)
 			err |= sysctl_err(path, table,
 					 "range value too large for proc_dou8vec_minmax");
@@ -1366,9 +1348,11 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * type     - Defines the target type (described in struct definition)
  * proc_handler - the text handler routine (described below)
  *
- * extra1, extra2 - extra pointers usable by the proc handler routines
- * XXX: we should eventually modify these to use long min / max [0]
- * [0] https://lkml.kernel.org/87zgpte9o4.fsf@email.froward.int.ebiederm.org
+ * min, max - numeric bounds used by range-checking handlers. Signed handlers
+ *            interpret these values as signed longs. Unrestricted ranges must
+ *            explicitly use the corresponding type limits. Custom handlers
+ *            keep their context in data and can substitute backing storage
+ *            on an invocation-local copy without changing these bounds.
  *
  * Leaf nodes in the sysctl tree will be represented by a single file
  * under /proc; non-leaf nodes are not allowed.
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 225c07faf2c9..9cda53941e22 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -37,27 +37,22 @@ struct ctl_table_root;
 struct ctl_table_header;
 struct ctl_dir;
 
-/* Keep the same order as in fs/proc/proc_sysctl.c */
-#define SYSCTL_ZERO			((void *)&sysctl_vals[0])
-#define SYSCTL_ONE			((void *)&sysctl_vals[1])
-#define SYSCTL_TWO			((void *)&sysctl_vals[2])
-#define SYSCTL_THREE			((void *)&sysctl_vals[3])
-#define SYSCTL_FOUR			((void *)&sysctl_vals[4])
-#define SYSCTL_ONE_HUNDRED		((void *)&sysctl_vals[5])
-#define SYSCTL_TWO_HUNDRED		((void *)&sysctl_vals[6])
-#define SYSCTL_ONE_THOUSAND		((void *)&sysctl_vals[7])
-#define SYSCTL_THREE_THOUSAND		((void *)&sysctl_vals[8])
-#define SYSCTL_INT_MAX			((void *)&sysctl_vals[9])
-
-/* this is needed for the proc_dointvec_minmax for [fs_]overflow UID and GID */
-#define SYSCTL_MAXOLDUID		((void *)&sysctl_vals[10])
-#define SYSCTL_NEG_ONE			((void *)&sysctl_vals[11])
-
-extern const int sysctl_vals[];
-
-#define SYSCTL_LONG_ZERO	((void *)&sysctl_long_vals[0])
-#define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
-#define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
+/* Numeric constants for sysctl ranges. */
+#define SYSCTL_ZERO			0
+#define SYSCTL_ONE			1
+#define SYSCTL_TWO			2
+#define SYSCTL_THREE			3
+#define SYSCTL_FOUR			4
+#define SYSCTL_ONE_HUNDRED		100
+#define SYSCTL_TWO_HUNDRED		200
+#define SYSCTL_ONE_THOUSAND		1000
+#define SYSCTL_THREE_THOUSAND		3000
+#define SYSCTL_INT_MAX			INT_MAX
+#define SYSCTL_MAXOLDUID		65535
+#define SYSCTL_NEG_ONE			(-1)
+#define SYSCTL_LONG_ZERO		0UL
+#define SYSCTL_LONG_ONE			1UL
+#define SYSCTL_LONG_MAX			LONG_MAX
 
 /*
  *
@@ -72,8 +67,6 @@ extern const int sysctl_vals[];
 #define SYSCTL_USER_TO_KERN(dir) (!!(dir))
 #define SYSCTL_KERN_TO_USER(dir) (!dir)
 
-extern const unsigned long sysctl_long_vals[];
-
 typedef int proc_handler(const struct ctl_table *ctl, int dir, void *buf,
 			 size_t *lenp, loff_t *ppos);
 
@@ -84,16 +77,17 @@ int proc_dobool(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
 		loff_t *ppos);
 int proc_dointvec(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
 		  loff_t *ppos);
-int proc_dointvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
-			 size_t *lenp, loff_t *ppos);
 int proc_douintvec(const struct ctl_table *ctl, int dir, void *buf, size_t *lenp,
 		   loff_t *ppos);
-int proc_douintvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
-			  size_t *lenp, loff_t *ppos);
-int proc_dou8vec_minmax(const struct ctl_table *ctl, int dir, void *buf,
-			size_t *lenp, loff_t *ppos);
-int proc_doulongvec_minmax(const struct ctl_table *ctl, int dir, void *buf,
-			   size_t *lenp, loff_t *ppos);
+/* Range handlers consume numeric table bounds. */
+int proc_dointvec_minmax(const struct ctl_table *table, int dir,
+			 void *buffer, size_t *lenp, loff_t *ppos);
+int proc_douintvec_minmax(const struct ctl_table *table, int dir,
+			  void *buffer, size_t *lenp, loff_t *ppos);
+int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
+			   void *buffer, size_t *lenp, loff_t *ppos);
+int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
+			void *buffer, size_t *lenp, loff_t *ppos);
 int proc_do_large_bitmap(const struct ctl_table *ctl, int dir, void *buf,
 			 size_t *lenp, loff_t *ppos);
 int proc_do_static_key(const struct ctl_table *ctl, int dir, void *buf,
@@ -116,15 +110,15 @@ int proc_do_static_key(const struct ctl_table *ctl, int dir, void *buf,
 int proc_dointvec_conv(const struct ctl_table *ctl, int dir, void *buf,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
-				   int dir, const struct ctl_table *ctl));
+		       int dir, const struct ctl_table *ctl));
 int proc_douintvec_conv(const struct ctl_table *ctl, int dir, void *buf,
 			size_t *lenp, loff_t *ppos,
 			int (*conv)(bool *negp, ulong *u_ptr, uint *k_ptr,
-				    int dir, const struct ctl_table *ctl));
+			int dir, const struct ctl_table *ctl));
 int proc_doulongvec_conv(const struct ctl_table *ctl, int dir, void *buf,
 			 size_t *lenp, loff_t *ppos,
 			 int (*conv)(bool *negp, ulong *u_ptr, ulong *k_ptr,
-				     int dir, const struct ctl_table *ctl));
+			 int dir, const struct ctl_table *ctl));
 
 /*
  * bi-directional converter functions
@@ -140,6 +134,7 @@ int proc_doulongvec_conv(const struct ctl_table *ctl, int dir, void *buf,
  * { return proc_uint_conv(u_ptr, k_ptr, dir, ctl, true,
  *                         custom_u2k, proc_uint_k2u_conv}
  */
+
 int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
 		  const struct ctl_table *tbl, bool k_ptr_range_check,
 		  int (*user_to_kern)(const bool *negp, const ulong *u_ptr, int *k_ptr),
@@ -226,8 +221,6 @@ struct ctl_table {
 	umode_t mode;
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-	void *extra1;			/* Deprecated; being removed */
-	void *extra2;			/* Deprecated; being removed */
 	unsigned long min;
 	unsigned long max;
 	void *priv;			/* Handler context, never used by the core */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ab25c75cb3ac..63a8a6b08090 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -22,13 +22,6 @@
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 
-/* shared constants to be used in various sysctls */
-const int sysctl_vals[] = { 0, 1, 2, 3, 4, 100, 200, 1000, 3000, INT_MAX, 65535, -1 };
-EXPORT_SYMBOL(sysctl_vals);
-
-const unsigned long sysctl_long_vals[] = { 0, 1, LONG_MAX };
-EXPORT_SYMBOL_GPL(sysctl_long_vals);
-
 #ifdef CONFIG_SYSCTL
 
 /* Constants used for minimum and maximum */
@@ -423,15 +416,8 @@ int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
 		ret = user_to_kern(u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if (tbl->extra1 || tbl->extra2) {
-			if ((tbl->extra1 &&
-			     *(uint *)tbl->extra1 > tmp_k) ||
-			    (tbl->extra2 &&
-			     *(uint *)tbl->extra2 < tmp_k))
-				return -ERANGE;
-		} else if (tbl->min > tmp_k || tbl->max < tmp_k) {
+		if (tbl->min > tmp_k || tbl->max < tmp_k)
 			return -ERANGE;
-		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(u_ptr, k_ptr);
@@ -547,19 +533,16 @@ int proc_int_conv(bool *negp, ulong *u_ptr, int *k_ptr, int dir,
 		ret = user_to_kern(negp, u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if (tbl->extra1 || tbl->extra2) {
-			if ((tbl->extra1 && *(int *)tbl->extra1 > tmp_k) ||
-			    (tbl->extra2 && *(int *)tbl->extra2 < tmp_k))
-				return -EINVAL;
-		} else if ((long)tbl->min > tmp_k || (long)tbl->max < tmp_k) {
+		if ((long)tbl->min > tmp_k || (long)tbl->max < tmp_k)
 			return -EINVAL;
-		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(negp, u_ptr, k_ptr);
 	return 0;
 }
 
+
+
 static int sysctl_user_to_kern_int_conv(const bool *negp, const ulong *u_ptr,
 					int *k_ptr)
 {
@@ -930,7 +913,7 @@ int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
  * values from/to the user buffer, treated as an ASCII string.
  *
  * This routine will ensure the values are within the range specified by
- * table->extra1 (min) and table->extra2 (max).
+ * table->min and table->max.
  *
  * Returns: %0 on success or -EINVAL when the range check fails and
  * SYSCTL_USER_TO_KERN(dir) == true
@@ -955,9 +938,8 @@ int proc_dointvec_minmax(const struct ctl_table *table, int dir,
  * strings are not allowed.
  *
  * When changing the kernel variable, this routine will ensure the values
- * are within the range specified by table->extra1 (min) and table->extra2
- * (max). And Check that the values are less than UINT_MAX to avoid having to
- * support wrap around uses from userspace.
+ * are within the range specified by table->min and table->max. Values larger
+ * than UINT_MAX are rejected to avoid wraparound from userspace.
  *
  * Returns: %0 on success or -ERANGE when range check failes and
  * SYSCTL_USER_TO_KERN(dir) == true
@@ -982,7 +964,7 @@ int proc_douintvec_minmax(const struct ctl_table *table, int dir,
  * strings are not allowed.
  *
  * This routine will ensure the values are within the range specified by
- * table->extra1 (min) and table->extra2 (max).
+ * table->min and table->max.
  *
  * Returns: %0 on success or an error on SYSCTL_USER_TO_KERN(dir) == true
  * and the range check fails.
@@ -1047,13 +1029,8 @@ int proc_ulong_conv(ulong *u_ptr, ulong *k_ptr, int dir,
 		ret = user_to_kern(u_ptr, &tmp_k);
 		if (ret)
 			return ret;
-		if (tbl->extra1 || tbl->extra2) {
-			if ((tbl->extra1 && *(ulong *)tbl->extra1 > tmp_k) ||
-			    (tbl->extra2 && *(ulong *)tbl->extra2 < tmp_k))
-				return -ERANGE;
-		} else if (tbl->min > tmp_k || tbl->max < tmp_k) {
+		if (tbl->min > tmp_k || tbl->max < tmp_k)
 			return -ERANGE;
-		}
 		WRITE_ONCE(*k_ptr, tmp_k);
 	} else
 		return user_to_kern(u_ptr, k_ptr);
@@ -1155,7 +1132,7 @@ int proc_doulongvec_conv(const struct ctl_table *table, int dir,
  * values from/to the user buffer, treated as an ASCII string.
  *
  * This routine will ensure the values are within the range specified by
- * table->extra1 (min) and table->extra2 (max).
+ * table->min and table->max.
  *
  * Returns: %0 on success.
  */
@@ -1348,8 +1325,8 @@ int proc_do_static_key(const struct ctl_table *table, int dir,
 		.data   = &val,
 		.maxlen = sizeof(val),
 		.mode   = table->mode,
-		.min    = 0,
-		.max    = 1,
+		.min = 0,
+		.max = 1,
 	};
 
 	if (SYSCTL_USER_TO_KERN(dir) && !capable(CAP_SYS_ADMIN))
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 8dde5a2cc532..184d4c5a7917 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -331,7 +331,7 @@ EXPORT_SYMBOL(proc_dointvec_ms_jiffies_minmax);
  * are treated as milliseconds, and converted to jiffies when they are stored.
  *
  * This routine will ensure the values are within the range specified by
- * table->extra1 (min) and table->extra2 (max).
+ * table->min and table->max.
  *
  * Returns 0 on success.
  */
diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 64c82fd53975..ed3547401f41 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -258,18 +258,18 @@ static void test_sysctl_calc_match_int_ok(void)
 		int defined;
 		int wanted;
 	} match_int[] = {
-		{ .defined = 0, .wanted = 0 },
-		{ .defined = 1, .wanted = 1 },
-		{ .defined = 2, .wanted = 2 },
-		{ .defined = 3, .wanted = 3 },
-		{ .defined = 4, .wanted = 4 },
-		{ .defined = 100, .wanted = 100 },
-		{ .defined = 200, .wanted = 200 },
-		{ .defined = 1000, .wanted = 1000 },
-		{ .defined = 3000, .wanted = 3000 },
-		{ .defined = INT_MAX, .wanted = INT_MAX },
-		{ .defined = 65535, .wanted = 65535 },
-		{ .defined = -1, .wanted = -1 },
+		{ .defined = SYSCTL_ZERO, .wanted = 0 },
+		{ .defined = SYSCTL_ONE, .wanted = 1 },
+		{ .defined = SYSCTL_TWO, .wanted = 2 },
+		{ .defined = SYSCTL_THREE, .wanted = 3 },
+		{ .defined = SYSCTL_FOUR, .wanted = 4 },
+		{ .defined = SYSCTL_ONE_HUNDRED, .wanted = 100 },
+		{ .defined = SYSCTL_TWO_HUNDRED, .wanted = 200 },
+		{ .defined = SYSCTL_ONE_THOUSAND, .wanted = 1000 },
+		{ .defined = SYSCTL_THREE_THOUSAND, .wanted = 3000 },
+		{ .defined = SYSCTL_INT_MAX, .wanted = INT_MAX },
+		{ .defined = SYSCTL_MAXOLDUID, .wanted = 65535 },
+		{ .defined = SYSCTL_NEG_ONE, .wanted = -1 },
 	};
 
 	for (i = 0; i < ARRAY_SIZE(match_int); i++)
-- 
2.25.1

