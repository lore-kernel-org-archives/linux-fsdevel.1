Received: from out203-205-221-250.mail.qq.com (out203-205-221-250.mail.qq.com [203.205.221.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441DE3A16A7;
	Fri, 17 Apr 2026 14:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776435843; cv=none; b=PH9xThejdykWXd12Kdmg9KwKVmA4ZpyYcqEfhd3kKjmSBQM8FSvIHJZmNXAT+yZxDkeN5CQk5OoKsaOqL/oQXDOFYbtT2NO3QHmamYGZ2KzZhBudve9t4Kb0l+CQT1Ry5+tf6TPp9p1TLfat3FuFJxM/gIqlq3S6RMCAkmASkq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776435843; c=relaxed/simple;
	bh=RDW7Ov+1FiIofFLagMpe+5hwb/O+wZObs8lbYoFHEeM=;
	h=Message-ID:Content-Type:MIME-Version:From:To:Cc:Subject:Date; b=BAV4CqlCLtwC7J7hGRJjHm95zTQWbUipKP8MQATMGGSV4Jg2mjGQNhKogTtBOJlJNheXoOjQp4GTj0EdOdFBEY2qm/jKF3u2x+qggF/L2OBc66p987qvE14yqAS8KX3iwMZCd2DF4oHJVmCWPtvxFaoQHUc2i0/h52gPe81W2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qYbPxHdr; arc=none smtp.client-ip=203.205.221.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qYbPxHdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776435828; bh=SnPuI25BLFSoHT2AszlZDOD+3XaqxWgIhS/ZO8/eOtY=;
	h=From:To:Cc:Subject:Date;
	b=qYbPxHdrCC7xJvUeCFZbFcuiYly3lZavXEY9CgGFHFzGj8XHDFlgQA9K/1LimPo2e
	 Yj/BGI+xGkF8tpQh49bU6gshzQevkE5bZ8A/Sq6suUz+3Lj1+geJP+8c1UMZ8BMd93
	 hPnuHdmWPuBaVTp8K5S86SAkrq/4yvckOTxYFFHY=
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2409:8a20:c5c:cba1:3d42:74b5:efa1:925c])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 5EEA645F; Fri, 17 Apr 2026 22:23:46 +0800
X-QQ-mid: xmsmtpt1776435826te17mu5ry
Message-ID: <tencent_4BACE37ED72C80152F8C6A8C585893505A05@qq.com>
X-QQ-XMAILINFO: NmRjDopJZVxOflmNXhuTwPdj5jy6tJ6t92GWRvLv+vhlCFw4HVswyMAvCS7qQn
	 KSgF7sYiXEapcsHkFMMHhuYQm3qNUzMLYyfZbToluzKC/3dcUHcWNsjQrS0VtZXSyskNQ5GpqLhJ
	 CwDC9E//gHVQpcxzrw17YWiUi3CwacGzjja7ZqpMsY+8yjQGX8faLYyCP4wIK5/LlCHqQhKf1Dlo
	 GleX0B3PYSJv4pjuF6qS2DIMQDz5LNL4kyvSAsBiJ0waEgSDuVx9Y/IvOFNsvZvcihSI91yZwv7a
	 H82DlZxVOsOunWWobDTBvvueFKs5ihLfTJF/RbrDSjiin/SQy+aCQMAbS3Mp3Iav2rFNDzEqcHLb
	 R3qow8ZWbwgUSrfrwC8jGzwpph8HlTnmHAyLZCxl5HDZRr0ZZMoBMF10IG7LroKp9xfEEJsO6XwP
	 MA+yACMNCpp+zH89yhNFG38UkYZKk+9D/rLqjBhpMI26/U0jul9EqsXknykyxV+JoRwLsLAst8hk
	 Wz7n9rKNmuYuTTy8Z37ohzr3xsh9KDI9/9kYjGedWbefYTcuk7LOag5kb5IoZilEKsXGigRkBUVy
	 7WLdixUtDzSz5yL8/OOUW+hO3+a49Zc9vVOTAUMWSX3bighm9ZqEKV+lrurtu+XuaxPSL7S1pfaE
	 +26MuvHmqkGdW/WH9TgLreB7BnDWOKrPSUKSCW5u0vWJswZFuQ/MXq6mwzyq7Ry1Ya/gF091c/sA
	 asQNvDGshD+fy9SLwreyx73K9YytYGO0Vz/niGphEWAbgPGgPXbpwwife1iTMBx/qf9gNAWdhPi9
	 wQPc6tYQR5UXpZ1VY3t+vjEqUArp0zp4B8ZxFY2NiEOvbK0WulB8PPbrUNcufiX1BCBYbjOCc5GX
	 Wcp6Y86Hxp+SYQpG9BnBkWahHx8toTWq2rL3a0vKqWNCebI/VI7A9sDly2W4uDFCP3n9PWC9ZZOp
	 UfVVC7YKvWCR5SL1p/OmwTEdvewpuGf6mDPqPSVwdUkCJlty6ADeofw+RlyBxGMuFx7P5JioZVye
	 Aj75oYHWW50MGB+PryXRlcYgHEnVnb9gQrbdaHNg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: wooridge <1063373698@qq.com>
