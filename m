Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C63C0A19;
	Thu, 30 Jul 2026 07:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395484; cv=none; b=QYPtwFevO2EDGrdNHHzBlsFbEkbgxSvMFD61Q1cnD3NXSCIwTZOzXKvIpyuF3g/6hGMoadqH1Dve0hj3otzBdlC0QYDMUajvQbpZibZG3JYIOG6g5JsZfu/OBXbhZT5uDfyIqf+l3Udfya7J/xdEmbIsN80nQloCYMZ3eut39DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395484; c=relaxed/simple;
	bh=yCPOHY/vvSAxJRtv1aYikNb1kTMwfpT/EeOO4ceE/F0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bwg8hBbADrWfGzo3WOZgKDcOesSj0h3khVgBTGQTM9aX+qsxgoFjK+I9QjCDDe+w3wZQ03Q8SQdndYu9c+PPe+cl5ishDnF7yEjfCr/ShELZCy04LKVSCTHVdD2rIu2Nq2ho/wdr5znGd5AMEaCAB936sErgpLjWNV6W3mf5IJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=b7GUxvq1; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="b7GUxvq1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785395229;
	bh=yED5x+StDvo5MtSKW/Bqwz8oe1lWtnBHz+SwHYu+EOA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=b7GUxvq1dTMWrgAs2pVbIdv6AG3lcsJyIIYtJXvyuj2KVGXFSejMkUV3sEKHkkA8p
	 v5yzSPJlx22Zq8iLuPOg8PpQQv+XA1zMm3235O/EyXi2atr3WtAydZD2Ux4K7gAMgE
	 DQmKPfFSxm+BsbqeyWpEVnOMApGD1snj25H3B1Eo=
X-QQ-mid: zesmtpsz1t1785395211t55489eed
X-QQ-Originating-IP: ODrXFwRwwWjTY7u0Rlbn5yWC5z4eynCRkFeVnT2BqO0=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Jul 2026 15:06:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5139842376568403803
EX-QQ-RecipientCnt: 7
From: Yichong Chen <chenyichong@uniontech.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	repnop@google.com,
	mszeredi@redhat.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] fanotify: stop permission watchdog when timeout is zero
Date: Thu, 30 Jul 2026 15:06:48 +0800
Message-Id: <20260730070648.549458-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: M5Uz2rwrqRnRBM3phOxzkvzOHalYIQHGp/9Apwgu9QL87D9jtDJuFjif
	JrvA/yECw8qFdhbhXRESx5RqN7ohn28n4PfaQJrjEChokRkYTr7J2YKhqbgb2vQVjo29rcM
	Uuu6PSvnQh1I9KurQ6otl55KChRT2+gVZuENphmPAJFs5r9YbyP9MjNhazw2a3SO0OMyZNJ
	ibKkD+I3OofiN8MemB9PqFiUkB3uX8Jjghrf9OR8T9Men9/tb+YL9yqiQffKMIAWnaOzlJ8
	zW+JtyghCTT/McFy4hTux7q4wMmM29URDf1bsB/GczPVsnOQcp+eOfpJfSm4m5dwX13qbAd
	rrIwdBSUJPKsDH4PuVVaEFIlRbnkB1e9NW3HW4MnmA5stiI0jwz72kw6E8HYIVYWW9XaN3/
	NN0RSF/PzZ9q5XOMVkTSp2ydcOwJoroAAwJMlI76GEuv/Pn1e2/UpliDV8Qh4gKtu17xZZ7
	oSC86lp3yqjDVSuRf0IPNgkoPTP1PBNTFFeR3Xi2lAjw0XGbsYI9fsl7FB7T8TPbNcrDMOD
	7Ez3Wqcg6zwpvurgIC3nckv050/G5Bp6f3PNbLajRJwmXIzD1P4cdBPc5m2tr/yA/Hkr/Oe
	x59QY1+DJU7e1D42I/PDfYc+KZTkhK1WoNjFN/7SD2hc2O5m5PUzWhVS10LoA+LPsIsJ9q7
	NKo/D/32lgruOUqeHz5bvmsqoKKR/5ZvuINktjluupI/D1FwU1mNBJAEQwUQq0ij5wkK6dn
	Lspptot9z2e9PSMrfHpv/UnF1MnS19M/kZkDP3qj2dQ7zH2CII8QE1aoWKNWphxvNkRyT1E
	R2qKH3fw5r76wSOanc12l3hTF/uzEmUuXw+VfQ1pfkrWl8hK2+ehpXpsZ/gP+71B5+Nk3uF
	Buk2CeHzCT7VuqeE+PPMQLNDjfAfytv87N71oGMVVQ+w9ZDXX3cYDc9seWOVWySKEiQF46w
	LruIExMr1tFEZSixjNrTn0i1N8KtnZudvBR2/GxMg0WZ05HNikOWh5VHLJvb/Cs4xQOFxyA
	zN3eNiRskvL/XZqNMLuecjR8NF22c=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

The fanotify permission watchdog can be disabled by writing zero to
fs/fanotify/watchdog_timeout.  fanotify_perm_watchdog_group_add() already
checks for a zero timeout before scheduling the watchdog.

However, once the watchdog work has been scheduled, perm_group_watchdog()
unconditionally schedules itself again with the current timeout.  If the
sysctl is changed to zero while the work is active, secs_to_jiffies(0)
causes the work to be rescheduled immediately, resulting in a kworker
busy loop.

Read the timeout once in perm_group_watchdog_schedule() and do not
schedule the work when it is zero.  This lets a running watchdog stop
after the next execution when the sysctl is set to zero.

Fixes: b8cf8fda522d ("fanotify: add watchdog for permission events")
Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/notify/fanotify/fanotify_user.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index b604e3da58ad..9ee373ff5840 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -112,7 +112,12 @@ static DECLARE_DELAYED_WORK(perm_group_work, perm_group_watchdog);
 
 static void perm_group_watchdog_schedule(void)
 {
-	schedule_delayed_work(&perm_group_work, secs_to_jiffies(perm_group_timeout));
+	int timeout = READ_ONCE(perm_group_timeout);
+
+	if (!timeout)
+		return;
+
+	schedule_delayed_work(&perm_group_work, secs_to_jiffies(timeout));
 }
 
 static void perm_group_watchdog(struct work_struct *work)
-- 
2.51.0

