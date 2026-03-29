Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DEA314D16
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781632; cv=none; b=sk2pbCj6ZG5W+ktBz/0ISTqNXeWZU6v/gF0spFGHWrcp/AYKHM95yoepzQWh95yAhBZIs8nO/9hs3jXqnZ9BY/SRjTVvg2lJejUqPY58hZpoDhrllvTleEm2LAE8pzVAjnDGu4XXD9jfh2uBMFnMsD43vh0MzxjkVW/HKboUvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781632; c=relaxed/simple;
	bh=ao2Xi9Wl17PViMKf6WGBjsNBt7xhaL8Ei3caE2OL2JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngdSSgCP+NsV+4/Knf1bpAX4KV3LbXD62+R2SsbmtopVVGaJfCDM05M2e7Zea1E+L8RgCGpQF6l3o07r60keFLOROW9Dey+4QOaWXav4GwK1f/wtcOgrjW0dnBogM8+xK3EoU/5Gi+qRIspIFAGVXwBtc8Wv2z8NYyXAwJa8PfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=msLpZ3p2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d9+kxp+0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=msLpZ3p2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d9+kxp+0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="msLpZ3p2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d9+kxp+0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="msLpZ3p2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d9+kxp+0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A1D24D4F5;
	Sun, 29 Mar 2026 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774781629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxihrPW/nLjv8olLis478LzU+j9xw1IS6YSy+0ZMlcA=;
	b=msLpZ3p2JF9Le5y/P2RMl0uzijmZt4QDgS82P0KFMZeePfbf+E588b8+ymlVm5oQyzxrYw
	Po/uXCWXG6hUzh3bjx1gJ5j21oz4921ybaFvEbmTNqUaaKcIMyEVMpc+nNZTPfE4WOrSW0
	QRvroVFylFzy5QVA+BK/AUSQFhgIOYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774781629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxihrPW/nLjv8olLis478LzU+j9xw1IS6YSy+0ZMlcA=;
	b=d9+kxp+0D5yJq/72WUMEtOq8D2SgojZ5a/ERJaBawBd67R1sVLt8IVWVMkHX6rJ6AqsN5E
	e+wMa07V/p88e6Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774781629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxihrPW/nLjv8olLis478LzU+j9xw1IS6YSy+0ZMlcA=;
	b=msLpZ3p2JF9Le5y/P2RMl0uzijmZt4QDgS82P0KFMZeePfbf+E588b8+ymlVm5oQyzxrYw
	Po/uXCWXG6hUzh3bjx1gJ5j21oz4921ybaFvEbmTNqUaaKcIMyEVMpc+nNZTPfE4WOrSW0
	QRvroVFylFzy5QVA+BK/AUSQFhgIOYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774781629;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxihrPW/nLjv8olLis478LzU+j9xw1IS6YSy+0ZMlcA=;
	b=d9+kxp+0D5yJq/72WUMEtOq8D2SgojZ5a/ERJaBawBd67R1sVLt8IVWVMkHX6rJ6AqsN5E
	e+wMa07V/p88e6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81AA24A0A2;
	Sun, 29 Mar 2026 10:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aLfRDrkEyWkqcwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Sun, 29 Mar 2026 10:53:45 +0000
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
Subject: [PATCH v4 5/6] vsprintf: Revert "add simple_strntoul"
Date: Sun, 29 Mar 2026 21:30:27 +1100
Message-ID: <20260329105307.2876-6-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260329105307.2876-1-ddiss@suse.de>
References: <20260329105307.2876-1-ddiss@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
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

No users anymore and none should be in the first place.

This reverts commit fcc155008a20fa31b01569e105250490750f0687.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Disseldorp <ddiss@suse.de>
Acked-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/kstrtox.h | 1 -
 lib/vsprintf.c          | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/kstrtox.h b/include/linux/kstrtox.h
index 6ea897222af1d..7fcf29a4e0de4 100644
--- a/include/linux/kstrtox.h
+++ b/include/linux/kstrtox.h
@@ -143,7 +143,6 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
  */
 
 extern unsigned long simple_strtoul(const char *,char **,unsigned int);
-extern unsigned long simple_strntoul(const char *,char **,unsigned int,size_t);
 extern long simple_strtol(const char *,char **,unsigned int);
 extern unsigned long long simple_strtoull(const char *,char **,unsigned int);
 extern long long simple_strtoll(const char *,char **,unsigned int);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 800b8ac49f53f..52ea14a08d3a5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -129,13 +129,6 @@ unsigned long simple_strtoul(const char *cp, char **endp, unsigned int base)
 }
 EXPORT_SYMBOL(simple_strtoul);
 
-unsigned long simple_strntoul(const char *cp, char **endp, unsigned int base,
-			      size_t max_chars)
-{
-	return simple_strntoull(cp, endp, base, max_chars);
-}
-EXPORT_SYMBOL(simple_strntoul);
-
 /**
  * simple_strtol - convert a string to a signed long
  * @cp: The start of the string
-- 
2.51.0

