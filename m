Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAE26B971;
	Fri, 31 Jul 2026 00:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458422; cv=none; b=StfKtQCmnuGmwKWR2gi2oIgFL9adRgcYFSt394kp7chBYI1G+pyaUndtp16uhkW3k03wsZHZm2XEp1G8gTBFqO8XN2hXpxl4ZQ75Q8D6LjWP3N7QkG0bu7T4mU8xDRjdw64xFQWXUESO3Rr9Bq3AFJu9o8HtXq01NeIK1DRVThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458422; c=relaxed/simple;
	bh=kHX9+U8t/ykCNbGPMfwaiBMVcqXpgFJu/LBF2GTv4tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkV+rd+9jUF59n19NOOOhoRwKQ7v7+yhxVzYF35S82GB/mNetmg/XDRsstNne4BVzMVRVMoWB19rz6/gEeCkkLhedAOwdWK4h5y+DlW5ecP5uLKCWFGQ17l9VH6Ob1pdfA3mP9IuXW20+mIiYHkfhgbB/xAAXFzRvm00fjCToZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWxfHI0k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWxfHI0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7896E1F00A3F;
	Fri, 31 Jul 2026 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785458421;
	bh=dMS0yG/5wL8jEa9Ei9W2Qc2CkaGtJ9b38A4PnF/469k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dWxfHI0kcR5kGQW90cBi5rpI4z1nChF7sOTdaNzZtG18RUzD+iCduQpPwQsnKtQoD
	 2f+cgt7EymZJAv4+xj6FsQV84ddr68sLFqMqWb8MaKUJi++1X8bJTzTFPHl+f8gHOF
	 x6tT32ELVOkqV7f+WMKUrukqRTyv4hlMWwk960iP+t4JrL2gzowZSPG5wqmHJFwnUV
	 NASWGIMxLbsQvTm1iDeqaFlHMd0VZypS6LM1ejgggwZi3cpZWcVHEKm+U/Ty2774/Q
	 v3/Xzqf+5kOu0tfXIJkFmjzGHwmseZRmjKhQNxJSla8br6hZVFz3hUV73jfEhmelOC
	 2HDtvOY7mEj3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 383ACCE0F6A; Thu, 30 Jul 2026 17:40:21 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 2/9] aio: Use accessor for hrtimer_sleeper ->task field
Date: Thu, 30 Jul 2026 17:40:12 -0700
Message-Id: <20260731004019.3530210-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e76a426b-f65c-4357-b263-96506d877136@paulmck-laptop>
References: <e76a426b-f65c-4357-b263-96506d877136@paulmck-laptop>
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
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: <linux-aio@kvack.org>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/aio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index f57fa21a250353..e8cd65fce41eba 100644
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

