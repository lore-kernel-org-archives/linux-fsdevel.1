Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A108336922D;
	Wed, 11 Mar 2026 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266199; cv=none; b=I4ESwIsdzQA962FkCoU5TQuUar0Yvx1qzBa6RkgedX77Ngb2m36S4lzkhasSjPC9rPXPf4FWJ1aZtOXrmNAd1hCu9CBdMAeRK4a1E1vSJCUh6mpBefsXv8ma10modnkOrDLf/W9YqUZomcNB8mTJDc7zL6ANKcu71JJWw+jtVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266199; c=relaxed/simple;
	bh=aJXunCWUMwo/RoSO3Pr5eSrF9qPQim1AZ9jP0b2ptO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nydrLjF2VkIdlJsmmWVMPxEazPnurJjUvJ3tU8r8lRuuT7TmDmv7QhO66YNblEMzdgUJwoiKq61zoH3iX58apgKXP8DAMFKyD/5xgTT866w1KFnFAWxAh6XDNNklMyHAFZT2m4BhAvsPONylDfRTft9XuU4SwaZ485l/z/Uoqlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJp2G6OT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJp2G6OT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6795DC116C6;
	Wed, 11 Mar 2026 21:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266199;
	bh=aJXunCWUMwo/RoSO3Pr5eSrF9qPQim1AZ9jP0b2ptO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TJp2G6OTzu/6nnsaqW4Cz+osmsS4bx7y5wQT0CzW3JUItLgwURYj/ZO/YtUrLGcYb
	 pN+8FYiVWfJan9bAsg2nBoP1857W9wLMqnCyLeLpk00HektiL1PszGYa4phbPTO0gG
	 US/3+xX59eGPmsGcK8hsIRmwvrB+9W2wlAjA9rtXKDPdLj4WhnD/OtJ/c5BkccBu5y
	 j7SOVfyKrhSwRwPPJeiSGPrnt2GmKndHMm6GroQFs07egwDT70xPvZ9ktPedV161VQ
	 Tkfi2+43vjK9CLbjZLN3k7Pq4PEAMpmxdsLg3OsTxLGjamr65ICazCDl4sikZ67Bge
	 2CT/9Fu6tTgSQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:54 +0100
Subject: [PATCH RFC v3 11/26] coredump: use scoped_with_init_fs() for
 coredump path resolution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-11-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aJXunCWUMwo/RoSO3Pr5eSrF9qPQim1AZ9jP0b2ptO0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPIz3nvqV949z8u8VZa9rNqX1LiI50vJvKWPNcOuH
 Xhu2JlR2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRib8Y/jtVF/KskWiaXnl1
 5YkQh4W1J+ze/J5y7O3UuBlH/XK/mi5lZLhurzdRIGD6zne5E66pvdhx+27F0Sc7TE+xTvVn0Wa
 6JMMEAA==
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

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 29df8aa19e2e..7428349f10bf 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -919,15 +919,10 @@ static bool coredump_file(struct core_name *cn, struct coredump_params *cprm,
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

