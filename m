Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AF2F8EA3;
	Sat,  1 Aug 2026 08:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572715; cv=none; b=dJtLqVa8xPyQr0JmpVp8nDr4AxhzJHshfobTTcUo5upwvgrdiW51IcmxOyv+iDTome+RPndY2thjSZCbvVOdi6Z3eFiuoyA3aEf0HyuJlc9dsU+CqX/abD/JodgNMVVN6BA2hSHCH4QCpav2bzuqrbvBF1nz1Jfa/+SKGYHq79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572715; c=relaxed/simple;
	bh=lz9Ho6okZWOEmxRQzjUhx1mfI22Qp6ewzjWUJFGvMYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=epmgvYhXgmN9bHp8BxuAleahtLzoWvcsGXtTnDtjq7pFYw8ueULeCBqDJ8l6vJK/EH/BX/YletfYLl4aZt9r5kN+ChfI2b2SIrS7m3OWOJFomfcJwUQqUDW95BXB/AZHb5Ug4HA39WtN399MdujqvrJDQ1hkaHWVWF+AyUHqqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RfTPmLUz; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RfTPmLUz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785572703; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=9sVKjLaMREosVvwvxLma6bySI0Syx+uyoFBM4/n36f4=;
	b=RfTPmLUzLNb8CnRlmgvjtPsgXqZ6My9Oq6ZKFceaPZoHVQtuAV8AZhh86rDX8+VoAu9A2+Nmzc0pjE7iVrslTMrD7rHqMoIw+U4Y6Ei0W+bfZIWsk3UPLXlGXoldU6HLKhuEIAxxSCVcUjjUHogjt2ErPPkcc82S3SqKVz/KaM4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X89uYvc_1785572691;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X89uYvc_1785572691 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Aug 2026 16:25:03 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: fuse-devel@lists.linux.dev
Cc: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH] fuse: wake one waiter per freed slot when raising max_background
Date: Sat,  1 Aug 2026 16:24:51 +0800
Message-ID: <20260801082451.2770813-1-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fuse_get_req() parks background allocations on fch->blocked_waitq via
wait_event_state_exclusive(), so each wakeup releases exactly one
waiter.  fuse_chan_max_background_set() clears fch->blocked when the
new limit exceeds num_background, but the accompanying wake_up()
releases a single waiter regardless of how many slots just became
available.  Raising max_background from 10 to 100 therefore admits one
request instead of ninety.

The remaining waiters are not permanently stranded — the "else if
(!fch->blocked)" branch in fuse_request_end() wakes one more per
completion — but that only helps while requests keep completing.
Consider a fixed pool of threads doing readahead or async direct I/O
with the quota exhausted: every thread is either in flight or parked,
and each completion wakes one waiter while freeing one slot, a net
change of zero.  num_background oscillates around the old limit and
the added quota is never taken up.

Waking one waiter per freed slot also preserves submission order:
once fch->blocked is clear, new callers of fuse_get_req() skip the
waitqueue entirely, overtaking waiters that parked before the limit
was raised.

Use wake_up_nr() with the number of slots that just became available.
Since the wakeup is guarded by !fch->blocked, num_background is
strictly below max_background, so the count is at least 1 and never
degenerates into wake_up_all().

Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/fuse/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..2f1ce77357c5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -397,7 +397,8 @@ void fuse_chan_max_background_set(struct fuse_chan *fch, unsigned int val)
 	fch->max_background = val;
 	fch->blocked = fch->num_background >= fch->max_background;
 	if (!fch->blocked)
-		wake_up(&fch->blocked_waitq);
+		wake_up_nr(&fch->blocked_waitq,
+			   fch->max_background - fch->num_background);
 	spin_unlock(&fch->bg_lock);
 }
 
-- 
2.43.7

