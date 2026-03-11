Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB33372B27;
	Wed, 11 Mar 2026 21:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266201; cv=none; b=oxIr/6T32tRxJKwLcCOOmaZ9wUEj5KKwVAKpwql73hObLkWGcGzQB4EhDS77kJSIY3n6yb+njB7cv+6uqwKPFKg8SML4l41kfb+2iG3LVKEF1U8Xovi4dp58RQeO9CIG+0qVMbLU32vs/9KyE/Jdiwy/MxyPntLxaiPBSOCewXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266201; c=relaxed/simple;
	bh=zF8twvQogD362sFS14b9O2jvMAhbKYrV4VTnG9w1uzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayWC9wfkwMd7dgkAd0H5plTySwNXFtwczoSq/sGZDaEquY1qzPoPXppNglOPyV9Fsd06sspFgOMdR2s9eG/3TDV8EoB0n8KdPkAf2SXfrpN46eru+89mVx8+8u0+rOeFFDbFQhrM3mpaU/sAQZOfQFOZn1E5nogkn4LlEywLjxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCZz5TVc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCZz5TVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FB8C2BC86;
	Wed, 11 Mar 2026 21:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266201;
	bh=zF8twvQogD362sFS14b9O2jvMAhbKYrV4VTnG9w1uzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZCZz5TVcWcRBijz2utA3RK1DZ5lMmeGItFtw9J9cZClS9xldRaguzBOSxVPsYA3N4
	 jVDANawiZ99N8wDbn1nPI+Z4TypPcuO/fvzfQwzcXEIVtSwOd0XwXRy66pn9hCEB+M
	 niNaXO+eviXNYaY8HuZkUbC4WC4Lr8GEe+fZyGh34AQ/mrZr3smS1UVs2ajCVQdS9D
	 JROF440QT1BoTao64/vBFR/UZ8wR44c/esUeHwESXig6VFFsj8DveWPkzLGe1XwdDT
	 X2vJ3k7GIYJzfZZIJcxigNLBakYHHqm30htut4l/swvsfIfqiZlYBMpoXFC8B8PgYr
	 aoPLVMrZVwsnw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:55 +0100
Subject: [PATCH RFC v3 12/26] fs: use scoped_with_init_fs() for
 kernel_read_file_from_path_initns()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-12-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zF8twvQogD362sFS14b9O2jvMAhbKYrV4VTnG9w1uzA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPKz+9hn5is9M1TjI4PEa49uNuDyNpS/9Oe47AedJ
 YuX1YlpdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkrz7Dfz+LNVY1mvPmcC86
 fu67hyVH5IfogH5fh8+T9RjTFxzdPovhf+KdB1n3TDRb95hHfnsvmHJmHeeXTJ9Tlj12R6p9Gh9
 H8AIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Replace the manual init_task root retrieval with scoped_with_init_fs()
to temporarily override current->fs. This allows using the simpler
filp_open() instead of the init_root() + file_open_root() pattern.

kernel_read_file_from_path_initns() ← fw_get_filesystem_firmware() ←
_request_firmware() ← request_firmware_work_func() ← kworker (async
firmware loading)

Also called synchronously from request_firmware() which can be user or
kthread context.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/kernel_read_file.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index de32c95d823d..9c2ba9240083 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -150,18 +150,13 @@ ssize_t kernel_read_file_from_path_initns(const char *path, loff_t offset,
 					  enum kernel_read_file_id id)
 {
 	struct file *file;
-	struct path root;
 	ssize_t ret;
 
 	if (!path || !*path)
 		return -EINVAL;
 
-	task_lock(&init_task);
-	get_fs_root(init_task.fs, &root);
-	task_unlock(&init_task);
-
-	file = file_open_root(&root, path, O_RDONLY, 0);
-	path_put(&root);
+	scoped_with_init_fs()
+		file = filp_open(path, O_RDONLY, 0);
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 

-- 
2.47.3