To: Kees Cook <keescook@chromium.org>, Joel Granados <j.granados@samsung.com>, Petr Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] sysctl: add CAP_SYS_ADMIN check to panic/ctrl-alt-del sysctls
Date: Fri, 17 Apr 2026 22:23:46 +0800

From f5ff7a45f093ebdf4d1db0f3dad244d2c5065943 Mon Sep 17 00:00:00 2001
From: wooridge <yurenwang152@gmail.com>
Date: Fri, 17 Apr 2026 20:59:09 +0800
Subject: [PATCH] sysctl: add CAP_SYS_ADMIN check to panic/ctrl-alt-del sysctls

Several kernel sysctls that control critical system behavior use proc_dointvec() as their handler with mode 0644, but proc_dointvec() does not perform any capability checks. In a user namespace where a process has uid 0, the VFS layer allows writes based on the file permission bits (0644), enabling unprivileged modification of critical kernel parameters.

Affected sysctls: kernel/panic, kernel/panic_on_oops, kernel/panic_on_warn, kernel/ctrl-alt-del

Fix by adding proc_dointvec_sysadmin() and proc_dointvec_minmax_sysadmin() as generic wrappers that check capable(CAP_SYS_ADMIN) on writes, then delegate to proc_dointvec()/proc_dointvec_minmax(). Also remove the existing static proc_dointvec_minmax_sysadmin() from kernel/printk/sysctl.c in favor of the new shared implementation.

