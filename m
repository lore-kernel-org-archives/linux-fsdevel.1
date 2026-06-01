Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D0E3BBA0A;
	Mon,  1 Jun 2026 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322243; cv=none; b=E3RLh6hellOritJFM5hCOWdsjBIU1eQXfozSZrh+UK1tr8TmLghV5kYgYtHoWCwXV3g9JTOgJt5bH1qMe4HtIOXbGJfDT42PXiJa2fxDyFTKq4WB6yI1rGL+9pSouSUAP3rWP1hVbab6YwX+lqzKQlWBS9XfFQMW9S3ne4RPeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322243; c=relaxed/simple;
	bh=WbM5yrbUDi3/A+W4ocvtE04HeGFEymTz1EUeNC3DQ9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tiaWekMosy15mVwS4M4KVlauwJ+Yod/XjtYDgOPcWYDU4kld4At5qQobWdef/DSsHZLs8Fugzifj7TQIz/RcrTDvSDBCYUXmqR6US5X/R0eZroez8gljvqGfQNTnfKt5POwhwPgFFUBIlDGLpYFs4VEiqwefKdiKwAtajbouWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A697x/VJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A697x/VJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B781F00893;
	Mon,  1 Jun 2026 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322242;
	bh=d9dIeMI3yeIFwM0OgiOFJGaxPa/9AVWdbWSEQYd01rI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A697x/VJkMi9C2hfKl3QiVjXXBZeTe8qGULFoPJEW21rCjd+knpjKW4vyLtRkCWyR
	 KKj9OUJHX17w/NU2DJH7S2Lv2ISbtirlGS7Y6tUtX7G6Rfp0dTztuzrnLq0di3eU19
	 D911DXBnSWAzkJpDvoWhLDzRxJpnp04V19Pgnhy2YioAeyFCqJlwKf8y/JIzZ+GEO+
	 HkRxNIaD0YGl/MjWxFNSwgf/Y9xoyCQ2fdwFESdvNJNzekdEPqq2km/dW3CVFynGuO
	 zz+czLX0sBO2oe8z/W7j2kMsX7RyrhNQz0Hw0bfEnpUQuxPXwIsQYQdwBd0HXYWAjG
	 otfimhqgXF0HA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:45 +0200
Subject: [PATCH RFC v4 12/25] fs: use scoped_with_init_fs() for
 kernel_read_file_from_path_initns()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-12-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WbM5yrbUDi3/A+W4ocvtE04HeGFEymTz1EUeNC3DQ9E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i8L+6j7zPs0252GZclzOdKFt+/ir5XmEgtlMMqSt
 P4gNim0o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKTMxj+xzp49oVpGK/UPnVz
 j/3mqWZBl4RSlH5ddmxldK283cLpxvCHc2PGz7A1d7zzN0hdy/rIJrI198lm1TlNdoa7T5Wn665
 kAwA=
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

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
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

