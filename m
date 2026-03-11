Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14150355F39;
	Wed, 11 Mar 2026 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266197; cv=none; b=lzBHesQpL71JC/GLFG6E2A9F1/j2uwqRSZmOURtC3E/9XdGFZhrAUJ797B9LB/+WRKJsfUjtThgDhXtpIXnCCoYaM+IA/TqfqBPWNnwqLGJMnkpz8FubM6eaimui5+ytgCDcmklcYmCzgJBg6f+xnqpIASuDk0P+vLcC5CBjDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266197; c=relaxed/simple;
	bh=tqh5LkBF8hJuRKX1E/HzPe/YDkw6eJT1HDZFcFDFrFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3KU8nvp24Vng536HSTkc8soRC/eG2GDasqo3qyGTw3rhTe5s1Y77SSSfRWrTFjNNJinGhJar3ESsiZ0FMmK/cGUxVqCFGyioapIKelpbQfNo79lFD/7WmAillXVJEqurm598l5az26gdcOTtL8tTW7ZKKjYFPOsTCc7YBS3ZX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TD/wbbVz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TD/wbbVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B2CC116C6;
	Wed, 11 Mar 2026 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266197;
	bh=tqh5LkBF8hJuRKX1E/HzPe/YDkw6eJT1HDZFcFDFrFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TD/wbbVzBn8sLLlguUJj8XlWCLIXet+fB2T4biypOXorcb2fQ9MKVpHA5UuN85S+E
	 RusnHyTA7r+SBMqJv7nwbEKj4330JNM+BJ0pzE8qULO+NK2D3TNW1psVyZmmVEWMJB
	 E2hrhte5fAjc6L3NENsqyEb+EnDh7t6Z86J+0llqIKxerVdGAtKHDFpAkuN2fxC0/7
	 jUqgQ6KRo7Dis9M6BiNx3dToMtffJXDHcOBsPUNGP8Ng2gqVEA32LfW80n3kJh66Nl
	 Ebfa52lrgw9KRWiFDlCpApO3n5G1yRteTVzIX1GyQyeH/b7ZrfbNKyzkD9GtYiGcVL
	 yd0xHJvofN85A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:53 +0100
Subject: [PATCH RFC v3 10/26] btrfs: use scoped_with_init_fs() for
 update_dev_time()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-10-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tqh5LkBF8hJuRKX1E/HzPe/YDkw6eJT1HDZFcFDFrFw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJjl++mh/y6bZedk3usJ/srqpeXnFx/+Lbu1B/RJ
 +ZWuGrUd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk3muGf4qHo64xtbbxmeTl
 Oazk1PvevWKuPNdcyyOzfVO+TPapmMrwP33a+5hbYSuvuv9xvP0ybsqyjQYLL266sfUS865JR8q
 cUlgB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

update_dev_time() can be called from both kthread and process context.
Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call when running in kthread context so the path
lookup happens in init's filesystem context.

update_dev_time() ← btrfs_scratch_superblocks() ←
btrfs_dev_replace_finishing() ← btrfs_dev_replace_kthread()
← kthread (kthread_run)

Also called from ioctl (user process).

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/btrfs/volumes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 648bb09fc416..b42e93c8e5b1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -12,6 +12,7 @@
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
 #include <linux/namei.h>
+#include <linux/fs_struct.h>
 #include "misc.h"
 #include "disk-io.h"
 #include "extent-tree.h"
@@ -2119,8 +2120,16 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 static void update_dev_time(const char *device_path)
 {
 	struct path path;
+	int err;
 
-	if (!kern_path(device_path, LOOKUP_FOLLOW, &path)) {
+	if (tsk_is_kthread(current)) {
+		scoped_with_init_fs()
+			err = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	} else {
+		err = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	}
+
+	if (!err) {
 		vfs_utimes(&path, NULL);
 		path_put(&path);
 	}

-- 
2.47.3

