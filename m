Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081A4369229;
	Thu,  5 Mar 2026 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753457; cv=none; b=QtnpCXdTeLwfD8MHZF/AYrCd1fE9D8BVU3WJgtgbeFP5krHygLXyZrZDtoMpTSEc8yncrO9j32XbWylDh7ekBmxzI+5C9s1YaL3fpYR9vv0eZsqbcvJiT7fP9Hu7+CqlmKK6ipMp42qP6w9dy6KmQ3kwb+kcPVrGgTp9Rg+KIpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753457; c=relaxed/simple;
	bh=GaVed/uXlUfN2mfqqpnSHi/Y3WP/E0BQOp7hhIxY23E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RPm/sf2Ojr9lFPETrp4D69Asez1s82QA8lKW4mnUGMkJ2OTCpQRaLQlUd+HG2dMtGPtia4tfzRJnJQeftztzIXBVyKOWRbdMkUkWmI63XXgd6OVJVaphy7BjF14WTfwMQAuhKI2H76mWjVyP/8GFLfqgZWX3j+pYNs2twUcoDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS/o3vnw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS/o3vnw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A200EC116C6;
	Thu,  5 Mar 2026 23:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753456;
	bh=GaVed/uXlUfN2mfqqpnSHi/Y3WP/E0BQOp7hhIxY23E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nS/o3vnwLVjDIZEKz5z8gopf9F+dqdAhQjg6K+fMBv7AQPxUFzir4hMcmoJFVJH+a
	 IOP+4+epWKcT0wnnk5vD9Y8jPoOCk0LITup4qerWka+JyuNZqiU9Eg0NgFsvUTRpZR
	 vQRsA7Y5C+1A5oSavXgo0r2adeubtTHiW0/NagoEde80ltH/XWYuzATtSfeVHlXRHz
	 ZOCteAxiwjPRLsWmkP6r6nStEYaJwQxYFRx93M0u8HmGEEUUV/nYmtdQZiFCbrcJUp
	 evB6zK52ROK3Xycmco9sYaj4vImYeQ0XPVMDkmhf5T1IYQVSLvWGRxv6SITDrfG45O
	 7/I9Zih1gJVaw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:17 +0100
Subject: [PATCH RFC v2 14/23] af_unix: use scoped_with_init_fs() for
 coredump socket lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-14-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GaVed/uXlUfN2mfqqpnSHi/Y3WP/E0BQOp7hhIxY23E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuKa/y077bUu08K+Bq05fXO6Ld8v3NT0rF+nndnmD
 Fvc//BLHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM508HI8E+4wEZU4BxTXpxg
 34pTWbEl+u3rZoXbGR6896q44y/nPYb/1XEt+odM2l3lHqV7B7iv0m/1Ml7j4LL7YuEE3w6tC3r
 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for the
coredump unix socket path resolution. This replaces the init_root() +
vfs_path_lookup() pattern with scoped_with_init_fs() + kern_path().

The old code used LOOKUP_BENEATH to confine the lookup beneath init's
root. This is dropped because the coredump socket path is absolute and
resolved from root (where ".." is a no-op), and LOOKUP_NO_SYMLINKS
already blocks any symlink-based escape. LOOKUP_BENEATH was redundant
in this context.

unix_find_bsd(SOCK_COREDUMP) ← coredump_sock_connect() ← do_coredump() —
same crashing userspace process

Same security rationale as coredump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 3756a93dc63a..64b56b3d0aee 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1198,17 +1198,12 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	unix_mkname_bsd(sunaddr, addr_len);
 
 	if (flags & SOCK_COREDUMP) {
-		struct path root;
-
-		task_lock(&init_task);
-		get_fs_root(init_task.fs, &root);
-		task_unlock(&init_task);
-
-		scoped_with_kernel_creds()
-			err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
-					      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
-					      LOOKUP_NO_MAGICLINKS, &path);
-		path_put(&root);
+		scoped_with_init_fs() {
+			scoped_with_kernel_creds()
+				err = kern_path(sunaddr->sun_path,
+						LOOKUP_NO_SYMLINKS |
+						LOOKUP_NO_MAGICLINKS, &path);
+		}
 		if (err)
 			goto fail;
 	} else {

-- 
2.47.3

