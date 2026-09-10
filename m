Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4B4AA59A
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055345; cv=none; b=aTQGXpte7PY2BZ6vjy3CxfWYdBHF1SfTFnZuPel+e23fBRrJIoJVyMAtUDEO6WWPGjJaQ0WY5hZffQSGvjnNqDZWv//J/a1IhaUMRKS3G2eTpvBpNqOhiBXTkf4tfqATdFZ/KGhH5uaEJNFiGeqGXkByfpDrF33Epk1HejmcCQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055345; c=relaxed/simple;
	bh=uuI0Vnn4FO91RQ5oQq6SfWjNHw8uvjejA2r8tdzKKGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhTOnlth6ECz+PwfiIHP/cqXoJZ73H9+PHl2BAdCTXqgdvMqqFhvBOQcepyPKEsWSbTUTFQSMxG2NVZhPrsp7tVgkLkAso5zB9gUU4RnPi3SLjJzCxc+nIjirANOjWB5MP7xRvi9aOdNFI2jHuh7kKzDfrSjnf3ssiDKBxK4NwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMqtCZBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMqtCZBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D0F1F000FF;
	Thu, 10 Sep 2026 15:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055342;
	bh=9hAqbW3nL/2uabINxDfy8nC2wUb3edjWpmx+pJdhD1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cMqtCZBsnNTZh7JyImQM1EBFBiKpF85XyRQFsImLtpLsAaMKqTYVC1CE3Iz96M8xl
	 5au55fBjFFpV5hUcLcLbqOVgxl2554OTfgnSgg0BlWN4nDlPqJ7R+rBNc3Sw7kFhkW
	 n3cTiuNh5zJMkzehOkGWKY3QwaAxLHo43g29kzNV4nSdM6EwWJh2ZBwYzIAc4q8FHC
	 HwESinssZ+dRQbtDE19tSbR6iymVJ6uxkj1mBJfQOhpS6sXBcW1s+Z2HkXX6MgX2Rx
	 R74dByMh6NWWR9P7Q5N/mRzK0qtDbT3BBjlgEhDaMhPaoCSHKuPYfRitagbG308t6D
	 4O6peO4qPsO4g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:14 +0200
Subject: [PATCH RFC v4 16/18] coredump: cancel io_uring requests before
 closing files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-16-a5c1800dc930@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1899; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uuI0Vnn4FO91RQ5oQq6SfWjNHw8uvjejA2r8tdzKKGE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumj3cHlnspP0hakmbZ0HKlcLm7jeeCp9enPSw7U1D
 md+X17S1FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARt2hGhu1PJ2ptCdh28sqK
 L8mLLWP2vBHsY1usXSX0xen+mSPcPP8ZGeYfNp+h33Dh0aNfK29+zhZ79WjrPtbMDyxF0gpTT1n
 /f84EAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

COREDUMP_CLOSE_FILES allows userspace to request to drop the descriptor
tables of the thread-group before the coredump is written. io_uring
requests the threads had in flight survive and say a poll-triggered
accept can install a descriptor into whatever table the thread has at
that point.

Since the whole thread-group is going down in a coredump do what exec
does after de_thread() and cancel everything. After that no io_uring
task work can be queued to the thread anymore.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 5 ++++-
 kernel/exit.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 4ffd801aca01..87befc5df961 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -40,6 +40,7 @@
 #include <linux/compat.h>
 #include <linux/fs.h>
 #include <linux/wait_bit.h>
+#include <linux/io_uring.h>
 #include <linux/path.h>
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
@@ -576,8 +577,10 @@ static bool coredump_close_files(struct core_state *core_state)
 	}
 
 	/* Use the dumper's real creds not the overridden ones. */
-	scoped_with_creds(current_real_cred())
+	scoped_with_creds(current_real_cred()) {
+		io_uring_task_cancel();
 		switch_files_struct(current, files);
+	}
 
 	coredump_wait_inactive(core_state);
 	return true;
diff --git a/kernel/exit.c b/kernel/exit.c
index 04f2c8c78879..4c94a475b958 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -452,6 +452,7 @@ static void coredump_task_exit(struct task_struct *tsk,
 		/* Pairs with the release in coredump_close_files(). */
 		if (smp_load_acquire(&self.files)) {
 			__set_current_state(TASK_RUNNING);
+			io_uring_task_cancel();
 			switch_files_struct(tsk, no_free_ptr(self.files));
 			atomic_dec_and_wake_up(&core_state->threads_remaining);
 			continue;

-- 
2.53.0

