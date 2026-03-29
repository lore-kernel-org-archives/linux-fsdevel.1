Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F064F31355C
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Mar 2026 10:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781623; cv=none; b=jFetntleKhrIb9fHe8OA2NkBWekPt1VnGKZ1986+RUGpiq3w21P97oRw1iOEdAzskCDamTvdh9YNw2qv+yYfgSerjcqp14Qz1wd/azeC+gMT50V5Y5+vtvcmwMkZPZX2/xiL5PDVcL2Ke4IpYJSvmhB0C5xSGdenRbYlJIbBYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781623; c=relaxed/simple;
	bh=1LTk4jsdk68clq9+RGJhf2C8O9FUoagnfRqW72nhv+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6SAePfim6zu+zxGvpetvRSPjvr2sVIoZwZtKByRx7XD0j6zsSC2ncCu4hSkM1fcJxzGxG3PTyeFiwXtzPPioy0tqruxLIjs2bVgUNsUR93Shfpj2CeAxEhxvFv6aoXNnWi0fcqNj9pyKWhwrz1QjIyBLPCHirPoZa2v8szeDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F3344D4F5;
	Sun, 29 Mar 2026 10:53:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 752304A0A2;
	Sun, 29 Mar 2026 10:53:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qJzDC7AEyWkqcwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Sun, 29 Mar 2026 10:53:36 +0000
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
Subject: [PATCH v4 3/6] initramfs: Sort headers alphabetically
Date: Sun, 29 Mar 2026 21:30:25 +1100
Message-ID: <20260329105307.2876-4-ddiss@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6F3344D4F5
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

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

