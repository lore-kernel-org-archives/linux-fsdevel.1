Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC103B635E;
	Mon,  1 Jun 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322231; cv=none; b=kxiFsMwgvhOaPFlajl9rW1W+fhGlPwMa28OvVpD+T5/dheBd+fJv+AvvJahjqqDCB5K5KN6f4JIqgBevwWlSmIJ8i4zj1hukBodLv7SeR5g8STmLtsHLRYeYTCy1pGqAERGd757ZIemZvYnV0w1dfoHEjKTjLBVNTblTM7eAuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322231; c=relaxed/simple;
	bh=by/+C59iwgehFw6nC4+2iHaRyiPP2fQCQhRwmRZjg10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/jnrYmalaHAYRiQqAq271ezoibMaytdMxNIFjdrdSXGa6RoqAIQ93GYL61MJWgsOQGJ4ujH5M0aRb34zU8fL4c7u0DayeEy0r6ggDwBKfIACYmxprsvhx+MLYdfJony8bVAwQOwxIHslNQTJLmXTyz2mfx5MVB6nMqe+qjCklY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQUdEeGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQUdEeGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAE61F00893;
	Mon,  1 Jun 2026 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322229;
	bh=x9Lc58HTpsAv/uPV2t8po/QIleDWlE/poupA2lhMO+M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZQUdEeGZ6o247TrjqL33dKounGqna8TQ/s8npGh4vWAwv+e2oMb9wHY0759wAbnIy
	 Ef6RR38m9AfhfIsDcPFy/EPBJpGwxCMSL3ZlXQT4pA0sC1HdU4qibhc+tHfU1B+7jp
	 099YMxTKeMhYdmNzRdUgPvNCHETHgIAHzq0nMriBMUftdFLiOhLYjEjmCikSi8lFuP
	 DSS7yRy0+wis+0Qbjz5ifSYOTETEjWfZ0IbKnVqfC2tNkk/XAAWbn9W9lmOTzXEJ/C
	 oaGsWPHi6O7l/Y70pmjxleFf9k12udQq4kpyu2pyjy+NRv5LW2rhqB8AdsWFtZQ3Y0
	 mKa1I1w8UbbHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:39 +0200
Subject: [PATCH RFC v4 06/25] rnbd: use scoped_with_init_fs() for block
 device open
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-6-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=brauner@kernel.org;
 h=from:subject:message-id; bh=by/+C59iwgehFw6nC4+2iHaRyiPP2fQCQhRwmRZjg10=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i9bsnMGI3vTzdrzyy7vf6Bh2mY1c5nXLKNoh4xFf
 OydvzJFOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYySZzhN4uJ5eEdkx/JRZyr
 vJGqVaTge3mFaMKDczva9Vapr5f778vwz1pX6ejLd/HBk+ZZqkq96rjs2/dOMSV72/q3G1d3Wn6
 zYgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the bdev_file_open_by_path() call so the path lookup happens in
init's filesystem context.

process_msg_open() ← rnbd_srv_rdma_ev() ← RDMA completion callback ←
ib_cq_poll_work() ← kworker (InfiniBand completion workqueue)

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
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

