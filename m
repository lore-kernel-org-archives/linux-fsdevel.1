Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0CB38C43C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392387; cv=none; b=iYkDQD+1hgmCtlez9XIYK7PZBUj+VL6PsCdvCkVnnFk37f6QrDf1vghyoSS6JwNtKufC6wWyhMYFmMrU2EsS8OjsplKdIlDUK4r+t4S871hS/0Il/V/HL/u4+jNBVw367BPtw+RifkZezVOXawZI/I4qo3F7TJxcNRnkubtlJF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392387; c=relaxed/simple;
	bh=MqXvlST8tA6PWevgg9+05teFyHJ5b4PPOudj/Mw2I6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoJ2jKDuP+Un66aWUswwgE1ScrofW3GoI7SNGFLM0S5xTw/dlW3lJcs8UbeCSYUNKSk2ORGN/+LvPg1h16yda/nb/+MU77IL0VOvsQfIQg+9KSUglfKVyHu4fHeYiWdMABeKamQWw34pGSwkREeU16c4LHYAnMmSW60CEkYheIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZFPQ7Nw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZFPQ7Nw"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-359f35dfef6so2656577a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392385; x=1774997185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzUhmZJGmmOaCUCwNpfN74I/PEj7MtTNruEIyc8Rl4g=;
        b=PZFPQ7Nwri2GME7Gpn4lXWqmzeH65Bm0UEeRpEEnmoLOcGQw5ykuDKXpYGEh25yCI2
         jyBCnvWIng8V7YKoYFPAxTvX9gNTcQxCIxxbX8j1dQDgNfQbuNLO1sjUDv6Agda5R4Rk
         Wi+161ARZ70UCTnAmSodbVmrurEn32d+R53UUfWJGEMpYnsBXlzfOxRYSVlzuXvmxz5R
         DIWtlZs0+JBDiqLZ9zQqdvoGmXO6P4FTMcX5X8WFkD/bsdgihVP9TC8Ozhb4rng+ji8D
         8tlSxZ68JHNnSdigF3uI+nc85WZoQhtxdLUUgYIcx2k3CXxf4zrOMJlZezxzlEOss0wl
         aKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392385; x=1774997185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BzUhmZJGmmOaCUCwNpfN74I/PEj7MtTNruEIyc8Rl4g=;
        b=foF6n03WqtMpRm1CmaSu52+BAB0ZhmxJlAqLMQZR8Q80ftg7MFJH3SlznBuRusdGk+
         EeSOD8huyIeqU9t0HsyhW+gRsRpEpTP+OAGYgMc09QcUn4gskxLK68uOkXT2YLIckVnK
         SUw5AYCBY28Ck39lEygNI4k471cTo44/hUc2DkDI9/MWR5Dld6cxMTXb1gt/0rVuS81L
         1dqjQIGMaksq1DNfacPDoIMh1v7rgFXJFXS7+WtvTkgoXik/f05BgetSE0e7BLyuuWIo
         qwFTearhG/BoHveslCJFeifk/oDc54Qk0akhDqz8O+dAA8lWIMduiWho7r3zQXn2wTDD
         5F6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUycfZleKdMl83AqXHwnfp2L4qXSdRYeNQ8Mrb6CZnFMekMr+38rrv8y04CyXGUODATn6PWo+S7PG3E5QFx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mB0bqet1+2td9LltaSwYaDHi/L8gSCUpX10GmgYBY7d1ZfCC
	/XaTbPOE610IE/W6XIb1R6AoIXE5QYNzEUJhnPGmVwFcdVns9FXz5IrRpymD7A==
X-Gm-Gg: ATEYQzxsCXk9mrntNC1gA03F1XkHUpjgH7O9xz0ndoeWnHyweFk9NFRDu94lWQ4d3h0
	hEjlRvpyyjrzSdC+qDCJLzjQYUaqpg6uiiWkJryM8yLbetQ5Tp5Vvs2U8xcKe+zN+Bjsl+W2MGk
	mp7ua5gOUiySvPfFF1XPLt6xBxMnoY6IVMQET6K/Hx5woGzIbj0iuROxTPKXGFO1ay7/68oqsHU
	mTMEwhV5orgLRTgbDWdJ8h4884xLYKnwhHSpZ3UmyL1GG2pKz8cvAYSmx+p6B7Es+K9mS51/q+A
	SWiHCj+ZfQakoR7QuLwfVP1a78hLHOS+/1LGcSckd9YWmdW0yvHJ6H/nz6JruIr6zKdlxyxiuBp
	+qHpkbEQQnmRfEqzv3mXcCXjkbiB40YHuIQZXZEw33I5WaVS93aP21oz4NrEU6SJ2LrCSpZkKYY
	Er4ZIF0XxSXOoEodLTpg==
X-Received: by 2002:a17:90b:3f47:b0:359:8a78:569c with SMTP id 98e67ed59e1d1-35c0dd81800mr958744a91.25.1774392385276;
        Tue, 24 Mar 2026 15:46:25 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:17::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c0e95653csm119524a91.4.2026.03.24.15.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:24 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 5/9] fuse: refactor setting up copy state for payload copying
Date: Tue, 24 Mar 2026 15:45:28 -0700
Message-ID: <20260324224532.3733468-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324224532.3733468-1-joannelkoong@gmail.com>
References: <20260324224532.3733468-1-joannelkoong@gmail.com>
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
index daf0c3dffcdb..81cd20e0d50b 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -641,6 +641,27 @@ static __always_inline int copy_header_from_ring(struct fuse_ring_ent *ent,
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
@@ -656,15 +677,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
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
@@ -687,15 +703,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
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

