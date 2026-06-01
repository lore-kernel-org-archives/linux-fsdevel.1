Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43DA3AE1A8;
	Mon,  1 Jun 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322271; cv=none; b=g8013DjkVeZfzCEigcL4KfCQaSpGbq+7rwLBvW24W1Px1OFgWufggGkzAw3FkZpAN1YQOPdD2F0DKN/jHOMmxSIjxd9T/ocP/MFnkYGMLfMn0y+lt3nM3jj2/H1ECoQY4J4cnas7SrXUAQ2pUsgS0YmhJkelM1gsOixHIo2gnSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322271; c=relaxed/simple;
	bh=wtNqwKWnZJr0D4OXCu8J+GZQVfY9knPrP4KsxbNHpCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUdaBWQA4UqkAUTwPCsvnDDuY1i2gEzBdINFqm8sW9tmfbj8PrtcIaEKisxUnA3G5Zf6hYn9DbftIU5ho7rl2Y276gqEeyGB+/ilHNcAGubSX2GPsJr02NE6B3KaHKM7SLZCzWAtEgp1bK3FbJlJjupWe2XrrEzsY1VOC9eHkdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW3ur3PL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW3ur3PL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D355B1F0089A;
	Mon,  1 Jun 2026 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322270;
	bh=VWYb/02ev4/1SjJ5CdnuW7B22eOglG9wau3YZ8JnIlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cW3ur3PLb+hcj4knw+U2F9gOYMiwPla9mSKJhfnu1lTT6gbGbQ7dDTGBuOxLbZSna
	 EzGIiKdidfvxN+sFPV3mOMMUOeL/VoS9OO1w/iVzw6iB8Y/D4Z58mnuob5E83osW8F
	 FN9eqa9HarwNy0wTjdgeERG0nMEE6Ex+efZFMDXPtnPPQr3+zvRvFfl5xQJIMAlpW+
	 0Dy5oxAHWR3gIZVtzZnW7Hf+i2FT0GhYdhud+9dGn0W2fxm28iQD7TKfeB9Z9CtoC3
	 9MkMkaMDxhsF2JzBx8/l6Zni9Clz6cJJn2EL4h5iW1ddbmN2sMnmCbL0q3liGePclu
	 nNizNrWDvCk1Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:58 +0200
Subject: [PATCH RFC v4 25/25] fs: stop rewriting paths for PF_EXITING |
 PF_DUMPCORE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-25-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wtNqwKWnZJr0D4OXCu8J+GZQVfY9knPrP4KsxbNHpCE=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGodj6fI42SEyZ1r8p8zLd/OjXFAjGC15pkRF7NaTpoyLfFdo
 Ih1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmodj6cACgkQkcYbwGV43KIXjQD/cUAO
 NTf0JolTYPB3HRHkpkRBF7J17yZ7aOCZx8222tIA/jaeUp8rsOq5HqsqLUaTfEGBVjH7pHUKXrX
 a+7niYugO
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Skip exiting and core-dumping tasks when rewriting fs_struct paths in
chroot_fs_refs(). Such a task is about to release its fs_struct via
exit_fs() anyway, so the worst case is that it lingers on a stale
root/pwd until it does.

This isn't entirely free: a skipped task keeps its reference on the old
root, so after a pivot_root() the old root can't be torn down until the
task is gone. With umount2(MNT_DETACH) that only defers destruction of
the old rootfs; a plain umount() could in principle fail with -EBUSY.
In practice this doesn't matter -- pivot_root(2) is meant to be paired
with MNT_DETACH and isn't issued while other tasks are actively using
the mount namespace -- so the transient pin is harmless.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_struct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 2a98cfbedd32..34699f3b6f88 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -61,8 +61,7 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
-		/* leave kthreads alone */
-		if (p->flags & PF_KTHREAD)
+		if (p->flags & (PF_KTHREAD | PF_EXITING | PF_DUMPCORE))
 			continue;
 
 		task_lock(p);

-- 
2.47.3

