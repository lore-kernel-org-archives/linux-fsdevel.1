Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5111D2C87F;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776872; cv=none; b=AQuVXkuSNeynq7FogjsipyYl+BMs6fpDk5Dt7kYFdRJB69rjqSVQlPRdsRhzntU+oYZgkUK3Y8PR4OL6447GTKtTSYGllqu3Qa9GHjA2HyO8GI/I8MINk6acVfyQphU0zOY5e2EaDbZ0VIUpk+bWmInzEJg7LM05WKv2THx8lM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776872; c=relaxed/simple;
	bh=FzNOe6FXEB9y8o+UdUONVt/z/IyaHCQhPSExC0na4Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUPfZPGiq5cpDDwTNa+ntLJPWyOelv+nto0Zb0FSfIFrCuUmte8NMal51yE0ztvq78sPSN+4yQnlDugRonYPsmpshVOH45NEfdKGg/UYF6/2wrnbAXUf7qbbEFivRKDhs/Xwbt+Fowwk10W4nZ+MuRd5h6FnQaAAxdJbi7PYaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DktDsY6g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DktDsY6g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063EC1F000FF;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=NpqRyqJwJUFnnDnjWdXkXDzaJ2TMRit9EaKVEA1xdIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DktDsY6g2shtpxvAQxnQDR7OE71ox1gebWniG4MwvT1xHe9dOFj1oNpAwcklX4V7J
	 C0QDKxSrNRyD3+7KYe/GZ0xKV2fGzauy3gDnaD0UVEURUpncRsxsXbvdZp/4UaLiIt
	 hkG7wfRmf4jNwox6Q+zNbIwCu3pJ9JIciK40K8byWyvoffbJEa/7ZzeOVtUIgXZ9rJ
	 4VWFInCAym3KUvajaS0Tf7jSdNgFrkWymJ6Lep9l6P0Jy0sCbzjvTMUP8jZqU+fq2u
	 z5ZgEti+hJxAeiPHPikIQ2ZLngEwhAIa6vZvVa4gpLgQv3FDah9Wertbxmebf6RsJv
	 sybRCKkvOfeoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C9A9FCE1775; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
Subject: [PATCH 01/12] hrtimer: Mark data-racy accesses to hrtimer_sleeper ->task field
Date: Fri, 18 Sep 2026 17:14:17 -0700
Message-Id: <20260919001428.3133388-1-paulmck@kernel.org>
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
can be restarted, which could be argued to be a user error.  However,
that is no reason to let the compiler introduce additional confusion.

Therefore, mark data-racy accesses to the hrtimer_sleeper ->task field
using READ_ONCE() (using a new hrtimer_sleeper_task_get() access function)
and WRITE_ONCE() (using a new hrtimer_sleeper_task_set() access function).

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
 include/linux/hrtimer.h |  8 ++++++++
 kernel/time/hrtimer.c   | 14 +++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 29072d89e5cb..d44549c0a2c1 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -320,6 +320,14 @@ extern int schedule_hrtimeout_range_clock(ktime_t *expires,
 					  const enum hrtimer_mode mode,
 					  clockid_t clock_id);
 extern int schedule_hrtimeout(ktime_t *expires, const enum hrtimer_mode mode);
+static inline struct task_struct *hrtimer_sleeper_task_get(struct hrtimer_sleeper *sl)
+{
+	return READ_ONCE(sl->task);
+}
+static inline void hrtimer_sleeper_task_set(struct hrtimer_sleeper *sl, struct task_struct *t)
+{
+	WRITE_ONCE(sl->task, t);
+}
 
 /* Soft interrupt function to run the hrtimer queues: */
 extern void hrtimer_run_queues(void);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 530d61257b9a..53c57d585696 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -2316,9 +2316,9 @@ void hrtimer_run_queues(void)
 static enum hrtimer_restart hrtimer_wakeup(struct hrtimer *timer)
 {
 	struct hrtimer_sleeper *t = container_of(timer, struct hrtimer_sleeper, timer);
-	struct task_struct *task = t->task;
+	struct task_struct *task = hrtimer_sleeper_task_get(t);
 
-	t->task = NULL;
+	hrtimer_sleeper_task_set(t, NULL);
 	if (task)
 		wake_up_process(task);
 
@@ -2347,7 +2347,7 @@ void hrtimer_sleeper_start_expires(struct hrtimer_sleeper *sl, enum hrtimer_mode
 
 	/* If already expired, clear the task pointer and set current state to running */
 	if (!hrtimer_start_expires_user(&sl->timer, mode)) {
-		sl->task = NULL;
+		hrtimer_sleeper_task_set(sl, NULL);
 		__set_current_state(TASK_RUNNING);
 	}
 }
@@ -2381,7 +2381,7 @@ static void __hrtimer_setup_sleeper(struct hrtimer_sleeper *sl, clockid_t clock_
 	}
 
 	__hrtimer_setup(&sl->timer, hrtimer_wakeup, clock_id, mode);
-	sl->task = current;
+	hrtimer_sleeper_task_set(sl, current);
 }
 
 /**
@@ -2425,17 +2425,17 @@ static int __sched do_nanosleep(struct hrtimer_sleeper *t, enum hrtimer_mode mod
 		set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
 		hrtimer_sleeper_start_expires(t, mode);
 
-		if (likely(t->task))
+		if (likely(hrtimer_sleeper_task_get(t)))
 			schedule();
 
 		hrtimer_cancel(&t->timer);
 		mode = HRTIMER_MODE_ABS;
 
-	} while (t->task && !signal_pending(current));
+	} while (hrtimer_sleeper_task_get(t) && !signal_pending(current));
 
 	__set_current_state(TASK_RUNNING);
 
-	if (!t->task)
+	if (!hrtimer_sleeper_task_get(t))
 		return 0;
 
 	restart = &current->restart_block;
-- 
2.40.1

