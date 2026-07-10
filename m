Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936433F8EB7
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676025; cv=none; b=r8x3fWoVs3v4j3xNEi0vkz9RV6F/UHwQYm6ClMfgHLvrf2RPHAmWvsQhQa6OO+/l5TpgjcXf4zGt8GRzdYxsbnu9PWkPVW0sMjqNsnW2eXjmhwz4JBYx79WOkS/SQMJJKYpkb8dwFCgUUBCMuz26wMBicb9PgNABX9tNue8ZoQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676025; c=relaxed/simple;
	bh=oOA9u8v9W3WVNuPiNiYwV6QBxJ629SxKoIUve4uHjjM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cy1gNeOrqbqtxZ/vW+gu1CcmtyUutpBcVy8U0as6m1wPKUDe6wDGGpLgWOQLrOKf8X+1KQT8whwrlff1JJafOL5K8IBzBJxQpcmc5+PqDcn0lNNL5QS1/dDd1kEUBqtP76R4MJ1fO+5Or9xaAkv8CfiAMMGGmgHaXASr3195BRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwnQ+sHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwnQ+sHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D99ED1F00A3E;
	Fri, 10 Jul 2026 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676022;
	bh=ZzgT+NAn5jg3W3R0UKNJyOYlRco2bIMUb8glGg/yjWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KwnQ+sHzG6+1jWd/4tnB6t8x1UofEX+ReHrYe5lDYLHCElLACmJYl5V8U3BoW7Tsj
	 4i8hAXcWqUx9fjNNapMTwGUm2tygYj3A46eYVgsH5GQ6a5cjd/L/pMbw+K+suFsfsn
	 26+0mTqnb5AZtaHMMI933hp/JcgiqNudQ6gWw38MNYP5LUYVMwnqXJdIEpd/XswJgZ
	 yLOqUPkix1hoKepvTqPYbkd+BGrGOTpmYayeTqez6CQgr9smeGDxUSUt1npVIDXIWc
	 QZtX7AjqnlJ9rQcrsoa6511mppnbnKdQufv1fJCIDdffCCpLMgY+u4Dbwz+unN9vlJ
	 EST0z2xzW80SQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:12 +0200
Subject: [PATCH v3 11/24] binfmt_misc: use print_hex_dump_debug() for the
 register debug output
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-11-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oOA9u8v9W3WVNuPiNiYwV6QBxJ629SxKoIUve4uHjjM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7Ilr92rfvCTxyMR7ZzNlV8S+7t2svf+Cc/rJ00dZ4
 nxORFYWdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkSIGR4Z1a/xHZJE7nI4vv
 HLLWCTihPVdLeKL0pgtvbK56Gm648IKRofex6Y3KFi2BjhPHjbM+6//yWsz3M1lT4ekc3ZMtXpy
 yLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The hex dumps in create_entry() are compiled out unless someone edits
the file to define DEBUG while the pr_debug() calls right next to
them are dynamic-debug aware. Switch the dumps to
print_hex_dump_debug() which follows the same rules as pr_debug() so
the register parsing debug output is uniformly controlled through
dynamic debug, and remove the USE_DEBUG machinery.

Drop the magic[masked] dump instead of converting it: it printed the
bitwise AND of two buffers dumped right above it and required a
temporary allocation on every registration just to recompute what
the reader can derive from the magic and mask dumps directly.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 52 +++++++++++++++-------------------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 96f9ac752511..252e1f2a8347 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -32,12 +32,6 @@
 
 #include "internal.h"
 
-#ifdef DEBUG
-# define USE_DEBUG 1
-#else
-# define USE_DEBUG 0
-#endif
-
 /* Entry status and match type bit numbers. */
 enum binfmt_misc_entry_bits {
 	MISC_FMT_ENABLED_BIT	= 0,
@@ -460,10 +454,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 			goto einval;
 		if (!e->magic[0])
 			goto einval;
-		if (USE_DEBUG)
-			print_hex_dump_bytes(
-				KBUILD_MODNAME ": register: magic[raw]: ",
-				DUMP_PREFIX_NONE, e->magic, p - e->magic);
+		print_hex_dump_debug(
+			KBUILD_MODNAME ": register: magic[raw]: ",
+			DUMP_PREFIX_NONE, 16, 1, e->magic, p - e->magic, true);
 
 		/* Parse the 'mask' field. */
 		e->mask = p;
@@ -473,10 +466,12 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 		if (!e->mask[0]) {
 			e->mask = NULL;
 			pr_debug("register:  mask[raw]: none\n");
-		} else if (USE_DEBUG)
-			print_hex_dump_bytes(
+		} else {
+			print_hex_dump_debug(
 				KBUILD_MODNAME ": register:  mask[raw]: ",
-				DUMP_PREFIX_NONE, e->mask, p - e->mask);
+				DUMP_PREFIX_NONE, 16, 1, e->mask, p - e->mask,
+				true);
+		}
 
 		/*
 		 * Decode the magic & mask fields.
@@ -492,30 +487,13 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
 		    BINPRM_BUF_SIZE - e->size < e->offset)
 			goto einval;
 		pr_debug("register: magic/mask length: %i\n", e->size);
-		if (USE_DEBUG) {
-			print_hex_dump_bytes(
-				KBUILD_MODNAME ": register: magic[decoded]: ",
-				DUMP_PREFIX_NONE, e->magic, e->size);
-
-			if (e->mask) {
-				int i;
-				char *masked = kmalloc(e->size, GFP_KERNEL_ACCOUNT);
-
-				print_hex_dump_bytes(
-					KBUILD_MODNAME ": register:  mask[decoded]: ",
-					DUMP_PREFIX_NONE, e->mask, e->size);
-
-				if (masked) {
-					for (i = 0; i < e->size; ++i)
-						masked[i] = e->magic[i] & e->mask[i];
-					print_hex_dump_bytes(
-						KBUILD_MODNAME ": register:  magic[masked]: ",
-						DUMP_PREFIX_NONE, masked, e->size);
-
-					kfree(masked);
-				}
-			}
-		}
+		print_hex_dump_debug(
+			KBUILD_MODNAME ": register: magic[decoded]: ",
+			DUMP_PREFIX_NONE, 16, 1, e->magic, e->size, true);
+		if (e->mask)
+			print_hex_dump_debug(
+				KBUILD_MODNAME ": register:  mask[decoded]: ",
+				DUMP_PREFIX_NONE, 16, 1, e->mask, e->size, true);
 	} else {
 		/* Handle the 'E' (extension) format. */
 

-- 
2.53.0

