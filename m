Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C199E1DED4C;
	Sat, 19 Sep 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776875; cv=none; b=mnjgzHBFRfOSSAB9RIZgU30MDPihA/iU0PJXqIONNY4heeh+EP+ruB4S68ylnk0COOJoGYijwHvZnNQ2ivYnT/cnA+bX4Qpai5s8fjzyDjfbWtiiTmI89ZMElI/HEMXUEJMALtyJsYzEnovOkSlTZjEy4eTu0lxvLV1Sp93ejMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776875; c=relaxed/simple;
	bh=wnats47a8dlC3/kZR77h9igyVXeB17sJZBL3+Qrut4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9jiBNi2588vZX7SM+EKV5VaJnTMB4syG/ks/ahMb9NnnFlyXIEFjL6aYvAEJ5J467ITZLIHbhi4iO9Uf3fQ43bcT/+4NzVqeqxAKvlfB4jctRlKfhLQnO4H7L7P78KD2rzJMEdI8/JJ5/J3J842SqICkz4QezZYebvqasMDRgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnhC6gI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnhC6gI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600F01F008BD;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=mKV9pLHnzC0J7Uj9Om6nUdp9nPL2uRasj95mk5CGawc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bnhC6gI6gqbDmle2imfooqeOwTyQm4vBn+k3cR+EXa+DlLhI0ahAbgD2Jkv7rMTfa
	 ASvYoZ3pzagusocA8cOFOZ0VLXY7ETVVyTBQhEzpPAgDaqi9wLKCg0wslDwWPwcPOV
	 5mdpr12nH4KhS0D/A98pnRo48SbNPwgPnL7fvmLRoabrbucKV9PzWIH2Pj3etEXBo5
	 k5Ob+00MJtld5i1NY2DTu4w/oQ1v/PKP5pJooHDF/LUDglzJmir8CZGvXGYKb0xHea
	 +d/lW939e3iM+ngjBUQd5AZphzQYNkxci/nBbOIyirys4AdVHqDGRLsJItKj5+IMIm
	 Ixz0SlzEh6yKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E059CCE1886; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 08/12] rtmutex: Use accessor for hrtimer_sleeper ->task field
Date: Fri, 18 Sep 2026 17:14:24 -0700
Message-Id: <20260919001428.3133388-8-paulmck@kernel.org>
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

Therefore, apply this accessor to rt_mutex_slowlock_block().

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <linux-aio@kvack.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <io-uring@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 kernel/locking/rtmutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4728631ae719..5a9534c715b8 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1644,7 +1644,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
 			break;
 		}
 
-		if (timeout && !timeout->task) {
+		if (timeout && !hrtimer_sleeper_task_get(timeout)) {
 			ret = -ETIMEDOUT;
 			break;
 		}
-- 
2.40.1

