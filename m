Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528537703C;
	Wed, 11 Mar 2026 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266204; cv=none; b=Ar8+tzxgm7Ei0DAI3NUOLRzAQQtt4fqsfm51CQ3ILQYmv+1JEJx+z7PeF2cHV2590JhhKPR+2VkXhQxYfkVSpUIQUBcNweTIN67/6jcq0HU/mCHKijtvezifWfEjV1SZKic+Pacowp+mex2xBvYEPOGdFmYmjbZ1WS5ebjzkpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266204; c=relaxed/simple;
	bh=2kDcoaN93XMP+vh/JKpvMv+7AMIQDdbFl8rAi3BOMms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZjFM14Xd/YEMN/2LWReySZ4etXBe8QR/xKAglVFAbaCGE8p/O2HMJNhDkuBNqMkj6SdOQqdfcQ1JvxplPtYDr2B3FF0QkgXM72+ZqUnAHRRsdCw1xjl4vlR6NfLVnKvftwkLD1buwVasrCPoIseicuUlNO7N7P+xXaXhyf1vw6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAArF1Pb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAArF1Pb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A051C2BC9E;
	Wed, 11 Mar 2026 21:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266204;
	bh=2kDcoaN93XMP+vh/JKpvMv+7AMIQDdbFl8rAi3BOMms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cAArF1PbGZuSnQswuvYbB3OR1KhNuB/zaf9snndRZfXzJgJsAO43T3q6voxYqqyF4
	 G/QcMcAe12ThawkYiL8ayYgdO/Pt37HxWSjzJERxeMD/YZhv92esJQvLraIyVsqJ+o
	 qKtiTSlp0lCa6n9qgIYIXOgpFBWr5FSeOJzCSzXNf7GgjVcoIC/T/A67Int3VHSQVA
	 IBrevnsO7QUd82Qb38YZuhFMPmMXdRW3I9sHW+018C5khHwLeJY1gpWfpK6Fox5NgL
	 n+xgoaRBvUE6AGYChBAFn1UTnT/gdrY7wVP9sLPZw5DNJtycDhN95zXhSItNCG00lT
	 hFtKII85p4e8A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:56 +0100
Subject: [PATCH RFC v3 13/26] ksmbd: use scoped_with_init_fs() for share
 path resolution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-13-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2kDcoaN93XMP+vh/JKpvMv+7AMIQDdbFl8rAi3BOMms=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPIzwSSvbPXaqQxnDXfZBSTobNZf1n5OdIn2ESOvx
 bZmkbxsHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJvczIsOYgZ9OxE5Wrjqy/
 uWpSsd/cc7duTmcSyHy9dWNDnHZi3l1GhmWSLxLvpEe3XOf8JFNiH9PQJv3rQY5tT33ac00dz5l
 hfAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call in share_config_request() so the share path
lookup happens in init's filesystem context.

All ksmbd paths ← SMB command handlers ← handle_ksmbd_work() ← workqueue
← ksmbd_conn_handler_loop() ← kthread

Signed-off-by: Christian Brauner <brauner@kernel.org>
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

