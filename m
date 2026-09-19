Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5117D13D891;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776872; cv=none; b=d4J289mqtjBU20Z4TgdlFMcWnQ0ga7kA0ObUVsTOQ5wvvVoEVH/t/xNKaJ4Aw/oYm0X21WYsHiixKh0mX6u2yaL9vbQBKKi3HPE5HJJYapKKqiOaV5EX8byS8GZDFGFU38z1ASIK3IPdKPNGRQ4sU9YBa3Pa4D7Gd7+TZOspLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776872; c=relaxed/simple;
	bh=/t3p1MK2MQCYAfYT4vQ6UOuagLKqaozUfy/bsZc2/ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rNkg1uPibo6duwyYo45bu06qf5j9co7tNBzTYlI4MK1eeSj+pmpe6vlL80W8E+aB3AH4tRq0MglF7vCC5WunG4XSkAsh6NcWj5eOZ1qP7yivtCcn7X2RE9cGSxvszt8XwJbfayGBIIQXo+p0iUzL148LCjDci6jtGlLE/SSzQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW1Q+ye9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW1Q+ye9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA361F00899;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=wGeXmGSU0hQFjCRhnOoobLOSq8+j0qaPj9BL2WAHKUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UW1Q+ye9Z84bwOQHXz39fQegOb+4TNv/11c/6UuUtyKNil05sL/Tw31oPb4eMTKEW
	 PPt9sNMy3Xsik/0p7zoHoXEQf8l+m0D7glOQBesQTvywKQRYSjrxK1eJH7xQWn4tFy
	 86ru/tik9cvRPWYHdUk7AVZohq0MXwM2uziXHk1gqVp2HQTOF7vYpCF6PLonHupRN3
	 gtJS5DVAUQ2+3yMuM/np153WxaSrbRSZPsStwxD+I/li6I+DBeK1w39D4fkTb14tUI
	 Zs/0iHyJQf38JfVHpKJckfjqLw3H3aJ0QmOYzK6k/jF/sKRNHu59GlYLXrWMU7XXRD
	 sQhtpkz2sZPSQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D09AECE17BD; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [PATCH 03/12] wait: Use accessor for hrtimer_sleeper ->task field
Date: Fri, 18 Sep 2026 17:14:19 -0700
Message-Id: <20260919001428.3133388-3-paulmck@kernel.org>
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

Therefore, apply this accessor to the __wait_event_hrtimeout() macro.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <linux-aio@kvack.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <io-uring@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 7e215330199c..c2af98b0074d 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -556,7 +556,7 @@ do {										\
 	}									\
 										\
 	__ret = ___wait_event(wq_head, condition, state, 0, 0,			\
-		if (!__t.task) {						\
+		if (!hrtimer_sleeper_task_get(&__t)) {				\
 			__ret = -ETIME;						\
 			break;							\
 		}								\
-- 
2.40.1

