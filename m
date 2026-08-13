Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B63F37BE6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593580; cv=none; b=KdTkoZWnUIeMYavIpmh9cgDduNauxxvmkGUQnCie1XO75ekRE2L0HDiPlD6ozJBPc3HK+xPwux8AhrP2v328e9G8Wum21yW+isskkupz/vkqw32m3BL1t5sfv5iPcjPw1rHTGu9gKVj4qQ07Y9bfHAJbeVoHePX0R3EM300k9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593580; c=relaxed/simple;
	bh=nD6RhNxzKWTetqlzx61RBaqinCaMJA4+rhml6gRPCNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOX5DxQuSOc3BsRl6BVWCghHB5WG97rg6+wxDGWAC+U8dfyp7TmDE/0eipl4gQGvLLPIcr+V9NH4v0TlxkUXStBxlfSm1g7i6QD+siVZbYy3MM5lO43oqagKqQWMaReORiC6JEYhGaUtQET60HcmMtaHnHyfxjnCyiEzjHk5Xi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QU+8CZHe; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QU+8CZHe"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cbedb88aa34so280302a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786593578; x=1787198378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6FudjjefIGcYQYJoeZLUqTaC0084KO9kQWcwAp5c3ro=;
        b=QU+8CZHeKwQgXT0He+Jhc143VaS8WjnXYAGTJz9vPCWG6Ze0Llrj+vBPOAsxkzMzVm
         nD4KF5JcroriJew91KUFmuXeBHaOHU9ukJ49e32A1bo7mD2mYM1lra6uWdPZhpemmOFo
         cEWGoOHPhT0D6dcZB6HBXKzz4RBP/PoTOIK8ptAbDBgpp7L6sbNWmnDwZ4EHvVg7TkJJ
         WE8uk+Jrvq4nWkNzwnB3VXiAK1qlO8j4XrsqTaL6kqB2DneRTqifdkx7u8nIyjNnzke/
         MC477tZMlspywXesDXV69R9zBHlk4bSsDOJE6+p4/+jch1wrGQhn7mfKev3BXhhV0wA+
         7VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786593578; x=1787198378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FudjjefIGcYQYJoeZLUqTaC0084KO9kQWcwAp5c3ro=;
        b=ekyT1xYNxYja5tix5jI70VVdxiITfwf/lX327NY7Zykf7Fnstsun3V1YpdN7Fw4uaR
         CVtYTxkBtEoF6fTiduQg4cpSmYSsKAvQDU8zK6x1W6L2s6Gu2yjPR9QfIrzzh7PkdqV/
         IbW7kCMrORe0AlGShkEbC7unzOPbbNLGctNH3OkuHfgDcIZfnadl0X/NAdbNctpQ1Qg6
         QDTslx1/n0LjDuAIpPjt5qlUCeQ5nZ3DvQ5J8TGZmXbZzdAWwLfQUqbzhayyw15E6H/N
         N3AgQnKuvbN7rfR6MLu02Z43F53CRzxI6Xk1mz0ZhrPg/MN3xrdqTbxEN3zH22cugeZo
         l2dQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrPvlg37jhR4MsT7Taa37Iu8HBIQJGd0J9lH51AaY2TYDBnV+FiwpmQ0mGYcd8wLkLA2f8anDC84TIxAUk@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlqmiR+CQBV1fRK7oTVS4WM/zpvWasYz2DIQfZ3O77Cr7NNL3
	+zlVbxhc8zUH0gGMpXy3HUm981lmF5X6WMlXWksx6stXk2PD/hz9gYk=
X-Gm-Gg: AR+sD13z000McpUaPTGaeomn14aPYkf3wnlX28UuzubyAb4Vuna10FcNDxRx4Y15pZU
	YdIPTpUWw8JZGdWs5guwIk1DMhtLzbp6WAsstiGpTeRtszytELVdIl+mWZjjden++KgI3G3PnuU
	lFo96hF0taPXRQP3oelViQdmbeEdqFXvq7jIJGVMeAyllm5VnLVxEcmennm67Kbahkfn4xPCAW7
	1+QZoPZo4GjSHlU6lHBq1BOGDUBtmrQKseA3ewDO2AVnyMxL2RyGcapgzrHwXbRXHU9DvJPJPGg
	7ZncMdQPsLeQgYIKY+nRKY5+rBs7bNAQxKXZ2VIdRbSGzANkUt6JXEnSUHmaYTiNtxkPNZvOgua
	9uF/5odoin8U7Gw1FqzhqWcAtIjhtqSfEhO6ePEbfI1R9AokMC0OaPuTMZzg1090mtisfs0R0nx
	/jeUA+SGWReDlQN4hzo06UyzFI6bZvQ46YFEBPI+Vgq36b0KaW1XdVW9EzoIdlKBFrBhlscJIyD
	7xDJ3DYEkTFwaLmJ/RD
X-Received: by 2002:a05:6a21:62c7:b0:3c1:85d:fa2f with SMTP id adf61e73a8af0-3cc554d4f6dmr3963089637.36.1786593578062;
        Wed, 12 Aug 2026 20:59:38 -0700 (PDT)
Received: from localhost.localdomain ([165.1.213.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412d964443sm3619941c88.9.2026.08.12.20.59.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Aug 2026 20:59:37 -0700 (PDT)
From: Rochan Avlur <rochan.avlur@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	joannelkoong@gmail.com,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Rochan Avlur <rochan.avlur@gmail.com>,
	syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Subject: [PATCH] fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free
Date: Wed, 12 Aug 2026 20:58:36 -0700
Message-ID: <20260813035836.74045-1-rochan.avlur@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The abort_on_kill path in request_wait_answer() calls fuse_abort_conn()
and returns without waiting for FR_FINISHED.  If fuse_dev_do_write() is
concurrently processing the same request (FR_LOCKED set), the caller
frees req->args while it is still being accessed, causing a
use-after-free.

Fix this by jumping to the existing wait_event(FR_FINISHED) instead of
returning early.  The wait will not hang because fuse_abort_conn()
ensures all requests are ended.

Reported-by: syzbot+d6540a3fa1626e11360d@syzkaller.appspotmail.com
Fixes: 204aa22a686b ("fuse: abort on fatal signal during sync init")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Rochan Avlur <rochan.avlur@gmail.com>
---
Tested by injecting a msleep(100) between spin_unlock(&fpq->lock) and
the req->args->page_replace access in fuse_dev_do_write() to widen the
race window, then running a reproducer that concurrently writes the INIT
reply while SIGKILL is delivered to the mount process.  KASAN reliably
reports the slab-use-after-free without the fix, and the report is absent
with the fix applied.

 fs/fuse/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c105aaf9ff5d..b946884d4d5b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -572,7 +572,7 @@ static void request_wait_answer(struct fuse_req *req)
 
 		if (req->args->abort_on_kill) {
 			fuse_abort_conn(fc);
-			return;
+			goto wait_for_finish;
 		}
 
 		if (test_bit(FR_URING, &req->flags))
@@ -583,6 +583,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 	}
 
+wait_for_finish:
 	/*
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.
-- 
2.45.2

