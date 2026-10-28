Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205400;
	b=U4yunBXIJ6rJ2XNzm3EXUDSEQxH3aLQJmjafhPsyeZNQ7c9G8oSOXZjnh5WIy5n2ncAA
	 f2hiAhQeR1gIID9PlpOjoGdN45unhi9HDgLDRwUrfsIkwhNru08jYt2z9Jev6xjR3hcBn
	 j9Kz0mrJob9qOiZVHyR6lVDba00id9tiyD/YD3CjFHgwUIj8Qqx7kjUeq19ixR+iIF0gg
	 /TYOD1bE1mhk2WiumTfIA/LvSiDxfQxRBcbPj1EZFt6GE/YE8bFUnvdXGMqh4OspMm0fA
	 u8iYZNURs1tCAZOSfLr2xQ1WYGj6LmqM2GyTLVz0bIIvddfs+XO4vlkIunxhwASBXyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205400;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t6Rsde8HUcg+MdMuIRYXrpKy4BcTFSWUMJlTOj5em8I=;
	b=aIZbcx9c2OL1yaVHFLJ/2sYBcldHYLNwZzIqIkMknmTLQfE9yGlAHWp3rymgAwnej1yw
	 fri+P6aOGX5x04P169yD0GVrO4Y05Yqog3FjAdXvcK7veYo9zn3MDGjPdxRQqxkTsNBpx
	 K86gZTD33r5iQPWRyh0HyfSMBzVKHajCbeOSsklgtGudkELsLVdhSBUM4js2C064cKFm5
	 A7uDlIljkbB0/USCDAd/JO+KBR51ALgI/xzvPuTUtJG7Gddf6Y5M2RRuJhSm42c877jjj
	 xCEmKOJV875XtV0QnmuHlVQU1BAoXEuF0fhjWH5K7yRZPEN+jqHwo5/tcyPz/EqrfKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eQOxGjTh;
	arc=none smtp.remote-ip=95.215.58.6
