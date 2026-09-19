Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261D1DF98F;
	Sat, 19 Sep 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776874; cv=none; b=l9t6XpfJlbgdmFZQw/XGhoZxNIBOpQ9NtCcpIcEslQ9kmuXL2zEXWmCgSwTqKJUPt5b8l3zwx8oHcSlWYXRJx3r/+1tPnY2Zoc5PsHojrKrfxmiQ4jj73YOOHue9d7rHuA9rlK64fzBiIwzYKUAUx6MJMjC1NVhbjARDiDu4kv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776874; c=relaxed/simple;
	bh=RbO9uhbiuw3i+ZeMoS+8CthIFuQZEpeZX4Ckt/wxulA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6GvyIruHkFMz4ndJmaDxt9sYB38xyNzHRxKYg6cxlN50CbmTZqeyLhOowvggRA0Vu9yQlYwOQyMMsMLH2GY7po8pFTTjhzWbq9GpZEhq4XzpEJuLsYsdnJ1/ZkubzgpBJUJu0tAGcrkFWpXRYMoVXeJHqfObaQHkhlRgjTz2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=il0TNv2a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="il0TNv2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6297B1F008BE;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=1/yYLfzzGqj+vj2r6yvnCpapDWeURXY4g2Iw57iAaAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=il0TNv2aItOSIEf3g1mVjMyI/wAysifH1Eaa/oYNAV3zsoEq4oFUAvvWRmQpkmj88
	 GzDn12HCD54ISv63964I1nGtxvtwI7SUGNSXarfFH/b50GeTsGii0fmp8qcBhjCtg+
	 A2yBxp98FhnufNQwLgGHXjmZY8IwXbhu7Egb3b/rLbPbY7arQErzvfPN/lflqgiAaC
	 1HU2UsaHPh5sYhpluhjfvX0mrqSnOeIQvDYBxWp+enkGzgGGsXdsvVGzSu25gSaX2Y
	 UcmN8cxNCHXLPdJB7ndMaJwVKQikWqdPfYFYUaYn1rI0EtVGN0nV3ecZBjrjcuzZps
	 mGflq2RkFNxWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E387DCE1887; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
Subject: [PATCH 09/12] futex: Use accessor for hrtimer_sleeper ->task field in requeue
Date: Fri, 18 Sep 2026 17:14:25 -0700
Message-Id: <20260919001428.3133388-9-paulmck@kernel.org>
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

Therefore, apply this accessor to handle_early_requeue_pi_wakeup().

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
 kernel/futex/requeue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 79823ad13683..196d6ff148a4 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -736,7 +736,7 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
 
 	/* Handle spurious wakeups gracefully */
 	ret = -EWOULDBLOCK;
-	if (timeout && !timeout->task)
+	if (timeout && !hrtimer_sleeper_task_get(timeout))
 		ret = -ETIMEDOUT;
 	else if (signal_pending(current))
 		ret = -ERESTARTNOINTR;
-- 
2.40.1

