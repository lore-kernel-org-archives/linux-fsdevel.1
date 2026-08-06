Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C9A410D30
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051033; cv=none; b=SOO3rNyEs8QqiOQyhAmY/zT+rKddkFfq/sxqywmXDvasHBMQ64BPTAxO0ubw/oTVRlyApInI3eYZ9Zv9VkS0XvUBddoiu3l8BO+SUPfeJ5uk8tKB0V2uU1pzevhgpzUrS4z+cJAdnW/rVJNUg3kqgzIOKImJVFe9XGQe8QBA744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051033; c=relaxed/simple;
	bh=5giSW+VuC78TRko3EcOP03tq37ilLAxMqTC7jxgfgHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=NOktfRfSvU2UxsrRrUwYHrbc6kBd/Jgf5O++y5x0vuLMYmVdioVNklFgExv5NxRmJXymUPVTaxy3tTevho76JbeKGYG3WMa6JxAwqsM1YaxzfcuM1H0M4WzLbAcxkuqkiFNvbn2F80eFkrxIBArfb9Z8n3XXXMSjLATnBQiQEqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HeRtD8jM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeRtD8jM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786051031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2/Y/fkmMMH1hnVR5XrKLq76YlQnpc28qBAYVCT6RNms=;
	b=HeRtD8jMn8Grtzw0od1C15c3SLMqA1ditKj+0fzuct35sdOGPqTb8WFOA5AjPl+BQhWtjo
	+UxQJoQsLwaCPkn027i1awVOhcVCNnAdkOEavkmH8PwZH8NkZe4fofp4F+tzkwVJ1cKCRO
	PJy2z89eAsZ/lbCPQYUnPeg+SPabNTc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-e-_1UQ5NOUOrs-xNCu_0Ow-1; Thu,
 06 Aug 2026 17:17:09 -0400
X-MC-Unique: e-_1UQ5NOUOrs-xNCu_0Ow-1
X-Mimecast-MFC-AGG-ID: e-_1UQ5NOUOrs-xNCu_0Ow_1786051027
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C083D18002C8;
	Thu,  6 Aug 2026 21:17:06 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.74.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6797D1956049;
	Thu,  6 Aug 2026 21:17:04 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Roman Dolgikh <rmd4work@mail.ru>
Subject: [PATCH v2] audit: free proctitle in context so it can be re-set by fork on exec_binprm
Date: Thu,  6 Aug 2026 17:16:59 -0400
Message-ID: <c8581fcfb66e5cfb2e6e9b0e95f9b356b2245b7b.1785261601.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Between the actual process startup (fork systemd) and the executable file
replacement (exec), systemd sets a temporary file name (executable file
name in parentheses). If an auditable system call occurs at this point,
the audit context will latch the temporary process name into the cache.
This name will not change again. The patch clears proctitle into the
audit cache when the exec call is made, allowing the new process name to
be latched.

Suggested-by: Roman Dolgikh <rmd4work@mail.ru>
Link: https://github.com/user-attachments/files/20751461/fix_audit_proctitle.txt
Link: https://github.com/linux-audit/audit-kernel/issues/170
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Changelog:
v2: simplified to call single use directly before need in audit_bimprm
---
 kernel/auditsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6610e667c728..c12b5dfcb279 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2601,6 +2601,8 @@ void __audit_bprm(struct linux_binprm *bprm)
 {
 	struct audit_context *context = audit_context();
 
+	/* clear proctitle in audit context to allow replacement */
+	audit_proctitle_free(audit_context());
 	context->type = AUDIT_EXECVE;
 	context->execve.argc = bprm->argc;
 }
-- 
2.43.5

