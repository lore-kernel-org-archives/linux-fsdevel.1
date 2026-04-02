Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570E3F1655
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147403; cv=none; b=u/iPtOYmB/ACtqmaXHDjqqfgLUqrQSLKk7VzRENhC8IdnxrNO8hMiCwAhfsYJX3XnCO0VxM2Pv2z7LSNzCCB6n0ovzz+yEZO9sxy16nMx+PrBQ1Fqwww8ML5SJpAIZMNnrcecKVvRpNt4TtBivPK3vlFrpz3/C8/OWp4186C3ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147403; c=relaxed/simple;
	bh=3/9sA5otBFOvkT2BQEuzVWIkirqctIJ9aNh6tllpEqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ6TBqvwfBKQhDmyDcGBtrkaFANJWJ3vyOVD6/1Z1zwc8hsSB+sTXxFy0HIs2efydYwo1lLlL1Ol1HpWnmiFnJq6ZHpQEmxnisoUYmDMarb1snwl7fF4DZ/y8UOhiSpA5PK3hslymIoHHUynSQwwP1jqfCSbbXyQp/h7FLTWVPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJwzXqpx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJwzXqpx"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-827270d50d4so974717b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147401; x=1775752201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swRraCZpomYR5gso+HpNrRZp9FUpzVW6Jdt2/gxlwCo=;
        b=RJwzXqpx6uS2PVCo5jRXfTf/k9DBxyIXm030i5Kd5s77wl3wp+t/dEziO5gNMeu9kL
         fEt52UHJQ3SZtWJ0jW88Q2HBqiYCom1qxk4Oay5/gxf6SSpt4mfFLleXt6N/WHmdttjm
         7+qv+0qFjwMDksImceSkw4LGsUPxyKSl0rgRiED0nB8axgqmlVFEuvwIbFUkOyoAd0Fa
         q8yvk3leNZ12Y9CN4Cq9IXK6guud/IM+1sW4zhc/9bgUZkROuz7FKMioI0UKaFKjYMyk
         YGTJsSXKGS37i5eOU3AxDAxexYRvA8XOc/AAm4/hVb65EH5zXqGw7oAXt/B5stl3lJCy
         NNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147401; x=1775752201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=swRraCZpomYR5gso+HpNrRZp9FUpzVW6Jdt2/gxlwCo=;
        b=CANBOwPhsS7mzjLstFsFhq9WF9XPIgKhCDBqM9+vuli2ZssUis1iRQfMDAVGreERKh
         Vf3c9yD7rrXIX6vmf8mkL+G7Xh/wzQHiOowGlzorMPrCahJhm/xvfLrULUOcQ8EaGrri
         UE5SFw9DGq616Oorf9l6VtFCO4B8lyZKtIDGmiU8m6fadyLNyBOlFaILLo1fh0UVR+aQ
         wf1d8WO69WaEt/+dMSHDLXXDnnlSG8M3f6QSnjUk6DVeJlscNpPpn8HjYj8g0R/0QTiu
         0zfIo8cYa54T+YJo8i17Z+zuvjJ9VhXWtLubO1GzeRgJt9bnqM8Tez6KEnW3K7dsZYyr
         kZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ67net1yCe5dON+uc2TEDdRbpvMA/jzYYtninaufnu7XOiyCcQ1koZqIuPHqBFL10hDKLIr0/4rgHmgK9@vger.kernel.org
X-Gm-Message-State: AOJu0YyxJoEfLL1XQfiW2kIWUl4vElOAfwSrhO2bWlViMH2Y8CeLsIcz
	R7h3nMWOEejDPI0mFR+3tvksbQby7rbZBhmGEnfbpL6P0bmeejPzUqnCKr4Zvg==
