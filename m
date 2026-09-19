Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB21419A4;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776872; cv=none; b=BTgK0wFz8jWP///Z0jumr3Sg+RaT7lrdUdf4xRZtRfusgS46JLtaWBFRU36be2144phV/cStu0VfqbFx/INB+DNELx62SUJf+7cDkwmZkQGRDa6jsEiHfCkqoWKdLCq5pY/C3YaTOtIoko6sHsfXRnA2hbNqB3ImS32CcO1w6NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776872; c=relaxed/simple;
	bh=9oW+ILsQfNGwMx9MLR3WFtT2cu7h74dmOW3ViubBX8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZXkCzgx88w7XA6NN4UDiXpRoLfJMLzndqrLcwjKwDHTzgsH/ACMx2bjiXr579nzOI8x6zam2uT68xcZYej4pcPx/zA17WFSUm9qGZGe/hHULv82XN8bJN8ZxvQyHxjYG9/nOQuXfcblo1T/FTxPAxrGafwLc45ahxczyoQF+94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTEiZOCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTEiZOCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A511F008A1;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=PknkRwPvvBeYfYi2D4CKC2RzvbganFXZNEUr/0BCVBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lTEiZOCcTzHv8ebJLOHtNscylp9Yhyv0mygMl8+8izw1mX/kjjcNpYxN4owxGWWNp
	 GKPrg+VjBySRTyhUWvs4qzsKNPRnCrKqHBZXoFH2nTN+A84uuShWcOMsK1wZ4XbZSh
	 7jC4SfrWBmozp1J3ihqBzd5/0MathwiUva+qu1n7XPRQrbr5Kgeqo3RTX7hJC38DLJ
	 VtuV7xq+wUK9wIp2lsDa3dFsK1GkZihfHI/FYkSPzbbNaMiHMeLlzSW0JtE9iPV0XO
	 oFUOVVo/E1GMM7kt0rMjhpy+Gn+T9llBJE+2aZDW1/VTdicuzrssnrkrgNccLKqXHg
	 wqS482zhxGqhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6D58CE1853; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 05/12] futex: Use accessor for hrtimer_sleeper ->task field in waitwake.c
Date: Fri, 18 Sep 2026 17:14:21 -0700
Message-Id: <20260919001428.3133388-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <5dca353c-6b3f-4d01-8808-bef2c0dd7af7@paulmck-laptop>
References: <5dca353c-6b3f-4d01-8808-bef2c0dd7af7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The hrtimer_sleeper structure's ->task field is used as a flag to indicate
that the associated hrtimer has expired.  This means that the hrtimer
handler can be storing to this field while other code is loading from it
to check for expiry.  Note that additional races appear for hrtimers that
can be restarted, which could be argued to be a user error.  However, that
is no reason to let the compiler introduce additional confusion, and to
this end, the hrtimer_sleeper_task_get() was introduced, use of which also
has the benefit of avoiding open-code access to hrtimer_sleeper innards.

Therefore, apply this accessor to kernel/futex/waitwake.c.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: "André Almeida" <andrealmeid@igalia.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <linux-aio@kvack.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <io-uring@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 kernel/futex/waitwake.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index d4483d15d30a..cf18309e5770 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -383,7 +383,7 @@ void futex_do_wait(struct futex_q *q, struct hrtimer_sleeper *timeout)
 		 * flagged for rescheduling. Only call schedule if there
 		 * is no timeout, or if it has yet to expire.
 		 */
-		if (!timeout || timeout->task)
+		if (!timeout || hrtimer_sleeper_task_get(timeout))
 			schedule();
 	}
 	__set_current_state(TASK_RUNNING);
@@ -539,7 +539,7 @@ int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *woken)
 static void futex_sleep_multiple(struct futex_vector *vs, unsigned int count,
 				 struct hrtimer_sleeper *to)
 {
-	if (to && !to->task)
+	if (to && !hrtimer_sleeper_task_get(to))
 		return;
 
 	for (; count; count--, vs++) {
@@ -590,7 +590,7 @@ int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
 		if (ret >= 0)
 			return ret;
 
-		if (to && !to->task)
+		if (to && !hrtimer_sleeper_task_get(to))
 			return -ETIMEDOUT;
 		else if (signal_pending(current))
 			return -ERESTARTSYS;
@@ -725,7 +725,7 @@ int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 	if (!futex_unqueue(&q))
 		return 0;
 
-	if (to && !to->task)
+	if (to && !hrtimer_sleeper_task_get(to))
 		return -ETIMEDOUT;
 
 	/*
-- 
2.40.1

