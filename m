Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498EB3659E7;
	Wed, 11 Mar 2026 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266207; cv=none; b=itevtw9hiXF+gOz4sFMzovjnnO+SAoyPaqofg1VsVvwgcrAeJXu7FHuCp1UsXTNRiwRjSRc4cXxqTfuZAHWYKUuiSNGUvgtE/h2oMiJyCdrioG25ApjIpVRXG9L/7qPXx/lPJ+XZ+cc8ypevb1GEBkt7SpABQ9QoAe0qnqawC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266207; c=relaxed/simple;
	bh=l6PdqSMlvF3b2b9R+GwUvIJev9lUgXCwT4zIDcHSxvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ak/mP7pXeT3Qi+Sh+3Yg2cGM0GZqlk8yoGqfq2Tc3Ev+pIEsXgZWEzwvLcC5IoxZcGJO/x3eOI9tc1UGd/s0MMBrPmecagypTkOnh7Mt2Gg41Ytzfs4HcjsUv3/dUYNF2VOYKf07A8QMAYIlYOLWd+lVj6Z6xIsZ4o+B/rLf+bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJL2IbRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJL2IbRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0678C4CEF7;
	Wed, 11 Mar 2026 21:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266206;
	bh=l6PdqSMlvF3b2b9R+GwUvIJev9lUgXCwT4zIDcHSxvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dJL2IbRcDFTppjakvK5yst/K0WaqT9HIxUXfcTIyUxaWlsTf4VRBJjrDojq7bm9el
	 30B+o04xDww1YDJJXiKEoYMHUWyRKMLHEtwheTfWJ5U7C6fxnMk6Uqwu8AZRg3Aidr
	 P8plsRybg1pcsxS+sHXxvWSN5hEtBoCi+ec9uRft2hGwAoeBKJZ0FdHe54vHvm4GG2
	 3C8QMYhNA+Y2dYfHaWw0IU+hvXwI5GNIafERxSCLzrRUVb04n1Ltuzq5iiPAX3B2x+
	 KEQfXkaXhDjM4IEGjluHdLaKNmoa/ppt81A0zILMdO3WvSxXgtqnx9udWXlRC9XzHc
	 dMnVPg4EKiXiQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:57 +0100
Subject: [PATCH RFC v3 14/26] ksmbd: use scoped_with_init_fs() for
 filesystem info path lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-14-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l6PdqSMlvF3b2b9R+GwUvIJev9lUgXCwT4zIDcHSxvE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPLT0nWl5qRfkd1fWzv2nS/onCK6/Z/fWc/HAkx1c
 6umdswt6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIOxdGhk3zvtis0OD93xDO
 /PrPI5E7nentkwpufhB9uH4pi4+5wxqGf4ap28V3mV/dHTxRxdow6x5Xv6yucdicYw3X2v8UHrk
 /gQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call in smb2_get_info_filesystem() so the share
path lookup happens in init's filesystem context.

All ksmbd paths ← SMB command handlers ← handle_ksmbd_work() ← workqueue
← ksmbd_conn_handler_loop() ← kthread

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/server/smb2pdu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 743c629fe7ec..0667b0b663cd 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -9,6 +9,7 @@
 #include <net/addrconf.h>
 #include <linux/syscalls.h>
 #include <linux/namei.h>
+#include <linux/fs_struct.h>
 #include <linux/statfs.h>
 #include <linux/ethtool.h>
 #include <linux/falloc.h>
@@ -5463,7 +5464,8 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	if (!share->path)
 		return -EIO;
 
-	rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
+	scoped_with_init_fs()
+		rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
 	if (rc) {
 		pr_err("cannot create vfs path\n");
 		return -EIO;

-- 
2.47.3

