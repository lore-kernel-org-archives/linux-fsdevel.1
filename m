Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A8497B72
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164898; cv=none; b=kjSETU+CXum4zqfs90rSLKGnx74Lvplzo0V2nPwEINz5f7mG4w8i9s1DlwaE6evTpZBsWggyE4ScIt5qFjxyKVgbuYw3EbWClumeSzS3HuTAudA1QwSt2U03ytUaDhRzLnJOUeCQpjSfAc/Bou5SBC5jn4TXs8FvcxCFOlzlOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164898; c=relaxed/simple;
	bh=LdQoQbgZU0lrWT2pURL+7/e3k5+0HWD3ja5iw2sMZws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+OaWi5g5Z2ddsFJ1uCxjVzoWpjHmiXm/slJpeDkBF08oQObq2xR3dJSqtUGdXygtYtiNgybI32O/UOMm9occlBxl9RNVisAGFaqVY0EXlHK+wTUYtFGPHUW1IoF3RS/BXqkVKYMA/CTcyX4Fy/jJSiTSkV4X7FLoVP5N49DHpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rrVk6KRS; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrVk6KRS"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so50055a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 15:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789164893; x=1789769693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bZMF2qooMPRk5Hq78os7KgYAWUsTasHU8sMqJeIvwpw=;
        b=rrVk6KRSqjxvzJ+D42cYDvBAtF2/WIXzMMqbkVrCRgEA6udEx+DbmuyffQkpfW9OdZ
         eVo5R5OjMVvCdMTIMluZuG6iYjZvQ2+TiaFyCzvHXSFrePjwcoaDwc92R8hbc9puoF0c
         VLrZ9UfOJkw47pNqd6rksfJtMxgkOIPQH+S5We6VMSvzoU+tw9vBQaagy79oZMO+mNHx
         UCbzemGSeygMJrdlwrhaTYOreDpwJkW48fgi9a0EYLgu9Ynirp2EJTbEEWXL5UupL/CC
         TiAwlASF5L/FHyS8SxF7l+qyEz9iRJIR+SxcYopKL68zxjV+FiqtB0xyvZPi0PkNZyKZ
         wqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789164893; x=1789769693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bZMF2qooMPRk5Hq78os7KgYAWUsTasHU8sMqJeIvwpw=;
        b=igIabg2ttgaRhYAS6gr10OqgyRpbEKtLUBGrF9NmFWqr8PUGfH0/XcJYsiIxHl14ZW
         PSdl9e6o1+RYGJtAfMXIwX5donQDIJOMOVi/LK6w7rKBiONG0vWgSL7EDKGKWmEylBl4
         ujoEaEP/JamVrwPGbZ4x5tM5GG0M9qHGC8BPeqfjHGNZBeVj7oUFibHCUv/oSjMpwLC2
         kbcXl2wl1U3tF9DOXt73l+7iYiveZcYG4iZGV6KgMzEBzEu38w/WZJ0PsaGvN7If/g/y
         tZBaEZCbErBc2/bWhHuTViOTHlTtlru81Bnso3Le92a6ju4Mtxmq0H58ZxCbb8UZDLl+
         PeFg==
X-Forwarded-Encrypted: i=1; AKwUvByXAClV6y3VBwPoYkdAVSI1/t6qEbsdNQ3hTx7xJLqhPVyPkKDkGi3wDM/niZTBYUs1Cugi+l3BFlLnVLtS@vger.kernel.org
X-Gm-Message-State: AFuF++nVKvPtg8soVmlsu0DPbw8tRTjJxEiRa/2JcjKUh0T2562RTfXl
	zA0PlaT6eDxiQN0VgJyq0wo9bSC9xwE4jkzTIXkxZAcZfmBqhaKjt61v
X-Gm-Gg: AYBFou32k1ESdP6939I3rgeu/IP4Zi/OPRTiElJ5+tfCZe3qi9J35wfJZMhrU7uOdZ6
	JQa8A3gFpR4skLQDtw0gNZC7OjJ2EK6BOBjjALPSjRDI5dZ7/R4qSNmUzfMtotTtCisoeCxfRoB
	sSUTD8QsupWn/auZuygpUGtb8nxCwxYvWBdMOMMB2kd6qSXDLI/hhPSWvqkMnl/8lyWuJr6vaCs
	/OW93xbmyTlzB17HQP2pAeNp+jrmIosvbLv5XNojtlzm5fIDoh1CAOlRS+wT//WgvxM4xUQIHhD
	BPi082JuN8CCKW08ynSXOdRteaxygVFHcLfJHwP4ZUqktt1u0zu2NFjwPFcdL+PiUi9kvcFDbCY
	kC86uh4pDvPt+/rWoQy+WogVAdA+td1TxZuJpQg2ieyU/1pSMQ/hI1+eXi490hfr6ZMbwTeI3lv
	y1GQ9Z3jMDUaptK94iLkD3RJ/iHaxx8Pbw1DZdu1aFJJUY3nmJMEo+8KhxTniVBq2Esp/O
X-Received: by 2002:a17:90b:258e:b0:39b:2c00:c3f5 with SMTP id 98e67ed59e1d1-39dbc6d8753mr375019a91.18.1789164892609;
        Fri, 11 Sep 2026 15:14:52 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e51449sm7862656eec.5.2026.09.11.15.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:14:51 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <liam@infradead.org>
