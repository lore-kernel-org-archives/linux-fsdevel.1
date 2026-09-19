Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9029408;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776872; cv=none; b=ja8osaq8aZ5QWXJ6VZAo7cP2oLVMgDchJla6FRKLyJSh70EfHD0fUhW0wfqkmoyoDYZmTdIGE+LugvE+3ehWpEZlXCAko48ejk9F6R0hh9845MbZ88WTTyhFLjkuUWAmyOk4ptEmIqmYidoU6bLJqogSjUfDR5eGKZS9n/G0Mew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776872; c=relaxed/simple;
	bh=nt7/BSWdripBRTKDMq3InC764hYuSGBv4Yo8ir8jnhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f6zZvg0Bhqpa2Qnc75bn49A5BId0HzcJtIKDMTcinNdlBtu3oiR1rFTKR4S2f1KmMpg5cLAv6O37FVvs2+EH/FByFZRiynAetfl/AX7+F5iTi3haWlrrPebrjqhnnVetcFuZCCfpzDmlnJFzDSui3hAqSvSp2zj1MSm/GMNg3CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4MuIS11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4MuIS11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C4D1F00898;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=hoBSL3WNFBNf1nDaxXUlvtVGda29bsX4DWIaXzlgvEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k4MuIS11PSFCRtCdlz6pD2ba+SS23IAIAMtEbxYak1w/oNioutE9AcChRgZzWHOXB
	 Nt6s6sSs0bf0vLmml6AKofvEiD/J3mbMPoMHp9Y9GNMc2zSGxdKHxOFQo0/dgfcOiH
	 NOugpeTJjar4JQznB7NcScFPw32FooDV5LTo4XMXHMp7B0PvnaGB4cdoo7/RMCEkl+
	 hrk9E7MgqzrNFIAEyfsCimR+chnjdB9hg1yK9HzhmhQHBRZ8nMmXWbEKBKXvLj5g5+
	 XdvlMWy5iZhD6RDKGF+NifXQixTxsaRkniZO/GwoCGwBiHww+aJgpIiHwigMjKE4ew
	 KF/uRZm3CGF1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD1E1CE178A; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 02/12] aio: Use accessor for hrtimer_sleeper ->task field
Date: Fri, 18 Sep 2026 17:14:18 -0700
Message-Id: <20260919001428.3133388-2-paulmck@kernel.org>
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

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <linux-aio@kvack.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <io-uring@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index d78acc69f487..8130d9e637ea 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1402,7 +1402,7 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
 		w.min_nr = min_nr - ret;
 
 		ret2 = prepare_to_wait_event(&ctx->wait, &w.w, TASK_INTERRUPTIBLE);
-		if (!ret2 && !t.task)
+		if (!ret2 && !hrtimer_sleeper_task_get(&t))
 			ret2 = -ETIME;
 
 		if (aio_read_events(ctx, min_nr, nr, event, &ret) || ret2)
-- 
2.40.1

