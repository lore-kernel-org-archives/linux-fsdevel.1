Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468C32EEE95
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 21:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785101882; cv=none; b=AMFfCuB50pQ6vrcsBGALIfwrNsEBq8uffom+sKLR1ckGhFJBXODc71MwZvIgjjV8y+8VERwsMC5cG0lAT8shM+jHJr1OUcDdpK7u+kibQwdUvGUfvhtPJF0C5Wkna52X8aCjlw3StTAAkXtdgFc4rHxZE7AQKw78oUObmxjQ7wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785101882; c=relaxed/simple;
	bh=yO/1rBEgspF2pky3bo6xrFYrRB0eDf9RvneSpMYePzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=iZjbkBQ+YRke8QdD28IO1IaOjB8kBGBAgcxAzF0bq8kPMyEUcT6k6WcBK96Pwvl1sw0hAuvtqCWmyyyoJDyogCVyj2W5cP0iFv7ZQkaqLFPnR4stxzgCx2fxiPGkBeLlE//rS9AJcMDbCXSfcJ2iVYrFYG/PwQ/WHNX/7DGMBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XNOGtitn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNOGtitn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785101880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=icC9lmHxi+eXaZ/PK7TjCUqIg70gArkiW9mP3zqc+Cw=;
	b=XNOGtitnK03Q2x8+aCTOK/RFFcHQ+Z298OmC+vVCq64DdAGBZhqFaqhFUDJZkPAp61IMUp
	mmasz3i40O5X9ZHLfFg0ZWZMHJRoxJd4h58yqH4REp63I5gfVA5y/7igc7SQmc/W9eUVRu
	krR0luCsQTU6CgiqvawH/FaBYvMupqY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-1Nhuo64yNZalb-x2ri4hQA-1; Sun,
 26 Jul 2026 17:37:56 -0400
X-MC-Unique: 1Nhuo64yNZalb-x2ri4hQA-1
X-Mimecast-MFC-AGG-ID: 1Nhuo64yNZalb-x2ri4hQA_1785101875
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D87641956045;
	Sun, 26 Jul 2026 21:37:54 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.58.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A37FD30001BE;
	Sun, 26 Jul 2026 21:37:52 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH v1] audit: free proctitle in context so it can be set by fork
Date: Sun, 26 Jul 2026 17:37:14 -0400
Message-ID: <d67349e701acb3125d733f833e6ef2e47c91daae.1785101356.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Original title: fixes clean proctitle in audit context on exec call

Between the actual process startup (fork systemd) and the executable file
replacement (exec), systemd sets a temporary file name (executable file
name in parentheses). If an auditable system call occurs at this point,
the audit context will latch the temporary process name into the cache.
This name will not change again. The patch clears proctitle into the
audit cache when the exec call is made, allowing the new process name to
be latched.

Suggested by Roman Dolgikh https://github.com/rmd4ctf 2025-06-11
Link: https://github.com/linux-audit/audit-kernel/issues/170.
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 fs/exec.c             | 2 ++
 include/linux/audit.h | 9 +++++++++
 kernel/auditsc.c      | 4 ++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b92fe7db176c..bd51489dec23 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1744,6 +1744,8 @@ static int exec_binprm(struct linux_binprm *bprm)
 			fput(exec);
 	}
 
+	/* clear proctitle in audit context to allow replacement */
+	audit_proctitle_free(audit_context());
 	audit_bprm(bprm);
 	trace_sched_process_exec(current, old_pid, bprm);
 	ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
diff --git a/include/linux/audit.h b/include/linux/audit.h
index 45abb3722d30..03ae563ca348 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -320,6 +320,7 @@ static inline void audit_cfg_lsm(const struct lsm_id *lsmid, int flags)
 /* These are defined in auditsc.c */
 				/* Public API */
 extern int  audit_alloc(struct task_struct *task);
+extern void __audit_proctitle_free(struct audit_context *context);
 extern void __audit_free(struct task_struct *task);
 extern void __audit_uring_entry(u8 op);
 extern void __audit_uring_exit(int success, long code);
@@ -353,6 +354,11 @@ static inline bool audit_dummy_context(void)
 	void *p = audit_context();
 	return !p || *(int *)p;
 }
+static inline void audit_proctitle_free(struct audit_context *context)
+{
+	if (unlikely(!audit_dummy_context()))
+		__audit_proctitle_free(context);
+}
 static inline void audit_free(struct task_struct *task)
 {
 	if (unlikely(task->audit_context))
@@ -470,6 +476,7 @@ static inline void audit_bprm(struct linux_binprm *bprm)
 	if (unlikely(!audit_dummy_context()))
 		__audit_bprm(bprm);
 }
+
 static inline int audit_socketcall(int nargs, unsigned long *args)
 {
 	if (unlikely(!audit_dummy_context()))
@@ -605,6 +612,8 @@ static inline int audit_alloc(struct task_struct *task)
 {
 	return 0;
 }
+static inline void audit_proctitle_free(struct audit_context *context)
+{ }
 static inline void audit_free(struct task_struct *task)
 { }
 static inline void audit_uring_entry(u8 op)
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..69484ab2c8bc 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -913,7 +913,7 @@ void audit_filter_inodes(struct task_struct *tsk, struct audit_context *ctx)
 	rcu_read_unlock();
 }
 
-static inline void audit_proctitle_free(struct audit_context *context)
+void __audit_proctitle_free(struct audit_context *context)
 {
 	kfree(context->proctitle.value);
 	context->proctitle.value = NULL;
@@ -1086,7 +1086,7 @@ static inline void audit_free_context(struct audit_context *context)
 {
 	/* resetting is extra work, but it is likely just noise */
 	audit_reset_context(context);
-	audit_proctitle_free(context);
+	__audit_proctitle_free(context);
 	free_tree_refs(context);
 	kfree(context->filterkey);
 	kfree(context);
-- 
2.43.5

