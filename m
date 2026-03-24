Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327638C43C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392382; cv=none; b=VEAibhhNJh8ZBfpH/RzwXuzz2EaIXTs7eOqFS+Rqr0zAP+T8dPBDsFlJWAB9OSIeMdUjjHnKWS+hlWdY85URQ8gzjfm4qwfwDVG9KpjnDsfyPTzPJPZMZDVG9LuRCFzpXE32oG1/3pnxYzJ4aqoLK6dW8rCYwfK/z9CXOuPTKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392382; c=relaxed/simple;
	bh=jyUfEN7nH+aYrAQ9KtJ/jySyBaRx3rRWny9GrkPv1oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HrVur3h7Z7jBnMLzKGnuCfWP6de56Q6wKX7sXCQsjjWTZ26RlY5LwOaNAm+HDbJD+a1KwbG4BLc7WQNs+oOsJqyQLuHK5E9sSKN5D0YMsdKLNYJLqMe1UICPss4uFmCMKB4ZgYWPgB66hnLzDvg+Jdp1oCmnTxykdqC0EoKQxXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaEoiA4U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaEoiA4U"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b042533de1so29879095ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392380; x=1774997180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeUiQ1xJmDJMKhUJex4rXETWTpt4O1w7c4C/EGOeKWU=;
        b=JaEoiA4UE1HnpSjTOBCJgWBsLy7sy6E2aM9QK4B/f7GNIG77DiC9cKMSfn9XEIDiRv
         EKr3ljKq4Y1YWFILNsifl84tpBWlVlWf41mOmi+wNAyjwQkmH5po7okOvLEcU7PEkz0p
         PtXtSa6tDwKE8mUOuAzsKpxegY0JYS1PIOenPI+KknzycLkOVKOq2cnvLltiJdTjKsv8
         C+xM7XZrb3dG5FDVp+iwdBl/pYTLxpeaT6ay6STRZO8uQafdOojOVX9qtQ1OS4fJCN88
         ShmZhqSsrBiYbse3DebebpnnB1qriC5yFFDyTq48wodgMuM7apy2HkEpIS+2z7Krb7OE
         fvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392380; x=1774997180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OeUiQ1xJmDJMKhUJex4rXETWTpt4O1w7c4C/EGOeKWU=;
        b=ewZBUpgioLnfmS8fb0eo8sfPpAAYh/51kzqMMVfES9p7mdn4daa9Qeo36TL97L+Rcd
         l4cBzQ322le9xR4cow2qesOi4BdLliTcwKHHrdxkWAsYNvFVsV1um4TvafRTrRezZNkD
         Hq0cd4mBU/0pyOS1dBoYhp70SfrAyKnuWaLa4CKRi8mPSI5RkCZinQZToLT0Oh0ach6Y
         fhT5pk2Z63XaXbDDcvUnj8Q0suF9xOC2f/yp4fJA/yinHx+xniNA5OxW//kwwuk6jiYL
         XJ9/znZFfDr4n5jowQ8GWQjQ1Tiqv++a8szQjAtnkcWRP2ZJh4E6bfGwoFCZLMhgOZBg
         9rLA==
X-Forwarded-Encrypted: i=1; AJvYcCUf1HNGlSgNpQrvwE7czx/3OC/mDUvM5ghDwqVAE3a7H7FakgxGniCITjK/Dm8b3y4xMTRLQREXpUnFQ5aN@vger.kernel.org
X-Gm-Message-State: AOJu0YzqeMa/e4YnvwF48HINt4WVgjQ+6MlTjzuEKCw6YntTSK1QlnXA
	Q9m48TyrufShixore45vDzkyPr1MTgERMQ3v5SFUniUguMsjTRmW+iZtSWSoFA==
X-Gm-Gg: ATEYQzy1zL4f5RsZBYzPZoJtr+K8TY3fVqofIuMoThz0IFv9RbYY3inYL9EuQiHxbyN
	Tj0Ixydh+emTGZiWUBWG7+/NxymM0YQ3GmAn1bIxKirXNEdzPDeR8OdGTyt65QMs1WN5sNb1Nzn
	F9YgSjWAk86cqMW4yEz1/F7L2YmXzzBR8Z8dGGWYQJZkRYtwDL2LBfh1xatiCvQ3qjCHhkq4RAl
	zfLDcW+aD0QKrGOAZsm55abFJSBuyg/lJhVF1UU9BVWdrqO6ugFew/OoPhxp/kHZZPyIFyx01AX
	t6FwSFsngEjlfOdO/cY7k3AH+tUsX3MfxF90ZzXgwohQOwZYtO5RZt956+rqlsAaEgvNf7kcoU9
	pi6h4yFTSGW0dOkSbkvrmF4u1ICKfZ6GPJ24NWoeTVPsXSRJECVgxOVD/WFWohNFy81cEwqBwDE
	QJg/HMYnPD14dtS1MZIw==
X-Received: by 2002:a17:903:22c7:b0:2b0:5a4c:7265 with SMTP id d9443c01a7336-2b0b098b3dcmr13426655ad.4.1774392380361;
        Tue, 24 Mar 2026 15:46:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0aefd07c2sm14756695ad.31.2026.03.24.15.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 2/9] fuse: refactor io-uring header copying to ring
Date: Tue, 24 Mar 2026 15:45:25 -0700
Message-ID: <20260324224532.3733468-3-joannelkoong@gmail.com>
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

