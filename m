Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FC21A9FA8
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636251; cv=none; b=ffh//6K6ARweWQza5hXWLPEToC/cc3LRZcHllytHB2epLWBnqDrzbhuRpVyvwKhQigP4wBbnuTXBzlQvCUm4mDfqD0x0bLdvPrWuFYIC2d0c3NiN2ujMwOAGVGApdjiUD4C3o2TlCnPFg2qxUs+nHkaXWLaa5DZY0tsDmmYMcuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636251; c=relaxed/simple;
	bh=OfGZ7AUeiJPcjTa/NY6QLIM4LTPZbuaFgV6FGA1KtY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EaPcvxZ/1FyFawpb2HGb6v75KtvoWmYCLEFGsHGYSActNOy7mDnyKiWUAKbcHHUW4SC8kNR4Po/DPSgSjZkLS8MqjRUaG9pBmpQPstfZAXJIbs3Q4xHKeifq7FFl223s2sNyXpbVzeqS/IgcO2OhvkuTFl+OZYtkTZpYzrLZMZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqF042L7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqF042L7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06A41F000E9;
	Thu,  9 Jul 2026 22:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636250;
	bh=Tj/MAvnir9DeW5WYFzT8Cvq+bgAVa01TFneC7nh31P0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cqF042L7BqakCLlYwb9cXOQ2dCQjhAM1UWP4msLDijM/GmT1AWdQws+P4X1qa9+JP
	 KlBy2uBdLp039jZ+CwJ+c65qgmJn2OZdOwKami5I7u2SnZGuNszWyTyfefxrcycMMQ
	 8UxxjWjIP/Ez/199K3Mb3CdcG9BS4X96A3lOIH1A74muHU1t1U5UD9+rtTpIBKet4/
	 CBKkdIXPuudvdkzT0JhturKae3ZZvCT/LLe8J3uEZ+QNe0Q9gkllt6Ce7JNfA+yblW
	 iqulgfeXcDMPTJVzh5YWVeVyXqFQX69DEhQ9UMMhHj/5mhqDVhWmj8ZXjMLjo5CWuD
	 rMyLQxMt7lOvw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:12 +0200
Subject: [PATCH v2 17/23] binfmt_misc: simplify check_special_flags()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-17-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OfGZ7AUeiJPcjTa/NY6QLIM4LTPZbuaFgV6FGA1KtY4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHy7nhRstWOBmoNyDLPSOeWe2wZL+PQP6C1bX/l8+
 z3BCe8+dZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE4DgjQ3fQ/8W7Ao9sLBAo
 nlttdiQi2j/lTzXv/4s6fBLfxKocwhkZLqev/3bJy+l4w5LNl3OqD3oel7/wv8xlmU+HSNT9rDd
 mzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Replace the cont flag and the pointer increment repeated in every
case with a for loop that returns from the default case, and shrink
the multi-line 'C implies O' remark to one line.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 4267f66128c4..1536e398aa67 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -309,43 +309,31 @@ static char *scanarg(char *s, char del)
 	return s;
 }
 
-static char *check_special_flags(char *sfs, struct binfmt_misc_entry *e)
+static char *check_special_flags(char *p, struct binfmt_misc_entry *e)
 {
-	char *p = sfs;
-	int cont = 1;
-
-	/* special flags */
-	while (cont) {
+	for (;; p++) {
 		switch (*p) {
 		case 'P':
 			pr_debug("register: flag: P (preserve argv0)\n");
-			p++;
 			e->flags |= MISC_FMT_PRESERVE_ARGV0;
 			break;
 		case 'O':
 			pr_debug("register: flag: O (open binary)\n");
-			p++;
 			e->flags |= MISC_FMT_OPEN_BINARY;
 			break;
 		case 'C':
 			pr_debug("register: flag: C (preserve creds)\n");
-			p++;
-			/* this flags also implies the
-			   open-binary flag */
-			e->flags |= (MISC_FMT_CREDENTIALS |
-					MISC_FMT_OPEN_BINARY);
+			/* C implies O */
+			e->flags |= MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_BINARY;
 			break;
 		case 'F':
 			pr_debug("register: flag: F: open interpreter file now\n");
-			p++;
 			e->flags |= MISC_FMT_OPEN_FILE;
 			break;
 		default:
-			cont = 0;
+			return p;
 		}
 	}
-
-	return p;
 }
 
 /*

-- 
2.53.0

