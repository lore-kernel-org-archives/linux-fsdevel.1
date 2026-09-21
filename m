Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38674AA588;
	Mon, 21 Sep 2026 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998354; cv=none; b=n3EHbQQUMUPtRkzgNtjdaLxeYpsSLGexUpXqScjWs8BHQXs/Pa2AN6xr0Hyl7xWe5IAwe2CudaEF6Ww64Tfx3IwHbKmd2oj6mhNdhUWuFOpUllX4OH3QLNHT2FLBQhbw5TXRSjrIbFPHpHYL89DWFsacY4Iui7ZQi2FvrUW+l0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998354; c=relaxed/simple;
	bh=B63fTvBDfUtF/BGISUIaLDChkQm0aNRJ/uKFQUOzDOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iWiUSTGk3B4dTbH90HNK/QcOLq1QtHp7O85ckl3+meEePYGs4LU0jbouvDhp6caboFZRG+eYnSJyVG5pywMl15yYExvGQEi/Q6YJjKlwcxP1RNTf5HmPMXeNyLCju3Pg5jUyPA23MPYmhGzIL672VzDdkeRJ5BfyLJw5ZEERXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ug0XbjGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ug0XbjGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6261F00893;
	Mon, 21 Sep 2026 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998353;
	bh=mPT8ADUtwA1ugCQ6bw6OiZg4E0fY+SldF60Vr0ZuxLQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ug0XbjGTbmYUSr9coKi7L+zPsvUJtshCsGuhrTUbK0kDKJr5wFYjESkyUuuLYTS2P
	 ppWztHXaekhoIiqW3BDOsW2uzs/UgX7PgFwcsNdLFt8BCtd3av0eoqH3wK6srN9Do3
	 DqvVkmYWTKhPoH3hz8bf51TDCHgQsYZt47xzR+6kMTUqyFVMPltg4+OJJ2mJDhD4hj
	 3ZnGCgAwVm5yDgn5wPzK6XMmRYonihfaBlkmihoSh6ndh8FlTMTOQXRP7wK8QKBucN
	 w5thdoufb9NwOS6FLktCivMwokg/pT2Evsub2UfTu7AXlGh2a3C5EY3ziuDIOijRE7
	 qVf1IbWe8OzvA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:45:02 +0200
Subject: [PATCH v3 13/17] fork: move the coredump and exec checks into
 create_io_thread()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-13-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B63fTvBDfUtF/BGISUIaLDChkQm0aNRJ/uKFQUOzDOo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLkzQX9O3u1LrD/S6zk+Rj6/njbrRoG2yU8jlRUn5
 22JXyNk11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARke+MDPcT2F/Lqy/ySJZ9
 6nI+9fXRz/5GbZu4c1lelE5Zm9H4ZR7DP1tBIbYQQYYd6+Smrf++MeuQ6mVhC1+z1HW6EcfWmh5
 9wAQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Only a PF_USER_WORKER thread returns from get_signal() after a fatal
signal and can go on to create a thread. get_signal() sets PF_SIGNALED
before it dumps core and before it lets a PF_USER_WORKER thread return.
That flags sticks.

The exec'ing thread itself is never signaled. But it doesn't need the check
anyway as we moved cancellation of io_uring requests before de_thread().
create_io_thread() is the only way a signaled thread creates another
one. vhost_task_create() is reached from ioctls alone.

io_should_retry_thread() doesn't retry -EINTR, so io-wq callers give up
the same way they did when copy_process() refused.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/aq0VLTyxNatFmLOK@redhat.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 50f5b3e2ca87..ede9f02bef47 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2706,6 +2706,10 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.user_worker	= 1,
 	};
 
+	/* A creator past its fatal signal gets no thread. */
+	if (current->flags & PF_SIGNALED)
+		return ERR_PTR(-EINTR);
+
 	return copy_process(NULL, 0, node, &args);
 }
 

-- 
2.53.0

