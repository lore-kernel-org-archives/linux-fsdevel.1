Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E813B95EC;
	Mon,  1 Jun 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322235; cv=none; b=Eiksa7HYwICXH+I6YP2sl8XylC6x100zW+uO9rNJabd3BvJepYMFCiQ7VOrkUC/urS7ivcLHpkfEXzr+RUAxCQlkIEh9SHYr743Xt2T7sxD0sP/n8On8DeJMQpJUHj3qkcYgJVFUNs8IMb5MEvPMEYs5lkpxmnBgpBId9vPGEJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322235; c=relaxed/simple;
	bh=28cTtoRZ91x0UobuBzcDuTy88XofJSyJRzGUK8il5ks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/2HFJrU5d1r+HLcW9Uj/yi8j2xruyIY1JI8sTvd+PKlHshus2s5hZdDtk4pHNEC6jnEUQVcBuCyOlZG/GpolK0EE1/lZynK8rgj/Wb/9yc1nu1M08vSqJGF4p5KFmMDUnHGfEavW8YN7k61jzVGLWsO4DGnczJzQ6hDD+OwBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luHnu9RB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luHnu9RB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6605D1F00893;
	Mon,  1 Jun 2026 13:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322234;
	bh=giKY8JuX3BnC+v3+mCwSxvb1yY79yldA0LrSALkMRIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=luHnu9RBuLVp9DPZ6KFuaeaGlOoxBQtxZtzDtxyt/MxbABLmiitL7ffSmZMZ3arnV
	 AOBV2bmp5jXOWq7UnN9GX3xIfbtngJvtALan7kY9wTObsqm8eiR9bvLiU5zXuGRkX7
	 g/tte6hJVUttVaWB3c8pY83+VRZHCe32vMBuNdZ8RLTWmyEASnN7gtEGeX9gQWt9yo
	 lT4PkT+vQwpuOa8M/0TaM/ZV7XIfA2XuIk82YIbwP4DnOuZ6nLR+LTWC/Y3sdT9WkJ
	 ypoqqN5cofrQLMwFX9/UZYh7PwLjD1S4i+ZLiOeGQ1pOD9/mQcgyv4BRaBBdrssRHG
	 f727xSia1UB/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:41 +0200
Subject: [PATCH RFC v4 08/25] scsi: target: use scoped_with_init_fs() for
 ALUA metadata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-8-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2077; i=brauner@kernel.org;
 h=from:subject:message-id; bh=28cTtoRZ91x0UobuBzcDuTy88XofJSyJRzGUK8il5ks=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i/LkwzqLl3NcCJLklFuRYtm4GvJ+W/nRG4WjyzgN
 +xczMXeUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHHwYwMnxikf045ufnhP3cT
 9bjsXtnYX/GSG095rmH5ppm/ecuVAoa/4vLbRH98UawOrWVt5PiWzBLL/1buQ8m2PSeUS0/bXtF
 mBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

core_alua_write_tpg_metadata() can be called from both kthread and user
process context. Use scoped_with_init_fs() to temporarily override
current->fs for the filp_open() call when running in kthread context so
the path lookup happens in init's filesystem context.

core_alua_write_tpg_metadata() ← core_alua_update_tpg_primary_metadata()
← core_alua_do_transition_tg_pt() ← target_queued_submit_work() ←
kworker (target submission workqueue)

Also reached synchronously from configfs (user process) via the
alua_access_state and alua_tg_pt_offline attributes:

core_alua_write_tpg_metadata() ← core_alua_update_tpg_primary_metadata()
← core_alua_do_transition_tg_pt() ← core_alua_do_port_transition() ←
target_tg_pt_gp_alua_access_state_store()

In that case current->fs must not be overridden as the path should
resolve against the calling process's filesystem root.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/target/target_core_alua.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_alua.c b/drivers/target/target_core_alua.c
index 10250aca5a81..140154d93c43 100644
--- a/drivers/target/target_core_alua.c
+++ b/drivers/target/target_core_alua.c
@@ -18,6 +18,8 @@
 #include <linux/fcntl.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
+#include <linux/kthread.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
 
@@ -856,10 +858,17 @@ static int core_alua_write_tpg_metadata(
 	unsigned char *md_buf,
 	u32 md_buf_len)
 {
-	struct file *file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+	struct file *file;
 	loff_t pos = 0;
 	int ret;
 
+	if (tsk_is_kthread(current)) {
+		scoped_with_init_fs()
+			file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+	} else {
+		file = filp_open(path, O_RDWR | O_CREAT | O_TRUNC, 0600);
+	}
+
 	if (IS_ERR(file)) {
 		pr_err("filp_open(%s) for ALUA metadata failed\n", path);
 		return -ENODEV;

-- 
2.47.3

