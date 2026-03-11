Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A27E375AB5;
	Wed, 11 Mar 2026 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266228; cv=none; b=jcf7sVzz13navzXojBtDDIhpS0iLoumCyYBHhubFTGigPRzTJmW/39wAJv/hGLLdJGjla96UHpB1k6w2gxb3+aez4RqNURX6fTewVm76zedgVMZI6Bpen09MDRHesW38UCgGdCNWjIlWXnA34SMYOcHsevBwc1UDLEquXgMyLR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266228; c=relaxed/simple;
	bh=OfklnmmZPVz/ZNjVBmutvpLLH5yXolehLkyGmRTZNpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKJQtgDFgi686lDSJ1M8Pcd1eG/CwYiJH5O2RTm6QCXgCNYHyZggUUjrCEul9sOkjYK5cMpPpb7s4Y8XDK+Lv03oeB8tRi0w/sdh1OUioWZMgKczeIRNtwMxB5AqawPhNRmyPTX6c3zcvUyvJvfstzAPISd/VR9J5oRSlKMyciU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rq0tQS2N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq0tQS2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE96C19425;
	Wed, 11 Mar 2026 21:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266228;
	bh=OfklnmmZPVz/ZNjVBmutvpLLH5yXolehLkyGmRTZNpc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rq0tQS2Nh892QmB3bDzhPMwel/vYol1iMe+ZqbM5IlaZkRQU0HjP7MJIthikxsvPT
	 /fFWSOU6wgCcZM42CkhKuL5ZDjy708Z0nEPk1gfqMWzyaFWijG7px09bDWcyzaKW0M
	 l/lmXMj3yZPI8Fu4nLjKd0xpW/peZ189owf+u2vLOSzHOmPOcJsHx1pyxqn0D4hA53
	 Uh4QAMyoymPsWzqMzQTvswi3qbwNdD2j/Z9YX0JG5plzCpgvO7yPetkhzDL9Sh730H
	 0v2FrUoTdPG2Ik5A6hMDHO9wWilBKCyxRUJnfZp5VolR5sWp5SlrjVI9SzS3XwMlP5
	 0Py2NgTeadERQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:06 +0100
Subject: [PATCH RFC v3 23/26] nullfs: make nullfs multi-instance
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-23-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OfklnmmZPVz/ZNjVBmutvpLLH5yXolehLkyGmRTZNpc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPIzbnN0aKP51vn7C4TPWby9+bAm/Mc21+ANq2x+v
 5rzV8TpQkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEzioyMnx8uu6bl/rc6O1T
 RO6/Or3r2I3FfzT+/Xgb+fT7wRNsvMt5GRkm3OdSkzDIr/gcu/8mZ9HyVRfWTLST4mpYrfvbLam
 3ppEFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow multiple instances of nullfs to be created. Right now we're only
going to use it for kernel-internal purposes but ultimately we can allow
userspace to use it too to e.g., safely overmount stuff.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nullfs.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index fdbd3e5d3d71..c6f5b9493e26 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -40,14 +40,9 @@ static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
 	return 0;
 }
 
-/*
- * For now this is a single global instance. If needed we can make it
- * mountable by userspace at which point we will need to make it
- * multi-instance.
- */
 static int nullfs_fs_get_tree(struct fs_context *fc)
 {
-	return get_tree_single(fc, nullfs_fs_fill_super);
+	return get_tree_nodev(fc, nullfs_fs_fill_super);
 }
 
 static const struct fs_context_operations nullfs_fs_context_ops = {
@@ -57,9 +52,8 @@ static const struct fs_context_operations nullfs_fs_context_ops = {
 static int nullfs_init_fs_context(struct fs_context *fc)
 {
 	fc->ops		= &nullfs_fs_context_ops;
-	fc->global	= true;
-	fc->sb_flags	= SB_NOUSER;
-	fc->s_iflags	= SB_I_NOEXEC | SB_I_NODEV;
+	fc->sb_flags	|= SB_NOUSER;
+	fc->s_iflags	|= SB_I_NOEXEC | SB_I_NODEV;
 	return 0;
 }
 

-- 
2.47.3

