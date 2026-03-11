Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C391E7660;
	Wed, 11 Mar 2026 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266189; cv=none; b=EXQ4aQWYn0n4Ru5OyRzd/+7apVfEL1NQJ7SN8ou3erbaKy1UcEaSMYx0xYfSoNZ7AmY2HVxWHNa64F+KzWA+nIhd3XWPBTGS9IaoAEKqD5dLQ75qFu6J7BnDQUmoCsIH4KL8xrTpK+vrEy/6kDgRkx3v2ZZEtp/nhj8Tpi3zu48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266189; c=relaxed/simple;
	bh=jsmYqEfin/W6QXrJh5f/89X3/kJ/bACDGoIAjq0LjVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7b8Xi7K4WOBc013iqobARK17gOqXH2MYZzeFxv89M8rXoLYauxLZEdrAMgx57lVz/XNeT4MPmGleVy89FF57SH0n250ZiyLmlcQbor1X5G+VKRO1qXtAvX+wI35q3vOewIAJLyeaAdeXblCidx6URVzkBs8Ngjf6Qt0iwoqxR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJiGUF3S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJiGUF3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265F3C4CEF7;
	Wed, 11 Mar 2026 21:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266187;
	bh=jsmYqEfin/W6QXrJh5f/89X3/kJ/bACDGoIAjq0LjVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EJiGUF3SEHU4DAbeLJypwaCzpwL8keAHscr6VgIJrRQmk6QBXBA950wk45PCagNNh
	 hgYFvKrKNhcwKMpE4r8XBkVhB+FHiFMYabw3fmceN04OBC9wHRx4q2bSa2YZ4UUhQF
	 2IdZctwNME6439wSjTmkp+b5RnBeeJU6mPQcMPIbLP3zilXlmA/MhXEsJtfmFS1EtH
	 dvsYiUe2d86US+0hnSTWsZ2Nb+TDy0DrC4YYcmyQT6fMjpI0NwwK7Azp3Ir6I9/xL1
	 xMSZnqXy3urPua3UKbYDPue8kZoSJb80P4TY62G15WpJ2vP/69gweu5VJVhk3Nh6vJ
	 7ojonbWBEkm9A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:49 +0100
Subject: [PATCH RFC v3 06/26] rnbd: use scoped_with_init_fs() for block
 device open
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-6-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jsmYqEfin/W6QXrJh5f/89X3/kJ/bACDGoIAjq0LjVg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJD46zwgeP1CY5Gd0828T/I3MFqsGbBZ9fJIeZsG
 wQ+99zm6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI7ruMDH3vnY52/tldf3PK
 vg39p7UDHKV0Pq7qyVj5V92yK9dU6SLD/4Ad5zSWWRj8rW1iiuUvfu8l91SM7UTz5DkJe6ucjjh
 EMAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the bdev_file_open_by_path() call so the path lookup happens in
init's filesystem context.

process_msg_open() ← rnbd_srv_rdma_ev() ← RDMA completion callback ←
ib_cq_poll_work() ← kworker (InfiniBand completion workqueue)

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/block/rnbd/rnbd-srv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 10e8c438bb43..79c9a5fb418f 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/blkdev.h>
+#include <linux/fs_struct.h>
 
 #include "rnbd-srv.h"
 #include "rnbd-srv-trace.h"
@@ -734,7 +735,8 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto reject;
 	}
 
-	bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
+	scoped_with_init_fs()
+		bdev_file = bdev_file_open_by_path(full_path, open_flags, NULL, NULL);
 	if (IS_ERR(bdev_file)) {
 		ret = PTR_ERR(bdev_file);
 		pr_err("Opening device '%s' on session %s failed, failed to open the block device, err: %pe\n",

-- 
2.47.3

