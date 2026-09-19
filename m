Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55320E030;
	Sat, 19 Sep 2026 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776874; cv=none; b=ibAhwTDGn/JSC894fY303oYCXzZPmxRU2z1+kpM7pEAH9qBnVKJqad+l6Qgh2U7TtkOxOc2p2GodRsg3mcMX/n6y+LHdrhWuIY9Cg9WyghxHrAkUMZtkiQ4eBfNT4XiqXkjXPTdbGvawU3juNthZBabCbsEbYJz4BQt8zSx30sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776874; c=relaxed/simple;
	bh=+dnQpTLtpHqhNaZi5uBSY+mporH5T33ABZrLaclj2Ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YWpApEtGTsG5iWa52DVoJ/43OfA1Ja5zOJCm8Ea4sJBL5iEbCUvdETqwqg0YB+wM3UcaZWkM78+qQ0T0sKpjYz+mQmxGBTDOS9mtdH0xsUaPmVBFiMv8ZD+yzHdBtb+8LOewwn9tkJi86jXDsVY2G+2C/n4+IfiUQaMBREbnnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huTvj12f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huTvj12f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7490C1F0089E;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=OuaB2Tq3QiHGb8/pjqRWOXZL4NLdHWH45trdINi4nHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=huTvj12f9HYklR3lJ9udUJ/UzTAwKO5DBBSehTAXZoBlffSN94D2iA9kxmQ7HqSiS
	 sU9H8/9kH6AHzTeuCJv0DWrYXczgtexGMxK2OzGBDI7I/dzA0ugmrs1HkloVDAcshr
	 hZ36saBNErDvxbSo6KgOlPp/eWPwHHopOv9YY+PAaxd8skl8Nz/lefE+hXorCRk0Zy
	 7ehuZp/5s0Hy3zOLJLi8zXFte8epAURaV0vS2ZLB/ykH66o7Px07m5LTjfK9qU6UhI
	 PSah0grmM5N6crYAIWQrme7N26m8t7eV7TPqwNFs2TAHVKirY4ckS/WGkVV8pGmSQC
	 LqPiodMwXqOnw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EB812CE18B5; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
Subject: [PATCH 12/12] hrtimer: Apply READ_ONCE() to lockless base->running loads
Date: Fri, 18 Sep 2026 17:14:28 -0700
Message-Id: <20260919001428.3133388-12-paulmck@kernel.org>
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

Updates to base->running are protected by the hrtimer base lock, but some
loads are lockless.  Therefore, prevent compiler mischief by applying
READ_ONCE() to the lockless loads.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
---
 kernel/time/hrtimer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 91ac2b517637..b3b4776c17a1 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1997,7 +1997,7 @@ bool hrtimer_active(const struct hrtimer *timer)
 		base = READ_ONCE(timer->base);
 		seq = raw_read_seqcount_begin(&base->seq);
 
-		if (timer->is_queued || base->running == timer)
+		if (timer->is_queued || READ_ONCE(base->running) == timer)
 			return true;
 
 	} while (read_seqcount_retry(&base->seq, seq) || base != READ_ONCE(timer->base));
@@ -2034,7 +2034,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base, struct hrtimer_cloc
 	lockdep_assert_held(&cpu_base->lock);
 
 	debug_hrtimer_deactivate(timer);
-	base->running = timer;
+	WRITE_ONCE(base->running, timer);
 
 	/*
 	 * Separate the ->running assignment from the ->is_queued assignment.
@@ -2093,7 +2093,7 @@ static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base, struct hrtimer_cloc
 	raw_write_seqcount_barrier(&base->seq);
 
 	WARN_ON_ONCE(base->running != timer);
-	base->running = NULL;
+	WRITE_ONCE(base->running, NULL);
 }
 
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
-- 
2.40.1

