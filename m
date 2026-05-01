Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A8396B76
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633344; cv=none; b=lZ3AiVPfDORGxA2ELpBK3f7Tjxzun8RZL3dlTbVcz1n+85HaLFxKm87sf2qYGM7TCzKhligzwlwx8GeMhIUFTXinD+B6nlkQHESOPQGOM73ulaBFe6vMElL2AuX/Hi4OGGeAXJWzF+2kt5BXU5nKPNayoaCkQgJVYgyO2QyCxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633344; c=relaxed/simple;
	bh=6q7Cse9LTZEajpIegGdnRfkT5EI8IG2GJIGVRzPO0tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pJtThVzwTaF2ntlMhkTW7fND5MbVDoLI20n7CJZD7ZYne8Okp2NlxIurOypd2FFu0JcYSLV8SSTyKke3kX1TzuJNBjbds6d2dvNcUw0o9M1i3byfisAJIJe6R0mFPaqQPHdZb3JavgSckyOtQX4xeNhXzwSc9wEZMIxdVY9+MuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNjju8WS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNjju8WS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b0046078so15068705e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633339; x=1778238139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+eCDUN5/k1aTUcp0ocOWEOuyZhFTl6ujThN0C1b1A0=;
        b=BNjju8WS4lnA/Alb5bTNhxbGspl/940t68iZBlNDpyqPt1F5lQc04bfTvt0/2vAOWk
         nthzTPpNDR/H6bqdX7T3urcyO97P1LP/tl1+CC3aSZE9uRrdSIlombaPWPrPS5+q0Ixu
         XRDZGZyQ7e4zmZIRtTzOwUuoINLT0Ak0Y4Q8Sv2S9WY+O423cVQNOPxysCTxejUXIeB3
         iyMdwDG++oN0LGiBFq4nOZ8X1KC6jXFSkIEj0gLlHd/DT8gg/KE9TKcnTgssThmeyQYT
         u9t5X6r2Iosg0JsqNwMcy1zzPwTs6U4CD7S7KuNJu6DS/tk9gI9VrhH5AhJhvPqo7Zus
         GqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633339; x=1778238139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+eCDUN5/k1aTUcp0ocOWEOuyZhFTl6ujThN0C1b1A0=;
        b=rBl58hCUT4PcoweZJg+IBj9FEcEowOfgDZ9NxhUSY8ee3s+o7OWhCkArweL1IRSPtg
         XYt03WiFEWJ54C9NjQ9gG0j9inzdftQwtXmyD/jLs6LIVJvZmTz3XNEViHoIEyWl2OH6
         oBfAhHy1xLAi5knK6TxuLPMe0z3xeklF6C9wmEsx8IMtuzRQ8070gV8lintiAg5Gw8yQ
         Q8l0ZAkykdJV/+7+b67/ArsjQHS2lrqE+m8/daoA1D2U9XnH/zcpxutXhWswS3OhTetD
         U/WI9mhvl5SXUAz7PMeIhIbuBqXUlDT3y45uKQvC+E4AdRqk+tyyWLj7U//tx+cBmxPs
         liQg==
X-Gm-Message-State: AOJu0YxaY7CY0g+GQ6TuYFU2hL41eraCAA5S1eKM3DU8dhY2tMScB33T
	yH4Lxd2GeXXe1D5MPaIpJcp8L9JxGN9azVnW/kk6+RxqS57nHBsnTb8=
X-Gm-Gg: AeBDieuqz30Wyeme/n+rRmYh/4LiiOSrqtCmd/4cBJdbLLKwoCARZLRwW45JuRh/w0O
	VeAJGXRpUQuczjXxCTjxz5Xt4IpmoFoZ9R6WHF2Gmg4h8aKV2SdwsdtEI25Z247/gXefNi+QVJk
	ee749ISdqTbOj91C73sxZHs//YX1NKycqP2fdkAxgkgCXOacGo6IwqvV9SD2PgGDJSIUdlsald+
	qQekAaotj6U/H0TdLXgjuY31I6YpQOXOt1j43tkoKvbHXb6TmtIBRdyZt1IRR+ThWc7eJrYBatZ
	aavqqTG5QWrKbcEmG0JuuZR6AdUY9gxIsSeG1DpAwWcPj5thXhzCYfVQsEPBfucinYYLIbV6LNT
	11YuCmqjezohWAJeT7FH5bqvYtlLjucZu3CLuKKjzZHJgje1mGc3TjaBgn84SppYz/j9Xe9MRpv
	Jgu0Q=
X-Received: by 2002:a05:600c:a00a:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48a8eb73a3cmr38267405e9.11.1777633339156;
        Fri, 01 May 2026 04:02:19 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm121627405e9.4.2026.05.01.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:18 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com,
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Subject: [PATCH 1/3] hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
Date: Fri,  1 May 2026 11:02:15 +0000
Message-ID: <20260501110218.29906-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

check_and_correct_requested_length() compares (off + len) against
node_size using u32 arithmetic.  When the caller passes a large len
value (e.g. from an underflowed subtraction in hfs_brec_remove()),
off + len can wrap past 2^32 and produce a small result, causing the
bounds check to pass when it should fail.

For example, with off=14 and len=0xFFFFFFF2 (underflowed from
data_off - keyoffset - size in hfs_brec_remove), off + len wraps to 6,
which is less than a typical node_size of 512, so the check passes and
the subsequent memmove reads ~4GB past the node buffer.

Fix this by comparing len against (node_size - off) instead.  Since
is_bnode_offset_valid() already guarantees off < node_size before this
point, the subtraction cannot underflow.

Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6df204b70bf3261691c5
Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e76bf3d19b85350571ac
Tested-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c          | 2 +-
 fs/hfsplus/hfsplus_fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13d58c51fc46b..c00645a4a5733 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if (len > node_size - off) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3545b8dbf11c5..10b2dda3f8044 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -600,7 +600,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if (len > node_size - off) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
-- 
2.47.3

