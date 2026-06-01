Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9639B3C276E;
	Mon,  1 Jun 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322258; cv=none; b=gnpymtUEd5jGRKyIYEBPvwZWHnevZfaLYfnJIdiirUmvwIEggAGd/ig7cIijHlbAzgQ8yaW8DT7Bp1JIGqjL26h+BU5GAsiyXKgT0d4vaV2pp3yv/t++G2a75nmVGSvDb9SwQf2c65SEeEC4mhRVTbc7jlQp7CwV5M8RXWqWraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322258; c=relaxed/simple;
	bh=ouNU407PhdIIo4gSUg9hKgoIISq776guRJTLUlV/918=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSl86yUuLmYCBiedJIOU3p3wt6aKaEtiy0QV9pmQNp8PUJj71Ai/VzYSFnyI2z+ibBz9ekXrGlOMWnT1KiSYXrfBKS+xeUBn51vKOQuuUIBEy/2nj3eo0vgAup2Lgvn4GQnOKcO4/QeB1o0Jsmkd+vbbsn3L+6+HODHTjf3kH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b19pQ784; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b19pQ784"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EB41F00898;
	Mon,  1 Jun 2026 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322257;
	bh=YVrJYzKiKi89cGpXusa/GFqngocxeuWdl+3cN2YlACU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b19pQ784V8OFqy9MyRxght8NdoRBmI+GgNjbJf95Zf0YBZ4NGqXzf8aW5TCNMdBBe
	 24ZSt+iCkHR0fPbVtBJ/kt10MOOmH+f5Y5CXBWIBqPheRlq/ZB0dp6jOHOQj0aNvR7
	 yLpPIonYxw719yLyX8DHNKf3TqnVm6cRnFd8IaRP0C70LmR/Arly6HFMHSH97jIGvQ
	 3KCjb1VAnYRX5t6JhUkLeLvu3IrrJqkGsBgDYkGm9Zrqb4pVTbvLBtniARqANFgLMs
	 LFwaY/lhhzDHAxEAD19XMxNB2ycgMnEPd+jWPUsaY9YLboudvGBSuVInddRKxtH1iK
	 09/3mNYUg34Yg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:52 +0200
Subject: [PATCH RFC v4 19/25] fs: stop sharing fs_struct between init_task
 and pid 1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-19-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ouNU407PhdIIo4gSUg9hKgoIISq776guRJTLUlV/918=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i939t2h+S5GtOIT8xul/AWvln63ueumXJSSmnR1/
 tGVYi4yHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpADf5L8Nf4Z3OJa4PGhlT9Bq9
 bbeqmV9acDSS2yx12jdnZ7NkzYf8jAxbwxanPl/GJT15g5CgzZW+5Rc3nxCI5ghesrpgqm3DCw4
 OAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Spawn kernel_init (PID 1) via kernel_clone() directly instead of
user_mode_thread(), without CLONE_FS. This gives PID 1 its own private
copy of init_task's fs_struct rather than sharing it.

This is a prerequisite for isolating kthreads in nullfs: when
init_task's fs is later pointed at nullfs, PID 1 must not share it
or init_userspace_fs() would modify init_task's fs as well, defeating
the isolation.

At this stage PID 1 still gets rootfs (a private copy rather than a
shared reference), so there is no functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 init/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index decfb0e03663..7432192b97fd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -716,6 +716,11 @@ static __initdata DECLARE_COMPLETION(kthreadd_done);
 
 static noinline void __ref __noreturn rest_init(void)
 {
+	struct kernel_clone_args init_args = {
+		.flags		= (CLONE_VM | CLONE_UNTRACED),
+		.fn		= kernel_init,
+		.fn_arg		= NULL,
+	};
 	struct task_struct *tsk;
 	int pid;
 
@@ -725,7 +730,7 @@ static noinline void __ref __noreturn rest_init(void)
 	 * the init task will end up wanting to create kthreads, which, if
 	 * we schedule it before we create kthreadd, will OOPS.
 	 */
-	pid = user_mode_thread(kernel_init, NULL, CLONE_FS);
+	pid = kernel_clone(&init_args);
 	/*
 	 * Pin init on the boot CPU. Task migration is not properly working
 	 * until sched_init_smp() has been run. It will set the allowed

-- 
2.47.3

