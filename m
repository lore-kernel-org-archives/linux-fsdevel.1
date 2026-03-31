Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A243B6379
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940777; cv=none; b=Trqtes7sHNvdvht3TqLbm4kEnoSZETaksACR/9CQ2baCS2ZxuJY6/VipPvfQqCstVAbes/s5Xpe0YR9BOOVqw11M1AM/BGxglAAHGxLvALl8l1tu66yW53X1JlYSHQoYf0yK7oMki5o7atgyFRd1KILIOGvNYUqT9EWBwYZaDYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940777; c=relaxed/simple;
	bh=NtdlBhQV2VlxX2h7MdXsFGBQD9aeOUTYJysty5gVNJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8UpedTWApm40EGqK0jyMeZTnjXwDlIQayDtwNjCFkEbf0GssCy951gyTYt2xTAJ6zbvFWdcQnVx0qnys0sa5zDXb6NLYDbIx53uWHZCmbVyXy6yOMa6WSc1wy37VGhvEjUCGuurtERP+Zh+DwUUoEJWKUVdEqufTXM/ffwENEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AqtJWMZg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tY6A6sTF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AqtJWMZg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tY6A6sTF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AqtJWMZg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tY6A6sTF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AqtJWMZg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tY6A6sTF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67FA35BEA1;
	Tue, 31 Mar 2026 07:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774940774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEicmogugLQP8Anuvmh2pN9+lvV3u9p8yS4Cd/a0rew=;
	b=AqtJWMZg7+Pb0YUcBN8kqA1oFNrK/3TpfltakkUCRr+N2fDp12jWM0y7t5W3CABS6f50JH
	eyqbJMW7BmaA5t7cp/OkSqcDwH9Ib43WQi/bfLtNF/UcqCOw7HybSZz1x+O9ZPZ7o4LZHM
	PLhpecl1/p7Z1n0qJRW61RcL/MON+Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774940774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEicmogugLQP8Anuvmh2pN9+lvV3u9p8yS4Cd/a0rew=;
	b=tY6A6sTF/Qu7fhbW0+sOY8thP+TiaRnXF8ayLD1ssCzLfg93hlaZcjsGCQFdGlWZznSRLS
	/2YS0oBKVcJHgUCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774940774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEicmogugLQP8Anuvmh2pN9+lvV3u9p8yS4Cd/a0rew=;
	b=AqtJWMZg7+Pb0YUcBN8kqA1oFNrK/3TpfltakkUCRr+N2fDp12jWM0y7t5W3CABS6f50JH
	eyqbJMW7BmaA5t7cp/OkSqcDwH9Ib43WQi/bfLtNF/UcqCOw7HybSZz1x+O9ZPZ7o4LZHM
	PLhpecl1/p7Z1n0qJRW61RcL/MON+Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774940774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mEicmogugLQP8Anuvmh2pN9+lvV3u9p8yS4Cd/a0rew=;
	b=tY6A6sTF/Qu7fhbW0+sOY8thP+TiaRnXF8ayLD1ssCzLfg93hlaZcjsGCQFdGlWZznSRLS
	/2YS0oBKVcJHgUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F68F4A0A2;
	Tue, 31 Mar 2026 07:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uI1VCmJyy2mEQAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 31 Mar 2026 07:06:10 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Disseldorp <ddiss@suse.de>,
	Petr Mladek <pmladek@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v5 6/6] kstrtox: Drop extern keyword in the simple_strtox() declarations
Date: Tue, 31 Mar 2026 17:57:36 +1100
Message-ID: <20260331070519.5974-7-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260331070519.5974-1-ddiss@suse.de>
References: <20260331070519.5974-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,intel.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLg9cg5ahbkfmeaz1ygcd5onax)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is legacy 'extern' keyword for the exported simple_strtox()
function which are the artefact that can be removed. So drop it.

While at it, tweak the declaration to provide parameter names.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
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

