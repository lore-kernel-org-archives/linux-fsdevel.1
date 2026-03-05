Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF827368298;
	Thu,  5 Mar 2026 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753444; cv=none; b=qwtL9kC+vohc8GgYhom3whXpcvPs8bVFrccEEnJjlPfzp2UJ9Tys6PiJEa3RXlxpEgZIaCF/6FgM9h4Ggu2Y2r2VF2Lku9Yyj5m3PdxJ5KiO8tsxoXmZtR5NnUlzZ/rh/yKZ4eR+vKRbYtzjegBf6bT4Vh+fHQN25INkAJSgdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753444; c=relaxed/simple;
	bh=zF8twvQogD362sFS14b9O2jvMAhbKYrV4VTnG9w1uzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdsIZ2NBA471QYcpWmcgmO0y+w0jxmPRuZdyLULZcEjx8G5RYAuVcEilAGspLzPFWfqie74h82qxqhB2DHQt0n31bqnuPdiR26HA5WmdmVmjh/xg6JNeID+ZI2SVVWTLs/IXAXKvYNEd4FkUI+O9t1y5qQOk9AXrVoN7OhJQBs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpcQ5y+S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpcQ5y+S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995AEC116C6;
	Thu,  5 Mar 2026 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753443;
	bh=zF8twvQogD362sFS14b9O2jvMAhbKYrV4VTnG9w1uzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fpcQ5y+SoTO2kqTwJABrjAnwVsF8o6y+scuDwDBQiR0WUyhGqMNpizAgq71cpfPP7
	 IGhqCOBwtgxrMn2B+d/PVJaFAB4OjEi4Ec8gJ/UPkECcKWTOazp6pwlksujcwEWiS8
	 2KYz0ue/oIx/yS/c40OVaWQ9nEp1uNJhZgk6szaQYONyM07DXj/XJ8mxK451fsG9E+
	 frGyrw0xYujbkCuTJulwHwrFl4W/rvBZzRjiYv3yG/cwZjmU3os/3A9BUSFupDbD7G
	 8bbkWp/JsLmwFkvpAuiDXg02ViW1EXMnT19xiC23VLqJy/wT+1VXbP4BS0T8hhYRH3
	 9cvGDzPRq4YIg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:12 +0100
Subject: [PATCH RFC v2 09/23] fs: use scoped_with_init_fs() for
 kernel_read_file_from_path_initns()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260306-work-kthread-nullfs-v2-9-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zF8twvQogD362sFS14b9O2jvMAhbKYrV4VTnG9w1uzA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuKUnme3ZJkxQ0GP4oP7hUUnY6wlWc/uPNJs1dJ6d
 s2lPwfCO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACail8HI8MZYuUf+1I83JXtv
 NVyyyl03sePnohdr+I9FVoftuG9h4MDI8GX52ux9HIErM2d4b/9d/8Q08vb0j107VzRdMtPtvr/
 xMjsA
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

