Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379608;
	b=mZ8mV1Puh3Hl1SbJf3kMU4Rkkex4VPOZxPyNuWLkHIbHwfsoQvqbUdy96xmyj8Q2uXwg
	 HME0nrWdL5ALyZfeNwjsi0zOe25BDs7R8ZWNGBBtRQ9pmLD8jNIXlKSWgwY3XjTLnI51t
	 /8W4Oa0ivO1rTrPZb/RaPpx6UN1ISo0R8NRJimqUpRiXfglv/pjzCM/nac7s504VXI6j3
	 feS2DK71VQ/iHO0eLmGjaL4G9ykfftjKWdDyrYmAst+JPv7oxPJTX0a/4cKESuUM+Quko
	 k5YgkM9YATqBxOWQxIRTSunaZh63SXFVOPfrirEPWmu8yIhzJDPsunDj2rcUyjcVabw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379608;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1zOfDWlY9E9tUb8YUI6fsfw2lGwWkARTEb35JoGHspk=;
	b=UuUhufrxL/W0225sBvlJ49tYb/1HZiK+0/zB0TULd0n2c3fNYreL7c6ILmXmWQjtUf2D
	 a4Z8nMsb0WGs0dUUiO8tfhFqiRX2c4XMbOsa+Lr+bPY7k6pKv7YJ0YzEoEOHrPVE5lGIh
	 gafBnAzniUsVfmbiB4n1E2oUNPgP7WB+ISO4pu+w8BtajG9YjTBpVkz0mgrkfdHzbIKho
	 8u2rtLaVyHY5EfmN5cVIp5HHQNKXHI+2UJ0mNIrIRKjqHDP470d3Ptj0apzKZMT70PcKO
	 OUTQzaZ3K/8dv2i1yIwxe25Q0SyHGyTk64ovUKH0moQR7pULLcgqs5F2plMOPIeeQUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XSCYPU7A;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EAB606A31C;
	Wed, 11 Nov 2026 06:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16EAB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=XSCYPU7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=XSCYPU7AeqaH6GEWuQCl0edE9BZx3+FzR9VaN1wQJKGTMuVUMmho+zW1/2g5sfYlh4MA1Kjb1jD9v
	 Xu8SRnmZsQfxOrG0q0Tl5I/XkxYIrzPVs1hhlBWZ157AxR3Q5pTel8AJ7LGDw4drLs6uMWN9o6+Xh3
	 myuDw044Vlkn/pik=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af40f54178-a1da0;
	Wed, 11 Nov 2026 14:46:44 +0800 (CST)
X-RM-TRANSID:2ee66af40f54178-a1da0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af40f51e23-d1f1d;
	Wed, 11 Nov 2026 14:46:44 +0800 (CST)
X-RM-TRANSID:2ee16af40f51e23-d1f1d
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jack@suse.cz
Cc: willy@infradead.org,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+c4e217748763d41236ee@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] writeback: mark concurrent accesses to the aging period time
Date: Wed, 11 Nov 2026 14:46:42 +0800
Message-ID: <20261111064642.17114-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writeback completion and the aging timer access dom->period_time without
a common lock. Concurrent restarts are deliberately allowed, since an
approximate aging deadline is sufficient, but the plain reads and writes
cause KCSAN reports.

Use READ_ONCE() and WRITE_ONCE() for the shared deadline. Keep a local
copy when calculating and scheduling a deadline so that each calculation
uses one snapshot.

Fixes: eb608e3a344b ("block: Convert BDI proportion calculations to flexible proportions")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 mm/page-writeback.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0694ec4098f6..fd75f46f744a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -550,18 +550,21 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
 				   struct fprop_local_percpu *completions,
 				   unsigned int max_prop_frac, long nr)
 {
+	unsigned long period_time;
+
 	__fprop_add_percpu_max(&dom->completions, completions,
 			       max_prop_frac, nr);
 	/* First event after period switching was turned off? */
-	if (unlikely(!dom->period_time)) {
+	if (unlikely(!READ_ONCE(dom->period_time))) {
 		/*
 		 * We can race with other wb_domain_writeout_add calls here but
 		 * it does not cause any harm since the resulting time when
 		 * timer will fire and what is in writeout_period_time will be
 		 * roughly the same.
 		 */
-		dom->period_time = wp_next_time(jiffies);
-		mod_timer(&dom->period_timer, dom->period_time);
+		period_time = wp_next_time(jiffies);
+		WRITE_ONCE(dom->period_time, period_time);
+		mod_timer(&dom->period_timer, period_time);
 	}
 }
 
@@ -590,19 +593,21 @@ static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
 static void writeout_period(struct timer_list *t)
 {
 	struct wb_domain *dom = timer_container_of(dom, t, period_timer);
-	int miss_periods = (jiffies - dom->period_time) /
+	unsigned long period_time = READ_ONCE(dom->period_time);
+	int miss_periods = (jiffies - period_time) /
 						 VM_COMPLETIONS_PERIOD_LEN;
 
 	if (fprop_new_period(&dom->completions, miss_periods + 1)) {
-		dom->period_time = wp_next_time(dom->period_time +
+		period_time = wp_next_time(period_time +
 				miss_periods * VM_COMPLETIONS_PERIOD_LEN);
-		mod_timer(&dom->period_timer, dom->period_time);
+		WRITE_ONCE(dom->period_time, period_time);
+		mod_timer(&dom->period_timer, period_time);
 	} else {
 		/*
 		 * Aging has zeroed all fractions. Stop wasting CPU on period
 		 * updates.
 		 */
-		dom->period_time = 0;
+		WRITE_ONCE(dom->period_time, 0);
 	}
 }
 
-- 
2.51.0


