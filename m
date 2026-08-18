Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0A3812DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787077760; cv=none; b=oluvozRqLxtZtJl9tGGerORLZlw3XkhOZ7pr/uAvJDpHpjG888+Bu2dp0M0fZpx0bm80HvQZS+3iQYgxPSRFIxWrCxIzJ9uTDCpp7vDHtfA2WAOPSUHq5mw/gN1tjX3SseuUzJ4IQuoUwUpOxnbIgQwPNpdpZqr2GCwIkfHXe4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787077760; c=relaxed/simple;
	bh=k/+ApJt3P3zMqFz21NN375NrfmjJgVvN8ar7Y/vPu4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=FCUtxAbwgWmyoIBgGjhiPbIaeV3S+1vw4qwcXoUOVQ/8Yt3/chxuutbPtUZMjhnGf7w7UMly9tRxwxtiON91EwUSAk9K/a+reFFces1CECB1a7Y/HmLcEMaKO5U7DrquARiu64Eq/m54xS8clXGjzWGaAdJCBAHTD5Poc5leN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BaMycFIb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaMycFIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787077757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E6WoPLdui5hJShuUBNt4cps69fDTpty5hKi5ZAV1Mr8=;
	b=BaMycFIb+PN6wjL56F2R9yS8LaN2SXd1tMxTU4bLzscpcHQ0UnmjDZvyd2nYIp40vyphVh
	FjKrWmJR6mHWY4kvZIUuJYl6ceCWKBYegnFKZwrYPyOjeUCRwkaoC82IVRQ3QuNGNNi0PG
	kZsdfh6t8LbnkiIoyklH98aUaLjIn4I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-iBRWyX7LN3iXibK8SivaWA-1; Tue,
 18 Aug 2026 14:29:14 -0400
X-MC-Unique: iBRWyX7LN3iXibK8SivaWA-1
X-Mimecast-MFC-AGG-ID: iBRWyX7LN3iXibK8SivaWA_1787077752
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 439E318001E6;
	Tue, 18 Aug 2026 18:29:12 +0000 (UTC)
Received: from madcap2.tricolour.com (unknown [10.22.74.2])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61E441800346;
	Tue, 18 Aug 2026 18:29:07 +0000 (UTC)
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@parisplace.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Richard Guy Briggs <rgb@redhat.com>,
	Roman Dolgikh <rmd4work@mail.ru>,
	Ricardo Robaina <rrobaina@redhat.com>
Subject: [PATCH v3] audit: free proctitle in context so it can be re-set by fork on exec_binprm
Date: Tue, 18 Aug 2026 14:28:53 -0400
Message-ID: <ef5bf18a4b3805ec0fe5fb638963ccbdfc01d6fe.1787077711.git.rgb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
---
 kernel/auditsc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2b9ce0b52511..ee7e53d2cd52 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -2601,6 +2601,8 @@ void __audit_bprm(struct linux_binprm *bprm)
 {
 	struct audit_context *context = audit_context();
 
+	/* clear proctitle in audit context to allow replacement */
+	audit_proctitle_free(context);
 	context->type = AUDIT_EXECVE;
 	context->execve.argc = bprm->argc;
 }
-- 
2.43.5

