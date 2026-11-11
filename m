Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386476;
	b=lEeLKhid6kTPLKbgHE3Y9aWeEwR88Kmi2CB2HnJLMwG9EdSsHIcC8xV0UxrDw09Ndu+X
	 OV1gwPAgdBozQrJEN0Ro4ZA0ZowUtjYj2Lkysn764bD/BFglK806iXQqt6Jrk1NW5ADU1
	 RWsfQqSqCPlc6YkvbjJEQEJ2ogsqp3zwc9MwvZz5YmBPZjuQqRCnXucD1DD776BQmDBcz
	 ypTU+5adT5DXONUpNUKAQhfUUdW4yLvJm7AeBa1dFmQWUXIsjQqhjGTp9rra8SoeAlwfe
	 daXLPWJq+5TiM0V27k4s+KrhppYCAt2+XlWmDaLwTdyEp+d8c0CDEdXnmD2eTH8MiOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386476;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=J5UV4bT2yRVrNKueqM3KP5TiKH0C0WlN+zlSkCoDuaQ=;
	b=dK30iwjvjxqjQMz1AP+bhRac8zGb7miTYMZ8l/n/g+dXyM6/OL96KCRncUEBpcghbBAW
	 zlMFtuQM+3c7NHGeiYJx7YQ7VzDg2hj9vCDtGqt3UxwNvXk6jKebszuG8JPXQDxXGowrR
	 ouaP/PCddFbWzKjQkH7CcFiWWRPDnd+8PyxUVl/+ec4XKoNHCEJ7vX4Ca6F7iMMvk4NNV
	 GFGwsgWgELrAyWEy8/b+ffCcQMAQkd/qyb7xaXIFSmfKkMdoC1rPZDd42dWX6mH3erYzM
	 Q9pwj9vmjJKhYSAoSwWWO+fJiIxj54u06DyGVgc5mq2+Gw+ITuOZoTl62ijJC5E17Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="C3qt/XCn";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06D5606A327;
	Wed, 11 Nov 2026 08:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B06D5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=C3qt/XCn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=C3qt/XCnxl+xNOTa/JbIB0y4dwOJszl+S9GMGfu33QZR6Oce9zv+8EOXqcvQJFEFT8/mo1aGX4uAg
	 zIfs9hrk1SmM+cOo4ZR34KXUMquhsHuacwIWrE6flG1uJrxkYjz2zGGsaoohwCPxXxU9Ksq167DkoG
	 m+MLrKSUNV3W9eNY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af42a29e9e-d44b6;
	Wed, 11 Nov 2026 16:41:14 +0800 (CST)
X-RM-TRANSID:2ee56af42a29e9e-d44b6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee16af42a29ae0-d5c34;
	Wed, 11 Nov 2026 16:41:14 +0800 (CST)
X-RM-TRANSID:2ee16af42a29ae0-d5c34
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jack@suse.cz
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7528a49543144ca596b7@syzkaller.appspotmail.com,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] buffer: Annotate the remote buffer LRU occupancy check
Date: Wed, 11 Nov 2026 16:41:12 +0800
Message-ID: <20261111084113.80884-1-zhujun2@cmss.chinamobile.com>
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

has_bh_in_lru() reads another CPU's buffer LRU while that CPU may install
or invalidate entries. The local BH LRU lock does not serialize this
remote occupancy check, which KCSAN reports as a data race.

The check only decides whether to send a drain IPI and never dereferences
the sampled pointer. Mark it as an intentional race and use READ_ONCE()
to keep the test to a single load.

Fixes: 42be35d0390b ("fs: only send IPI to invalidate LRU BH when needed")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 fs/buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 5d3852b726d6..1232f1c086ae 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1437,7 +1437,8 @@ bool has_bh_in_lru(int cpu, void *dummy)
 	int i;
 	
 	for (i = 0; i < BH_LRU_SIZE; i++) {
-		if (b->bhs[i])
+		/* Only test occupancy; the remote CPU owns the references. */
+		if (data_race(READ_ONCE(b->bhs[i])))
 			return true;
 	}
 
-- 
2.51.0



