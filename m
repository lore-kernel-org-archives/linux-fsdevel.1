Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B03B27D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636238; cv=none; b=s4I2UCTJpe5iCQTyZiZrkzHozvHl9YVNDbrEo2eIecIz7KTkM0Vjnl1MtLDAH//j2HnBmflBhj6fQAbHd3MHmd6D2avCkx6hVIy0ag/q3Z1fxBJzXiagSDVori3oI1Kj+PLjq0Xhb3+Ob11y2Ndm6J5T7prIKi9ax0rXJnRGJ4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636238; c=relaxed/simple;
	bh=Hnx9I6YXPdW4DfS6oMHkO6Onu8cYJIsXRERI4Hns+l4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmDyhU/01K7LzPwrzNufuIkOfC006C4tc9EfJddlAbsz/YHGqN+OIqFpjFtkFK9WlJloSaw9WKAXQV/tt9EjbPJ5JRiM8QPWNCJ34bWNaiH0TqnvUebX+sZJ8TUktZntZbso25JwZ58raeyeu5AeUvHHD9QESzvmIbxEO49Ve98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlLvCASp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlLvCASp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 252B51F00A3A;
	Thu,  9 Jul 2026 22:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636236;
	bh=qWpetlqy02guy981iF+sx2R5W7hc1Y+3cQLz8oP2Az0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TlLvCASp7aGXhq9FmTH92OZi2sGKbpiyHWiMOiByQymFxcb5xSQ1GFgq689LU9l40
	 7mQs0xW4xRuULr7rxqiyNVEPe6uSKPcumSm1h5hdp5APl5Ul5WdWQEIsFmZdKyAD+Z
	 wPdIcQ3jK3k4c7oLgnwTLV5WAhJ4rcZ9Zhali3bo9uvzExyx5yI80ptGe4MGRj6UJJ
	 ha28U7Us+FN1BEq2foEm9vM7RylOsxOIJjV6+NoaW0dHT/YHrMOTz+hmLNRFk6gSum
	 I4BbWPuV9C7pv4QE2TekdpkEj8F0Xsx2y2qheYe4SL83ubrOnZ/NZrBtZLg+ch6lo+
	 HsArRQg/rfYmg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:05 +0200
Subject: [PATCH v2 10/23] binfmt_misc: use print_hex_dump_debug() for the
 register debug output
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-10-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Hnx9I6YXPdW4DfS6oMHkO6Onu8cYJIsXRERI4Hns+l4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHxtu5O02Ev4Xuz17Gq7WR1e06OXuhnkCLmzJxZlX
 V0ikrmko5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKT6xj+J9z8O+OaY2qnmNyd
 zwIm7zv3FEf8ZLtfeJZrazO3d+2Zmwz/1L8wVZjN3lBRYdPaoPTvafF3yej2VcusJIU0v02OWB3
 PAAA=
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
index 947ef6dfd55b..2ac82925b8ed 100644
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
@@ -456,10 +450,9 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
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
@@ -469,10 +462,12 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
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
@@ -488,30 +483,13 @@ static struct binfmt_misc_entry *create_entry(const char __user *buffer,
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

