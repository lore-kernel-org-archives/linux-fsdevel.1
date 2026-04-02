Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445D3382F3
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147398; cv=none; b=uyD6Vvxl+fSHKun3N7gApeiTBvRj017yvG+xWmK053BNbUh0KK6/73ua5IM16aMXiZGHBVh/i0+V7h+oUav2ArmW2zVxfs9sW3jHyBd9qDNdS4aj9VT2dcescTFbVlN5dIpP9fyWu5NPg+Zf9ARR15MhSI0fw7YWRS317xSw7QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147398; c=relaxed/simple;
	bh=3X+IQcG+smPLZwbNLS0cG3KX07jF9UwRD92tKW4j52g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6aNiPVWxffo9EiUu1l5hMhku3D9mCFu5Ij1X3Ff0sPzbgqLGWrkumyQ9z3NOMk9K0OWd4oxusRIgQwTbi4JJsLp93jtsI6L9v2Ab0al+qyO2/nkXVLTqlxfPoH2vCEWDTJMkoo9gVdwxDHpIsSay0xevCWfZVI2oa9CBliKbCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3RMhAuH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3RMhAuH"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso450016a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147396; x=1775752196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jG8j6tInrJYCb69mMxNEg77/Mf9GQ5uqZC6tnNXMEHw=;
        b=D3RMhAuHvqbIQNHy0kyBhZmN9ssE6g+BR/pm8bmCLLYx9QSvLkn5ZxbiTwWureX5od
         cYILMTAICgT0m3K/d0W5CEhMfXyitHDp1xtwAT4lKMQ2xwfjX1+UiWbqJ6C4528+Fis0
         zyeryiJ4FUHYWEaJzUv8DLhdocp5T68L3lvkFXfsYI49JHMuMgeZ0VdNiLoG99jhL6Wd
         pPmuW8dhyV0OZkdtymUd2GC90xXKwHnE+r9vykiSsX6+H08j2E72mXIQL6Kvwj+9aKmo
         eHtyYRnMfpmACEWMRPAMiVHxqvUkHhLdo81wTYFJQplAYwLiE17cV5uBM1uhM5zcT0dE
         u24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147396; x=1775752196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jG8j6tInrJYCb69mMxNEg77/Mf9GQ5uqZC6tnNXMEHw=;
        b=qjA2Kr5EA23PJZFTgKwtRrEekCiA0qRHWJIyqd/d+BWCQa2yQHJgGKU7KmiFqTY1zm
         mPLBSDtpOcd3QDQpJdqoTPjEwe1T8sf6zaH1XsWTzER0IEc+8tzPGy2chGcb0AU4mvFg
         OOO5X7A9FtQ8CzNkkVV0YWUd4NXz3S6FZ0j9pfMoG3YKcm5B34TATfNSwTxJgjSCFci7
         CyKKBibv6RJTqqhdi5gA3jtLsycMPuY7WNEcZBQKgBb7ARgHZxN7/76Wdd4MQqfbjtyr
         JA1QeA/vYaQ7+Ir7EXhVfr+8bPagjggj73mUPkf4H3N+Cdvyv+TrjUW3ZYjOkZm6tHp3
         eziA==
X-Forwarded-Encrypted: i=1; AJvYcCU98Y724JljoMYuoapQG1M2AwgbS8lVQ15Eit1SIjnm7TFC067jF1fQjt3B6HDqfjyheIJ08Ed3I+wpasTP@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMh2yObSDIFGIH7rAr3iwb2wvmeYYQpGaiYyqbMa6NRA7mtaY
	af8A7068UjswaCmrqx37duhLRmNcdxWUQxGnnZYolfDZrKyfssVVar8U
X-Gm-Gg: ATEYQzxDlby7rU2PSQGpAhL8w6AUwzBJ+oFaZsdTmFqZvpV3MMIQVE99solXKKG/7Ob
	U7iVymYdGL/60vpJDJ9GH/5Qq8u4pu38PHza6qA+l2LDqTOdAyiDoY19fJVZ/EEbImvW5yuwjgj
	m5R74kLBLdnXyv+4nDN0xJpxcKBydC/1nPsv616z/+KVmV5RjHfSVA1V7X41wnJoR8amFkHP1hV
	oNzWn3nDl6acx3nkTLYGX+kWsm48MInvhPwQNndzM2ubTg6IdeJbUtMg0P5jIJV2D+K1u5Q+AHv
	SvsAtlCK3QHVdI7Uk1hkXlUfZFzBr6CpHYpXraj5c6LWOKOZCF6tn3vBdE88BGhOm69MkJUUPdB
	YXBaW+CNaPeylIfK1iqiGGhTuneaLUCVyr87c1lA0H+fHK5LyPoCIQfboHFuuULnJPIUvqqJ27T
	J3GZ5J1Yi0OHQYzyvcLA==
