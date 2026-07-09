Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304BE391512
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636257; cv=none; b=bFCR1usxqp0zlzlE13+NCOMmmQ+m+wRn1+Ss5+bPrMPLuBzrZ27vm8ORJNBg+RaPQbvR0lN0Lidp3fACLd5ZOpDhj0g5sYuvV/Pw+3ympjn2YP326v2qGwiVDI+OfHUI/n4xPiflMJK8YUpriz96kHRezigAW+EEz9OIOociIZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636257; c=relaxed/simple;
	bh=McQDaVPB5ahM1jPM6oFGOwP56eQl6ZRjgCLBJccmyO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DX098CSP9OvY7iK5gTUQz2fxYxXVWmTMb+1nlGK36WTvwYZ9Bz6AMfNGqClkikYwxSZK9Pn8KfNr1h/Cx6wuDT7uxgeeVFTByEXybsEcvgFiMlR7Ix8rUpofTWOQr39CPnqodR7FwRvOphcyPG8kjoTtY3+Fpvow1TPTwGYHQCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdDxyqeW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdDxyqeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6498E1F00A3D;
	Thu,  9 Jul 2026 22:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636255;
	bh=12q52AkfpwCcKaywW5xgOYdbyP2Q2Z9ADa+mmKu+0cs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UdDxyqeWfhsab+ZCnH0169DDa43vbA6VPZXRbx5UcBWL8lwTBaogAuwpDN8SgMuim
	 utlPjzjYY4bNLcBs2mLEg33tzYzQeG1eGITGcAsScOJ1421UJprnf+/LePysZABfZB
	 eL1bSxQO+M/W+ln7FLu0xsnXFCiv6hc7MGEZ/eqtr0Po8tPf2/BdO4Rr/bGi5pxNoF
	 5DAvxLhF1xMYAKGzmYRdX5vgqEIkRsb5ZW2nwUBaHOypHAljcTK30ab+KK43cIlCi4
	 ktRt7a1oG9LwHNsuKJqcuM/rLAQ1HnG5Zn5VY3KsMn15i/Fntq+ng7t1irCsfEFyVr
	 qieo8Cc6KxcxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 10 Jul 2026 00:30:15 +0200
Subject: [PATCH v2 20/23] binfmt_misc: use __free(kfree) in
 bm_register_write()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-work-binfmt_misc-locking-v2-20-2a1c3d4126a7@kernel.org>
References: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
In-Reply-To: <20260710-work-binfmt_misc-locking-v2-0-2a1c3d4126a7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1851; i=brauner@kernel.org;
 h=from:subject:message-id; bh=McQDaVPB5ahM1jPM6oFGOwP56eQl6ZRjgCLBJccmyO4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQFKHx7GSCc9nVCw6ltRd0BrM/YZ9w75Haxr4FjtlRjv
 PGlWzm/O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay8ifDP723NS/6HXyr7nkr
 llVbb3pZNM3GvU9UTDTpkNfibXNnxzEy/D9y13nd61X3nq9d1/ZR6PZvbyv1vWZyv9Vvif7i2br
 4Mz8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

bm_register_write() has to free the entry it got from create_entry()
on every failure until add_entry() has linked it into the filesystem
and made the inode its owner. Arm the entry with __free(kfree) so the
error branches can simply return and disarm it via
retain_and_null_ptr() once ownership has been handed to the inode.
The interpreter file keeps its manual error cleanup as freeing the
entry would not close it.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index c2d947f934ab..6acce58ce405 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -796,13 +796,12 @@ static int add_entry(struct binfmt_misc_entry *e, struct super_block *sb)
 static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *ppos)
 {
-	struct binfmt_misc_entry *e;
+	struct binfmt_misc_entry *e __free(kfree) = NULL;
 	struct super_block *sb = file_inode(file)->i_sb;
-	int err = 0;
 	struct file *f = NULL;
+	int err;
 
 	e = create_entry(buffer, count);
-
 	if (IS_ERR(e))
 		return PTR_ERR(e);
 
@@ -819,7 +818,6 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);
-			kfree(e);
 			return PTR_ERR(f);
 		}
 		e->interp_file = f;
@@ -831,9 +829,11 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 			exe_file_allow_write_access(f);
 			filp_close(f, NULL);
 		}
-		kfree(e);
 		return err;
 	}
+
+	/* The entry is owned by its inode now. */
+	retain_and_null_ptr(e);
 	return count;
 }
 

-- 
2.53.0

