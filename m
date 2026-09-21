Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935E04A260B;
	Mon, 21 Sep 2026 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998361; cv=none; b=b7LE+qgJMWehe1eAFbtCesu16Tf32CbUXSga7Nkvdh5E2OCZm4qCx/XgmaXbGBAJ+5/jgnJrnmRVXzCXOfLi8TgveipPjyM6odUMshEkxADeDMReSH8FHKs2GiGBoQbftu2byZy4DXnxTOtSKkuKM55D3bP/A3dVJRRTEthoNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998361; c=relaxed/simple;
	bh=yCrptVQSCLxgp40maZKNV7rkyMoVZAxnjWKhpjaLvr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gn0KeL/zikmHhWpDEiyqmDS8xkWL2Izk4B6vS70eYesoThPqzI2ZglcHFyLFz2UA1DH3Dluw04OPdT2rzbbjNAaHGQL8HTuPXxx/eaWxsT3E7HBypJDrSJnQneBtKIhOy7ClSkmPk/Y7RID0L/Rh9MLu1j/VxdaUtrcfoeFi0JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icz+xHLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icz+xHLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610E51F000FF;
	Mon, 21 Sep 2026 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998360;
	bh=XxgAqAUyM3r1AMPXMQ8hoig8LfHIWtySTBDxI0y9Hk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Icz+xHLQDbSSHi+N16YU2y1GynY0LZOE3JZDzMAEEJb1D9m6KWdZXk6U6V/zR4B+b
	 7BQ0M3FukLH+6GiiG/lrkgJnTx7AD7Sb6I6vnfmSz5HLp5Dix+bFsCqut5L3GjA84M
	 H81IAH19uXN6Xpky01tPMlFxnH0Fpg0k8NQlnf0R0XcS9UWA8CYZGJPPB9dFi/5Pmk
	 7xDw0is63fwMPgi2HR6RClWMOqNiQzerzUvn5Zll65iyjGHicysJEoPvNi8FAxlajD
	 iJ+9qqED0JN0fTAPWDJA+iFMly2UY9vjm5b0x3DmUfPelnNqQ6VHRnVMnsqCYGF42n
	 6q6C1ZI5oYsmg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:45:04 +0200
Subject: [PATCH v3 15/17] fork: use SIG_KERNEL_ONLY_MASK for the user
 worker signal mask
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-15-8e4adb1619e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yCrptVQSCLxgp40maZKNV7rkyMoVZAxnjWKhpjaLvr0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLkbfG+y84Npu9ZWagY+7p2WIyKbz3Sfa/8+x/vSD
 zafPhYr3lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARaRNGhrcXY7ZsTZ6jNNM8
 5+Da9zJOzt/TT616dPpe/LnU5El8RdsZ/grymgnb7Ti1aX/FebM0wdDwrOML/9l++xg9x/7uwxI
 md04A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

For a user worker copy_process() blocks every signal except for SIGKILL
and SIGSTOP. Use SIG_KERNEL_ONLY_MASK instead of open-coding it.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index fd2829b0a8b6..be5980d0dd9f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2146,12 +2146,9 @@ __latent_entropy struct task_struct *copy_process(
 	if (args->kthread)
 		p->flags |= PF_KTHREAD;
 	if (args->user_worker) {
-		/*
-		 * Mark us a user worker, and block any signal that isn't
-		 * fatal or STOP
-		 */
+		/* A user worker takes only the signals nobody can block. */
 		p->flags |= PF_USER_WORKER;
-		siginitsetinv(&p->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
+		siginitsetinv(&p->blocked, SIG_KERNEL_ONLY_MASK);
 	}
 	if (args->io_thread)
 		p->flags |= PF_IO_WORKER;

-- 
2.53.0

