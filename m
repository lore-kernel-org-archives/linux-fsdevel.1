Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905B33AEF3D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147406; cv=none; b=IPBWbBw6kwNKYdqj9SsQgqK3L7vx2IbYTobg8MAyIJjG/l4O9HeU8Yq7aVAja1QRMNrgHKpAiPMNsgtVCaQuRbKaIKVLBwTqoh+D4BJTvQsqDWIfmtPgr0rWGCzEoxMfxPthj/HtxiXJZ1u34K2Y8aMbePErGaRP8qRkvZrbxWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147406; c=relaxed/simple;
	bh=gCn9UDUzVGoQ53OjiB0XJE2imtbIy5vN9wUobVNdIfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBdGmyhqkoMjbFbwAh/rx9LWMmv9lpBwkONU7JHSTKA2uZZ58sQfvkv+YNqkmv05KHLD7Ja80sjiUI1IkVAF0Lu4lOYhn83Ja47X6ohi50wXey6BwO6m5LeO28m2qJRUcmYMOsMyymQGFg1qs0oBPRKvdU8hzbSPaHUsbKlNKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KppNGdGQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KppNGdGQ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so514681b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147405; x=1775752205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/CYuAMtCrG3OogtMJsJic3GqXMIYYMw6zY7KdLQeNU=;
        b=KppNGdGQIT10gOhZsVW3GrE3F05yHapqkgPKETvJk92LRiMuG+vu0YnoLLQTdLldWZ
         1xOMS/WR1NSpQbgRv5Wt++jlgzv8WNZcKvHk9yzCLQj4piG0WN8l5LkbDgoBBXi5cC1O
         0gEBLkoQRIpic0jCTp7dAACLMbZ5DfGYEdJ/t1qZZoE7zhwyOzmoNCldKEn8WynpkQ31
         vKJ4bLnOx+pNn7baG+/XoEtMWQDFwWCjbqWGfoI91kH47aHFkQGkPFP+Gkow4QUM2wP3
         iJmSq4XLBEsi5LIyzKHP5G2EfudaXpGe5ItSdT4OYBt/d0WM9lBgJg7gjf1frHvuiZDI
         qVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147405; x=1775752205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/CYuAMtCrG3OogtMJsJic3GqXMIYYMw6zY7KdLQeNU=;
        b=QXz5zpPsH/YBiX9IZBqz5inzgyVGAgtD6FqJ9l4Eq9jt8l8rkVwhB6ojYTakqlcJyb
         jgOKOnq87LDAb0uF6wl66ViSaoRvEHBNkFtyslLSDDwnsXZcKsxXy9iBu9SbtZ813fbv
         BhcmOy/OmyXyjvv6B4HeOmEQeHCKAP+bOBpa0YNN7jwlE+zyrBnfe0TGPUq8mj4Xr5bD
         /gDFZ5sRbTR3mpVBm5qaBnXR0uoHDSaoae7Fal2CPejzZBeRj0E4Dqj0RMtKqR9gWzqV
         InjSK5LtRDM+t3DvwzwKxqCbhZ9L1IaWWV9sbosvsXUuEo//cKxpZix2IsGqXr8ocbFX
         6IQg==
X-Forwarded-Encrypted: i=1; AJvYcCWxpOAEfFz8LwMp+FzyBlZvLCCA908MJyuI1FY0eNKQ4JlCIAlXmtSrhSkARj8/PVt87o7j0Ane4CGnHPl2@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxv6YbZdSSWcJDM0NC+cNDAIBwC2DDJpxNzUSAMSIww6aqC8Cl
	kOjVUjCVHbrRfJT7J1duusp8THmXrfBa6KJPj4ib838K/EG0GTWcWRWg
X-Gm-Gg: ATEYQzygDa6RGK+34H+TcYzt3AHmSTg1nV1lgZo1bdPuDt4QSufuxJ7go327VFg74K8
	2YazxE625O0x1CvFo9Mch59RNCM1bexFdXEavqBoW8nGURQEYG7oSf3qPwDBsHHsAPiTvXyDvw3
	Cm2DTNR5u+E8eUB17m0GyKam4MUl3/6ApDwmUFv4jnzGbdjj0QdzrjuKHUdE5lRM+JV4nzBT4rL
	yzIxyIZ1Li8eWmI26ej079X/CdmYk+Jr6RuJeomAb5U6GJRNRketzNpylMPGevk2NoX7MPWJR8r
	tEmUmfK7aBnIjJkb61IROLhBP8ttw9PVjtpWOVV1VugAhwi8i7R1Z1tjEbuuiTEAeIjC98BvhTI
	2gIJAADYSACE1B1TS5c6meaFKh+LC9u8zaQopKs7ulDq9rsw8aXIeOazMwah0f6pRFT1VgJvpCK
	bYQ1KwpBmYFRO8KRRb
