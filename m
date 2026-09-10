Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFED466B57
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055322; cv=none; b=em2E9sJjJT9aYKQSpcVXEBChnIugz2ulWceMBgUi3C4pM8+K/J/qwvxUInlwzLN5OKGzvzSzcVLKy3a2IGKe3ckMdAe1rrWkJJUGHC2DJXYKUNZ3VicZj0qFE6uQAUZRRUze4P6jUb0Ws3cMcAZFhBVPVRAGBl/iB7FK4Jxk9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055322; c=relaxed/simple;
	bh=aNv31u/U/hTJQ0rzNFFcJZyfnOywjjk5WznCfQHQQOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tzg93GfiibCpBeFOfQBLRE2FFWk4wkh/eUzPWGGM77gGaE6O0+rAmBaOXvQ6FsEZqf9f5tWCl9r4858vHC67tp9zTvM7Buxov68pazPFcn7zvMyhd+GW50bjmpFLrECRBr9aGrYlDVxpUmumSR2hT+/XmRUv5wQk+2oI0CuKNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVtR/P2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVtR/P2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0D31F000FF;
	Thu, 10 Sep 2026 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055320;
	bh=Ls9m1DYaOor53vLbaiGXqbMiy9JGE18egUEfz3LGjUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fVtR/P2w7Bo3NN+0WqEjr+n1fteM1/7M+H1xkkAoBn0scIP6wHQWM730/kTkYn4vY
	 /sFjwgwnIrvD4NjVdYXdgp+PM1xgoyBaBgHsZ+1POI3FYyVx91RlV2uV71UIzvYa2y
	 QjinI5tDYcLjKsS23jxi4LN6jRzRLGVlige0VQvwMC+uXHhuId9aZ2NkTrW/6xnInT
	 xLQvgFf+7CrLghLNkFHE/TtMd4SSQiD2F1L7CRHLFqFI6mXK3RAsgSo9ViRAz5g1bL
	 GYTZsm6qQ1t4HWO+qM8NKZfckknYy9m6yvZIu4HCrl/5kbmgFy7ZUuHvuh5fjuNsg4
	 r6SKnHEs6nPsQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:06 +0200
Subject: [PATCH RFC v4 08/18] fs: rename do_close_on_exec() to
 close_cloexec_files()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-8-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aNv31u/U/hTJQ0rzNFFcJZyfnOywjjk5WznCfQHQQOc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumh7v2yO7ffblXUuW5dcN0+YYnJC4f3hrP5w36ei/
 xli92fs7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIwHpGhuvlRlXVl+bKXH9X
 3pBapPVBXfL6XelAhlXv/5Y8bXgj8pCR4WVn+n3T11Wic3hfJsZ4/WRZfr01h7XV5n6YlZK+bMh
 efgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rename the helper and align it with close_files().

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c               | 2 +-
 fs/file.c               | 2 +-
 include/linux/fdtable.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 977778f44cfc..1d9163155d16 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1179,7 +1179,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * This must happen after the point of no return, and after unsharing
 	 * the FD table.
 	 */
-	do_close_on_exec(me->files);
+	close_cloexec_files(me->files);
 
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
diff --git a/fs/file.c b/fs/file.c
index 178c8cb9da09..b0490566719c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -901,7 +901,7 @@ struct file *file_close_fd(unsigned int fd)
 	return file;
 }
 
-void do_close_on_exec(struct files_struct *files)
+void close_cloexec_files(struct files_struct *files)
 {
 	unsigned i;
 	struct fdtable *fdt;
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 666808a1caf5..2965acd120bc 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -106,7 +106,7 @@ struct fd_range {
 	unsigned int from, to;
 };
 struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __latent_entropy;
-void do_close_on_exec(struct files_struct *);
+void close_cloexec_files(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);

-- 
2.53.0

