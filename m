Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430731F9A3;
	Wed, 11 Mar 2026 21:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266177; cv=none; b=JkwCmOIm57pmC815Wd1k1uHH+ZSzPWO3uF26eFfmUhEspmlljMwL4A+073XsYnMC715fcH3K7dcFx9SfC3rCJP9CP+9K9defERFSMflMTdymOJrpz6uPtiD9+w9cq7qxmWbVhceUeUQndKmPBjT22oDPsywt40pNoE0GJExZc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266177; c=relaxed/simple;
	bh=PLrJo7pAFoBlfQ7T9p5ztHY4D+o6TOQ9sANou7DEIh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OW/07IbJAtJzbDZCGIlrLTmd3lT5S//3evegl8WspdbQNMF3a42g+zPAO8EjUOrzmL4zsRX0DW+qvNtYhBRewNlc6udRNE1jzt4WI8qrkaycdSP7nEgsK9Hj4MiuRYhoEH/WiQrQOV5ZavCac+YC1Bu9cgN1toyHGJXQXz8J5m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zw6BmCQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zw6BmCQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270A8C2BC9E;
	Wed, 11 Mar 2026 21:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266177;
	bh=PLrJo7pAFoBlfQ7T9p5ztHY4D+o6TOQ9sANou7DEIh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zw6BmCQg5vchEkSaG7M0Ca+nLTgp0kz3WHf6qF+LM0jtEKvTYBtjEjcj7y3bBSrVP
	 D+RAyoFli7wrtZ3us8Axx3KsNJlhfI2ftBqf7IL6brFKkBju216J3oXLxp3g/B6JsR
	 GLFk0gONl3CBwVIAKt7TaqomqbZJgBtjAVBgvMRyJZTNzxf38oTLYlWTHmTnxTRkco
	 tn16yPOl6Bb+yOepzIfEwEnGIZPd3COTEmkrdr+paBXEteFSdUmjHYqpnz5MSabfJ/
	 kTySTK24/CO4Tc9shyUPf2TQaqyYoKl7Rh7VFvsoYtw/8+HiTGyXBJK9jPEvXLn8o7
	 ayCN0NUng7JbA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:45 +0100
Subject: [PATCH RFC v3 02/26] fs: notice when init abandons fs sharing
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-2-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2264; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PLrJo7pAFoBlfQ7T9p5ztHY4D+o6TOQ9sANou7DEIh0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJj6rI7oXYhJ7qdZRa0JTW8/PWl4+yJfXEZrbZR9
 4SYftUkdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk3U2G/zGHn7xQ2suyvuKX
 5M87qYaKxb+rzn1l3KN0eCfv3QZm99+MDLPUYutL5urKLrgarN/70qnVcY16ucLVv2cNj546ZeJ
 7lgMA
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

Signed-off-by: Christian Brauner <brauner@kernel.org>
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

