Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5234C826
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465259; cv=none; b=MiDJ9iJngaUUI2ms2jvyjJN2XwiDEQvRU9/kRIyMBXyOG0o8Pd9wmqaL71bjX8G/HPxsWR5xP6OLD00ftKlbVuHGef2GRr97DUAYKYytv8Cz/iAyZPP1ZB/HJQ2gPyzC7dFVTLXA3PTVE+13XyLPFF+4bvMlYosrQ5J6ewGJpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465259; c=relaxed/simple;
	bh=9UEMg/LUGz82KTZ4mXaCFHNFRy8OlbOJf3nyqzMuYP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mua985CxRDGkedJsREBNIMg5D1It1bzxSwtvib2+Hwp2C1uCsHUP3qN3a0Dq/IWFn0gu3eIzDtAX6fB1DHiebFBG2nu79+IS788HXpag57ymKDLEexqLm8/leGpBlu9vWeZMIyhY/vOm/I9lGPJtv0y7+9NBtJ7pYkSAzN54qjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=TJLDN6/c; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="TJLDN6/c"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso122454a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1774465254; x=1775070054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzCbch/KsCOdnnvj+/cBnu2Cwa08GiMJ/oPkFKD+RSg=;
        b=TJLDN6/c6gBMwovAfpfB/Ho/vlYJDHptgPDukKB5mfXjIh8yBVeyR1wnnbmzIxt3Er
         hg1B95OCnqRqo9dvUc3A7/tNBPmQMKOsNCLoaWtwclmTmMV9fr26LBcjWsfTOg84V9NP
         Bnwq8yB+qi4QGo2jDP2geTbVw1+nwxXRNlKgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465254; x=1775070054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qzCbch/KsCOdnnvj+/cBnu2Cwa08GiMJ/oPkFKD+RSg=;
        b=h7ZT16Tot3YhjxPJNAeFqD2yoljV3uHkly4gWiwDTOK/HMYxyXMYOfvH41WIDrMLGV
         qln02Z3YP+3J07oOUDqFq9O8QzwbfyEXZfR7l9kK0QM5+IdUzPzNGhm1P8r0CUNQro0M
         JAU+bU+leOWMjEGR5urGddM1c6xsjZLLKG7EQdxRsGmedT/4Jl1oEizzGxznPeIy5Xxl
         KqWW3Q0HNPqGEAcOqKLWbR7xzySMM3k2OXITCPleM5/TyqPVJpnN7oyYPs7IKm6RvYR7
         ovX71/LRxupixefyeeF3ipuNvwq8iBZuW5ZHhU4+/gX2BOVo45mT4lh749y8N6YmdAIJ
         9HVw==
X-Forwarded-Encrypted: i=1; AJvYcCVYORrAn4z/j5Z6v5ZTMuAjERuLKFFguZA/k2a17BuFHkrkTY/PPUJ0cuyLj6fm8tq5v8FzytEPFy4QiQMl@vger.kernel.org
X-Gm-Message-State: AOJu0Yw23oJc9kO5sQpNij/MbKkHDrQ4oD95L6JEfLK87SYTmjBbFXjT
	UUzyaKdzIyFMzbyrgE+m/iFIT8inLqv1mFwVtRZkI5+D0/KGfMm9pkFMM1sYWhu0I9Y=
