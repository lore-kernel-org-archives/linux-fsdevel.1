Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0483BB9E3;
	Mon,  1 Jun 2026 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322245; cv=none; b=jlpwpNgemUTh8O+m/S/Zm0JdCT4e5IYIkagDFSIekBCzveungyB/9O+nTMDECOW0/lJaB9F7T1NBzApwE7bOZTx+2jyVh8Jswzn8/3B/KM7NxVaU70ZRwvKq/yvCBNJTOHhrcL+uxQzr3bMFFwrUvcJipdM3CZsc1013/WnVzI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322245; c=relaxed/simple;
	bh=hmspYre6B8hLxwtzedBtLGee9Mt/2dAkvKYui4zrliI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ci+/FoXsnQsV+Dq2RdXNX666a/gPa7pVHEb0OCg6oTRG5xw+wgTXPXI6WZbIrmxomfqinHanZ7pzVPYD7pU7WMDtfm6Zjm5eUBSW80qPA4smyTPN4Bhz+wSJWg4E1g5cbM0qgyWpMbFiJzz8siNcSYjtI+oCDyr8avEi9f//qGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGdDBvWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGdDBvWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B5F1F00898;
	Mon,  1 Jun 2026 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322244;
	bh=MCWQm59ZH3b9vqMODPMumqMATKfB/FyQLnOJnFo2a6w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gGdDBvWhMjdQDJZIELxe6fssLShnuNL29YqvfmnWmnPnxjiyYA5A99XjLhGRENvRH
	 D0sjxVnpuAhjtWMk24nBEO4K4jncwFxUKdlZpw9bf7E9GoclEoLyx0d1asLeeTw7IE
	 pKh/hFNqUbeWnBR+pxU4tKQsOneHiYg5zmw3O0EUd7c1XpUYnuuWyDk4TLAMr/vAIA
	 cyLR0v7IrHh+MBlV57c/hR0lAXbIoVCgIq9F+ut95tIKwUzaHTDvd/fj3CKP6S0O5Y
	 3qTJNV1fh1u4dxWDSPZlnmPOtrjZJr6rt9iQEXj2RZR4JPXxK9mRwgYmZpPyomDmYN
	 I7JiCzboLNpnQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:46 +0200
Subject: [PATCH RFC v4 13/25] ksmbd: use scoped_with_init_fs() for share
 path resolution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-13-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1243; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hmspYre6B8hLxwtzedBtLGee9Mt/2dAkvKYui4zrliI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i87PzHb6mD/8wnrIlb1xR6SeeITtc5o1aVLBkHp0
 t4tH9gPdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkVg4jwwltjp1uduK/OJWr
 vjPcfbq5plCs8yfPadeCL5bSMYolLQz/Xfw6Ct4t8hJwLXy7eoXZ3Pfc1wp27n7x8PJTybyUFVc
 YGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call in share_config_request() so the share path
lookup happens in init's filesystem context.

All ksmbd paths ← SMB command handlers ← handle_ksmbd_work() ← workqueue
← ksmbd_conn_handler_loop() ← kthread

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/smb/server/mgmt/share_config.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index 53f44ff4d376..4535566abef2 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -9,6 +9,7 @@
 #include <linux/rwsem.h>
 #include <linux/parser.h>
 #include <linux/namei.h>
+#include <linux/fs_struct.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
 
@@ -189,7 +190,8 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 				goto out;
 			}
 
-			ret = kern_path(share->path, 0, &share->vfs_path);
+			scoped_with_init_fs()
+				ret = kern_path(share->path, 0, &share->vfs_path);
 			ksmbd_revert_fsids(work);
 			if (ret) {
 				ksmbd_debug(SMB, "failed to access '%s'\n",

-- 
2.47.3

