Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8122627A10F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962053; cv=none; b=l3DGD2klq7erkWGG5PlEprLGlqGuHcHl5gmIDrjQEQ7A8RA4iiBtXXMNnugIXYGJy1Gzh514xIucAKRee36s/hE9o2vLH/506vN3k7uZiSJpYBMktBT8bfVO3/n3iTp98ffqt48PjVvIMOMWx7QrPZ2nBxBrD0eucWYlYWfP48U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962053; c=relaxed/simple;
	bh=Ap46lyv6AzrobCjyywLm+H3et0NVQli587V2AXUztLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a4jU1W8xYns4Rz5Yguk9ABd7RWb2C6BqQD8/ZPVxFqBL+rRtWVDVRqQNVVinjf1GB7bhIfLEXcTWdTkwPqkfm09LClWBP/7mJYXpO4C07A9qeQK6JkEsPsXuoNfZD3rL8IqvJL5qLKppOdPX6JZTnC5cvUyf9fo9/Hio7nRRmIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y84JjfYz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y84JjfYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783962049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jT/M178Y/zRvK+cz2JT3TB74NeelxfqjdEk797vBTC0=;
	b=Y84JjfYzngoLOz+0YOcwo0B0z8OEdVO/s9gvIWGt5xnVy3OjvSbRXgKJ4FkpeFwBfroDOd
	swVf2zBOD27qKIRaOxM1FB7sBsfX88RnfHU8gGbiXpI2MXU5Og9aH5CM9/EQ751zXfMBQz
	9Tf53wbL4WrIxEO3R2EfpuKKPhnoez4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-H4EtxHBUP5uzDfjR0unPKQ-1; Mon,
 13 Jul 2026 13:00:46 -0400
X-MC-Unique: H4EtxHBUP5uzDfjR0unPKQ-1
X-Mimecast-MFC-AGG-ID: H4EtxHBUP5uzDfjR0unPKQ_1783962044
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8D621800595;
	Mon, 13 Jul 2026 17:00:43 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F2111800348;
	Mon, 13 Jul 2026 17:00:39 +0000 (UTC)
From: Ricardo Robaina <rrobaina@redhat.com>
To: audit@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	sgrubb@redhat.com,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
Date: Mon, 13 Jul 2026 14:00:35 -0300
Message-ID: <20260713170035.4073532-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Modern mount tools (util-linux >= 2.39.1) use the new mount API
(fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
syscall. The generic SYSCALL audit record logs the move_mount syscall
but does not capture the flags argument, creating an audit gap for
mount relocation operations.

Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
to move_mount(2). Pathnames and file descriptors are captured through
existing PATH records and SYSCALL record arguments.

 ----
 type=PATH : item=0 name=/mnt/test_src inode=1 dev=00:41 ...
 type=SYSCALL : arch=x86_64 syscall=move_mount ...
 type=MOVE_MOUNT : fs_flags=0x4
 ----
 type=PATH : item=0 name=/mnt/test_dst inode=27460862 dev=fc:00 ...
 type=SYSCALL : arch=x86_64 syscall=move_mount ...
 type=MOVE_MOUNT : fs_flags=0x4

Link: https://github.com/linux-audit/audit-kernel/issues/152
Link: https://github.com/linux-audit/audit-kernel/issues/153
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 fs/namespace.c             |  3 +++
 include/linux/audit.h      | 10 ++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/auditsc.c           | 13 +++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3d5cd5bf3b05..a6b0286744d9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -34,6 +34,7 @@
 #include <linux/mnt_idmapping.h>
 #include <linux/pidfs.h>
 #include <linux/nstree.h>
+#include <linux/audit.h>
 
 #include "pnode.h"
 #include "internal.h"
@@ -4625,6 +4626,8 @@ SYSCALL_DEFINE5(move_mount,
 	if (flags & MOVE_MOUNT_F_EMPTY_PATH)
 		uflags = AT_EMPTY_PATH;
 
+	audit_log_move_mount(flags);
+
 	CLASS(filename_maybe_null,from_name)(from_pathname, uflags);
 	if (!from_name && from_dfd >= 0) {
 		CLASS(fd_raw, f_from)(from_dfd);
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..d1dc4035cb3c 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -449,6 +449,7 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 			      enum audit_nfcfgop op, gfp_t gfp);
+extern void __audit_log_move_mount(unsigned int flags);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -598,6 +599,12 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 		__audit_log_nfcfg(name, af, nentries, op, gfp);
 }
 
+static inline void audit_log_move_mount(unsigned int flags)
+{
+	if (!audit_dummy_context())
+		__audit_log_move_mount(flags);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -730,6 +737,9 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 				   enum audit_nfcfgop op, gfp_t gfp)
 { }
 
+static inline void audit_log_move_mount(unsigned int flags)
+{ }
+
 #define audit_n_rules 0
 #define audit_signals 0
 #endif /* CONFIG_AUDITSYSCALL */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index e8f5ce677df7..40abf3dfd307 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -122,6 +122,7 @@
 #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
 #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
 #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
+#define AUDIT_MOVE_MOUNT	1342	/* Record showing move_mount flags */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..4aca04d33d00 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2882,6 +2882,19 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 }
 EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
 
+void __audit_log_move_mount(unsigned int flags)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL,
+			     AUDIT_MOVE_MOUNT);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "fs_flags=0x%x", flags);
+	audit_log_end(ab);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
-- 
2.53.0

