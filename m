Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BE343D64;
	Wed, 11 Mar 2026 21:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266181; cv=none; b=EY3eIyaHIL2krle89QX9MNwUb0TIFxZ/BvwWcru7Y+KQrkOxWi37Tzyh8DdsupsvRgRhhNsLcbr+lZbfwSxkSkxx8wTbNm096lKyUw2tZ9wKa2HK90UP5vRQ/KcFCZmiiDx8IWfRK+ur4atfjPNrfw5gj4qsP/SbKtdZIb6vsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266181; c=relaxed/simple;
	bh=pKcYYv5NzsH6Tds8Fh0T0OgLaCOFJ6HHiCfJSN8HVgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bY3LT8xMngJAV13D57msN2bCLoNoN83liKS9w2Juik+ah8Qw3x2VmuyEJiqXmdmiUu+hl5/n2NksRa3r9tAcrBcGVmmJVvS/o0PdUIHoaQ3nF+iKSTZ10cRvKSGzAM3BiaDVEvl0zgbpPjj4coHXFghyeemJQ3wX3RhcMtK91XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNfOjvfE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNfOjvfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E9CC116C6;
	Wed, 11 Mar 2026 21:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266179;
	bh=pKcYYv5NzsH6Tds8Fh0T0OgLaCOFJ6HHiCfJSN8HVgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VNfOjvfE0wg36JHYun7b1fJFgnLtzkecGrA2uhh5yulE1FfE3OB1haPn1jCom3Wc/
	 h1yPSjjOwj6Yfybeabwxd4RFRv4DtP6lsBu7FBC9FTpH+/HYnWoZTRVln3BbRcFa8U
	 ClomA7/ytZuWkb1MVpHpDCSn/XWcYAEmuc/8ebJItBV6KA/R/EIWjdJKDHFM/4+4E4
	 l0iwa/4m7tPv08rRbhRYJfExYMIN4MCRKhsp8IuoaiRXbW/Ybdu2rxaEL+k3raALAo
	 4uDbnR1JmEW2dn1Qf5v2kQw7IjBX1lp31zQWba3W6M4VmI02ilKgC8DpazHLxUyZfQ
	 c3re3zgQp8Zaw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:46 +0100
Subject: [PATCH RFC v3 03/26] fs: add scoped_with_init_fs()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-3-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pKcYYv5NzsH6Tds8Fh0T0OgLaCOFJ6HHiCfJSN8HVgE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPIj/sej38sSNqvmRDLxqe/aL/P/5uPLfFLSvxJ1N
 2Zr/r9+rqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiiSmMDK9V+7r1U3f9jFZO
 mnDg2BRD1kRbBoG1TNskF6hdSpKvm87wV76lWH2b9PKiNn7bG0cdE/oCv+zeWJie8z1JQzoraZk
 eGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Similar to scoped_with_kernel_creds() allow a temporary override of
current->fs to serve the few places where lookup is performed from
kthread context or needs init's filesytem state.

Signed-off-by: Christian Brauner <brauner@kernel.org>
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

