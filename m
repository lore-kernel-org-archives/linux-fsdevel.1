Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9356F3B2FE5;
	Mon,  1 Jun 2026 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322224; cv=none; b=PSB75M3skbDlxULwLj0vIwB8LiPZ5Lzo4kqSLWnt8Wcx+Uwj1uT9FMtI3EOPTO1xU3a3UcfdoTMy/aH/IU36JUC4FQMgW32Ih6DL9tXsz6S3fDB4rNLRbFzhxiRPwNLlyDUqQsOJ6Y6QLP3AmoKCEG3Uao8ktiSqtPyGUMpFiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322224; c=relaxed/simple;
	bh=BliA19S07rKsVkf4xeLasH02Rb4ERGW+MohJKrIOM2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rjy4OA/m9CmmIALI9oIzbLsu7kvVebVbKn4xMyr/nJsyqINFWnY0uXzzX77ak3kcgEemtQGJzeUzrDJvzojloRecuCaKz9n8jKe90voytKO44gAg/5R1sG/SOVxQlK9P8vx/r0WseLESoXbvP6xdx8rebyDHjfn7uHRYfzyV7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8vvKcnh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8vvKcnh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3B91F00898;
	Mon,  1 Jun 2026 13:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322223;
	bh=mTIpKAHMdDKkQPRhXjj8t3+oXF1jvWG1sx7dcBjeR8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a8vvKcnhGWtfVHtAPaxANEHq0nux0Cz3rGFjEnVv54BGeSCLhgQ4rDOXzcwnGIHST
	 SZP6Lb5BO+kVD5xXWBccp2encQf0Otgqci6gBuvz/wtmsylQSzTEPmsksMK13Gw1Vm
	 7sVM0kPKYZzSVOZH1IsEwaOpoRCYlGkjXSKJIsDq8gyApeZYOfgx/ERozDxEfk3xw5
	 l5rzfk//dBgioDqMqab00GJPZQiBnt0lqXA7wUKm8b7FT953wcHN9qfS8oPuEJ6pFA
	 xhEYSUEjP4ZedWkPQei0tTvSX3OW9hEtC6fjed473pfvTjvWTYs6X8kqAmyTQyZSl6
	 oST5CNvruDNng==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:36 +0200
Subject: [PATCH RFC v4 03/25] fs: add scoped_with_init_fs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-3-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BliA19S07rKsVkf4xeLasH02Rb4ERGW+MohJKrIOM2g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i/jtZR+ftEk1qp0vdBK6SviL/Yk91wo/HH/2DbOi
 E/3G15s6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhITifDXzmmOncug9D7mlOT
 464cm/TizI4Lr15OWHJw9fVQYQkdkVUM/2vff+GfuTiM6TxXwE6L0wnzTi3g8tI+cjc5/VrLvZg
 H/1kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Similar to scoped_with_kernel_creds() allow a temporary override of
current->fs to serve the few places where lookup is performed from
kthread context or needs init's filesytem state.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 include/linux/fs_struct.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index ade459383f92..e11d0e57168f 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -6,6 +6,7 @@
 #include <linux/path.h>
 #include <linux/spinlock.h>
 #include <linux/seqlock.h>
+#include <linux/vfsdebug.h>
 
 struct fs_struct {
 	int users;
@@ -49,4 +50,34 @@ static inline int current_umask(void)
 	return current->fs->umask;
 }
 
+/*
+ * Temporarily use userspace_init_fs for path resolution in kthreads.
+ * Callers should use scoped_with_init_fs() which automatically
+ * restores the original fs_struct at scope exit.
+ */
+static inline struct fs_struct *__override_init_fs(void)
+{
+	struct fs_struct *fs;
+
+	fs = current->fs;
+	WRITE_ONCE(current->fs, fs);
+	return fs;
+}
+
+static inline void __revert_init_fs(struct fs_struct *revert_fs)
+{
+	VFS_WARN_ON_ONCE(current->fs != revert_fs);
+	WRITE_ONCE(current->fs, revert_fs);
+}
+
+DEFINE_CLASS(__override_init_fs,
+	     struct fs_struct *,
+	     __revert_init_fs(_T),
+	     __override_init_fs(), void)
+
+#define scoped_with_init_fs() \
+	scoped_class(__override_init_fs, __UNIQUE_ID(label))
+
+void __init init_userspace_fs(void);
+
 #endif /* _LINUX_FS_STRUCT_H */

-- 
2.47.3

