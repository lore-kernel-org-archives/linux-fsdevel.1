Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301F1E1A17;
	Sat, 19 Sep 2026 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776874; cv=none; b=jwPtXbs3wkzFLBkrwMWG0FzjCkIfLbOpVNYIonuwOKGFp/zWd3/Yg1EfHPv+QLYUPhkuPvEzQrVVBQzlZ0M7s2Cy7m5zN2n1VnNUCZEJWJqzCAa/lKEHp4t0wDApl57lOckfUx8nQsktpANgEEbnj2sLqP9FLQ6qf3gxhMaM9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776874; c=relaxed/simple;
	bh=i0nr8VXYIYPAOl4NJESfeTdQfHgyPx3QUDhAr9siOBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUqkAKHqQdRGLNikFoUeFrnK8aGnpi5J7tx4aUKPHVHpy8duEHDGTDN1TUtbWFlC7zy3Aln8lAye+LkQpT4KKYTadpyPi0uSB6ane5ulY7gvlQsiIK9PH4ioe20uVD1c7dVVKU27efC2vkWM1LW7nV26ww02WE0V8wVWxmyEqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dADBfN+t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dADBfN+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7F61F008A6;
	Sat, 19 Sep 2026 00:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776871;
	bh=CzjdvS6NjJxJ/lht751zg/tEjCectpDU/lK6Y1KdC8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dADBfN+t5ZM0E0ErcjD1Mqv4YsV8BRdtzS6vbpOFtX3ynVQ6kisv7P8CT8u2xURvz
	 WHDORn0BF9TnA06/QbTosWl1YzRNV1tUd2Jq9lM8zByzlX4bSAgFRHtlzqyjIocSK0
	 6EAE9YOpl5ozUvEriXnKYuCrfv/yIT5DZB8AwcX2w/ELTEKDz6RCtbVoskPQtsrcxT
	 g/GiIIe0Fy9iDGBbWfywoNyw7c3t33ejFsCFFSD7vKgHARnHeRGEKYRRMNlBa6q4JL
	 YEF4+VlsuCN2/qd9+S93MFd+H0v9HEPAmPFno9MBpRpsuuO0POpo1vxyEG/pYQRFDo
	 1jOagffte5wZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E6368CE189E; Fri, 18 Sep 2026 17:14:30 -0700 (PDT)
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
Subject: [PATCH 10/12] hrtimer: Update hrtimer_resolution only if value changes
Date: Fri, 18 Sep 2026 17:14:26 -0700
Message-Id: <20260919001428.3133388-10-paulmck@kernel.org>
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

Currently, the hrtimer_switch_to_hres() function unconditionally updates
hrtimer_resolution to HIGH_RES_NSEC.  This causes KCSAN false positives
in kernels built with CONFIG_KCSAN_STRICT=y.  It also causes unnecessary
cache-line traffic on the many code paths that load hrtimer_resolution,
which is especially regrettable because the value of hrtimer_resolution
normally changes only once during the lifetime of a given kernel.

Therefore, update the value of hrtimer_resolution to HIGH_RES_NSEC only
if it does not already have that value.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
---
 kernel/time/hrtimer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 53c57d585696..91ac2b517637 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -780,7 +780,8 @@ static void hrtimer_switch_to_hres(void)
 		return;
 	}
 	base->hres_active = true;
-	hrtimer_resolution = HIGH_RES_NSEC;
+	if (hrtimer_resolution != HIGH_RES_NSEC)
+		hrtimer_resolution = HIGH_RES_NSEC;
 
 	tick_setup_sched_timer(true);
 	/* "Retrigger" the interrupt to get things going */
-- 
2.40.1

