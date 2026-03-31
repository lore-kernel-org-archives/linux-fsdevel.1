Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D73C3590A9
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940772; cv=none; b=jmeDAlZOAB0K4L6PQiz2CN8uIIccxilX4PHIXCVe510EfcY/6dNNbKYaHZKweBQPoIMMNGQh5v1OzQD7exV3RMwY5MisQPm5uXBApkBYOaahlaszYxui/LoGj4XJUPmrwx/MmSs0hR92ZdVBZLahU5YghlsXA2o7GKRBUIG7bqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940772; c=relaxed/simple;
	bh=ao2Xi9Wl17PViMKf6WGBjsNBt7xhaL8Ei3caE2OL2JE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxKZ6xK1MmPGb2612SIGLOrpvQ2+U7XAyjsM1YavELt8ICIz/A9CUUOcqPCwvbcSUUgICVGc2vRKZAYXwXdEmZFvNShpUiNo5cxLebKJJZ8tpmdgBCORka2XbOuqSOB0m1aQYNI1ga+OILgm37HxTsEMcr7OY8k96m8QsL9vN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DDEDA4D549;
	Tue, 31 Mar 2026 07:06:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5CBE4A0A2;
	Tue, 31 Mar 2026 07:06:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aKwoJ11yy2mEQAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 31 Mar 2026 07:06:05 +0000
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
Subject: [PATCH v5 5/6] vsprintf: Revert "add simple_strntoul"
Date: Tue, 31 Mar 2026 17:57:35 +1100
Message-ID: <20260331070519.5974-6-ddiss@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: DDEDA4D549
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

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

