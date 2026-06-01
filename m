Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A6D3BB12A;
	Mon,  1 Jun 2026 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322241; cv=none; b=HJNuMdxumMROftBmEOpps2HJtoN7W14GNL4ltY/84+PuRbWFd+AEOR85rpE3NF2yLZSMYjJsP9ihZoXAyMI+vFcvyDMiGt2LcuLr/7F22Pm+3yFLXkE/fTTga5yB0ESu0wZDhpnerTfbDU5G6MPcxpkUHeex1MQ3f56LhjT0E+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322241; c=relaxed/simple;
	bh=jZu8M0n+dKdGzUCCyIpPQrmaPkWMSz/q9u6Z1w7pxx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOsy8XGPBlLAjjgbOfPuBjvae7Q0g1l+W9aHSokWKyS6LZh3ZwP2P2tR5R5/b87NHu8R93nuGNC2bqLm0AR+SeOCYNhcN7JPhD15E7tD4zrFVSe1x9bANqr7KZnqZETFa9PhHpELBdsBQztY0FFuO625B/14T7CyoZbGuqkb0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCKwB2a2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCKwB2a2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C7F1F00898;
	Mon,  1 Jun 2026 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322240;
	bh=RxyI8sQQsQSUFxhc5pSDtl0L207LrmPXq24mekBd1vM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SCKwB2a2NLyvNiI9El9yu+kZJGYPxViY/PBpnwuUuwhqb6XiiirAGCgbAUYz1dFk4
	 p++Z6nZY3qKncRrMGA6ys21JOloK0StjcfoRcTeNAZMg2L3e6GnypQQxLbOIuAXAEc
	 wFbHrmQ24qtCdzV9Ccs5i3SVZEBbjyZAmbxY0R9KXbbwzlN9gF1W4Bic2IKTpp5AnD
	 5Tkann5mFokEZYoQKTh9+1VfEuK3aLlBlCqythVQ8pW/qWmp4bujp7m7k32FZalJ30
	 M8xi3hgVMXhFe65nLJaC/xSE2LwE152sc/3UCdVJBikHjRnqxaDRfp3epFgd27ilUl
	 H1ni7SLFbd+TA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:44 +0200
Subject: [PATCH RFC v4 11/25] coredump: use scoped_with_init_fs() for
 coredump path resolution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-11-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jZu8M0n+dKdGzUCCyIpPQrmaPkWMSz/q9u6Z1w7pxx4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i+bXbtYQfNQmpCcWpjur/Bv62b1+Vr0qq0u3Caen
 zFpml1hRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQM+hn+F94o7GBnM9u2/cH8
 PonQhgrFbds0XFl4/HdK67CmR7QUMvyVSa6d+dk7r/LUtq8yZgWdrZwvKz8c3Pavi9Mz48i+KTF
 MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the filp_open() call so the coredump path lookup happens in init's
filesystem context. This replaces the init_root() + file_open_root()
pattern with the simpler scoped override.

coredump_file() ← do_coredump() ← vfs_coredump() ← get_signal() — runs
as the crashing userspace process

Uses init's root to prevent a chrooted/user-namespaced process from
controlling where suid coredumps land. Not a kthread, but intentionally
needs init's fs for security.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index bb6fdb1f458e..4c81182e2c63 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -922,15 +922,10 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
 		 * with a fully qualified path" rule is to control where
 		 * coredumps may be placed using root privileges,
 		 * current->fs->root must not be used. Instead, use the
-		 * root directory of init_task.
+		 * root directory of PID 1.
 		 */
-		struct path root;
-
-		task_lock(&init_task);
-		get_fs_root(init_task.fs, &root);
-		task_unlock(&init_task);
-		file = file_open_root(&root, cn->corename, open_flags, 0600);
-		path_put(&root);
+		scoped_with_init_fs()
+			file = filp_open(cn->corename, open_flags, 0600);
 	} else {
 		file = filp_open(cn->corename, open_flags, 0600);
 	}

-- 
2.47.3

