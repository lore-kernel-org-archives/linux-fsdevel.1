Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB8E3382F3
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147396; cv=none; b=f2Tdtt28kkgZym6sp3qpTUKWuBd5Xk5kL39gQfVoTHJyP2gsWgmi5AvU0a6o89bJw1Y67LJx56MX+tUv+mE5FtCsojied4TKILeVkpIFKY/6jsCELb1OoDo3sXUJliQVb4kjeOlB+J35ZHhKfS2PY6LIOlZ7V31PcW6SiLXKdU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147396; c=relaxed/simple;
	bh=DWqtpK9pB0Er3AH87vzg6uMksPMJLYDb9Z3UgedcRnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IG5RI3lxHPxXF8gP7VYQ4jL70v17jaXFtwtB5ItnFCNlJQaUyRIBnBwRSjvn2P1UUTnGRFGD9JR38MTk8MJaTp+g/NrYL482tAsqGkn+WZ0UISa11C7l6F4C9MA1Tj5wtgs8q4fqqNb68WlYmh/WGqX3+MizlYw1+43bJ6r/Fcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUqWLIov; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUqWLIov"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35c206f0481so964290a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147394; x=1775752194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tauJgjxbKw+B2sWNaX3/4gfjcSyVJZGHGNKZAPhzhaY=;
        b=qUqWLIovHdWsUlWpQWPiOaGfKmk4js9NnVHEs6u8ge1jy4UGZatRGUH2c+qiPbfLWs
         V8S5jYcEvi7qyj5m1tfx4WzvmCpd4P4rVLWY/1OuPwrYram7aqjNvj4afp4HnvcJp4Zy
         ZuAbMWaX04YI4wDDfHRBXiUFhCvxDaKg6wHpGLao6KSpHOlQOAGlawgWq6QKu/c14kY7
         +2FwxO6RdCJ4pVY8wryvD+Ig44Qd611hHdzawkLTL5tYIKKYf1qLkjnMEsln8sQEi8jT
         7+c8L0wi/1RKeX1Otlu64YgOv5nKTk+gZdVE0meQIkENdWY0NWGyTzHeNZp+UnSsyhV4
         Z0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147394; x=1775752194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tauJgjxbKw+B2sWNaX3/4gfjcSyVJZGHGNKZAPhzhaY=;
        b=EJPVZWPDruGl46Wvvdnv7h2uWFZ/U++CTEGyIdHRilSBMmx/xYZ5Q/C/64flVr6TbK
         tev3yJfFkf1Yz7z45dxL+KhDK6qxoL8Dy1Jaivkt99UufER5yqWR46vUme5IHwHKAsBw
         h3elrxBi75jkRSwfg/mesNO5TF6e6onz9916znGEM7KqmhhZ1MIVizpW+SngYmTxqu6L
         vkQZ28Nm9SXjJTHI95ps/2ulQVWKgZyz+6D4WeFav/EmQa2Qom96uF8J/TlMS/JeQpb8
         v1BkKI1Ad7Q9zSwPyHkRv5/p5x8gKT3rqXla02I/PNXDE8Vp2N/S9BZ7dvl+JPjxMdVN
         0Dyg==
X-Forwarded-Encrypted: i=1; AJvYcCXgnWV4Xt/+rFir6vx12P/PlMVH9xZzWraPQ7IBg7JMqSU20umfKxlu8eD6vyZUXI7D2DoZY5pBxhhzHV6X@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0JucdpQCttIVvVrGu8hLYMDqXX3K9vPLUFqaK0b5PI/BfDTQ
	ICtoNvu6VQDwjL9OzV6fC0cuZk+yN0D0XT7Q1h+epe+smj0sF20k/EHh
X-Gm-Gg: AeBDietgykpTE4nMd6I0vBIGwjK46BHf8zrLJU8B3Fct3RkoJzdTBG3d6o8WiD7mz7x
	TKAVydc/n+N91Cko40QXXPID1PTVxPT+avtoLbCYJFCzgBW63aT2jQm4sZHNCpR2xnESXVBSuAM
	ztS3vogIxDMgKwV7cPxrKIJMi6Sy5od+4xkuQPeFgzJTiwVhMByuAoppYsYK/mQoNk78HpFWn1J
	4OQZVCzAufe12WPzfb0IMuopBpdyk0MxZtqDG9cEgjostNdFdW4T+aTtvfTxq2OGJeFX5yMeg0K
	Vamoi4wau9QYuQv4Z+z4EwFU02eObcuSkVZ6/piYhMFy08nIc4TM8E5O4Vo6EfnLQnts+Dtc8Rm
	t/07ITgQWC2RugtQT1U6XQT88vKzx+Lzdh8Ji4IBgiJtAvgSD9YOl8Tg641/L5hCDyA30nkAyDP
	bdzerzu20AOaX4hqO0nTT58czo1b4L
X-Received: by 2002:a17:902:e78f:b0:2ae:c916:511 with SMTP id d9443c01a7336-2b275b498a5mr43340505ad.24.1775147394396;
        Thu, 02 Apr 2026 09:29:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a475fsm31798025ad.61.2026.04.02.09.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:29:54 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 03/14] fuse: refactor io-uring header copying from ring
Date: Thu,  2 Apr 2026 09:28:29 -0700
Message-ID: <20260402162840.2989717-4-joannelkoong@gmail.com>
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

Move header copying from ring logic into a new copy_header_from_ring()
function. This makes the copy_from_user() logic more clear and
centralizes error handling / rate-limited logging.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5fc8ca330595..86f9bb94b45a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -587,6 +587,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
+static __always_inline int copy_header_from_ring(void *header,
+						 const void __user *ring,
+						 size_t header_size)
+{
+	if (copy_from_user(header, ring, header_size)) {
+		pr_info_ratelimited("Copying header from ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -597,10 +609,10 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_from_user(&ring_in_out, &ent->headers->ring_ent_in_out,
-			     sizeof(ring_in_out));
+	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
+				    sizeof(ring_in_out));
 	if (err)
-		return -EFAULT;
+		return err;
 
 	err = import_ubuf(ITER_SOURCE, ent->payload, ring->max_payload_sz,
 			  &iter);
@@ -794,10 +806,10 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_from_user(&req->out.h, &ent->headers->in_out,
-			     sizeof(req->out.h));
+	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+				    sizeof(req->out.h));
 	if (err) {
-		req->out.h.error = -EFAULT;
+		req->out.h.error = err;
 		goto out;
 	}
 
-- 
2.52.0

