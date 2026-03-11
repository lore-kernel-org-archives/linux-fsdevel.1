Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3601E7660;
	Wed, 11 Mar 2026 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266192; cv=none; b=Jx/G4X54WJb2n+/2sdcftxL2rZlp1yXs0CL+8sXqreuv+mIj/Pu8uwr0EnCLDW0ICWxes5sUScAkFNyf4Ct5sLtvyVsxOJKfcGNPvp0BOZ6xKqoSg43tDYvpzVdgwWuhjkqobXFCeer+esxQQAnCymdFLF8UZ16SNrmwlZT5Exw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266192; c=relaxed/simple;
	bh=BkzEXSS/aDyD/0RcykK+9iDod6MNEZ0v8zFBHEaX1Bk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nl8PoztYT5qNv6ni3Vo08zV7u0gl2W/+ZbC+pRt8hwExJrXL4g6jlEAkth+KVMtVxSbOPbB8JyM5pyVme6kNyHojKOQvsoGy7Eq/akTEhggC6u9wmy6B7rLv3CGCldlt6U8bQJnMzu76exU1G3/Mj1XVHHm6B3mHmZqqbXPGkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwCnWaPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwCnWaPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F8FC19425;
	Wed, 11 Mar 2026 21:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266192;
	bh=BkzEXSS/aDyD/0RcykK+9iDod6MNEZ0v8zFBHEaX1Bk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZwCnWaPvq5AHnnngvOsk11RmYjzfguwpJSnN3uwM/0P9IE9Om4MvP4mbegmWi3A6Z
	 F6BaB5xOU7AG14zApLiU6T+iOFSK+Dle1iHWwEGYFXAp04XRlBFFolS7JQJglhG/Y/
	 EJTUABKDCWEagg5Ff+8OokgzhRDiyZ0/Bzn/I9FGhh3sx1QwjRj3tLDP1dQwltn1WX
	 DN/3MeHium5ZIWWNncv5K7C93pgm0PHV7Mk0nvwd9FSI9UL78zn3LlA5T7ME7cIKAt
	 ccXS2RfnK9Cr+b3LG1fOImPE2EzS/eHYRDCRvqba7tklN5njOrZlFA6CTghBz4vf8/
	 HzOGmRzw5G2TQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:51 +0100
Subject: [PATCH RFC v3 08/26] scsi: target: use scoped_with_init_fs() for
 ALUA metadata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-8-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BkzEXSS/aDyD/0RcykK+9iDod6MNEZ0v8zFBHEaX1Bk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPIjI85+V+n7/SEbJsveixCX53tntn9DWF+CXK/UJ
 MGXdziyOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaiysTIsCdy2sN/c8r4D1iZ
 PGdadGTG7v+rV3Rrz/KXiPJMUUuczcjwP2OP0+1/CnPXSPB/EYyJ0//xV8H2VTWr33pzP5sQo5s
 WXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the filp_open() call in core_alua_write_tpg_metadata() so the
path lookup happens in init's filesystem context.

core_alua_write_tpg_metadata() ← core_alua_update_tpg_primary_metadata()
← core_alua_do_transition_tg_pt() ← target_queued_submit_work() ←
kworker (target submission workqueue)

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_alua.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 10250aca5a81..fde88642a43a 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -18,6 +18,7 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
 
@@ -856,10 +857,13 @@ static int core_alua_write_tpg_metadata(
 	unsigned char *md_buf,
 	u32 md_buf_len)
 {
-	struct file *file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+	struct file *file;
 	loff_t pos = 0;
 	int ret;
 
+	scoped_with_init_fs()
+		file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+
 	if (IS_ERR(file)) {
 		pr_err("filp_open(%s) for ALUA metadata failed\n", path);
 		return -ENODEV;

-- 
2.47.3

