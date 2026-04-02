Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8184F3F076D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147394; cv=none; b=J93gwvSMIpWiWx4+RJA7+j+K3lH/1aBWvrWM49nsLD9xKdaLK6wY40MfauXH7SyoPnzXwy52698Oe50++KxKkQU/PUBd33JLJpwMwbcjGgt2xDR1d7hglCS8axM0CiDVOOA6VA+Tx+bVcAAkyG/DC5BAAll9up+baLAge2KlhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147394; c=relaxed/simple;
	bh=jyUfEN7nH+aYrAQ9KtJ/jySyBaRx3rRWny9GrkPv1oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6StZEP2THhhAXxd77NMHYPpiDJEZ272ZzGYEYALx1ZZcRZbhJywC293SPbU7GecXt+WixwbZc2xcfRnX40W2J7DzjMrlJiWahvbZQJYkDn3h9BppCIKI3GpVg4yExWxLmCpjc2qyUkDaN/nA3BlLwZZEqosi0wEX09MKKxMXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME6ILDaU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME6ILDaU"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso4885065ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147393; x=1775752193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeUiQ1xJmDJMKhUJex4rXETWTpt4O1w7c4C/EGOeKWU=;
        b=ME6ILDaUU6IArLJLSUaL8KJ5AkoI9h4pVTjkH1fyGeUqliUsHphb+jKUWdTEbRXGx6
         J698wnK7bMGKPHZfH53LIETjlHfzHfiZd7YqRxGRh83jsR1BDAL48ejczKmWVkCUz0Pd
         3SMPFdMS/k6H1e6ZTgsiNrgkJWZh7DrFaBt2ut4uLw9Bqi/aHuurarYnj5zFH+DQ2sNP
         iMQV5xvoSbvVdjkAxkWFKEAyizrYLZIsI4e8ioT3zVp6q/Xj0+mvRGSscT2EwI3ojRnb
         rFUoyIY+c0aJe567+3KJkuOPP0+zI1D1ZPFCMgcQOgnnKOa0MpUSOqe42r+I8YP21NsK
         Xpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147393; x=1775752193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OeUiQ1xJmDJMKhUJex4rXETWTpt4O1w7c4C/EGOeKWU=;
        b=JEH+Qjey5M5D5tR6qh4t4UK9bw5TGMHNrpIG7BNTKwEgHwAV4TwPxqyT9anA4mjJkg
         wgH6zTbjdTjx9+f52UdOBiTJ9rYCI2NVcpfK5M117E9ZxlNCmTjtFpXycopyFVne7ADq
         p1388DaCJiNdBGCU+ycJdSWBeb2Ulwf/HRsHbTCU17DQfSQee9DL6jxLa4lQoi+C385k
         pLuRMEAF2doj5Qlr0kHYUlHoQLLvB/45HVLzPTzZhXJ+pGDg1HVFAn4zoiL2pzOsESSi
         J7iw4zU3W3WZh9l63dFJzxxQRPg/PyqHGKJ3USgqEHrFOjpQDF1eiMj3BE+8AFmRZGuU
         YETg==
X-Forwarded-Encrypted: i=1; AJvYcCXiuQi7WQ601XPLoiAfuXkvIFLO8iPFDI5YRGsOCoqHiuqBlkuSQFkbFfnPu9v2uJjPsb3fI/LDA8Xf3Bhk@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlnlgn+rhc/k8o/u/eSO/wZN6sAuOBjQE3oo4JuvxB82+rZhk
	1wNOW0ow2ciVd/TMrRjJTUMtExrA0Eyjpv9/TMhOhSmDbxDbd9PrDlcJ
X-Gm-Gg: AeBDiesGZ4Xu/rGwQQ/XcXr1TIAp+pVPJJHOrk26u1fDZGk9s6LqA6j3hcIUEXjXHa7
	Gp9MCJkWXFWBcEuW+ttqEtg+6LzsCBbgbu5rX0VAK8+JWxw8WClODUeFdZ839Phoh0iRPJyk2m1
	kTLlkOS5c1q1XOsYLEnQA1bVQdnl5Tov8bPwLoXQApAKpPzjIiJUIXuDBQuSxd1+TRUg+3yLbfu
	+LRJje0c/uLHyADBvmoki/vfcd4xHUSkvzGp1WnljUe14Qaoyz0HA9BBH81j2qIKCJCAaymlDnL
	k8SssRZlNP09f83ATEaI+a6XVqbdWA6AcWPpEiHMa1iDl/uA7mlwE0dz0C7/vWx2CRAgOoE0rHz
	g7pl4LSzozIxb/8E/P8o0jbjM+Tqy+F0QOlm7gfEXeWJt44l/fT1isy1XEPKDmaQdnXIME/P/rH
	T0DnWjaFymhiGokiMX
X-Received: by 2002:a17:903:38c7:b0:2b2:596d:594 with SMTP id d9443c01a7336-2b269aa8249mr81904745ad.13.1775147392558;
        Thu, 02 Apr 2026 09:29:52 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd4dsm33720615ad.76.2026.04.02.09.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:29:52 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 02/14] fuse: refactor io-uring header copying to ring
Date: Thu,  2 Apr 2026 09:28:28 -0700
Message-ID: <20260402162840.2989717-3-joannelkoong@gmail.com>
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

Move header copying to ring logic into a new copy_header_to_ring()
function. This makes the copy_to_user() logic more clear and centralizes
error handling / rate-limited logging.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 54436d3fda4d..5fc8ca330595 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -575,6 +575,18 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
+static __always_inline int copy_header_to_ring(void __user *ring,
+					       const void *header,
+					       size_t header_size)
+{
+	if (copy_to_user(ring, header, header_size)) {
+		pr_info_ratelimited("Copying header to ring failed.\n");
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 				     struct fuse_req *req,
 				     struct fuse_ring_ent *ent)
@@ -637,13 +649,11 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_to_user(&ent->headers->op_in, in_args->value,
-					   in_args->size);
-			if (err) {
-				pr_info_ratelimited(
-					"Copying the header failed.\n");
-				return -EFAULT;
-			}
+			err = copy_header_to_ring(&ent->headers->op_in,
+						  in_args->value,
+						  in_args->size);
+			if (err)
+				return err;
 		}
 		in_args++;
 		num_args--;
@@ -659,9 +669,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	err = copy_to_user(&ent->headers->ring_ent_in_out, &ent_in_out,
-			   sizeof(ent_in_out));
-	return err ? -EFAULT : 0;
+	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
+				   sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -690,14 +699,8 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	err = copy_to_user(&ent->headers->in_out, &req->in.h,
-			   sizeof(req->in.h));
-	if (err) {
-		err = -EFAULT;
-		return err;
-	}
-
-	return 0;
+	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+				   sizeof(req->in.h));
 }
 
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
-- 
2.52.0

