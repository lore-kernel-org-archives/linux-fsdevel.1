Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC4282F12
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962030; cv=none; b=TB8fEnLzX+Bsp/EmmbUtOppRtC3TPrjYQo4g6XpeH6yeXOU1Pb1X0R+GwrzyAmQ1W+d2cqX/ey2OH+AG9c9Z2lgzhDr1eoeIt2hxLeY/8UgA5Y9dJ4eWiqDH5TRgway0sYibGaVByM/LlYJaRWpU/EHaRGO5kmjFg4vwtwEg0qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962030; c=relaxed/simple;
	bh=V+KM+vPxI4Ogx85SRR1uTgAvTTWwG+wm7EyiWVFvf8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WT5kV3wFgxtmO9RlaDb3IEnwpCJ6epbz5LLmGecKmQY+Xf3uDvClHcBHk6lCZLkq8VVNM4VaHbvNqMbp+m9yLa4r1d67aDquRSd7CISqRTHtWEERQytn2uukA423rswSc09HYGLFUj9KrtpclC8YlnIKc92kckkDXo1LU3waRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyiU0O5I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyiU0O5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783962027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6A5f+FwjZK0+6lpKa/A2QPfH0c31sI/ogQwv34uiowk=;
	b=XyiU0O5IZ7a/5tiUqL+DS6BNKndO3MSaB1tPr1yQ3YiU1yXgKki+Cx6fHHD1bR2a80S3tg
	APzBGLKqWL/uz6Sgcj42FwyoPK5gq+owhCJ3Xe8N9PaL1PjWrbVxpZiOnRzP7raC9IGL5U
	xp1o69vsxwB9rKar0Atsj9y4jCdosF8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-5R3e1YTpP7CtHrd6rT6yUw-1; Mon,
 13 Jul 2026 13:00:23 -0400
X-MC-Unique: 5R3e1YTpP7CtHrd6rT6yUw-1
X-Mimecast-MFC-AGG-ID: 5R3e1YTpP7CtHrd6rT6yUw_1783962022
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B7CC1956045;
	Mon, 13 Jul 2026 17:00:21 +0000 (UTC)
Received: from wsxc.redhat.com (unknown [10.96.134.95])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C364136F2A;
	Mon, 13 Jul 2026 17:00:17 +0000 (UTC)
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
Subject: [PATCH] audit: add FSCONFIG auxiliary record to log filesystem configuration
Date: Mon, 13 Jul 2026 14:00:13 -0300
Message-ID: <20260713170013.4073499-1-rrobaina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Modern mount tools (util-linux >= 2.39.1) use the new mount API
(fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
syscall. The generic SYSCALL audit record logs the fsconfig syscall but
does not capture the configuration parameters, creating an audit gap for
critical mount information such as the device being mounted.

Add an FSCONFIG auxiliary record that logs the command type, parameter
name (key), parameter value, and aux parameter passed to fsconfig(2).

 ----
 type=SYSCALL : syscall=fsconfig a1=FSCONFIG_SET_STRING ...
 type=FSCONFIG : fs_cmd=1 fs_key=source fs_val="tmpfs" fs_aux=0
 ----
 type=SYSCALL : syscall=fsconfig a1=FSCONFIG_CMD_CREATE ...
 type=FSCONFIG : fs_cmd=6 fs_key=(null) fs_val=(null) fs_aux=0
 ----
 type=SYSCALL : syscall=fsconfig a0=0x4 a1=FSCONFIG_SET_BINARY ...
 type=FSCONFIG : fs_cmd=2 fs_key=hidepid fs_val="<binary>" fs_aux=4

Link: https://github.com/linux-audit/audit-kernel/issues/153
Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
---
 fs/fsopen.c                |  7 +++++++
 include/linux/audit.h      | 13 +++++++++++++
 include/uapi/linux/audit.h |  1 +
 kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index ae19e5136598..9b3c02f59df4 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -15,6 +15,7 @@
 #include <linux/namei.h>
 #include <linux/file.h>
 #include <uapi/linux/mount.h>
+#include <linux/audit.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
 	struct fs_context *fc;
 	int ret;
 	int lookup_flags = 0;
+	const char *value_str = NULL;
 
 	struct fs_parameter param = {
 		.type	= fs_value_is_undefined,
@@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
 			goto out_key;
 		}
 		param.size = strlen(param.string);
+		value_str = param.string;
 		break;
 	case FSCONFIG_SET_BINARY:
 		param.type = fs_value_is_blob;
@@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
 			ret = PTR_ERR(param.blob);
 			goto out_key;
 		}
