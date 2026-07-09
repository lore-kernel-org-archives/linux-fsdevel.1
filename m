Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D330C179
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636245; cv=none; b=qc2n+s8LAsKJH9k6rI99y4yj/aZM99gpNshnc8zH3XFV/uubykEv4yR6UCyPZlLws9P4SAEmWa3/sUvfcIRG2B0urZVWcivX1cRvJ65hs/SleQCZc77knpitld7nzuefefR5KwvG+rhVI2Hd5ixXMlbxhR5srOwOjoP0JEjlGuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636245; c=relaxed/simple;
	bh=Ll2FrYd9HjDHtPC5X13nUkIPqoyZg+Kg0S/zH98yQME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f9alYhYDFgAAOw2qAfh4tztRNGFUtcJUGv0xMvCYjf6pFYBbxc0Sffw/VdDuAxJoUj9EPl+JMgQcwKRYGrIH8w+31O9oJug5jFP9da16t9rN5wrRUa9/c7SJsaKZMwZe/X8al/L+PtkFz3hRpPSQski5O0gdBCYa0k7Da8A1GMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwLjnXSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwLjnXSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA4A1F00A3D;
	Thu,  9 Jul 2026 22:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636243;
	bh=mmi4ph+oWqWXEOWD3R7tpRATe6i/+o09C72s6qL5Zwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MwLjnXSfviTLdq9jtCBRjJ7TPc9rArvu5BF3yFxT0cBqG9x+tyTogp3Lc1qhqh69z
	 uFYHFpG+VHxUsHihLc2TEeIMZaNdOTaRKyPVSaaCG2ZWqWjAG8ECUTigaHOf7wnTnf
	 RAAQ+ZzkPvmTAXk3o0B57Ycpi0EQNrzDRjbTKeRFb2Glgyi/RixYR+X/IhBEPyJjra
	 LRgi9kiXOjL1vTXk/wXBk0JScPth0gyJ+zmDjjpZI32zSvraREHR9k3aGPRouVwKIO
	 jb0cgkDx1MUX21IY4W2XWSqg9/GOSjWSkAnMoSoOA9yTPnikigu2dz0CxtaZg5e4BE
	 PD2T3jkLXTXUQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:09 +0200
Subject: [PATCH v2 14/23] binfmt_misc: return errors directly in
 load_misc_binary()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-14-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3789; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ll2FrYd9HjDHtPC5X13nUkIPqoyZg+Kg0S/zH98yQME=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHzl8J5u+SBfcfE922cCkXozTteofjMx471atNDmk
 9WfhYeLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSdJLhf3C21+HtRWVMAjEt
 0dIzVh4/P+tB6Ubj4k5h1sMqB0tkWRj+mcwJaOypT58RU+zIkSes+fni8QOflnZcySh92Lbz/+/
 f3AA=
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
index ac2276eeff4e..4172c0937161 100644
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

