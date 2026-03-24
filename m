Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5780F38F635
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392385; cv=none; b=DVpqf6EerfPL3UT0M2OF6e8L9ReWDTjbeS7/QxhTYjLdOS2IVh2quGzKBeWc/zTvbOwE3ADKjuUyjDtsLWQZ22LJh8refK2/nqLGRlTJUHdCUKV3CmjPnQGdIHH49hFJcXsfJj7a5o6x1KhkT4dS0Sp2Dt/axwMo1of7FMyYmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392385; c=relaxed/simple;
	bh=Z4etxx49HOR8tvuu1t/Gt9/uplR9RCZHUqvn5tidKKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKiu1ymhmj3f8mV1BQLuMgqAqx1uWt/cXiNFUhsP20SFqfPUgB0mvV1/pI6ru7uXPNidM591oCY36O/GBP/oXzu2KHaTBy4Dgc2c7zIr0KeJ9TWYHTZJh5WYTZItDmzHd2yb3Y5nu5Jka7+znHk05qHK3CQmJQ690evo9Qm00TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1yvk9f0; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1yvk9f0"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82c68339cf0so234426b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392384; x=1774997184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCGWORlQRr3WgI1Otikh/RB1voRrEHrRy7fRsTiCsXs=;
        b=V1yvk9f0FTfyjnYnf8JG8NGfddJkbLmRR9VouAhmgyeHDxMEaVOuH5/5lnFdWwH/zn
         X5LL2GSQeJe4xWvl3XmD+x7f27pBytGeLGdvTOFgQeiaLm8N1GoGqGq54B7AhfDuo7uG
         Nxk6eaZ/P0Hk6yzbMzGskALww6Ic7+rwJqUpwdrWsSBYIqTvHR1ZMnY4D+V6NL6hQFG8
         x1ZOzEQx0L+botgS/aoIsLmemCiT89+TzCoKEHEAzR+LFzvnUltcmYncxxEexivUX77O
         JTmRS4vKSyybWJLYkM8gv6lXhIpPrAYU+NnAiHc5ihJBTZf6WbPIqm/6dEiDOoLeOyFz
         B5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392384; x=1774997184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCGWORlQRr3WgI1Otikh/RB1voRrEHrRy7fRsTiCsXs=;
        b=PybgqKp//okwnyqML2YL72/8oBMFZ1B+mE2/BuVHi7UMuyhzHslBgOQCPhfdYlkpPe
         8Vcsem0BNpmmdMiIzAkQ+m4rAx+iZcRY1ZaXbMCr5n/wpLBrDsVucE/Okvi7rzYffui9
         JMcWAaaGj6360Ijcry8yWcyOxqOXfQGxVdTrk2X9JlVoTRSk3rHSVzkbW60Coqz3VjO5
         uksN/U3c3qcGDEB4k9oI6HKDRd1fbbFusJRBPpSw4HtN1JLPFIJAfMw6eWXsW+LfEk01
         EK6bWW+sl07G5XCpDlO3LnuXPPb1e2sZ4GIRpff1C5O5OpjhQJ7lHHhAPxbGZPOW+1sd
         6v8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVIRS8ssIzkYYmUZU5U1jgzNjRh/2cCt6AsdXnWBTJhHrxbChkJVElJq0CEViVP7ytAdD27YOXrGJkNefx@vger.kernel.org
X-Gm-Message-State: AOJu0YwhWQLTeBsdrpiF+Vhfgl0V5vdzc5jD/6SOOsAzFXqxfdRzC5cc
	n6VGdzbgSJRtjlHXe2K4QMQ4KxGiN+hXzBt67sy3hR4tXwJeaTWrfvEd
X-Gm-Gg: ATEYQzzyMnwTfll2pzEQBdYplNnujsmIa09O6ChPEx9H3rzJRI/GMS40fCS0/KuWUt1
	+tgLQbqYDpqLutIXFbyiLDo7hUNmWxV9WjRxL8+CVmUMqtSyZvku6aPOjZ01S7srL7XJcu8TzYX
	hLDF0hIWws6GjqPI9qXcd6e/dvf81yh/Pu7lLDNzLl+rZw95jcM19+tuKEnx2K7kj/Py/6QpVZe
	ttgQdB2XMCadDyU0WOc6tZ70GFzx5qQA49jjDlaKsTkd5w0rEor3Z4LfPihqouG0ovGNK+cmzK4
	pdYbjDKF8/yiCcVNg/G9BQi8Z7oZAIC4MqGuZ3Pf1WZbr+h0itG3mVl7ZLVQAFSh1o1OoJ0vSCA
	c+VKkvznAMJQDnyIjY/7QD1J0rJGp3eVViaJiGYLmi4zSQx5vhuvojS/+K7Tc1+MW5mvDEXjStv
	7gfuDYCpyIrEj4DkKP
