Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A73F7A9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676029; cv=none; b=bKG7EBwldSbCL6lLXg65D7IM7HSTRzUBfjVtAtguqZvzsKcr2XZqHmou+AX9T13lCMyEims4o4pXFNCbRAEZqZhkoMIU4AWDFoGHpRLfhKP+NlBl+jFn6Lj6MLGscM4pqm2TXMc7MLq05fktLAdZHgQbrGbKkP5RtsgKLJfkvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676029; c=relaxed/simple;
	bh=BT+3XnPAOqe+UbenBLQo9xtGqAk3t4eTUKJnpezq85I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4yL3w9aYVsSoeZU3lytlalfJmXXJR0kYnkiPMZDgs4A6bUV5sqBMcAqjAcVUaRdQugv3edBeBnCmdnFU9SmUEYT0GxXMS3Kd8oHe9xAHseusvFI4FwPSvgxZCu7gLdXcSVtGxVRY1Ti28IUzgNteQn/Vo+VvAptCFERZvLhRmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sp+FwLAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sp+FwLAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6AF1F000E9;
	Fri, 10 Jul 2026 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783676028;
	bh=HjV5VoEllouOqts4U3VTjiuzsvEpGH8U1hM8bDNPXKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Sp+FwLArWMmiP/gI0nr18E+ZEZ258B4LGnmLGFuCa9j+Z9pAhljpCLGqUrKPqNQrQ
	 6nOPPNQHvqXPQ8iYLGysVb8g0x7ZBeCWjSn3nhx/J75eLASjXhgkcvGeXoKAm8haZ0
	 mB4yIQk4MBD7PuvkKZOHnv9mq8tPP1FRRJUYF2mrVxiRqra+dokWqrwjH/PA5408mQ
	 tEY7nLDpmGVGIObSATOugwq52wuj0uPtIFwCBKuTGZ5FSA/czrfAF+YYJgEYwTKz43
	 vU19HNHEIJCOyoeLqy5aGPZRO44Mi5wFoVITvFaF2t3yr1lkOARgWTuy1D3xLDYRcn
	 GoVLEk5wnAkog==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 11:33:15 +0200
Subject: [PATCH v3 14/24] binfmt_misc: rename load_binfmt_misc() to
 current_binfmt_misc()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v3-14-a162f7cb58d6@kernel.org>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BT+3XnPAOqe+UbenBLQo9xtGqAk3t4eTUKJnpezq85I=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQF7ImL0qg+dWJZ0+vDU576vnn6L+q9QwFz2LbtG/OmB
 brYnvVd0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRHQGMDO2yhW0vn7xz2+r+
 6cznaSEPjWP7QmQmSsUYnuhaX9+dZcHIsDr1b+5O42Tn23Wys16etF0ns0A8jf2UwZGV3OmtiSW
 rWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

load_binfmt_misc() is one word swap away from load_misc_binary(),
the binfmt loader it serves. It doesn't load anything, it looks up
the binfmt_misc instance of the caller's user namespace, so name it
after what it returns in the style of current_user_ns() and friends.
Tighten the parent walk into a for loop and fix the stale wording
and typos in the kernel-doc while at it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 6a56f40f23ae..cd5dbf61771e 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -184,29 +184,27 @@ static void put_binfmt_handler(struct binfmt_misc_entry *e)
 }
 
 /**
- * load_binfmt_misc - load the binfmt_misc of the caller's user namespace
+ * current_binfmt_misc - get the binfmt_misc instance of the caller's user namespace
  *
- * To be called in load_misc_binary() to load the relevant struct binfmt_misc.
- * If a user namespace doesn't have its own binfmt_misc mount it can make use
- * of its ancestor's binfmt_misc handlers. This mimicks the behavior of
- * pre-namespaced binfmt_misc where all registered binfmt_misc handlers where
- * available to all user and user namespaces on the system.
+ * If a user namespace doesn't have its own binfmt_misc mount it uses the
+ * handlers of its closest ancestor with one. This mimics the behavior of
+ * pre-namespaced binfmt_misc where all registered handlers were available
+ * to all users and user namespaces on the system. The init user namespace
+ * instance is statically set up so the fallback is never reached in
+ * practice.
  *
  * Return: the binfmt_misc instance of the caller's user namespace
  */
-static struct binfmt_misc *load_binfmt_misc(void)
+static struct binfmt_misc *current_binfmt_misc(void)
 {
 	const struct user_namespace *user_ns;
 	struct binfmt_misc *misc;
 
-	user_ns = current_user_ns();
-	while (user_ns) {
+	for (user_ns = current_user_ns(); user_ns; user_ns = user_ns->parent) {
 		/* Pairs with smp_store_release() in bm_fill_super(). */
 		misc = smp_load_acquire(&user_ns->binfmt_misc);
 		if (misc)
 			return misc;
-
-		user_ns = user_ns->parent;
 	}
 
 	return &init_binfmt_misc;
@@ -222,7 +220,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	int retval = -ENOEXEC;
 	struct binfmt_misc *misc;
 
-	misc = load_binfmt_misc();
+	misc = current_binfmt_misc();
 	if (!READ_ONCE(misc->enabled))
 		return retval;
 
@@ -983,7 +981,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 		INIT_HLIST_HEAD(&misc->entries);
 		spin_lock_init(&misc->entries_lock);
 
-		/* Pairs with smp_load_acquire() in load_binfmt_misc(). */
+		/* Pairs with smp_load_acquire() in current_binfmt_misc(). */
 		smp_store_release(&user_ns->binfmt_misc, misc);
 	}
 

-- 
2.53.0

