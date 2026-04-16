Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA43E47B;
	Thu, 16 Apr 2026 06:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776320523; cv=none; b=ec32DAPIyAisCNePoUJmkBYMGITvKT0LlBKLJVKbwPSeE9t/BuMLw/3vVlmG+W4qBAbLGys5WiKZVs8h+aXx9sT7AmNeYohXArbx0Lic/Qs033Zb3Euk2jgwBW6fCXdUmhOI8lB+OPSoLTgyKL2wSaWpOzQXk9Z5m5LpZBqQXHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776320523; c=relaxed/simple;
	bh=+9yQFf35/VRsf+cuF8haa3rFDjPv9xGg41zieJHa+QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQxO7KxSTwAAXmllbDuwDLZMz1wiN0vjPO0ewPHL4QPGEWvM9Yn1nCuDvrffLRDRIx3WobvpxWvuKRGQNXFDOVX8Weoz7bcdX0SYQhDBi5OSh+re/FczRO0xzAjyN6ORcMlClm8neLLuVJ2WmILO5+xbVWudaxSac3wS7nNnvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=baFUhw48; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="baFUhw48"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1776320500;
	bh=8ZMLyvbn2fgdu7Z3o9im5HijS6UBj0WeThNLqEENxqY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=baFUhw48e0rBNLcNuZzE2oJqdfiTRnzyVXRWhYOHypqjNld1xaGXArxQ16ggGrfqR
	 dQANQFYxrQGz+mIs9tK7EhAve012MszmPMoPSfHCM9J2lRSBsrEIBTi3YUsnk0bA0R
	 0YQbxkbekRSkRy9l/QN2zpUm7imRTNsMzF7CoGns=
X-QQ-mid: zesmtpip2t1776320494t052b9a3f
X-QQ-Originating-IP: 6etNeGWsyHbe+jnxF4LjP9VfIIR64ylKlNl0/hIl3c0=
Received: from uos-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 16 Apr 2026 14:21:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1443119381760885576
EX-QQ-RecipientCnt: 6
From: Morduan Zang <zhangdandan@uniontech.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a761f017e231803b82cd@syzkaller.appspotmail.com,
	zhanjun@uniontech.com,
	Morduan <zhangdandan@uniontech.com>
Subject: [linux-next] fuse: avoid double pqueue allocation in fuse_dev_alloc_install
Date: Thu, 16 Apr 2026 14:21:29 +0800
Message-ID: <033E3BB729B194C4+20260416062129.408277-1-zhangdandan@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MjSuC7PzPhnaS1Sb+o7nMfBk0rhb82pR03h9rBSbf7af4TRhGffljWfB
	EOguRz+brImxRg0xQ0lCplHoSYvRKkZuBKYgI3/uETWMWfOQRPYGPFIMUy4mNoUBiEtV+yZ
	RicSmiN1QKIogLY1lGO9nve/0XYNhdVLWhHxdfJ6YAod+vqIDEVVa+GsWuRUZPWp1eH8qhT
	Xd2YVIpSaXG9lzSYCu2qKDjt2CIyHwk9LPuhLdZuIEMzZJWeYWqXkwC3E6Gd1suxPKE6IY4
	YrqmNYUEVx2dh7MpxE9ImM+7T9oJbOOseqlyWN9h5RkYUlPZ9Hc18bZdQ3En570gAucRbQl
	1m+DoW46NEoUeQsQdK5qWRb7X6DUkBPLs+Y0xq3UpqIfU+e5P+K/H93ZXkcw4epMoxspwYP
	jONx73p+ZzPaeFSRVTGts8cXBSvB3lfOuKlDwoBlQr5aDZ5Bvnb8omDjQzFao8tCS85Oi7w
	ez3AEVz8nhKWDUSok6QHVlnRaRQOGmc2ndC4omTUMr+3Y7QLU+gNKLI5TGibQJsfNCC+N0q
	f6wC0qfCfj1+d0PWZ5kUOB9meJHFWdiArpRsxh8wycuqHxl9oxnFzArGyrhExQBEyFQjUdD
	QhxBaAZypQBEz4Zu6nwqGwAMEduNSXV0CXjfHGKdMIiNaC1Ae2blmrnrKb+5iSMVNxbDhkM
	hVFajAl2+kwy7j6wCHplAPtHYW02hErDBUNBp0E/m4sXOfCBWps2kJYqMvMDCXQjJZQQCQa
	+tgrdSa/u5ATDWS70sAK3/qNbo3uRrFX8NjdUSCiXoQVC7wppIoUbB0zfZvtD0YtvpjEhg1
	I3vXJ4L4gXs1EC35zCIns3yvLjjLXOX9G+fzld+5uzNxubdXeB4fGnhDWcvoO2fCQqdTw97
	K4i6F804b6xs7889vXqtWVCG0Won0spU28EWc3p1Dp1SYXQeMHXf5Xakf0ogF4YK2zt+fKD
	1UIh1ytXlM/Q2pvUxE1joVUTrvznbWjsPwJH/BA0qpzeGSavhJVHapFE1bZhRlB+J6SD6yf
	/WiYmBh0CbvJqp2zlYtDJg6+kRlbfCUq+NvjDSOW3MlTU5NkEH887S7yc8bsEdPFGDxslpC
	Q==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Morduan <zhangdandan@uniontech.com>

fuse_dev_chan_new() preallocates fch->pq_prealloc. After dca5bba8d17f,
fuse_dev_install() transfers that queue to fuse_dev_install_with_pq(),
which expects fud->pq.processing to still be NULL.

The CUSE open path still goes through fuse_dev_alloc_install(), which
unconditionally uses fuse_dev_alloc() and allocates fud->pq.processing a
second time.  Opening /dev/cuse then triggers
WARN_ON(fud->pq.processing) in fuse_dev_install_with_pq() and panics when
panic_on_warn=1.

If the channel already carries pq_prealloc, allocate the fuse_dev
without a processing queue and let fuse_dev_install() transfer ownership
of the preallocated queue.

Fixes: dca5bba8d17f ("fuse: alloc pqueue before installing fch in fuse_dev")
Reported-by: syzbot+a761f017e231803b82cd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a761f017e231803b82cd
Signed-off-by: Zhan Jun <zhanjun@uniontech.com>
---
 fs/fuse/dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 87c0a6e60440..6001163db34e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -501,7 +501,10 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_chan *fch)
 {
 	struct fuse_dev *fud;
 
-	fud = fuse_dev_alloc();
+	if (fch->pq_prealloc)
+		fud = fuse_dev_alloc_no_pq();
+	else
+		fud = fuse_dev_alloc();
 	if (!fud)
 		return NULL;
 
-- 
2.50.1

