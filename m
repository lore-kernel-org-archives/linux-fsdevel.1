Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A172D3909BE;
	Wed, 11 Mar 2026 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266218; cv=none; b=kKU6/qm3rbN3d1Ay+M9TXoc/r5L+3843vzOu9eBR6vIOk2SrBCTUXb94qnY8OS/5pC/PBYF0XKDo93HuPPnGj22EpqtA/1vXQvealzYIAj7Mvv4ow1CB5Vsy+dwkvFMTLlvMsH751sBFVoJfdvOWlT6wmLH6TLgMvk5GJoStF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266218; c=relaxed/simple;
	bh=cEPoxGsNVeZpiXD7WHSwi6VwLjjrPPIdV4amCA7QCoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DWbgYf7OqE4odYZw7Vx64uLCetfy39ZGNWW+HC3x8CP3I+8GQlGzkKbJf9eCko98CR+MIneXlmABSBE/odSxRq9ltsYamjghqjGgYD8K5w2x0LxU5mUCRRzZzT/ickkUn+jpgaOosb1MW2V8kD0+TesMkOvsDUpewxqhy79hMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ+VwBgx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ+VwBgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBBEC116C6;
	Wed, 11 Mar 2026 21:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266218;
	bh=cEPoxGsNVeZpiXD7WHSwi6VwLjjrPPIdV4amCA7QCoA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BQ+VwBgx7ibv2Swk9+UTOvu2r4XXKwqGZelQr4EYxRsXw9RkaPgkFK0T9Mffht7TD
	 X4FBmKqmiwaPTqPrQ6gMpXTl6nGWX98V8YuHh6lfIjDLqB4L7o19t/qfmYMBJ0vakh
	 mFS6wWiFGb5fh+5ioiYj2+9Zpv5wPS6gV7vVRpOvTSUqTFLr3ykxQFOUrN0rpF9C4t
	 eUZgTGkfFD8MHPdbH67z8O+vv01dKknGjAzj+uHR7IMbTl3MfS6BT68XzhyNJcGjD8
	 S4mwj9AlQ5uppuAE+eecSf0pKWxKoq9G8nsqsKG/wFySdH4R2bepaT+ngTCPi1OaCi
	 R4sEjV+YtM9tQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:02 +0100
Subject: [PATCH RFC v3 19/26] fs: stop sharing fs_struct between init_task
 and pid 1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-19-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cEPoxGsNVeZpiXD7WHSwi6VwLjjrPPIdV4amCA7QCoA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPLTfYWmx/Yju7K49WW+MCzS/Jy+IDD/aMbWyzY3f
 ypq9uc+6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI4w6GP9we9vdZ10xMPdK3
 bu1v6bqNFdNbZsWWJhxMT3+aufdE72+G/07twVs7//+avfP+qU1HYk/Z3cqPV9sb5ZP+NXJ744J
 dwuwA
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

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 init/main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 5ccc642a5aa7..6633d4bea52b 100644
--- a/init/main.c
+++ b/init/main.c
@@ -714,6 +714,11 @@ static __initdata DECLARE_COMPLETION(kthreadd_done);
 
 static noinline void __ref __noreturn rest_init(void)
 {
+	struct kernel_clone_args init_args = {
+		.flags		= (CLONE_VM | CLONE_UNTRACED),
+		.fn		= kernel_init,
+		.fn_arg		= NULL,
+	};
 	struct task_struct *tsk;
 	int pid;
 
@@ -723,7 +728,7 @@ static noinline void __ref __noreturn rest_init(void)
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

