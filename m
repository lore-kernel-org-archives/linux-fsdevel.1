Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5BF3BBA0E
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940763; cv=none; b=Yh4JNX/31+EueT2TzEm5GBqEI+kQGX+Zl73JdtU+XTTsPyREf/fYFcjh9Bp5c/0qOhNZVPKtPDWam4PwhT+nKxIpLLN9wgsB3+jIigwe5SAlE8cq59sxiiHDYlovI/IGeOvDleiZQbY0N/ymz7pYZQk99lJ1MOsv/s3OXyZz4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940763; c=relaxed/simple;
	bh=1LTk4jsdk68clq9+RGJhf2C8O9FUoagnfRqW72nhv+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3/u2JXJiHjNP4DPRvXJNK58Po6JH+rqtpP7KT/L3mY8DRS7f/XyQBkBzK8CsIB+qIRAITMo4a65hbXfsQlGFLcd/KvbAYwRNIgVMLiF5gJ40JOZ2VGHHr0RRBR3QKdhwLzMbcNpLG6MxhzyO6CSyHBpJN7sUQ+IOieTUA+D4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w7bPTg3V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YI8rjdwx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w7bPTg3V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YI8rjdwx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w7bPTg3V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YI8rjdwx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w7bPTg3V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YI8rjdwx"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D75354D549;
	Tue, 31 Mar 2026 07:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774940760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzLtLqjxWRClqhR2bLCDjTKl4rcITvPBBsrVVdrHFZE=;
	b=w7bPTg3VYEOTo1c8j8hcDtKdSum9xcCNjwMsYbf6qN9w3Vvkq/q8G3oIlCR4HHgFrnQg2r
	Keannm9dwW6wszYavu4go5oKnEVEbo3tQ4naYs8Ope1xc9U0InYq1M0eComABl3/iDThWq
	ALJVSyJ1Bmk/kmH06ZpK+i8+xLVjs4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774940760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzLtLqjxWRClqhR2bLCDjTKl4rcITvPBBsrVVdrHFZE=;
	b=YI8rjdwxLUp7En7dspLKJbvbboUduit7B0cs7d29P2DlWzJoGxe2RNV4UzrtEoZJKv1UBA
	mRVqwKbs3ibj5EDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774940760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzLtLqjxWRClqhR2bLCDjTKl4rcITvPBBsrVVdrHFZE=;
	b=w7bPTg3VYEOTo1c8j8hcDtKdSum9xcCNjwMsYbf6qN9w3Vvkq/q8G3oIlCR4HHgFrnQg2r
	Keannm9dwW6wszYavu4go5oKnEVEbo3tQ4naYs8Ope1xc9U0InYq1M0eComABl3/iDThWq
	ALJVSyJ1Bmk/kmH06ZpK+i8+xLVjs4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774940760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzLtLqjxWRClqhR2bLCDjTKl4rcITvPBBsrVVdrHFZE=;
	b=YI8rjdwxLUp7En7dspLKJbvbboUduit7B0cs7d29P2DlWzJoGxe2RNV4UzrtEoZJKv1UBA
	mRVqwKbs3ibj5EDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF7064A0A2;
	Tue, 31 Mar 2026 07:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aJPKJVRyy2mEQAAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 31 Mar 2026 07:05:56 +0000
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
Subject: [PATCH v5 3/6] initramfs: Sort headers alphabetically
Date: Tue, 31 Mar 2026 17:57:33 +1100
Message-ID: <20260331070519.5974-4-ddiss@suse.de>
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
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,intel.com:email];
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sorting headers alphabetically helps locating duplicates, and makes it
easier to figure out where to insert new headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 139baed06589a..4ed796566cf35 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -1,25 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/init.h>
 #include <linux/async.h>
-#include <linux/export.h>
-#include <linux/fs.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/fcntl.h>
 #include <linux/delay.h>
-#include <linux/string.h>
 #include <linux/dirent.h>
-#include <linux/syscalls.h>
-#include <linux/utime.h>
+#include <linux/export.h>
+#include <linux/fcntl.h>
 #include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/init_syscalls.h>
 #include <linux/kstrtox.h>
 #include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/namei.h>
-#include <linux/init_syscalls.h>
-#include <linux/umh.h>
-#include <linux/security.h>
 #include <linux/overflow.h>
+#include <linux/security.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/syscalls.h>
+#include <linux/types.h>
+#include <linux/umh.h>
+#include <linux/utime.h>
 
 #include "do_mounts.h"
 #include "initramfs_internal.h"
-- 
2.51.0