X-Gm-Gg: ATEYQzzV6hMrUBLjgdBT7Gxh1TOFmJxST2IQ1XaVv9oodNtvmOpi17lko+jKvD8kLLd
	U8xmz2WNJ7vPY5Qf+UmENciKvNe8n0OlpTvzXctXy37oi4vYsLzj38qoZHsxxDUegCTEtQoPNre
	YxvF67ZxT55jkrklgF79X/UD5D7SF1HJHiwl2GUQfrL3f4uxJb4jW9TYg63JawKtc8YVB5llLMU
	BloKZ9QmP8VHr1o97ZoCfrza7QvnRRF+RQxVhs73pX1XEVe94n3lJFek6FgICsNRQ3tMASA+aWH
	dyi8sQfjvtPV7wOmwn2+Xfxlaq+q9wOFqkFXKHRDlp0C1zItN/cVFP2krmlv1saA5Ym5Zn1TdrS
	8hxhOr0K96Z1lL1i8m+DaAZL4wcNCPW04BcxfwxhrJSKCmvnv690vQJRsAfCgTfKsOoDwUIxoZp
	DZju/tUpa2hm3ghSXHng==
X-Received: by 2002:a05:6a00:2e94:b0:82c:7383:3745 with SMTP id d2e1a72fcca58-82ce88e5eb7mr8614633b3a.19.1775147401352;
        Thu, 02 Apr 2026 09:30:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbdfsm4531080b3a.53.2026.04.02.09.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:30:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/14] fuse: use named constants for io-uring iovec indices
Date: Thu,  2 Apr 2026 09:28:33 -0700
Message-ID: <20260402162840.2989717-8-joannelkoong@gmail.com>
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

Replace magic indices 0 and 1 for the iovec array with named constants
FUSE_URING_IOV_HEADERS and FUSE_URING_IOV_PAYLOAD. This makes the usages
self-documenting and prepares for buffer ring support which will also
reference these iovec slots by index.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 045394a7ae41..a85acd9c2b71 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -18,7 +18,8 @@ MODULE_PARM_DESC(enable_uring,
 		 "Enable userspace communication through io-uring");
 
 #define FUSE_URING_IOV_SEGS 2 /* header and payload */
-
+#define FUSE_URING_IOV_HEADERS 0
+#define FUSE_URING_IOV_PAYLOAD 1
 
 bool fuse_uring_enabled(void)
 {
@@ -1063,8 +1064,8 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 }
 
 /*
- * sqe->addr is a ptr to an iovec array, iov[0] has the headers, iov[1]
- * the payload
+ * sqe->addr is a ptr to an iovec array, iov[FUSE_URING_IOV_HEADERS] has the
+ * headers, iov[FUSE_URING_IOV_PAYLOAD] the payload
  */
 static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
 					 struct iovec iov[FUSE_URING_IOV_SEGS])
@@ -1094,8 +1095,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 {
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_ring_ent *ent;
-	size_t payload_size;
 	struct iovec iov[FUSE_URING_IOV_SEGS];
+	struct iovec *headers, *payload;
 	int err;
 
 	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
@@ -1106,15 +1107,16 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	}
 
 	err = -EINVAL;
-	if (iov[0].iov_len < sizeof(struct fuse_uring_req_header)) {
-		pr_info_ratelimited("Invalid header len %zu\n", iov[0].iov_len);
+	headers = &iov[FUSE_URING_IOV_HEADERS];
+	if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
+		pr_info_ratelimited("Invalid header len %zu\n", headers->iov_len);
 		return ERR_PTR(err);
 	}
 
-	payload_size = iov[1].iov_len;
-	if (payload_size < ring->max_payload_sz) {
+	payload = &iov[FUSE_URING_IOV_PAYLOAD];
+	if (payload->iov_len < ring->max_payload_sz) {
 		pr_info_ratelimited("Invalid req payload len %zu\n",
-				    payload_size);
+				    payload->iov_len);
 		return ERR_PTR(err);
 	}
 
@@ -1126,8 +1128,8 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	INIT_LIST_HEAD(&ent->list);
 
 	ent->queue = queue;
-	ent->headers = iov[0].iov_base;
-	ent->payload = iov[1].iov_base;
+	ent->headers = headers->iov_base;
+	ent->payload = payload->iov_base;
 
 	atomic_inc(&ring->queue_refs);
 	return ent;
-- 
2.52.0