Cc: Yury Norov <ynorov@nvidia.com>,
	Chris Li <sparse@chrisli.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-sparse@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	maple-tree@lists.infradead.org
Subject: [PATCH 2/3] idr: assert static storage for DEFINE_IDA()
Date: Fri, 11 Sep 2026 18:14:42 -0400
Message-ID: <20260911221444.1523311-3-ynorov@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911221444.1523311-1-ynorov@nvidia.com>
References: <20260911221444.1523311-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DEFINE_IDA() uses IDA_INIT(), which initializes the embedded XArray lock
with a static spinlock initializer. For an automatic local IDA, lockdep
cannot use the lock address as a persistent class key and reports
"INFO: trying to register non-static key" before disabling itself.

Apply ASSERT_STATIC_STORAGE() to DEFINE_IDA() so that this misuse is
rejected at compile time. For example:

  void example(void)
  {
          DEFINE_IDA(ida);
          ida_destroy(&ida);
  }

GCC reports:

  error: initializer element is not constant
    name##_storage_check = &(name)
                           ^
  note: in expansion of macro 'ASSERT_STATIC_STORAGE'
    ASSERT_STATIC_STORAGE(name)
  note: in expansion of macro 'DEFINE_IDA'
    DEFINE_IDA(ida);

File-scope definitions and static DEFINE_IDA() within a function remain
valid. Automatic local IDAs must instead be initialized with ida_init().
Direct uses of IDA_INIT() are not covered by this declaration check.

Convert the five automatic local IDAs in the userspace radix-tree tests
to ida_init() so they satisfy the new requirement.

Validated file-scope and static local definitions with a kernel object
build, and confirmed that an automatic local definition fails to compile.

Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 include/linux/idr.h                 |  5 ++++-
 tools/testing/radix-tree/idr-test.c | 20 +++++++++++++++-----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 789e23e67444..e2a4b6298511 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/percpu.h>
 #include <linux/cleanup.h>
+#include <linux/compiler.h>
 
 struct idr {
 	struct radix_tree_root	idr_rt;
@@ -269,7 +270,9 @@ struct ida {
 #define IDA_INIT(name)	{						\
 	.xa = XARRAY_INIT(name, IDA_INIT_FLAGS)				\
 }
-#define DEFINE_IDA(name)	struct ida name = IDA_INIT(name)
+#define DEFINE_IDA(name)							\
+	struct ida name = IDA_INIT(name);					\
+	ASSERT_STATIC_STORAGE(name)
 
 int ida_alloc_range(struct ida *, unsigned int min, unsigned int max, gfp_t);
 void ida_free(struct ida *, unsigned int id);
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 945144e98507..6fcba5b5870b 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -460,9 +460,11 @@ void ida_dump(struct ida *);
  */
 void ida_check_nomem(void)
 {
-	DEFINE_IDA(ida);
+	struct ida ida;
 	int id;
 
+	ida_init(&ida);
+
 	id = ida_alloc_min(&ida, 256, GFP_NOWAIT);
 	IDA_BUG_ON(&ida, id != -ENOMEM);
 	id = ida_alloc_min(&ida, 1UL << 30, GFP_NOWAIT);
@@ -475,9 +477,11 @@ void ida_check_nomem(void)
  */
 void ida_check_conv_user(void)
 {
-	DEFINE_IDA(ida);
+	struct ida ida;
 	unsigned long i;
 
+	ida_init(&ida);
+
 	for (i = 0; i < 1000000; i++) {
 		int id = ida_alloc(&ida, GFP_NOWAIT);
 		if (id == -ENOMEM) {
@@ -496,11 +500,13 @@ void ida_check_conv_user(void)
 
 void ida_check_random(void)
 {
-	DEFINE_IDA(ida);
+	struct ida ida;
 	DECLARE_BITMAP(bitmap, 2048);
 	unsigned int i;
 	time_t s = time(NULL);
 
+	ida_init(&ida);
+
  repeat:
 	memset(bitmap, 0, sizeof(bitmap));
 	for (i = 0; i < 100000; i++) {
@@ -522,9 +528,11 @@ void ida_check_random(void)
 
 void ida_alloc_free_test(void)
 {
-	DEFINE_IDA(ida);
+	struct ida ida;
 	unsigned long i;
 
+	ida_init(&ida);
+
 	for (i = 0; i < 10000; i++)
 		assert(ida_alloc_max(&ida, 20000, GFP_KERNEL) == i);
 	assert(ida_alloc_range(&ida, 5, 30, GFP_KERNEL) < 0);
@@ -576,10 +584,12 @@ static void *ida_leak_fn(void *arg)
 
 void ida_thread_tests(void)
 {
-	DEFINE_IDA(ida);
+	struct ida ida;
 	pthread_t threads[20];
 	int i;
 
+	ida_init(&ida);
+
 	for (i = 0; i < ARRAY_SIZE(threads); i++)
 		if (pthread_create(&threads[i], NULL, ida_random_fn, NULL)) {
 			perror("creating ida thread");
-- 
2.53.0