Signed-off-by: wooridge <yurenwang152@gmail.com>
---
 include/linux/sysctl.h |  3 +++
 kernel/panic.c         |  6 ++---
 kernel/printk/sysctl.c | 10 +-------
 kernel/reboot.c        |  3 ++-
 kernel/sysctl.c        | 58 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 67 insertions(+), 13 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2886fbceb5d6..6322822206a7 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -82,8 +82,11 @@ int proc_dobool(const struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
 int proc_dointvec(const struct ctl_table *, int, void *, size_t *, loff_t *);
+int proc_dointvec_sysadmin(const struct ctl_table *, int, void *, size_t *, loff_t *);
 int proc_dointvec_minmax(const struct ctl_table *table, int dir, void *buffer,
 			 size_t *lenp, loff_t *ppos);
+int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int dir, void *buffer,
+				  size_t *lenp, loff_t *ppos);
 int proc_dointvec_conv(const struct ctl_table *table, int dir, void *buffer,
 		       size_t *lenp, loff_t *ppos,
 		       int (*conv)(bool *negp, unsigned long *u_ptr, int *k_ptr,
diff --git a/kernel/panic.c b/kernel/panic.c
index c78600212b6c..a966a4c81473 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -162,14 +162,14 @@ static const struct ctl_table kern_panic_table[] = {
 		.data		= &panic_timeout,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_sysadmin,
 	},
 	{
 		.procname	= "panic_on_oops",
 		.data		= &panic_on_oops,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_sysadmin,
 	},
 	{
 		.procname	= "panic_print",
@@ -183,7 +183,7 @@ static const struct ctl_table kern_panic_table[] = {
 		.data		= &panic_on_warn,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_dointvec_minmax_sysadmin,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
index f15732e93c2e..c48694739fee 100644
--- a/kernel/printk/sysctl.c
+++ b/kernel/printk/sysctl.c
@@ -5,20 +5,12 @@
 
 #include <linux/printk.h>
 #include <linux/capability.h>
+#include <linux/sysctl.h>
 #include <linux/ratelimit.h>
 #include "internal.h"
 
 static const int ten_thousand = 10000;
 
-static int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int write,
-				void *buffer, size_t *lenp, loff_t *ppos)
-{
-	if (write && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-}
-
 static const struct ctl_table printk_sysctls[] = {
 	{
 		.procname	= "printk",
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd..47055fedabbc 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -16,6 +16,7 @@
 #include <linux/reboot.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
+#include <linux/sysctl.h>
 #include <linux/syscore_ops.h>
 #include <linux/uaccess.h>
 
@@ -1379,7 +1380,7 @@ static const struct ctl_table kern_reboot_table[] = {
 		.data           = &C_A_D,
 		.maxlen         = sizeof(int),
 		.mode           = 0644,
-		.proc_handler   = proc_dointvec,
+		.proc_handler   = proc_dointvec_sysadmin,
 	},
 };
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9d3a666ffde1..4e0bc095ffeb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -843,6 +843,52 @@ int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
 	return do_proc_dointvec(table, dir, buffer, lenp, ppos, NULL);
 }
 
+/**
+ * proc_dointvec_sysadmin - read/write a vector of integers with CAP_SYS_ADMIN check
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Same as proc_dointvec, but writes require CAP_SYS_ADMIN.
+ * This prevents unprivileged writes from user namespaces where
+ * the process has uid 0 and thus passes VFS permission checks.
+ *
+ * Returns 0 on success, -EPERM if a write lacks CAP_SYS_ADMIN.
+ */
+int proc_dointvec_sysadmin(const struct ctl_table *table, int dir, void *buffer,
+			   size_t *lenp, loff_t *ppos)
+{
+	if (dir && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return proc_dointvec(table, dir, buffer, lenp, ppos);
+}
+EXPORT_SYMBOL_GPL(proc_dointvec_sysadmin);
+
+/**
+ * proc_dointvec_minmax_sysadmin - read/write a vector of integers with range and CAP_SYS_ADMIN check
+ * @table: the sysctl table
+ * @dir: %TRUE if this is a write to the sysctl file
+ * @buffer: the user buffer
+ * @lenp: the size of the user buffer
+ * @ppos: file position
+ *
+ * Same as proc_dointvec_minmax, but writes require CAP_SYS_ADMIN.
+ *
+ * Returns 0 on success, -EPERM if a write lacks CAP_SYS_ADMIN.
+ */
+int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int dir,
+				  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (dir && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return proc_dointvec_minmax(table, dir, buffer, lenp, ppos);
+}
+EXPORT_SYMBOL_GPL(proc_dointvec_minmax_sysadmin);
+
 /**
  * proc_douintvec - read a vector of unsigned integers
  * @table: the sysctl table
@@ -1260,6 +1306,12 @@ int proc_dointvec(const struct ctl_table *table, int dir,
 	return -ENOSYS;
 }
 
+int proc_dointvec_sysadmin(const struct ctl_table *table, int dir,
+			   void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+
 int proc_douintvec(const struct ctl_table *table, int dir,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -1272,6 +1324,12 @@ int proc_dointvec_minmax(const struct ctl_table *table, int dir,
 	return -ENOSYS;
 }
 
+int proc_dointvec_minmax_sysadmin(const struct ctl_table *table, int dir,
+				  void *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+
 int proc_douintvec_minmax(const struct ctl_table *table, int dir,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-- 
2.50.1 (Apple Git-155)