+		value_str = "<binary>";
 		break;
 	case FSCONFIG_SET_PATH_EMPTY:
 		lookup_flags = LOOKUP_EMPTY;
@@ -445,6 +449,7 @@ SYSCALL_DEFINE5(fsconfig,
 		}
 		param.dirfd = aux;
 		param.size = strlen(param.name->name);
+		value_str = param.name->name;
 		break;
 	case FSCONFIG_SET_FD:
 		param.type = fs_value_is_file;
@@ -458,6 +463,8 @@ SYSCALL_DEFINE5(fsconfig,
 		break;
 	}
 
+	audit_log_fsconfig(cmd, param.key, value_str, aux);
+
 	ret = mutex_lock_interruptible(&fc->uapi_mutex);
 	if (ret == 0) {
 		ret = vfs_fsconfig_locked(fc, cmd, &param);
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..978eb881974c 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -449,6 +449,8 @@ extern void __audit_tk_injoffset(struct timespec64 offset);
 extern void __audit_ntp_log(const struct audit_ntp_data *ad);
 extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 			      enum audit_nfcfgop op, gfp_t gfp);
+extern void __audit_log_fsconfig(unsigned int cmd, const char *key,
+				 const char *value, int aux);
 
 static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
 {
@@ -598,6 +600,13 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 		__audit_log_nfcfg(name, af, nentries, op, gfp);
 }
 
+static inline void audit_log_fsconfig(unsigned int cmd, const char *key,
+				      const char *value, int aux)
+{
+	if (!audit_dummy_context())
+		__audit_log_fsconfig(cmd, key, value, aux);
+}
+
 extern int audit_n_rules;
 extern int audit_signals;
 #else /* CONFIG_AUDITSYSCALL */
@@ -730,6 +739,10 @@ static inline void audit_log_nfcfg(const char *name, u8 af,
 				   enum audit_nfcfgop op, gfp_t gfp)
 { }
 
+static inline void audit_log_fsconfig(unsigned int cmd, const char *key,
+				      const char *value, int aux)
+{ }
+
 #define audit_n_rules 0
 #define audit_signals 0
 #endif /* CONFIG_AUDITSYSCALL */
diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index e8f5ce677df7..5cd0eb602528 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -122,6 +122,7 @@
 #define AUDIT_OPENAT2		1337	/* Record showing openat2 how args */
 #define AUDIT_DM_CTRL		1338	/* Device Mapper target control */
 #define AUDIT_DM_EVENT		1339	/* Device Mapper events */
+#define AUDIT_FSCONFIG		1341	/* Record showing fsconfig args */
 
 #define AUDIT_AVC		1400	/* SE Linux avc denial or grant */
 #define AUDIT_SELINUX_ERR	1401	/* Internal SE Linux Errors */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..222bf79ee9bd 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2882,6 +2882,33 @@ void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
 }
 EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
 
+void __audit_log_fsconfig(unsigned int cmd, const char *key,
+			  const char *value, int aux)
+{
+	struct audit_buffer *ab;
+
+	ab = audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FSCONFIG);
+	if (!ab)
+		return;
+
+	audit_log_format(ab, "fs_cmd=%u", cmd);
+	audit_log_format(ab, " fs_key=");
+	if (value)
+		audit_log_untrustedstring(ab, key);
+	else
+		audit_log_format(ab, "(null)");
+
+	audit_log_format(ab, " fs_val=");
+	if (value)
+		audit_log_untrustedstring(ab, value);
+	else
+		audit_log_format(ab, "(null)");
+
+	audit_log_format(ab, " fs_aux=%d", aux);
+
+	audit_log_end(ab);
+}
+
 static void audit_log_task(struct audit_buffer *ab)
 {
 	kuid_t auid, uid;
-- 
2.53.0

