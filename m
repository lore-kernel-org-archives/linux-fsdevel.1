Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468768;
	b=S5zbfqOzTyAxM8K2c+gbSZhxa3xs769aP2iIDLZstfToIdunlcY8jPjqaYXMJl7QSkkb
	 ie8MUX2wdgJpts85XI1mykfX6m/HH5b9sXtCCiWZKJ9ISk9V4IJgR7bLXszds2GqAMMy/
	 OJiksXOq4rHsbz2ovG7rkgxrVbuoA72KsoutWD7QfP3VB2dW3XGI0XIoJg63k0DSaxxrO
	 nuzcTdVliW2bC0V91x4sJ7WeRHIFupttRDA1LUKlQb1DbI6yD/i3W6qMNyk0lIM+/mRaS
	 3vFJViYd1X3egqtEiXlO57M04VaXYDlIw5we4dVwpGnIQZ0X83TdKGxwQ9Dopp+4MiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468768;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=0ObW9Yx+qWLsXjEDMVy3psMDuJaghQZedLXpxrcvDdE=;
	b=1VMImaltX3kHQobFZzuIhTniEpQ7jBjnuWnzAWret3ENiOImGAbvRCJnCZ+UMChpLXF1
	 qcNsGJ1p3YAjEiY1zhWHPv5ZFLhNF9+bSRlwAeALs3HUGkx6KQWkpYCGcjKphx6XYDS+Y
	 fQPJV8nDtNpMFAaSrNTJDlt4jq+C+N6s4OAFxkuz4uKY2BIyCiL5rQ5oeeqOM7Z6oG3LS
	 Q83UXQk9iHgOhi+dm6pH+UeUwwYejjTCjYpN7WgPkJk4PqEA3V5qxtSGyr4UoIzNioj/l
	 YNR402XtbrpgRdi5MdUqZQ/9h03Q32PudKuq/DtvuBvjYSszfusMu1N86Zd4LJnOzJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qteqodOj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6EitxnqZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qteqodOj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6EitxnqZ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF81606A31A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 03:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF81606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qteqodOj;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6EitxnqZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qteqodOj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6EitxnqZ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5625421CEF;
	Tue, 20 Oct 2026 03:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792468765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0ObW9Yx+qWLsXjEDMVy3psMDuJaghQZedLXpxrcvDdE=;
	b=qteqodOjmb4uBfz4wVBRgYiDnr/AP+iniiuwx+ZjfyH2QX0zVWGiJ8u1e+NT5G5WMLyEef
	hb1OblVOp/XSJWk3/3UtjMnIN3JsQpo/koFZ2j0C9PJxw0VUkKqtoWbObdlDh0JmnC3men
	zZs9ef3w1kPDpiiBncwEPSrDM5Lj4jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792468765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0ObW9Yx+qWLsXjEDMVy3psMDuJaghQZedLXpxrcvDdE=;
	b=6EitxnqZGz5hkjMnCcByZDT01Gju6mCWQ/gPspXiAenH6Bk2bGJ2sEnLaLpuz4ydid24aC
	70wQxGFQpOcXpnCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792468765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0ObW9Yx+qWLsXjEDMVy3psMDuJaghQZedLXpxrcvDdE=;
	b=qteqodOjmb4uBfz4wVBRgYiDnr/AP+iniiuwx+ZjfyH2QX0zVWGiJ8u1e+NT5G5WMLyEef
	hb1OblVOp/XSJWk3/3UtjMnIN3JsQpo/koFZ2j0C9PJxw0VUkKqtoWbObdlDh0JmnC3men
	zZs9ef3w1kPDpiiBncwEPSrDM5Lj4jU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792468765;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0ObW9Yx+qWLsXjEDMVy3psMDuJaghQZedLXpxrcvDdE=;
	b=6EitxnqZGz5hkjMnCcByZDT01Gju6mCWQ/gPspXiAenH6Bk2bGJ2sEnLaLpuz4ydid24aC
	70wQxGFQpOcXpnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DEA04136C6;
	Tue, 20 Oct 2026 03:59:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4gBjKBzn1moHKQAAD6G6ig
	(envelope-from <krisman@suse.de>); Tue, 20 Oct 2026 03:59:24 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: hughd@google.com,
	baolin.wang@linux.alibaba.com
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Daniel Tang <danielzgtg.opensource@gmail.com>,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH] shmem: Report casefold setting in mount options
Date: Mon, 19 Oct 2026 23:59:17 -0400
Message-ID: <20261020035917.693478-1-krisman@suse.de>
X-Mailer: git-send-email 2.56.0
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
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,suse.de,gmail.com];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Level: 
X-Spam-Flag: NO

For shmem, casefolding is a mount option.  Report the current encoding
and casefolding flags in /proc/mounts, so userspace can easily check if
casefolding is supported withour relying on parsing dmesg or trying to
set +F.

Reported-by: Daniel Tang <danielzgtg.opensource@gmail.com>
Link: https://lore.kernel.org/linux-fsdevel/5193732.31r3eYUQgx@daniel-desktop3/#R
Tested-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 mm/shmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 848316eaa7f4..bf3b19ed2e44 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4919,6 +4919,17 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	if (sbinfo->qlimits.grpquota_ihardlimit)
 		seq_printf(seq, ",grpquota_inode_hardlimit=%lld",
 			   sbinfo->qlimits.grpquota_ihardlimit);
+#endif
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (root->d_sb->s_encoding) {
+		unsigned int version = root->d_sb->s_encoding->version;
+
+		seq_printf(seq, ",casefold=utf8-%u.%u.%u",
+			   unicode_major(version), unicode_minor(version),
+			   unicode_rev(version));
+		if (sb_has_strict_encoding(root->d_sb))
+			seq_puts(seq, ",strict_encoding");
+	}
 #endif
 	return 0;
 }
-- 
2.56.0

