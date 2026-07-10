Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9C3F927B
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676046; cv=none; b=uDxIWwapm8NdEjFSN/w2i+r6vkfiTWboKe4RB+K0J5scT06LOXjSQB3SQmmAsxGKNue3K50Dcwho3hHM3GUYlhdqjL8StXSaRyog9r5weCp242UNzLARBjhsEBr+3Ow9iFmjyAVKzKCs3FvgxrF9uYclZ2Z+TLhpLyu1KdzIGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676046; c=relaxed/simple;
	bh=4GuuVyRng9OHFmylgBpD5RM8zjdQhkp8WOAwJFEG7Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4zcMzk/aSDAQ92ixr3VwOfsTZ+WgWdae1s6DQbj9XLH9ZyufJtVzIJxI6gK5JumU/Ccwa50isoZLlWiL0FF/9lfibi5m7ARGuSTaZuMq1RRPC3qYUtmhjNiCeUuhFw9K93Is134gqnW9VC2Y0VWePnGhjspMq6YAOMeyQUfaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIpRCako; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIpRCako"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86A31F000E9;
	Fri, 10 Jul 2026 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676045;
	bh=jXliMhF9wchTM8HndPmuEzU03cAlC7HEcmkW9Z3q90Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CIpRCako4iYtW5mJmd/n9uefv3LEN8Wf8XtkujJTIZDqEYSa5BNWNoOOpxcZMqM9+
	 1TtBqye4tzQTliRM08aUDBLeYbtoHVkDBzV2+tDZ60GlwTfq6U66PlxqmDPkmuLtGA
	 pHc4Y2o+5Y6yfUGs/8OhVDjMrrhIBYwjvRINNfm7S+M7VvhdpXuDczRLeYogQ5iDQu
	 sMhyFyAqbVG4FbExbXvl0UUfLem7bnyuRtHoQBnwbTT8J8CrE79KrGJmkonF6uMWAm
	 0b1KH8H0v4p/3ueDWUwd5+04FhI2R+aL7vE1kMITs7OroqFxh37L2yhO7i7DcPj6Gb
	 3j3G3UsbtzLZg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:24 +0200
Subject: [PATCH v3 23/24] binfmt_misc: include what is used
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-23-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4GuuVyRng9OHFmylgBpD5RM8zjdQhkp8WOAwJFEG7Us=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7IlnXGx/ZcVPrzfb1ERO2t7bvvthus3Xvs4W9tdX7
 7o9iJ7wvqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiPbwMPxmn9hnu2DQxXGhh
 3xOWxgmdiUmFyU83RPy3zbueN9VTdwfD/5qynQYTr23gN+q6FaT44NH9XrVd32RWPXWqrT+p9P7
 ZC14A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The include list still reflects code that left this file years ago:
nothing here uses sched/mm.h, pagemap.h, namei.h, syscalls.h or
anything from fs/internal.h anymore, mount.h and the bm_fs_type
forward declaration lost their last user when the pinned bm_mnt
machinery was removed. Drop all of that and instead spell out the
headers the file actually relies on but so far pulled in
transitively: bitops, bits, bug, cleanup, cred, kstrtox, printk,
refcount, string and user_namespace. With that nothing needs the
kernel.h grab bag anymore, so it goes too, and the list is sorted
alphabetically.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 189b9218e5a6..46c65a618b19 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -10,27 +10,29 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/sched/mm.h>
-#include <linux/magic.h>
 #include <linux/binfmts.h>
-#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/cred.h>
 #include <linux/ctype.h>
-#include <linux/string_helpers.h>
 #include <linux/file.h>
-#include <linux/pagemap.h>
-#include <linux/namei.h>
-#include <linux/mount.h>
+#include <linux/fs.h>
+#include <linux/fs_context.h>
+#include <linux/init.h>
+#include <linux/kstrtox.h>
+#include <linux/magic.h>
+#include <linux/module.h>
+#include <linux/printk.h>
 #include <linux/rculist.h>
+#include <linux/refcount.h>
 #include <linux/seq_file.h>
-#include <linux/fs_context.h>
-#include <linux/syscalls.h>
-#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/string_helpers.h>
 #include <linux/uaccess.h>
-
-#include "internal.h"
+#include <linux/user_namespace.h>
 
 /* Entry status and match type bit numbers. */
 enum binfmt_misc_entry_bits {
@@ -62,8 +64,6 @@ struct binfmt_misc_entry {
 	char buf[];			/* register string, fields point in here */
 };
 
-static struct file_system_type bm_fs_type;
-
 /*
  * Max length of the register string.  Determined by:
  *  - 7 delimiters

-- 
2.53.0

