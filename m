Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3438F65A;
	Wed, 11 Mar 2026 21:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266216; cv=none; b=Ep8X8POzU+0LiKZe4aS5BwdsiMPv+2Z50zn2C63F/tfol8x9sqwtq3T+WQI9dJUuRFQBnOuV3yAAkO2YFfvF/2cVyYJILFVCakwCcHpLu/OfyjN7/MpxQwQ6nR3sMb6mZeXXkdygMV73q4Am2+uU1Wdlff2aCXtzt4htKPOvftE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266216; c=relaxed/simple;
	bh=GaVed/uXlUfN2mfqqpnSHi/Y3WP/E0BQOp7hhIxY23E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nLqBkT/O2eGRgaxtM9PwYn5Xgepdndm0pe66WFqrXc5QB6+hQYVpNAIhDjHo+B4BCMKZU2S4I7rSaotfs86Bndm6i9HTuYUNDNaQGJrE9WcLNOGGGiJVMSzY2GpGWSfQMBN0XViNTtaQG1uEi+fpdaOGYo9Cf3/5JcbUpiUdv4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO1G7PMX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO1G7PMX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DF1C4CEF7;
	Wed, 11 Mar 2026 21:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266216;
	bh=GaVed/uXlUfN2mfqqpnSHi/Y3WP/E0BQOp7hhIxY23E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iO1G7PMX+8xhBjofPl5+LptdsrV3MX1HYjDSSiv028qt287fcvXV8obq/IXGx84Ya
	 3/NqHLhbL0Ub7JgJSF7J00e5cSnWLCp6NL3NdTOIf26UhbSQEMDIm1Av8lAVnIDtPR
	 cGMhvgKBNlDwUBN8d8RFSHg8w01CSjgb5/1vm1dzHSncMMztnJxJNEw9+QIv0UV9Mm
	 csVfL7rlHQ0ZyHn87TOarXnQQP7zi5ucOl6ajHXK7kdUABAgkQEfOLv2UVxIBNFQ81
	 Q9BPTTdg6q/CuPw2CN0AI13vWUmeL52p1xkdcfUsVKS2iOIXIurFn0xcHR/Zde6njA
	 Je3TfMzomZr5w==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:01 +0100
Subject: [PATCH RFC v3 18/26] af_unix: use scoped_with_init_fs() for
 coredump socket lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-18-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GaVed/uXlUfN2mfqqpnSHi/Y3WP/E0BQOp7hhIxY23E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPIz/dWDjR+L5xzQE5Gb/8i2xykyXd7B6tXipJhY+
 6r+sJagjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImsymH47/A7P+EIm8SiZRUf
 ciZYbO4zXvXE/E6ve4z0yvy/q7tWH2JkOF/3c6a+l4K4/T6ZKNZdB/W+y+zWC1fMP7a7I/fr4qe
 J7AA=
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