Received: from mta1.migadu.com (out-6.mta1.migadu.com [95.215.58.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A760606A323
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A760606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eQOxGjTh
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UN/PXg8OHExCVZApoImY21e96+g5EqlSdVLGJoX9ozs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205397; v=1; x=1793810197;
 b=eQOxGjThhCOdvLaST2RmPH3YSgaNwywb46lLK+hVSCQCeSwCPym+sPGx1ZfM7PAgXJFqbFBi
 klpCjd8tW4uV0S6FN46rGwrrlGI6mNZYes6Pm07XLBV6wPqGtxeRIiR4Mw22JZzJIh2yZfPZS4w
 NhM36yqh5dXzHeOLJBtdyuRU=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a36cb2db2e5f3eae;
	Wed, 28 Oct 2026 16:36:36 +0000
X-Mizu-Trace-ID: a36cb2db2e5f3eae
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/39] sysctl: store filesystem sysctl bounds by value
Date: Thu, 29 Oct 2026 00:34:49 +0800
Message-Id: <bb21735464bf099c71fec12356a7735f4037514c.1793204511.git.wen.yang@linux.dev>
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

Replace filesystem bound pointers with numeric limits.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 fs/coredump.c                      | 15 ++++----
 fs/dcache.c                        | 13 +++++--
 fs/devpts/inode.c                  | 10 ++---
 fs/drop_caches.c                   |  4 +-
 fs/eventpoll.c                     |  7 +---
 fs/exec.c                          | 10 ++---
 fs/file_table.c                    | 12 ++++--
 fs/fs-writeback.c                  |  4 +-
 fs/fuse/sysctl.c                   | 24 +++++-------
 fs/lockd/svc.c                     | 18 ++++-----
 fs/namei.c                         | 16 ++++----
 fs/namespace.c                     |  3 +-
 fs/nfs/nfs4sysctl.c                |  6 +--
 fs/notify/fanotify/fanotify_user.c | 17 ++++-----
 fs/notify/inotify/inotify_user.c   | 14 +++----
 fs/pipe.c                          |  6 +--
 fs/sysctls.c                       |  8 ++--
 fs/verity/init.c                   |  4 +-
 fs/xfs/xfs_sysctl.c                | 59 +++++++++++++++---------------
 19 files changed, 121 insertions(+), 129 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b25ef2ffbdee..295f9bd0353b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/slab.h>
+#include <linux/limits.h>
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/freezer.h>
@@ -1722,8 +1723,6 @@ static int proc_dostring_coredump(const struct ctl_table *table, int write,
 	return 0;
 }
 
-static const unsigned int core_file_note_size_min = CORE_FILE_NOTE_SIZE_DEFAULT;
-static const unsigned int core_file_note_size_max = CORE_FILE_NOTE_SIZE_MAX;
 static char core_modes[] = {
 	"file\npipe"
 #ifdef CONFIG_UNIX
@@ -1752,8 +1751,8 @@ static const struct ctl_table coredump_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_INT_MAX,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname       = "core_file_note_size_limit",
@@ -1761,8 +1760,8 @@ static const struct ctl_table coredump_sysctls[] = {
 		.maxlen         = sizeof(unsigned int),
 		.mode           = 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= (unsigned int *)&core_file_note_size_min,
-		.extra2		= (unsigned int *)&core_file_note_size_max,
+		.min		= CORE_FILE_NOTE_SIZE_DEFAULT,
+		.max		= CORE_FILE_NOTE_SIZE_MAX,
 	},
 	{
 		.procname	= "core_sort_vma",
@@ -1770,8 +1769,8 @@ static const struct ctl_table coredump_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "core_modes",
diff --git a/fs/dcache.c b/fs/dcache.c
index 37d021d22a7d..0e8ebb0a9b93 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/ratelimit.h>
+#include <linux/limits.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
@@ -207,6 +208,8 @@ static const struct ctl_table fs_dcache_sysctls[] = {
 		.maxlen		= 6*sizeof(long),
 		.mode		= 0444,
 		.proc_handler	= proc_nr_dentry,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "dentry-negative",
@@ -214,8 +217,8 @@ static const struct ctl_table fs_dcache_sysctls[] = {
 		.maxlen		= sizeof(dentry_negative_policy),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 };
 
@@ -226,7 +229,8 @@ static const struct ctl_table vm_dcache_sysctls[] = {
 		.maxlen		= sizeof(sysctl_vfs_cache_pressure),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "vfs_cache_pressure_denom",
@@ -234,7 +238,8 @@ static const struct ctl_table vm_dcache_sysctls[] = {
 		.maxlen		= sizeof(sysctl_vfs_cache_pressure_denom),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE_HUNDRED,
+		.min		= 100,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index bd1e8eb26edb..7aa5bccd1074 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -42,8 +42,6 @@
  */
 static int pty_limit = NR_UNIX98_PTY_DEFAULT;
 static int pty_reserve = NR_UNIX98_PTY_RESERVE;
-static int pty_limit_min;
-static int pty_limit_max = INT_MAX;
 static atomic_t pty_count = ATOMIC_INIT(0);
 
 static const struct ctl_table pty_table[] = {
@@ -53,16 +51,16 @@ static const struct ctl_table pty_table[] = {
 		.mode		= 0644,
 		.data		= &pty_limit,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &pty_limit_min,
-		.extra2		= &pty_limit_max,
+		.min		= 0,
+		.max		= INT_MAX,
 	}, {
 		.procname	= "reserve",
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.data		= &pty_reserve,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &pty_limit_min,
-		.extra2		= &pty_limit_max,
+		.min		= 0,
+		.max		= INT_MAX,
 	}, {
 		.procname	= "nr",
 		.maxlen		= sizeof(int),
diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..835c41fe443c 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -85,8 +85,8 @@ static const struct ctl_table drop_caches_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0200,
 		.proc_handler	= drop_caches_sysctl_handler,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= SYSCTL_FOUR,
+		.min		= 1,
+		.max		= 4,
 	},
 };
 
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f48b829a710f..957ab9ff2398 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -520,9 +520,6 @@ static void unlist_file(struct epitems_head *head)
 
 #include <linux/sysctl.h>
 
-static long long_zero;
-static long long_max = LONG_MAX;
-
 static const struct ctl_table epoll_table[] = {
 	{
 		.procname	= "max_user_watches",
@@ -530,8 +527,8 @@ static const struct ctl_table epoll_table[] = {
 		.maxlen		= sizeof(max_user_watches),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &long_zero,
-		.extra2		= &long_max,
+		.min		= 0,
+		.max		= LONG_MAX,
 	},
 };
 
diff --git a/fs/exec.c b/fs/exec.c
index 8d2b14e1d455..7ac813f138b3 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -2078,8 +2078,8 @@ COMPAT_SYSCALL_DEFINE5(execveat, int, fd,
 
 #ifdef CONFIG_SYSCTL
 
-static int proc_dointvec_minmax_coredump(const struct ctl_table *table, int write,
-		void *buffer, size_t *lenp, loff_t *ppos)
+static int proc_dointvec_range_coredump(const struct ctl_table *table, int write,
+					void *buffer, size_t *lenp, loff_t *ppos)
 {
 	int error, old = READ_ONCE(suid_dumpable);
 
@@ -2096,9 +2096,9 @@ static const struct ctl_table fs_exec_sysctls[] = {
 		.data		= &suid_dumpable,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax_coredump,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.proc_handler	= proc_dointvec_range_coredump,
+		.min		= 0,
+		.max		= 2,
 	},
 };
 
diff --git a/fs/file_table.c b/fs/file_table.c
index 9c2a5e06d678..cab577116511 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/string.h>
+#include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/file.h>
 #include <linux/init.h>
@@ -142,6 +143,8 @@ static const struct ctl_table fs_stat_sysctls[] = {
 		.maxlen		= sizeof(files_stat),
 		.mode		= 0444,
 		.proc_handler	= proc_nr_files,
+		.min		= 0,
+		.max		= ULONG_MAX,
 	},
 	{
 		.procname	= "file-max",
@@ -149,8 +152,8 @@ static const struct ctl_table fs_stat_sysctls[] = {
 		.maxlen		= sizeof(files_stat.max_files),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= SYSCTL_LONG_ZERO,
-		.extra2		= SYSCTL_LONG_MAX,
+		.min		= 0,
+		.max		= LONG_MAX,
 	},
 	{
 		.procname	= "nr_open",
@@ -158,8 +161,9 @@ static const struct ctl_table fs_stat_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= &sysctl_nr_open_min,
-		.extra2		= &sysctl_nr_open_max,
+		.min		= BITS_PER_LONG,
+		.max		= (SIZE_MAX / sizeof(void *) < INT_MAX ?
+				   SIZE_MAX / sizeof(void *) : INT_MAX) & -BITS_PER_LONG,
 	},
 };
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 58a6403780aa..559041eb7759 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/sched/sysctl.h>
+#include <linux/limits.h>
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -2662,7 +2663,8 @@ static const struct ctl_table vm_fs_writeback_table[] = {
 		.maxlen		= sizeof(dirtytime_expire_interval),
 		.mode		= 0644,
 		.proc_handler	= dirtytime_interval_handler,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
index 74eca5ce9a2c..0aca807d190e 100644
--- a/fs/fuse/sysctl.c
+++ b/fs/fuse/sysctl.c
@@ -11,15 +11,6 @@
 
 static struct ctl_table_header *fuse_table_header;
 
-/* Bound by fuse_init_out max_pages, which is a u16 */
-static unsigned int sysctl_fuse_max_pages_limit = 65535;
-
-/*
- * fuse_init_out request timeouts are u16.
- * This goes up to ~18 hours, which is plenty for a timeout.
- */
-static unsigned int sysctl_fuse_req_timeout_limit = 65535;
-
 static const struct ctl_table fuse_sysctl_table[] = {
 	{
 		.procname	= "max_pages_limit",
@@ -27,8 +18,9 @@ static const struct ctl_table fuse_sysctl_table[] = {
 		.maxlen		= sizeof(fuse_max_pages_limit),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &sysctl_fuse_max_pages_limit,
+		.min		= 1,
+		/* Bound by fuse_init_out max_pages, which is a u16. */
+		.max		= 65535,
 	},
 	{
 		.procname	= "default_request_timeout",
@@ -36,8 +28,9 @@ static const struct ctl_table fuse_sysctl_table[] = {
 		.maxlen		= sizeof(fuse_default_req_timeout),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &sysctl_fuse_req_timeout_limit,
+		.min		= 0,
+		/* u16 request timeout: up to ~18 hours. */
+		.max		= 65535,
 	},
 	{
 		.procname	= "max_request_timeout",
@@ -45,8 +38,9 @@ static const struct ctl_table fuse_sysctl_table[] = {
 		.maxlen		= sizeof(fuse_max_req_timeout),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= &sysctl_fuse_req_timeout_limit,
+		.min		= 0,
+		/* u16 request timeout: up to ~18 hours. */
+		.max		= 65535,
 	},
 };
 
diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index f0e1a58c9106..f45ab868d05f 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -78,7 +78,6 @@ static const unsigned long	nlm_timeout_min = 3;
 static const unsigned long	nlm_timeout_max = 20;
 
 #ifdef CONFIG_SYSCTL
-static const int		nlm_port_min = 0, nlm_port_max = 65535;
 static struct ctl_table_header * nlm_sysctl_table;
 #endif
 
@@ -432,8 +431,8 @@ static const struct ctl_table nlm_sysctls[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= (unsigned long *) &nlm_grace_period_min,
-		.extra2		= (unsigned long *) &nlm_grace_period_max,
+		.min		= 0,
+		.max		= 240,
 	},
 	{
 		.procname	= "nlm_timeout",
@@ -441,8 +440,8 @@ static const struct ctl_table nlm_sysctls[] = {
 		.maxlen		= sizeof(unsigned long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= (unsigned long *) &nlm_timeout_min,
-		.extra2		= (unsigned long *) &nlm_timeout_max,
+		.min		= 3,
+		.max		= 20,
 	},
 	{
 		.procname	= "nlm_udpport",
@@ -450,8 +449,8 @@ static const struct ctl_table nlm_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (int *) &nlm_port_min,
-		.extra2		= (int *) &nlm_port_max,
+		.min		= 0,
+		.max		= 65535,
 	},
 	{
 		.procname	= "nlm_tcpport",
@@ -459,8 +458,8 @@ static const struct ctl_table nlm_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (int *) &nlm_port_min,
-		.extra2		= (int *) &nlm_port_max,
+		.min		= 0,
+		.max		= 65535,
 	},
 	{
 		.procname	= "nsm_use_hostnames",
@@ -475,7 +474,6 @@ static const struct ctl_table nlm_sysctls[] = {
 		.maxlen		= sizeof(nsm_local_state),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec,
-		.extra1		= SYSCTL_ZERO,
 	},
 };
 
diff --git a/fs/namei.c b/fs/namei.c
index 96c65940391a..5c13f63ec11f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1214,8 +1214,8 @@ static const struct ctl_table namei_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "protected_hardlinks",
@@ -1223,8 +1223,8 @@ static const struct ctl_table namei_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
+		.min		= 0,
+		.max		= 1,
 	},
 	{
 		.procname	= "protected_fifos",
@@ -1232,8 +1232,8 @@ static const struct ctl_table namei_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 	{
 		.procname	= "protected_regular",
@@ -1241,8 +1241,8 @@ static const struct ctl_table namei_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.min		= 0,
+		.max		= 2,
 	},
 };
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 9f6ec35c7b9c..c88483ff0f55 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6774,7 +6774,8 @@ static const struct ctl_table fs_namespace_sysctls[] = {
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/fs/nfs/nfs4sysctl.c b/fs/nfs/nfs4sysctl.c
index d1a92d8f8ba4..189f601c5c65 100644
--- a/fs/nfs/nfs4sysctl.c
+++ b/fs/nfs/nfs4sysctl.c
@@ -13,8 +13,6 @@
 #include "nfs4idmap.h"
 #include "callback.h"
 
-static const int nfs_set_port_min;
-static const int nfs_set_port_max = 65535;
 static struct ctl_table_header *nfs4_callback_sysctl_table;
 
 static const struct ctl_table nfs4_cb_sysctls[] = {
@@ -24,8 +22,8 @@ static const struct ctl_table nfs4_cb_sysctls[] = {
 		.maxlen = sizeof(int),
 		.mode = 0644,
 		.proc_handler = proc_dointvec_minmax,
-		.extra1 = (int *)&nfs_set_port_min,
-		.extra2 = (int *)&nfs_set_port_max,
+		.min          = 0,
+		.max          = 65535,
 	},
 	{
 		.procname = "idmap_cache_timeout",
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 63c9759fc3b0..1caea0461542 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -57,9 +57,6 @@ static int perm_group_timeout __read_mostly;
 
 #include <linux/sysctl.h>
 
-static long ft_zero = 0;
-static long ft_int_max = INT_MAX;
-
 static const struct ctl_table fanotify_table[] = {
 	{
 		.procname	= "max_user_groups",
@@ -67,8 +64,8 @@ static const struct ctl_table fanotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &ft_zero,
-		.extra2		= &ft_int_max,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "max_user_marks",
@@ -76,8 +73,8 @@ static const struct ctl_table fanotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &ft_zero,
-		.extra2		= &ft_int_max,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "max_queued_events",
@@ -85,7 +82,8 @@ static const struct ctl_table fanotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "watchdog_timeout",
@@ -93,7 +91,8 @@ static const struct ctl_table fanotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 5f19c24ec187..43f1a9481a73 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -55,9 +55,6 @@ struct kmem_cache *inotify_inode_mark_cachep __ro_after_init;
 
 #include <linux/sysctl.h>
 
-static long it_zero = 0;
-static long it_int_max = INT_MAX;
-
 static const struct ctl_table inotify_table[] = {
 	{
 		.procname	= "max_user_instances",
@@ -65,8 +62,8 @@ static const struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &it_zero,
-		.extra2		= &it_int_max,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "max_user_watches",
@@ -74,8 +71,8 @@ static const struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(long),
 		.mode		= 0644,
 		.proc_handler	= proc_doulongvec_minmax,
-		.extra1		= &it_zero,
-		.extra2		= &it_int_max,
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 	{
 		.procname	= "max_queued_events",
@@ -83,7 +80,8 @@ static const struct ctl_table inotify_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO
+		.min		= 0,
+		.max		= INT_MAX,
 	},
 };
 
diff --git a/fs/pipe.c b/fs/pipe.c
index c41ab753c893..41710777c94b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1579,8 +1579,7 @@ static int do_proc_uint_conv_pipe_maxsz(bool *negp, ulong *u_ptr, uint *k_ptr,
 					int dir, const struct ctl_table *table)
 {
 	return proc_uint_conv(u_ptr, k_ptr, dir, table, true,
-			      u2k_pipe_maxsz,
-			      proc_uint_k2u_conv);
+				    u2k_pipe_maxsz, proc_uint_k2u_conv);
 }
 
 static int proc_dopipe_max_size(const struct ctl_table *table, int write,
@@ -1597,7 +1596,8 @@ static const struct ctl_table fs_pipe_sysctls[] = {
 		.maxlen		= sizeof(pipe_max_size),
 		.mode		= 0644,
 		.proc_handler	= proc_dopipe_max_size,
-		.extra1		= SYSCTL_ONE,
+		.min		= 1,
+		.max		= UINT_MAX,
 	},
 	{
 		.procname	= "pipe-user-pages-hard",
diff --git a/fs/sysctls.c b/fs/sysctls.c
index ad429dffeb4b..64e5aa0da9ff 100644
--- a/fs/sysctls.c
+++ b/fs/sysctls.c
@@ -14,8 +14,8 @@ static const struct ctl_table fs_shared_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_MAXOLDUID,
+		.min		= 0,
+		.max		= 65535,
 	},
 	{
 		.procname	= "overflowgid",
@@ -23,8 +23,8 @@ static const struct ctl_table fs_shared_sysctls[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_MAXOLDUID,
+		.min		= 0,
+		.max		= 65535,
 	},
 };
 
diff --git a/fs/verity/init.c b/fs/verity/init.c
index 3aa55dec88fc..be78ec9fe0a0 100644
--- a/fs/verity/init.c
+++ b/fs/verity/init.c
@@ -19,8 +19,8 @@ static const struct ctl_table fsverity_sysctl_table[] = {
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec_minmax,
-		.extra1         = SYSCTL_ZERO,
-		.extra2         = SYSCTL_ONE,
+		.min            = 0,
+		.max            = 1,
 	},
 #endif
 };
diff --git a/fs/xfs/xfs_sysctl.c b/fs/xfs/xfs_sysctl.c
index 7f32d282dc88..693765c284cc 100644
--- a/fs/xfs/xfs_sysctl.c
+++ b/fs/xfs/xfs_sysctl.c
@@ -51,12 +51,11 @@ xfs_panic_mask_proc_handler(
 #endif /* CONFIG_PROC_FS */
 
 static inline int
-xfs_deprecated_dointvec_minmax(
-	const struct ctl_table	*ctl,
-	int			write,
-	void			*buffer,
-	size_t			*lenp,
-	loff_t			*ppos)
+xfs_deprecated_dointvec_range(const struct ctl_table *ctl,
+			      int			write,
+			      void			*buffer,
+			      size_t			*lenp,
+			      loff_t			*ppos)
 {
 	if (write) {
 		printk_ratelimited(KERN_WARNING
@@ -73,8 +72,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= xfs_panic_mask_proc_handler,
-		.extra1		= &xfs_params.panic_mask.min,
-		.extra2		= &xfs_params.panic_mask.max
+		.min		= 0,
+		.max		= XFS_PTAG_MASK
 	},
 
 	{
@@ -83,8 +82,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.error_level.min,
-		.extra2		= &xfs_params.error_level.max
+		.min		= 0,
+		.max		= 11
 	},
 	{
 		.procname	= "xfssyncd_centisecs",
@@ -92,8 +91,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.syncd_timer.min,
-		.extra2		= &xfs_params.syncd_timer.max
+		.min		= 100,
+		.max		= 7200 * 100
 	},
 	{
 		.procname	= "inherit_sync",
@@ -101,8 +100,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.inherit_sync.min,
-		.extra2		= &xfs_params.inherit_sync.max
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "inherit_nodump",
@@ -110,8 +109,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.inherit_nodump.min,
-		.extra2		= &xfs_params.inherit_nodump.max
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "inherit_noatime",
@@ -119,8 +118,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.inherit_noatim.min,
-		.extra2		= &xfs_params.inherit_noatim.max
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "inherit_nosymlinks",
@@ -128,8 +127,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.inherit_nosym.min,
-		.extra2		= &xfs_params.inherit_nosym.max
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "rotorstep",
@@ -137,8 +136,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.rotorstep.min,
-		.extra2		= &xfs_params.rotorstep.max
+		.min		= 1,
+		.max		= 255
 	},
 	{
 		.procname	= "inherit_nodefrag",
@@ -146,8 +145,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.inherit_nodfrg.min,
-		.extra2		= &xfs_params.inherit_nodfrg.max
+		.min		= 0,
+		.max		= 1
 	},
 	{
 		.procname	= "filestream_centisecs",
@@ -155,8 +154,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.fstrm_timer.min,
-		.extra2		= &xfs_params.fstrm_timer.max,
+		.min		= 1,
+		.max		= 3600 * 100,
 	},
 	{
 		.procname	= "speculative_prealloc_lifetime",
@@ -164,8 +163,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &xfs_params.blockgc_timer.min,
-		.extra2		= &xfs_params.blockgc_timer.max,
+		.min		= 1,
+		.max		= 3600 * 24,
 	},
 	/* please keep this the last entry */
 #ifdef CONFIG_PROC_FS
@@ -175,8 +174,8 @@ static const struct ctl_table xfs_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= xfs_stats_clear_proc_handler,
-		.extra1		= &xfs_params.stats_clear.min,
-		.extra2		= &xfs_params.stats_clear.max
+		.min		= 0,
+		.max		= 1
 	},
 #endif /* CONFIG_PROC_FS */
 };
-- 
2.25.1

