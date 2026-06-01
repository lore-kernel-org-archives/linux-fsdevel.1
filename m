Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3B3B19A5;
	Mon,  1 Jun 2026 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322222; cv=none; b=UeKRjYFbyAd/4GjjXY9g5n4Q4PvEhIBnuNepBr7pIgBbhYfyYpRFG+ZiSkUnP1nntnfV0PKAMT6fXLoDcGcowNxlJXSD4E0UnmZTlurDKGLuQae4eAveBf5g+FwMzzpAynkjI025Xu4piILgMmMaUBqptVZRXguimwVnMyIHsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322222; c=relaxed/simple;
	bh=KCPdiX6BH/IBnrnw84ASQ+v0phwip0MhXYRHVBBlZ+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KUnAogdfufjYklbNgSNZS556g6iPxgdZwvDu+D9et7OtnYPrtN20cQgg14Kwlpz5DB43MBIGfU7UsyEov2dHVVYyuBqTlwPvuGV+cg/lB0tfZOX+quWxlqVW4Wq46H3ZuWtIR9jE1QKft9O2AAK5Vb0iV3MRmEUwgAWm5zw03qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOvMc9I+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOvMc9I+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69851F00893;
	Mon,  1 Jun 2026 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322221;
	bh=/ist+XEJ15RumsCrqpUFl4FU7hObKp3HJhM31n6k+qg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hOvMc9I+5HR8yHw5H8CHRnDnvwW4rwzJwLg5XxT0dnkAol0PNqTZFQv7KXcJj/MN1
	 7s0x6ZycuVsZi3vZaofUciX28oY8bBrICyqzloNym5+2yJS+OFt0Wk7af9yTJAJO3n
	 KMSBdak8+fa7PDgeDPZt8vUwQiEIWvzFY1dWe9LEiJ/T5EGgDBI++MjFvjp8aPIAJn
	 Vh65TOS+qUa4pTlG1np0hkUcj83zUj6CSiA6yvNEiUuLUCf4KZy2qkjLq0N/Sm9Y+T
	 JopC1kKp8lHNSHwMGdG19ZFVowEuyKQjKmc9vh7Ez4VpZbfS90H36O6WdSU2kx6IrP
	 SZr/hHWAWk3gw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:35 +0200
Subject: [PATCH RFC v4 02/25] fs: notice when init abandons fs sharing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-2-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2275; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KCPdiX6BH/IBnrnw84ASQ+v0phwip0MhXYRHVBBlZ+k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i9TO2mpLzWXZYkK26ZdU0wvXkj3FC9O2ZfbZbZ0x
 qb7y+yTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCspuR4cjVMtnC+avWnZqp
 v4hhXeWj2V+NRW9wGto8tZJ0EfK4kMrIMHNze0XRNkelZIGTka2/NyROzv3gZL8ufuUe/a/elYw
 KjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

PID 1 may choose to stop sharing fs_struct state with us. Either via
unshare(CLONE_FS) or unshare(CLONE_NEWNS). Of course, PID 1 could have
chosen to create arbitrary process trees that all share fs_struct state
via CLONE_FS. This is a strong statement: We only care about PID 1 aka
the thread-group leader so subthread's fs_struct state doesn't matter.

PID 1 unsharing fs_struct state is a bug. PID 1 relies on various
kthreads to be able to perform work based on its fs_struct state.
Breaking that contract sucks for both sides. So just don't bother with
extra work for this. No sane init system should ever do this.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs_struct.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index c441586537e7..fcecf209f1a9 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -147,6 +147,30 @@ int unshare_fs_struct(void)
 }
 EXPORT_SYMBOL_GPL(unshare_fs_struct);
 
+/*
+ * PID 1 may choose to stop sharing fs_struct state with us.
+ * Either via unshare(CLONE_FS) or unshare(CLONE_NEWNS). Of
+ * course, PID 1 could have chosen to create arbitrary process
+ * trees that all share fs_struct state via CLONE_FS. This is a
+ * strong statement: We only care about PID 1 aka the thread-group
+ * leader so subthread's fs_struct state doesn't matter.
+ *
+ * PID 1 unsharing fs_struct state is a bug. PID 1 relies on
+ * various kthreads to be able to perform work based on its
+ * fs_struct state. Breaking that contract sucks for both sides.
+ * So just don't bother with extra work for this. No sane init
+ * system should ever do this.
+ */
+static inline void validate_fs_switch(struct fs_struct *old_fs)
+{
+	if (likely(current->pid != 1))
+		return;
+	/* @old_fs may be dangling but for comparison it's fine */
+	if (old_fs != &init_fs)
+		return;
+	pr_warn("VFS: Pid 1 stopped sharing filesystem state\n");
+}
+
 struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
 {
 	struct fs_struct *fs;
@@ -162,6 +186,7 @@ struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
 		read_sequnlock_excl(&fs->seq);
 	}
 
+	validate_fs_switch(fs);
 	return new_fs;
 }
 

-- 
2.47.3