X-Received: by 2002:a05:6a21:3f90:b0:39c:50af:6add with SMTP id adf61e73a8af0-39c50af994bmr209260637.17.1774392383661;
        Tue, 24 Mar 2026 15:46:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a8186efsm11029214a12.13.2026.03.24.15.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 4/9] fuse: use enum types for header copying
Date: Tue, 24 Mar 2026 15:45:27 -0700
Message-ID: <20260324224532.3733468-5-joannelkoong@gmail.com>
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

Use enum types to identify which part of the header needs to be copied.
This improves the interface and will simplify both kernel-space and
user-space header addresses copying when kernel-managed buffer rings are
added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 62 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 86f9bb94b45a..daf0c3dffcdb 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -31,6 +31,15 @@ struct fuse_uring_pdu {
 
 static const struct fuse_iqueue_ops fuse_io_uring_ops;
 
+enum fuse_uring_header_type {
+	/* struct fuse_in_header / struct fuse_out_header */
+	FUSE_URING_HEADER_IN_OUT,
+	/* per op code header */
+	FUSE_URING_HEADER_OP,
+	/* struct fuse_uring_ent_in_out header */
+	FUSE_URING_HEADER_RING_ENT,
+};
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -575,10 +584,34 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
-static __always_inline int copy_header_to_ring(void __user *ring,
+static int ring_header_type_offset(enum fuse_uring_header_type type)
+{
+	switch (type) {
+	case FUSE_URING_HEADER_IN_OUT:
+		return 0;
+	case FUSE_URING_HEADER_OP:
+		return offsetof(struct fuse_uring_req_header, op_in);
+	case FUSE_URING_HEADER_RING_ENT:
+		return offsetof(struct fuse_uring_req_header, ring_ent_in_out);
+	default:
+		WARN_ONCE(1, "Invalid header type: %d\n", type);
+		return -EINVAL;
+	}
+}
+
+static __always_inline int copy_header_to_ring(struct fuse_ring_ent *ent,
+					       enum fuse_uring_header_type type,
 					       const void *header,
 					       size_t header_size)
 {
+	int offset = ring_header_type_offset(type);
+	void __user *ring;
+
+	if (offset < 0)
+		return offset;
+
+	ring = (char __user *)ent->headers + offset;
+
 	if (copy_to_user(ring, header, header_size)) {
 		pr_info_ratelimited("Copying header to ring failed.\n");
 		return -EFAULT;
@@ -587,10 +620,19 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
-static __always_inline int copy_header_from_ring(void *header,
-						 const void __user *ring,
+static __always_inline int copy_header_from_ring(struct fuse_ring_ent *ent,
+						 enum fuse_uring_header_type type,
+						 void *header,
 						 size_t header_size)
 {
+	int offset = ring_header_type_offset(type);
+	const void __user *ring;
+
+	if (offset < 0)
+		return offset;
+
+	ring = (char __user *)ent->headers + offset;
+
 	if (copy_from_user(header, ring, header_size)) {
 		pr_info_ratelimited("Copying header from ring failed.\n");
 		return -EFAULT;
@@ -609,8 +651,8 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
-				    sizeof(ring_in_out));
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				    &ring_in_out, sizeof(ring_in_out));
 	if (err)
 		return err;
 
@@ -661,7 +703,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_header_to_ring(&ent->headers->op_in,
+			err = copy_header_to_ring(ent, FUSE_URING_HEADER_OP,
 						  in_args->value,
 						  in_args->size);
 			if (err)
@@ -681,8 +723,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
-				   sizeof(ent_in_out));
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				   &ent_in_out, sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -711,7 +753,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
 				   sizeof(req->in.h));
 }
 
@@ -806,7 +848,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
 				    sizeof(req->out.h));
 	if (err) {
 		req->out.h.error = err;
-- 
2.52.0