X-Received: by 2002:aa7:93dd:0:b0:82d:785:f64f with SMTP id d2e1a72fcca58-82d07860d67mr923656b3a.40.1775147404761;
        Thu, 02 Apr 2026 09:30:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbf6sm3827862b3a.52.2026.04.02.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:30:04 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/14] fuse: rearrange io-uring iovec and ent allocation logic
Date: Thu,  2 Apr 2026 09:28:35 -0700
Message-ID: <20260402162840.2989717-10-joannelkoong@gmail.com>
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

Move fuse_uring_get_iovec_from_sqe() to earlier in the file and
move the allocation logic in fuse_uring_create_ring_ent() to the
beginning of the function.

There is no change in logic, this is done to make the subsequent commit
that adds buffer rings easier to review.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 78 ++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index cce8994241b7..a061f175b3fd 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -277,6 +277,32 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	return res;
 }
 
+/*
+ * sqe->addr is a ptr to an iovec array, iov[FUSE_URING_IOV_HEADERS] has the
+ * headers, iov[FUSE_URING_IOV_PAYLOAD] the payload
+ */
+static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
+					 struct iovec iov[FUSE_URING_IOV_SEGS])
+{
+	struct iovec __user *uiov = u64_to_user_ptr(READ_ONCE(sqe->addr));
+	struct iov_iter iter;
+	ssize_t ret;
+
+	if (sqe->len != FUSE_URING_IOV_SEGS)
+		return -EINVAL;
+
+	/*
+	 * Direction for buffer access will actually be READ and WRITE,
+	 * using write for the import should include READ access as well.
+	 */
+	ret = import_iovec(WRITE, uiov, FUSE_URING_IOV_SEGS,
+			   FUSE_URING_IOV_SEGS, &iov, &iter);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 						       int qid)
 {
@@ -1076,32 +1102,6 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	}
 }
 
-/*
- * sqe->addr is a ptr to an iovec array, iov[FUSE_URING_IOV_HEADERS] has the
- * headers, iov[FUSE_URING_IOV_PAYLOAD] the payload
- */
-static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
-					 struct iovec iov[FUSE_URING_IOV_SEGS])
-{
-	struct iovec __user *uiov = u64_to_user_ptr(READ_ONCE(sqe->addr));
-	struct iov_iter iter;
-	ssize_t ret;
-
-	if (sqe->len != FUSE_URING_IOV_SEGS)
-		return -EINVAL;
-
-	/*
-	 * Direction for buffer access will actually be READ and WRITE,
-	 * using write for the import should include READ access as well.
-	 */
-	ret = import_iovec(WRITE, uiov, FUSE_URING_IOV_SEGS,
-			   FUSE_URING_IOV_SEGS, &iov, &iter);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static struct fuse_ring_ent *
 fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 			   struct fuse_ring_queue *queue)
@@ -1112,40 +1112,44 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	struct iovec *headers, *payload;
 	int err;
 
+	ent = kzalloc_obj(*ent, GFP_KERNEL_ACCOUNT);
+	if (!ent)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&ent->list);
+
+	ent->queue = queue;
+
 	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
 	if (err) {
 		pr_info_ratelimited("Failed to get iovec from sqe, err=%d\n",
 				    err);
-		return ERR_PTR(err);
+		goto error;
 	}
 
 	err = -EINVAL;
 	headers = &iov[FUSE_URING_IOV_HEADERS];
 	if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
 		pr_info_ratelimited("Invalid header len %zu\n", headers->iov_len);
-		return ERR_PTR(err);
+		goto error;
 	}
 
 	payload = &iov[FUSE_URING_IOV_PAYLOAD];
 	if (payload->iov_len < ring->max_payload_sz) {
 		pr_info_ratelimited("Invalid req payload len %zu\n",
 				    payload->iov_len);
-		return ERR_PTR(err);
+		goto error;
 	}
 
-	err = -ENOMEM;
-	ent = kzalloc_obj(*ent, GFP_KERNEL_ACCOUNT);
-	if (!ent)
-		return ERR_PTR(err);
-
-	INIT_LIST_HEAD(&ent->list);
-
-	ent->queue = queue;
 	ent->headers = headers->iov_base;
 	ent->payload = payload->iov_base;
 
 	atomic_inc(&ring->queue_refs);
 	return ent;
+
+error:
+	kfree(ent);
+	return ERR_PTR(err);
 }
 
 /*
-- 
2.52.0

