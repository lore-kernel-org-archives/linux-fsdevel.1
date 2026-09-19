Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28001DFDA1;
	Sat, 19 Sep 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776874; cv=none; b=ChffJSk2LkeGfMLnGhu44PT1y8ChmHhrvQOfIfps8XTXpthrcgPEybMycMZ7WU2Enda5VyVOhNZe7mZ0znKwhV31Ep15FpYX1sntOhFIoNMlDws6eBhgRGVhEm/vIsT555rFxdBaI9EIJ1I8ovFavVkmb5ZzC9sPjSfjAnkVcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776874; c=relaxed/simple;
	bh=rnI9TciP7/B57+GRRBpqXPGFNrL5fJtOX0IJAWDeejQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTpWUq1GO8s6HYdIhxrF48uUL8z63DnUKXbbezJTNcfuzcQe2AOs7hIxhtGrBItBuaUu34HxSLe8onKWeaUCYl7ufYg+d2Vv9CM9oWtgQuwHiOe7ry6hIHS8jEhJYneuQdRcIW/K+Hn0frbxT2vdEjwAm8kkN15gYpvMpuhWG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1D8klGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1D8klGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744631F0089A;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=UYF2NywdsrdvwbP9TbcpnWu/pPSRrQ4zYvUvhUYeBkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K1D8klGoQdJnC3cWnQQ4sVwDzu88S2cDly9gfuiegvX8SuEszsieM20HhJMSmsfeE
	 6IZczcg6T+uGEJ9M7Kt16rdFW4r2/uGt3rrDPyTBUIRvmZdVqtXBL/Vc/lIl7bMCq2
	 LPKCvcaJUXVqQFHBuZE40HaqujDPJebmD5+1ZAcQqI0vCzHJSX4AMqyttYQ+fTFv3V
	 yhCWTjAhWrXEMhegNW3367dWvBPwJj2BW7RV+1gAHLMJCa8f3JqRm9wzpMr6svYbuW
	 gBBRa8E6b77eIjJyi2DLM04MZvceBxX1js4X5g9V7tZEC/lq2Rngwn9Q9iqYCfVWp+
	 0bv5BteoHw92w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E8EA1CE18B4; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 11/12] hrtimer: Mark the hrtimer_sleeper structure's ->task field __private
Date: Fri, 18 Sep 2026 17:14:27 -0700
Message-Id: <20260919001428.3133388-11-paulmck@kernel.org>
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

The hrtimer_sleeper structure's ->task field is now used only by the
hrtimer_sleeper_task_get() and hrtimer_sleeper_task_set() functions,
and there is no reason for it to be directly accessed anywhere else.

Therefore, mark this field __private and use ACCESS_PRIVATE() in
hrtimer_sleeper_task_get() and hrtimer_sleeper_task_set().

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/hrtimer.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index d44549c0a2c1..cad8482337cb 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -72,7 +72,7 @@ enum hrtimer_mode {
  */
 struct hrtimer_sleeper {
 	struct hrtimer timer;
-	struct task_struct *task;
+	struct task_struct *__private task;
 };
 
 static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
@@ -322,11 +322,11 @@ extern int schedule_hrtimeout_range_clock(ktime_t *expires,
 extern int schedule_hrtimeout(ktime_t *expires, const enum hrtimer_mode mode);
 static inline struct task_struct *hrtimer_sleeper_task_get(struct hrtimer_sleeper *sl)
 {
-	return READ_ONCE(sl->task);
+	return READ_ONCE(ACCESS_PRIVATE(sl, task));
 }
 static inline void hrtimer_sleeper_task_set(struct hrtimer_sleeper *sl, struct task_struct *t)
 {
-	WRITE_ONCE(sl->task, t);
+	WRITE_ONCE(ACCESS_PRIVATE(sl, task), t);
 }
 
 /* Soft interrupt function to run the hrtimer queues: */
-- 
2.40.1

