Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE51A6820;
	Sat, 19 Sep 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776873; cv=none; b=ozu8X3i0N1QDhUiJglovgraWsCP90/uVasY4/j6Q9YB0Xxlb6hpeTi6Iow0bpJsFplfIWKQmCwr8EtnPtylZRY2SD3tMV3csvaOJKT+sx1mOwLEZ8SeXG38bL/h5CaVReR1tCpVvtFvOs8qpG2BCrBekX8TuGZPTPCL/qh0uvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776873; c=relaxed/simple;
	bh=fr7VPXtKblPhkPqqP5ucNKM/5+paNqhvrB9Sk9BtLp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aZr7yyzRKkDAOzb+o1hW24CpNFr8qhqmkzfVhDZn4yHObWG63HDc6084MGGDHA5K6uTDZE+rxTBCvtptiI9GlDJZ2PS+kjgTEP7FxlKp+uX9SO+KXI5NrM6UihmZuwLaH9Qizt0uOZ+QhY6XdYGONgjU1MTOFjbjGJGrqX2fpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8AK6HPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8AK6HPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDC51F008BC;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=h5NxlKx0hY7bVJxUx2DOkeDYxRslcd+bfH1GUZvOswU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D8AK6HPRzdxPRb7PEb5uX9ohbnvQL2nzxUmeWfJz3++eiefsH7FxUPv4YvAucIdsJ
	 6vMyiFkfPY2+mRzQGmjGRCXZjRZbEwD3NXFl2ZWI1rtVtt5IpAqvolG0eCqCzyLx1V
	 0rT73HNzRzhYdwZ39ExbOoskQW+bJ6R6zDZihb5Px11p7URAHKq9RqhQwa9b6GjAxf
	 S7TtoYYoKwEqXymTDYqNr0fIMgxFYk8rqNWdU1E/4+9P1p5sraNRn4kVcjpSBWwzab
	 IRvWR8iz5qzy7ZoS0BBWvCwcraT0QDTcYLSrtMuIhrcgcfAgoiTSiEB14mwIlWxRmY
	 /NXN4rVgQyXFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D9E6ECE1854; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 06/12] timers: Use accessor for hrtimer_sleeper ->task field in sleep_timeout.c
Date: Fri, 18 Sep 2026 17:14:22 -0700
Message-Id: <20260919001428.3133388-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <5dca353c-6b3f-4d01-8808-bef2c0dd7af7@paulmck-laptop>
References: <5dca353c-6b3f-4d01-8808-bef2c0dd7af7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hrtimer_sleeper structure's ->task field is used as a flag to indicate
that the associated hrtimer has expired.  This means that the hrtimer
handler can be storing to this field while other code is loading from it
to check for expiry.  Note that additional races appear for hrtimers that
can be restarted, which could be argued to be a user error.  However, that
is no reason to let the compiler introduce additional confusion, and to
this end, the hrtimer_sleeper_task_get() was introduced, use of which also
has the benefit of avoiding open-code access to hrtimer_sleeper innards.

Therefore, apply this accessor to schedule_hrtimeout_range_clock().

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <linux-aio@kvack.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <io-uring@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 kernel/time/sleep_timeout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sleep_timeout.c b/kernel/time/sleep_timeout.c
index 3c90574bd904..ad8c415851ae 100644
--- a/kernel/time/sleep_timeout.c
+++ b/kernel/time/sleep_timeout.c
@@ -212,7 +212,7 @@ int __sched schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 	hrtimer_set_expires_range_ns(&t.timer, *expires, delta);
 	hrtimer_sleeper_start_expires(&t, mode);
 
-	if (likely(t.task))
+	if (likely(hrtimer_sleeper_task_get(&t)))
 		schedule();
 
 	hrtimer_cancel(&t.timer);
@@ -220,7 +220,7 @@ int __sched schedule_hrtimeout_range_clock(ktime_t *expires, u64 delta,
 
 	__set_current_state(TASK_RUNNING);
 
-	return !t.task ? 0 : -EINTR;
+	return !hrtimer_sleeper_task_get(&t) ? 0 : -EINTR;
 }
 EXPORT_SYMBOL_GPL(schedule_hrtimeout_range_clock);
 
-- 
2.40.1

