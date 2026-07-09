Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E630C179
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636261; cv=none; b=Rglyu25avItFPACWugJTJG/HLfQhEz3P8Bv1on/DnczzVFkHNPOvf3Fqn1xSEbwtF4OnPV/Ad+kjV8cjv14ZTewChICCKm25iJfMqwZhz4cuo8uk80Jy8LECNjhkqrQI5YRutIL6r74OO8fwQVYHrqssNelTAXNHoSNoHa7QuRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636261; c=relaxed/simple;
	bh=zjcToFTi/b8LBXp7pn3SKXOJi5PklAi6PPGbhZqIVt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AuBg9IsV9H2KOFPUMYFjBmoBcjxyiKGFi5nXM338rQQS0AqyNBLIwf9N3G0Wb7qYmAQ52A8mjHgWKxV6rpr+3JAo9mV3bSuEgd8Yd9QBZjXed3ixqoRmir0uNqwk/PoUwA5ttgXE20EwuzC57/0cy5O618gyctjQE35yN8pPZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwM3V6va; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwM3V6va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B4B1F00A3A;
	Thu,  9 Jul 2026 22:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636259;
	bh=DPDx1vQrB1AgHb6k+MV04TDD1FmulFHOlgEYVxZySHA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AwM3V6vagPHO+whU7hM1PBJbul2gJsXD/5TBEUtSaX3pvxNDeU7GvYydu/FrgczCH
	 t3NDO0JRYc5Lep8ZGfIfVFA/UNgIOIkE610FnlJxc0x5rrlUwfqDvJmIvC0Q2ZUIZ3
	 B8m39v7VxzyBa841xmWM30FuDGNpsi2RjN1Pxb2w97vf18l0WpxZ8HLYFY+BsbYPo2
	 U2HHSYjMJCYboAepPZ/BIrIioCsIFtsuGyF4c7vv53CXW6za/i8eLPY1eF4BLsAbUI
	 ZanfbI24GPFGticXgVvsFGQS7RixCFQVtotrxuShMded4oBcND0roqgqcWEvOpDC6X
	 enW9U0GDkMnNw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:17 +0200
Subject: [PATCH v2 22/23] binfmt_misc: include what is used
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-22-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zjcToFTi/b8LBXp7pn3SKXOJi5PklAi6PPGbhZqIVt4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHzjf1rBbcnSoXqLxaur+7PAp1UH6hLm1r7ftuARQ
 z1PnfGijlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8E2b4HzNFOmqKciyP77LL
 Pcu+LVPe4a3ZnqYyN2Ha0g8Bhx1XBzD8j5srcDkm66uMuGDupd1fIq/+63gy78akpRnvVzo1NH8
 05wUA
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
index 4c641cacdcc9..050e83c8533f 100644
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

