Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3223B364053
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 17:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016491; cv=none; b=rzWomvXB993+NHYQD3kh81ormETYCbgLisIJ01q76vMUnoFX8FkXyEJ24hslm4bmPBGlsr/kSUbSDBxyuSAZ+F8Uj2J2b6msWUAQf+0tLC6ZLFpQ3lDI02rGhi3BD5FbmkYymZ+NrtpH0Pa9YSfrE47/sWjpfMZa1ezsha9Vxy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016491; c=relaxed/simple;
	bh=5/Y9hQKZ4OOZe1i0vEGDGNVSXMosZaJhMi/ItQkI7Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b++UVgsuZVYKO+1S4m9Hczsr8W7towWhYNF7KqcPdh5RxuLDGELjItwiVSfrLaAnZgHiRHRsK9CASx1i6xnEYvRfCB143rxZMbBvlkBJ2eBjfJ+Utp8t/0J+/0j0M6mAYs3f0jI/EAMvS3fjzoOHlqjLA8qzwJqnaXjFF9z0VWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QrZ+UCFf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zcy8P8aM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QrZ+UCFf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zcy8P8aM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QrZ+UCFf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zcy8P8aM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QrZ+UCFf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zcy8P8aM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7756336F0;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV8RRNcUeXfYtPEUeWIzBRyWQ3xrfntQTyQn7Z9VmYg=;
	b=QrZ+UCFfrnAkaA6xIyVvW3tqfhc/dZivSFyE7UmASxyhv5luMOUXGtoZJnJr1OynVCTI43
	A9HdS1pjmussLtynfnMOAn/3pNy44VlBGFS8xHYhQwnaLmC+DFJPxGNU2A+gzDTBmVSe/G
	ZmKjnaZN6D9tarYSkNC/uIyGygcXnd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV8RRNcUeXfYtPEUeWIzBRyWQ3xrfntQTyQn7Z9VmYg=;
	b=Zcy8P8aMeDgw8yWmWMUM3MnBvsrH2Snu+uxkJWqtmttTaYOhb6HBZ8u6zuZttYBgthPrw4
	DmZ3GzQStbumjyAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QrZ+UCFf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zcy8P8aM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1769016473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV8RRNcUeXfYtPEUeWIzBRyWQ3xrfntQTyQn7Z9VmYg=;
	b=QrZ+UCFfrnAkaA6xIyVvW3tqfhc/dZivSFyE7UmASxyhv5luMOUXGtoZJnJr1OynVCTI43
	A9HdS1pjmussLtynfnMOAn/3pNy44VlBGFS8xHYhQwnaLmC+DFJPxGNU2A+gzDTBmVSe/G
	ZmKjnaZN6D9tarYSkNC/uIyGygcXnd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1769016473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rV8RRNcUeXfYtPEUeWIzBRyWQ3xrfntQTyQn7Z9VmYg=;
	b=Zcy8P8aMeDgw8yWmWMUM3MnBvsrH2Snu+uxkJWqtmttTaYOhb6HBZ8u6zuZttYBgthPrw4
	DmZ3GzQStbumjyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F4643EA63;
	Wed, 21 Jan 2026 17:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mFOwHZkMcWlbHQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Wed, 21 Jan 2026 17:27:53 +0000
From: David Disseldorp <ddiss@suse.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 4/8] initramfs: Refactor to use hex2bin() instead of custom approach
Date: Thu, 22 Jan 2026 04:12:52 +1100
Message-ID: <20260121172749.32322-5-ddiss@suse.de>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: A7756336F0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is a simple_strntoul() function used solely as a shortcut
for hex2bin() with proper endianess conversions. Replace that
and drop the unneeded function in the next changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 init/initramfs.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 750f126e19a05..8d931ad4d239b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -6,6 +6,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/hex.h>
 #include <linux/init.h>
 #include <linux/init_syscalls.h>
 #include <linux/kstrtox.h>
@@ -21,6 +22,8 @@
 #include <linux/umh.h>
 #include <linux/utime.h>
 
+#include <asm/byteorder.h>
+
 #include "do_mounts.h"
 #include "initramfs_internal.h"
 
@@ -192,24 +195,25 @@ static __initdata u32 hdr_csum;
 
 static void __init parse_header(char *s)
 {
-	unsigned long parsed[13];
-	int i;
-
-	for (i = 0, s += 6; i < 13; i++, s += 8)
-		parsed[i] = simple_strntoul(s, NULL, 16, 8);
-
-	ino = parsed[0];
-	mode = parsed[1];
-	uid = parsed[2];
-	gid = parsed[3];
-	nlink = parsed[4];
-	mtime = parsed[5]; /* breaks in y2106 */
-	body_len = parsed[6];
-	major = parsed[7];
-	minor = parsed[8];
-	rdev = new_encode_dev(MKDEV(parsed[9], parsed[10]));
-	name_len = parsed[11];
-	hdr_csum = parsed[12];
+	__be32 header[13];
+	int ret;
+
+	ret = hex2bin((u8 *)header, s + 6, sizeof(header));
+	if (ret)
+		error("damaged header");
+
+	ino = be32_to_cpu(header[0]);
+	mode = be32_to_cpu(header[1]);
+	uid = be32_to_cpu(header[2]);
+	gid = be32_to_cpu(header[3]);
+	nlink = be32_to_cpu(header[4]);
+	mtime = be32_to_cpu(header[5]); /* breaks in y2106 */
+	body_len = be32_to_cpu(header[6]);
+	major = be32_to_cpu(header[7]);
+	minor = be32_to_cpu(header[8]);
+	rdev = new_encode_dev(MKDEV(be32_to_cpu(header[9]), be32_to_cpu(header[10])));
+	name_len = be32_to_cpu(header[11]);
+	hdr_csum = be32_to_cpu(header[12]);
 }
 
 /* FSM */
-- 
2.51.0