X-Received: by 2002:a05:6a20:394e:b0:39c:4cc1:b934 with SMTP id adf61e73a8af0-39ef76c2951mr9110586637.34.1775147396192;
        Thu, 02 Apr 2026 09:29:56 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6477bbcsm3095043a12.3.2026.04.02.09.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:29:55 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 04/14] fuse: use enum types for header copying
Date: Thu,  2 Apr 2026 09:28:30 -0700
Message-ID: <20260402162840.2989717-5-joannelkoong@gmail.com>
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

Use enum types to identify which part of the header needs to be copied.
This improves the interface and will simplify both kernel-space and
user-space header addresses copying when buffer rings are added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 66 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 86f9bb94b45a..cca795dd72e1 100644
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
@@ -575,10 +584,33 @@ static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
 	return err;
 }
 
-static __always_inline int copy_header_to_ring(void __user *ring,
-					       const void *header,
-					       size_t header_size)
+static int ring_header_type_offset(enum fuse_uring_header_type type)
 {
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
+static int copy_header_to_ring(struct fuse_ring_ent *ent,
+			       enum fuse_uring_header_type type,
+			       const void *header, size_t header_size)
+{
+	int offset = ring_header_type_offset(type);
+	void __user *ring;
+
+	if (offset < 0)
+		return offset;
+
+	ring = (void __user *)ent->headers + offset;
+
 	if (copy_to_user(ring, header, header_size)) {
 		pr_info_ratelimited("Copying header to ring failed.\n");
 		return -EFAULT;
@@ -587,10 +619,18 @@ static __always_inline int copy_header_to_ring(void __user *ring,
 	return 0;
 }
 
-static __always_inline int copy_header_from_ring(void *header,
-						 const void __user *ring,
-						 size_t header_size)
+static int copy_header_from_ring(struct fuse_ring_ent *ent,
+				 enum fuse_uring_header_type type, void *header,
+				 size_t header_size)
 {
+	int offset = ring_header_type_offset(type);
+	const void __user *ring;
+
+	if (offset < 0)
+		return offset;
+
+	ring = (void __user *)ent->headers + offset;
+
 	if (copy_from_user(header, ring, header_size)) {
 		pr_info_ratelimited("Copying header from ring failed.\n");
 		return -EFAULT;
@@ -609,8 +649,8 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
 	int err;
 	struct fuse_uring_ent_in_out ring_in_out;
 
-	err = copy_header_from_ring(&ring_in_out, &ent->headers->ring_ent_in_out,
-				    sizeof(ring_in_out));
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				    &ring_in_out, sizeof(ring_in_out));
 	if (err)
 		return err;
 
@@ -661,7 +701,7 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		 * Some op code have that as zero size.
 		 */
 		if (args->in_args[0].size > 0) {
-			err = copy_header_to_ring(&ent->headers->op_in,
+			err = copy_header_to_ring(ent, FUSE_URING_HEADER_OP,
 						  in_args->value,
 						  in_args->size);
 			if (err)
@@ -681,8 +721,8 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 	}
 
 	ent_in_out.payload_sz = cs.ring.copied_sz;
-	return copy_header_to_ring(&ent->headers->ring_ent_in_out, &ent_in_out,
-				   sizeof(ent_in_out));
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
+				   &ent_in_out, sizeof(ent_in_out));
 }
 
 static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
@@ -711,7 +751,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 	}
 
 	/* copy fuse_in_header */
-	return copy_header_to_ring(&ent->headers->in_out, &req->in.h,
+	return copy_header_to_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->in.h,
 				   sizeof(req->in.h));
 }
 
@@ -806,7 +846,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
-	err = copy_header_from_ring(&req->out.h, &ent->headers->in_out,
+	err = copy_header_from_ring(ent, FUSE_URING_HEADER_IN_OUT, &req->out.h,
 				    sizeof(req->out.h));
 	if (err) {
 		req->out.h.error = err;
-- 
2.52.0

