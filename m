Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA961A3A80;
	Sat, 19 Sep 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776874; cv=none; b=LpjG7dpnAQyIyiZM3l3fVaRz7Qoj7RBSjHidwErcry67i4jjsAUDnJsfY40fdLyUcKunpJIXtyiY3K+2YDEPl5mgxa8WiDXVoLhsvSck8ZOPFUNyFoV/5kFKS1agXk4phKLiXh4D8aKY6X6U6qwNkXhWDAEIZhEDJ7LaEdbdTRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776874; c=relaxed/simple;
	bh=fxC1nyZn01EId/OqHZTU0Hv4ID9wGWmwsuIT9fhDHX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GDE5Ct2nRXWCmJRV18nwY1E0e8AzVJCjyROKtVFHNvBx3dMb1GyLbUaxfdl+lR68DnNIsy5SvB5ngrzHATuyfHup1z4Jmt/YV3Ua2ZJTY+yJLzpAtKC52EnPcDG6elPkgRRRDUBc2lQ1lotO13a4o7dAYgsrMPTPlFw/8F3C1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeIzmPj/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeIzmPj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D501F008A3;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=NTCQLayrSQzpVB0r4X9Jwtyc50fnjrA/EIJm2xS4qUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CeIzmPj/mEbPxmD5X8+r5sH1vR8VRzZrK6AJ5JIi6o0mvrtZEnRY+LYOm8PaFG/eQ
	 25T78E21ua0aEcza1YtcWuXKCRdH+spB0STrnvgpX6asV261QvWZYleOjz6LeE+bDO
	 EZ27FS4yr+gtM6l1oYW33kLsn04Crn8VleHprOwTuuACRMzCgEebAPEZb9W8pr5L3x
	 SiCHzYxgmOP80vnxsksxkzp6BAPgNPDCBuYgCSiiKthgZ4eoWpO2FET9irVPS+NQz3
	 wLi1sDPYvm7d/Uc57sVDM18o/ilbQh0ICOVxtjJQTeiesS56iqLSp+6mqz2Fx16NLH
	 LZxzbT7bfIT0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DCFBACE1855; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 07/12] net: pktgen: Use accessor for hrtimer_sleeper ->task field
Date: Fri, 18 Sep 2026 17:14:23 -0700
Message-Id: <20260919001428.3133388-7-paulmck@kernel.org>
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

Therefore, apply this accessor to the pktgen spin() function.

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <netdev@vger.kernel.org>
Cc: <linux-aio@kvack.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <io-uring@vger.kernel.org>
---
 net/core/pktgen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 7f81aed46672..784d8398fb7a 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -2346,11 +2346,11 @@ static void spin(struct pktgen_dev *pkt_dev, ktime_t spin_until)
 			set_current_state(TASK_INTERRUPTIBLE);
 			hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_ABS);
 
-			if (likely(t.task))
+			if (likely(hrtimer_sleeper_task_get(&t)))
 				schedule();
 
 			hrtimer_cancel(&t.timer);
-		} while (t.task && pkt_dev->running && !signal_pending(current));
+		} while (hrtimer_sleeper_task_get(&t) && pkt_dev->running && !signal_pending(current));
 		__set_current_state(TASK_RUNNING);
 		end_time = ktime_get();
 	}
-- 
2.40.1

