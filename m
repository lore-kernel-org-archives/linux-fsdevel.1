Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51073F0744
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147399; cv=none; b=NFppCfuTwshxUcDpDib0OPqz0ddt8ux5StggNyANgVtJJrZchI2QDTScLT79dgMyNj9dz6QIZwpNshmiSWWvI4XKkTRt18/XFcJJFdl5Iu0TEz2B3QdVY2EMkZhu8HFvge1hd948rYvI8PpDQG+xFoQ5gq54GGNM6AbLwQ+p2pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147399; c=relaxed/simple;
	bh=gqjdLe5bggbWi4ieVAisUMrocyXWJY6NNoHfdfNgdJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKhYjLMJ8Fx2Zhvt3yLCNX5WSmNyztAwI8N6E/qAes652SLTxqdwuXvXjPjJhwk6qLvSmEKxonA8n7YAZAgtcU0YadNd87xSL0Kbo0gy0rs5qenBTioglD8+sjUAzN5lr0HmAOdCKE4ifrjvrlnIQHLVzlls5aTtzW8hQmcsf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Re9okGzD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re9okGzD"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so500249a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147398; x=1775752198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTX25gE5DdkZZEwJxQB0wKR13LGTyXDupGcTwbkWt2E=;
        b=Re9okGzDA3F0QyBGW5CXNy1v6zPVJ/0gPQ0bEKTNWPk59jIcByMsXwp79VcvKu+9L4
         tK3bvPb/OGARNzmYKNqdAjFK+pDJPY/u5zy6SJNC7x3vvY45PROghjsvI20+TKo3p5Yr
         WsxrfZB/t7+3sY/3IJwoaOMEXISWtO7y76gaAGRoqT+XWLMWEKg97Yye5hyP6BP95Xl7
         VAxnBIGnVFoeNRLGMRpZv7JcBSwqZTDoiRSQDDtW5i6Nr78uDcDk5CKcn3wP83sJYIxM
         L8H87I3Rod+KKSHTMHv3Wg/xXfVoRYw6Z7GZiakcfnawGd77lF/qI/JTzhzFK2hMbQDs
         lsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147398; x=1775752198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTX25gE5DdkZZEwJxQB0wKR13LGTyXDupGcTwbkWt2E=;
        b=TCIqFEARDhLLOSStER0EPzNneZwLZICD/b281F7Ky9Z0EuymOjGGjm9O0f2NNPk52F
         GgDATdndNhJGsiBv3JUsEMzXZHcb9sCD/Ydi8kowpMFtlgpHDyjiPxwAzkVD9LgCpQIV
         khYpu1WdaVcfNrZtRcG+ENhLDQp/ivOYOHlxc/lPU7Wmy+t6w8852xlQ9HBNr0NO1cpM
         fNzF7yk30GApP5xVFVUUBq3ycZfafTlGfAhXM3Y5uLxgNbowblYDNfJZZrYtr9odfSyo
         3GdADNqP8lRuYUsDh2CeYnOCBxFI93OozqlKG6pZqjJGm6GTxS8unvimOuFaozCCMom5
         CQYg==
X-Forwarded-Encrypted: i=1; AJvYcCVRIPgouNPLBtPZvTsrQdjOEbUDuBxlTK6BKZ8Pu103X2RVcq6Uej/gDkv3BhRHNE+9hBhguOkVT9/I0ThF@vger.kernel.org
X-Gm-Message-State: AOJu0YxXWh3EBHjXftXYSeh2KUeylurP+J9nTXkIfrIThnj4ihOrcZGI
	PFhtsIvaNqh86eQCZccdsw2tLPvOkvBPi86kOTL3/IIOfrHF3SfIKA+YQiyhlQ==
X-Gm-Gg: ATEYQzxb+aN26GioyCi0E7nxsy9kKePP+FbJ7tH/cYFaQJjhiTkXPVViZTl/+ui1i44
	Vj+ZlU7UjEE/s41nMxUoqZi2P3S/fqrjgjdYcWZo9qtHmQAwEYehHOdenAy6mEvT9pqa6+2ajwR
	g+By7kLDMhn+GnaLDYLQfeCHzqk9LLAv3ajPKtU9ZH5Uddnv9Sb/uZM9chK3MVM1TA1ldw3l9dT
	kY+xjwM4bufb9gDcApXtN+2Ycd4TcFiHlzz/Km+8hKmJwfxdhVu/A1Lw1Ju2CIWFERic9Yaw4N+
	/VK1YuzOI1qqyfVlhBRfzabbFyKXl9nS/dDfaW7ffXCW3YPAlpeaWQ3TyL7Q6A6bm7T/SZ+Fj3p
	q6cUDZpZcTXxlE36zKovhaaIYjr3SJLGMv4r/aNtIem1rXPIvr7d6p6iveBcb8fRhP15swDRwCc
	YAAptvSLJFqwDVW4Vnmg==
X-Received: by 2002:a05:6a20:918e:b0:398:7973:277e with SMTP id adf61e73a8af0-39ef76be325mr8769781637.31.1775147397896;
        Thu, 02 Apr 2026 09:29:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:17::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3ccc8sm4713098b3a.19.2026.04.02.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:29:57 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 05/14] fuse: refactor setting up copy state for payload copying
Date: Thu,  2 Apr 2026 09:28:31 -0700
Message-ID: <20260402162840.2989717-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402162840.2989717-1-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper function setup_fuse_copy_state() to contain the logic
for setting up the copy state for payload copying.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index cca795dd72e1..045394a7ae41 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -639,6 +639,27 @@ static int copy_header_from_ring(struct fuse_ring_ent *ent,
 	return 0;
 }
 
+static int setup_fuse_copy_state(struct fuse_copy_state *cs,
+				 struct fuse_ring *ring, struct fuse_req *req,
+				 struct fuse_ring_ent *ent, int dir,
+				 struct iov_iter *iter)
+{
+	int err;
+
+	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
+	if (err) {
+		pr_info_ratelimited("fuse: Import of user buffer failed\n");
+		return err;
+	}
+
+	fuse_copy_init(cs, dir == ITER_DEST, iter);
+
+	cs->is_uring = true;
+	cs->req = req;
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -654,15 +675,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	if (err)
 		return err;
 
-	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
-			  &iter);
+	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_SOURCE, &iter);
 	if (err)
 		return err;
 
-	fuse_copy_init(&cs, false, &iter);
-	cs.is_uring = true;
-	cs.req = req;
-
 	err = fuse_copy_out_args(&cs, args, ring_in_out.payload_sz);
 	fuse_copy_finish(&cs);
 	return err;
@@ -685,15 +701,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		.commit_id = req->in.h.unique,
 	};
 
-	err = import_ubuf(ITER_DEST, ent->payload, ring->max_payload_sz, &iter);
-	if (err) {
-		pr_info_ratelimited("fuse: Import of user buffer failed\n");
+	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
+	if (err)
 		return err;
-	}
-
-	fuse_copy_init(&cs, true, &iter);
-	cs.is_uring = true;
-	cs.req = req;
 
 	if (num_args > 0) {
 		/*
-- 
2.52.0

