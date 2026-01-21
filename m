Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B315E47A0D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016506; cv=none; b=XGYQLlztd1UPE5SCetyL3GNWXSThlR9/b7p3ruzRFCpT7Z/+CLkcrQNlaZBv3zdy8BTlQKvI7UPAoqrBpnIungpldIhGBLXiScKkOnxZt80vnVSlY+TRelQpYpFHwtXjrpBaj+c4HDua1yl3pvvzcRRYDjqO7W18dFbWMvRfHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016506; c=relaxed/simple;
	bh=HJcYSL/lNSKy320k5x5zFvLYFTHYT9BrKPAdH8AzTzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZsd3mRXQuii4sCmZzkzT8E7oyiJqtD4IM3Z4/1juUYhPHlma/HsaclQp2sM2yXZWA3jIGuYw4Qnr16fzUv96evI05qm0+FAzPzGcnG7bh/qELUO7DSkT7K2+74XYst5MrWNBQ3O6dfvKHZW3NCOH2ISucIIAC2nIfFXrM3K9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v3tcJoDY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UCoxFljD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=v3tcJoDY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UCoxFljD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v3tcJoDY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UCoxFljD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v3tcJoDY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UCoxFljD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 765AA336F2;
	Wed, 21 Jan 2026 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiYUX0kSRYQCvC1yXctjEzXOPnr0KCULLaM9KkX98qY=;
	b=v3tcJoDYePcRd/EVzl1liqBup6LZHyyXU4/S3Op+iD6aMGBxdnkLH0luKGxoxvRz5+8Ner
	JHq/TPZY046OcraIfqDAws5+q3vw+iXQyPGzzHkx4cUKMp8rvVfVX07iXXgy7BOSo6il9N
	38/mZkYWJGXhM6DcXwedCFuqEuMloQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiYUX0kSRYQCvC1yXctjEzXOPnr0KCULLaM9KkX98qY=;
	b=UCoxFljDQPZ0cmLj1812x9V5prSjuumzpj+XWZLHnXIdQYnfmbIasPpropZ0D8iff8TBEt
	zs4mwQswqksb9QBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=v3tcJoDY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UCoxFljD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiYUX0kSRYQCvC1yXctjEzXOPnr0KCULLaM9KkX98qY=;
	b=v3tcJoDYePcRd/EVzl1liqBup6LZHyyXU4/S3Op+iD6aMGBxdnkLH0luKGxoxvRz5+8Ner
	JHq/TPZY046OcraIfqDAws5+q3vw+iXQyPGzzHkx4cUKMp8rvVfVX07iXXgy7BOSo6il9N
	38/mZkYWJGXhM6DcXwedCFuqEuMloQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016474;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IiYUX0kSRYQCvC1yXctjEzXOPnr0KCULLaM9KkX98qY=;
	b=UCoxFljDQPZ0cmLj1812x9V5prSjuumzpj+XWZLHnXIdQYnfmbIasPpropZ0D8iff8TBEt
	zs4mwQswqksb9QBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FAD33EA63;
	Wed, 21 Jan 2026 17:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2BccEpoMcWlbHQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 17:27:54 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 8/8] kstrtox: Drop extern keyword in the simple_strtox() declarations
Date: Thu, 22 Jan 2026 04:12:56 +1100
Message-ID: <20260121172749.32322-9-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121172749.32322-1-ddiss@suse.de>
References: <20260121172749.32322-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLtufeqg1sdi4a9xkadyw15ebt)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 765AA336F2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is legacy 'extern' keyword for the exported simple_strtox()
function which are the artefact that can be removed. So drop it.

While at it, tweak the declaration to provide parameter names.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/kstrtox.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 7fcf29a4e0de4..6c92828667704 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -142,9 +142,9 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  * Keep in mind above caveat.
  */
 
-extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern long simple_strtol(const char *,char **,unsigned int);
-extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
-extern long long simple_strtoll(const char *,char **,unsigned int);
+unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base);
+long simple_strtol(const char *cp, char **endp, unsigned int base);
+unsigned long long simple_strtoull(const char *cp, char **endp, unsigned int base);
+long long simple_strtoll(const char *cp, char **endp, unsigned int base);
 
 #endif	/* _LINUX_KSTRTOX_H */
-- 
2.51.0