X-Gm-Gg: ATEYQzxFoiVLVY+sRQE/pfkBo1fd4YPyEBDmUF6erUS96pDmlze0kidnXe85nmJcKk/
	ET5eAPFQPUKkgJ3r30lgj2GvJcDq1+A4QUw3G0dN4To2bXKrct58XKZbzgYLsQ6Sg3XcUgIxY9I
	nu0MzfaikYPoE/6xA0HKRxwBkMc95oxUcwVn6zFUYkuAr7rHwjF+zd8qFuAw0P6zxvkmqvlQYwW
	crAJAZwQVcnVAdM0htQmpRae8XG+VXDCW39J472Wzlo8da/l9WPog/3+L3ZTY9SBwP1BG4QZJQF
	azs2oGyy4paJcf1MfdJYSGE6e+/3IVgilegcxXJ5wSGQNjPdvlN2DWS++78EdmUiUIgC17opIi8
	9gn2DMk1endNOR0bq11V1rLSGvizMSjg5zizv9DLCjmkDO3WpUDZwAklUMeJAW4ajaTKU+fFsPD
	3Hc4EgDfPogWPIbM3dcLqraljTKzxCLeduDinQzz5iziDpnGkui9ZPJSOhyrSAoEyD9AbJC8Fnj
	clrFy06qRB73K0SfnokVw==
X-Received: by 2002:a17:903:908:b0:2b0:669d:3a68 with SMTP id d9443c01a7336-2b0b0a15b81mr51723535ad.19.1774465253887;
        Wed, 25 Mar 2026 12:00:53 -0700 (PDT)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc79f7dbsm6483485ad.25.2026.03.25.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:00:53 -0700 (PDT)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: manfred@colorfullife.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	rstoyanov@fedoraproject.org,
	ptikhomirov@virtuozzo.com,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: [RFC PATCH 2/3] msg: move struct msg_msgseg and DATALEN_* to include/linux/msg.h
Date: Thu, 26 Mar 2026 00:30:24 +0530
Message-Id: <20260325190025.40312-3-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325190025.40312-1-ssrane_b23@ee.vjti.ac.in>
References: <20260325190025.40312-1-ssrane_b23@ee.vjti.ac.in>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct msg_msgseg and the DATALEN_MSG / DATALEN_SEG macros are
currently private to ipc/msgutil.c.  struct msg_msg (already in the
public kernel header include/linux/msg.h) carries a pointer to
msg_msgseg, making it an incomplete type for all callers outside
msgutil.c.

Move the definition of struct msg_msgseg and the two DATALEN macros to
include/linux/msg.h so that other IPC code can safely copy
multi-segment message payloads into a kernel buffer under a spinlock,
without calling store_msg() which performs copy_to_user() and therefore
cannot be used under a spinlock.

ipc/msgutil.c already includes <linux/msg.h>, so it picks up the
definitions from the header with no functional change.

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
 include/linux/msg.h | 13 +++++++++++++
 ipc/msgutil.c       |  7 -------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/linux/msg.h b/include/linux/msg.h
index 9a972a296b95..2d5353bace9a 100644
--- a/include/linux/msg.h
+++ b/include/linux/msg.h
@@ -5,6 +5,19 @@
 #include <linux/list.h>
 #include <uapi/linux/msg.h>
 
+/*
+ * Each message is stored in one or more page-sized segments.
+ * The first segment is embedded in struct msg_msg; overflow goes into
+ * chained struct msg_msgseg blocks.
+ */
+struct msg_msgseg {
+	struct msg_msgseg *next;
+	/* message data follows immediately */
+};
+
+#define DATALEN_MSG	((size_t)PAGE_SIZE - sizeof(struct msg_msg))
+#define DATALEN_SEG	((size_t)PAGE_SIZE - sizeof(struct msg_msgseg))
+
 /* one msg_msg structure for each message */
 struct msg_msg {
 	struct list_head m_list;
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index e28f0cecb2ec..9cd4b078d55c 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -31,13 +31,6 @@ struct ipc_namespace init_ipc_ns = {
 	.user_ns = &init_user_ns,
 };
 
-struct msg_msgseg {
-	struct msg_msgseg *next;
-	/* the next part of the message follows immediately */
-};
-
-#define DATALEN_MSG	((size_t)PAGE_SIZE-sizeof(struct msg_msg))
-#define DATALEN_SEG	((size_t)PAGE_SIZE-sizeof(struct msg_msgseg))
 
 static kmem_buckets *msg_buckets __ro_after_init;
 
-- 
2.34.1

