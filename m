Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F7A3F7A88
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676031; cv=none; b=hJn0ojDCw8A9XA6jqjK+qkA++yl1j/n6okaFByutpixGVngspCEVYsoXQd8fL7LND5qpEyjk1Xn6S38gnQRrJMAM6O0vpM9t2vSkM6AkWpQUH5oZwRh8idseFWh2fhkel0A1A3ob86eJUGTgQOtgcqIuleyJne9GS+GLwgV/cPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676031; c=relaxed/simple;
	bh=qqm2eAOnpJr7SnNA4N7fHD6KqzuTB+1Y/9elatuqZGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rt0eXTbYvhUf+dIUjWtpcKT1VmCFInetGzZEzJdXFAHKTRVegAvxnb4OUWdJHQ9GoafzqKUZ8Rqu5+BVibWJ/ywkr8rlTlqF9O4hmRKMCvTQe1OGIKQK5hHUcppeIHETxMVThaXm0SzHzu6CKeM7uahM3IY/HP7KgErBQuVB1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DD3T941K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DD3T941K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628021F00A3A;
	Fri, 10 Jul 2026 09:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676029;
	bh=bY/IkBdMAIEfddN2BADd+7Pjk9lYCu7pWA7slAVG+oM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DD3T941KgTOkCLLvij8xkEatOd1D+ZXdtRwvQNX4m1oTUB8mTjGFggS1W8l5p7XdE
	 MURrHv2tXfEoZSszFNFNVUvBXed/3Y104bogmRI9Mw0Asntgnb79pwIx73ex2RJ8Ae
	 2VA5a3nRwj3563jKSLhLLQeJCgTqJx5qXziYAT3+NVSBpdl22o/bPFdAKCT8oUiU2f
	 59f6hTebI5W9+IkLCcKqdYbYtOkKvFS6v7JLRqyt8mlSle6mrak+4V1nj/2Iy0pmQl
	 +rzVECsTvpfYMyT2cuuJXrgaicIp07r/OxClF3pu3zcK8qk+UXwv1HBo/W8+f7QpqG
	 FI8fqpQga7kxg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:16 +0200
Subject: [PATCH v3 15/24] binfmt_misc: return errors directly in
 load_misc_binary()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-15-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3789; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qqm2eAOnpJr7SnNA4N7fHD6KqzuTB+1Y/9elatuqZGg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7IljXblw5YddikvnVCQ9cn1/cvGBjTy7XxTMfuaSO
 HVxjwlXaUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEun8zMnQ/VNM4+t56zYep
 +9knNCrc3GV2K7zZZveTKT7Hy+VnCjQyMrRH5h7Zv0UvgT9RbLF4sPr5LSq9G23Cpf5UHpfbanV
 zCysA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

load_misc_binary() seeds retval with the error for checks that
happen further down, reassigns it along the way and funnels every
exit through a ret label whose only job is dropping the entry
reference, so figuring out what an early return actually returns
means replaying the assignment history. Give put_binfmt_handler() a
cleanup class and take the reference with __free() so every failure
can return its error right where the condition is checked. The
comment at the label restated what the put_binfmt_handler()
kernel-doc already explains, it goes with the label. Drop the dead
NULL initialization of interp_file which is assigned on all paths
before use.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index cd5dbf61771e..06f4849cf1ad 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -183,6 +183,8 @@ static void put_binfmt_handler(struct binfmt_misc_entry *e)
 	}
 }
 
+DEFINE_FREE(put_binfmt_handler, struct binfmt_misc_entry *, if (_T) put_binfmt_handler(_T))
+
 /**
  * current_binfmt_misc - get the binfmt_misc instance of the caller's user namespace
  *
@@ -215,30 +217,29 @@ static struct binfmt_misc *current_binfmt_misc(void)
  */
 static int load_misc_binary(struct linux_binprm *bprm)
 {
-	struct binfmt_misc_entry *fmt;
-	struct file *interp_file = NULL;
-	int retval = -ENOEXEC;
+	struct binfmt_misc_entry *fmt __free(put_binfmt_handler) = NULL;
+	struct file *interp_file;
 	struct binfmt_misc *misc;
+	int retval;
 
 	misc = current_binfmt_misc();
 	if (!READ_ONCE(misc->enabled))
-		return retval;
+		return -ENOEXEC;
 
 	fmt = get_binfmt_handler(misc, bprm);
 	if (!fmt)
-		return retval;
+		return -ENOEXEC;
 
 	/* Need to be able to load the file after exec */
-	retval = -ENOENT;
 	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
-		goto ret;
+		return -ENOENT;
 
 	if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
 		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
 	} else {
 		retval = remove_arg_zero(bprm);
 		if (retval)
-			goto ret;
+			return retval;
 	}
 
 	if (fmt->flags & MISC_FMT_OPEN_BINARY)
@@ -247,19 +248,19 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	/* make argv[1] be the path to the binary */
 	retval = copy_string_kernel(bprm->interp, bprm);
 	if (retval < 0)
-		goto ret;
+		return retval;
 	bprm->argc++;
 
 	/* add the interp as argv[0] */
 	retval = copy_string_kernel(fmt->interpreter, bprm);
 	if (retval < 0)
-		goto ret;
+		return retval;
 	bprm->argc++;
 
 	/* Update interp in case binfmt_script needs it. */
 	retval = bprm_change_interp(fmt->interpreter, bprm);
 	if (retval < 0)
-		goto ret;
+		return retval;
 
 	if (fmt->flags & MISC_FMT_OPEN_FILE) {
 		interp_file = file_clone_open(fmt->interp_file);
@@ -274,27 +275,13 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	} else {
 		interp_file = open_exec(fmt->interpreter);
 	}
-	retval = PTR_ERR(interp_file);
 	if (IS_ERR(interp_file))
-		goto ret;
+		return PTR_ERR(interp_file);
 
 	bprm->interpreter = interp_file;
 	if (fmt->flags & MISC_FMT_CREDENTIALS)
 		bprm->execfd_creds = 1;
-
-	retval = 0;
-ret:
-
-	/*
-	 * If we actually put the entry here all concurrent calls to
-	 * load_misc_binary() will have finished. We also know
-	 * that for the refcount to be zero someone must have concurently
-	 * removed the binary type handler from the list and it's our job to
-	 * free it.
-	 */
-	put_binfmt_handler(fmt);
-
-	return retval;
+	return 0;
 }
 
 /* Command parsers */

-- 
2.53.0

