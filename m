Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537236A017;
	Sat, 30 May 2026 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133931; cv=none; b=pJJsB6qhz85PMoq2nyF31SI/YvuyKQhuYDr9Bn08hkiEEup/mfJYSS74WwdFBYR3C6d7Abbx1jXzU0KRDDTKNd7rAkuJ74EC4clGLyozPyubvfB17QDzWZNae3B5h+yPbCbYW9gx5//eOmoX8aDR8ysLewJTEiEwhbH3hnF7E1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133931; c=relaxed/simple;
	bh=JpJFlUECNNus1Qk62uCTbOSmj3u9VJzWwPJQZHOeoQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoiD5BO698Yk4tXeYohmwmOpg8hu4d+fDm/mSxREpdJVKHKES2hVYdlxeKqA0bwgD0rsz2rj7ByUzA78A8a5cRLRCg/sULKWCWBbBgS1EBOcHJ01I5yW/hB3lM9MW/aKn46Yd2750fY+e7dEy5OhhpZwbz37CeWNLXvYS8J9o2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IC9H7nCg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhRJDnhF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IC9H7nCg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhRJDnhF"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780133921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfTkEpFSA6rsnLRfrCgif8Z+qwt1DWfiZbx/HB3hB8c=;
	b=IC9H7nCgqM3GgcqgG3K2dF5O/Cv/gnQHAszaP29L8irFI9462XzBdPBm7S8IPLOrpKAwXq
	lsCybyvLPFkozivqZWXCMiCL0Y+e3FE+mWUl2KuQPVK1TY7AFri2hzkD0OwBkMeFD6+uKo
	Nwnq0gfxG+qXFZAOtZCGPt7n3/W+LBotErFXeBVuw+jqbvdCYc3IOR9MuWAJTpwmCVFaMF
	oRcTp4tCCA4RtMgRgrpTcuRRRlam3zv98qK/vNTiOa7ZFwAm22ifo2R1380jwf9NWaqOsU
	mFFReJ8UmhmxY75NvRI5WKHE6mAf5mrFITovBxymvmEa9QbkhNFxUyM52s73Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780133921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gfTkEpFSA6rsnLRfrCgif8Z+qwt1DWfiZbx/HB3hB8c=;
	b=qhRJDnhFwZ8TqHBneHsEk/GhVH6IcMx4DkFwxkYRORmpyHFxbK+5lV95z8vn2mBtXB4Z3m
	Yqc/WOnSPH0C+2Dw==
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 1/2] selftests/eventpoll: Add test for multiple waiters
Date: Sat, 30 May 2026 11:37:31 +0200
Message-ID: <3bdf0657811f04e257e508f221d72ff4a66f3f93.1780133499.git.namcao@linutronix.de>
In-Reply-To: <cover.1780133499.git.namcao@linutronix.de>
References: <cover.1780133499.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a test whichs creates 64 threads who all epoll_wait() on the same
eventpoll. The source eventfd is written but never read, therefore all the
threads should always see an EPOLLIN event.

This test fails because of a kernel bug, which will be fixed by a follow-up
commit.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 .../filesystems/epoll/epoll_wakeup_test.c     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c =
b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 8bc57a2ef966..f6f1a7ff01b0 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -3493,4 +3493,49 @@ TEST(epoll64)
 	close(ctx.sfd[1]);
 }
=20
+static void *epoll65_wait(void *ctx_)
+{
+	struct epoll_mtcontext *ctx =3D ctx_;
+	struct epoll_event event;
+
+	for (int i =3D 0; i < 100000; ++i) {
+		if (!epoll_wait(ctx->efd[0], &event, 1, 0))
+			return (void *)ENODATA;
+	}
+
+	return (void *)0;
+}
+
+TEST(epoll65)
+{
+	struct epoll_mtcontext ctx;
+	struct epoll_event event;
+	int64_t dummy_data =3D 99;
+	pthread_t threads[64];
+	uintptr_t ret;
+	int i, err;
+
+	ctx.efd[0] =3D epoll_create(1);
+	ASSERT_GE(ctx.efd[0], 0);
+	ctx.efd[1] =3D eventfd(0, 0);
+	ASSERT_GE(ctx.efd[1], 0);
+
+	event.events =3D EPOLLIN;
+	err =3D epoll_ctl(ctx.efd[0], EPOLL_CTL_ADD, ctx.efd[1], &event);
+	ASSERT_EQ(err, 0);
+
+	write(ctx.efd[1], &dummy_data, sizeof(dummy_data));
+
+	for (i =3D 0; i < ARRAY_SIZE(threads); ++i)
+		ASSERT_EQ(pthread_create(&threads[i], NULL, epoll65_wait, &ctx), 0);
+
+	for (i =3D 0; i < ARRAY_SIZE(threads); ++i) {
+		ASSERT_EQ(pthread_join(threads[i], (void **)&ret), 0);
+		ASSERT_EQ(ret, 0);
+	}
+
+	close(ctx.efd[0]);
+	close(ctx.efd[1]);
+}
+
 TEST_HARNESS_MAIN
--=20
2.47.3

