Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795752544;
	b=cvtsbwZlKVLTXXOfH8jqrzojgGxNG1DCXDofPxshv9JUFSU99+nDIJhzyTU+7DLwAuPP
	 Coi2BQAL9oyUMaLaLRR9StJRdclIqIFYKojwLD8ndECmQRI88PdRqjeLAMyU1ijmEtZQ2
	 P3lzf7vqmr0ZvWrpdFLXQlq/WuLJE1gvghDIvOZQwyYabrT5zm2zv/5QlGbDZRYgezKm5
	 Qlx4nasT8KMmW+nSJpP9PK9LzWoUKW0efDoKQ3m/mDYPiC/Y+KJ2Yg2ypzz9TS4yh63T1
	 74Qkx1VYFfcmIuSy5sZLZBs6FpYK7LkSX0zEwZREsl8a0ls56hwXY6+oSvWofjV9ejQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795752544;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jaMTV5zX0PIAiuhK706pc5SSpEkmxr31qNU70BT6xS0=;
	b=rAZqkKWGUmshTBifc+XXDc9pgRoMWgUq0jKK1QNJXOrhEZR1HNg72tGw8+o9nLVCOyfb
	 jXO7bnFlv/A8Ua47bf+RGMQOzQcUp9zl0oVS1N4qhrt1qVFiNtin+BOMEXkeWTSylokkA
	 qnv+SFGXcDFX9gr2+tgS+VB5uWUUfi7PRdmbu6lPMsd9pEW/4HlTFHLeJ7nNm/JAMUNrk
	 AKzxNuokaRguT/n9U/3B/to3Vc0DlufgP5aVQeQMeEFItqogMEKhSL6fLYOwiyQo4ZRBN
	 /XrRZNMDB44vs4bqWkCKgo5yY2xnbBHqyaODskI8XPK7qsQ/iUEUv1rXbHkYOpkt4ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N60RVhpa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA7606A327;
	Fri, 27 Nov 2026 04:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N60RVhpa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795752543;
	b=c0PE9QQDZ2qMLUjhzUFb26M3mmZk9UyzniIFIviIljfAW70AW2fm3YvKWvWuPyK4Bdt5
	 eEtiEiW6sjhhTnp31k06DnGCxywz2Ooa197ZI/etnWQGR2kJtlbxGmZL7sxuZuEzZ71t7
	 /NvQonsl+tg9dM92i9orQ8jab+npNBwbbr/A33XNyY6tkWGClIzedmKbEZn49nswmTeY4
	 oXp/n87fgc6J2LHpAsZYwRtxV7VYdAXuu5atrCOgA0PoYNXhvoCuN5BHPw/v4y+H5rywI
	 QmAh8c8XxhbpLrZuzI1nmbqp5SJydPqpy+hBvpwkInvmM4VLEGaKqImvny5qpSjM/ww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795752543;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jaMTV5zX0PIAiuhK706pc5SSpEkmxr31qNU70BT6xS0=;
	b=BaYFGX25JvJZfMSjYtuNfo1iV6a+zsKJc26orkWOSujI/wKU3ZZ6SuGcI01DZwZgGtWK
	 QqzimrtlrxqzlqARiqEJ6/Tb5egwCoUIlPPIYxNs7qqUDTzIhx7e3HdUmHCHzGvqmGwpM
	 3fKXdO08p7ADlDFZd4SPKfhBNCqqrPRXb6OBfBeTVW0nfoXsaU4fk0ARYzp02D8TwidDV
	 XT5qP6brdDBwyx7qch+MwW881VoRstTJxvwMY9qb6Y+QoPZUQlCK3NeT7C4gebmLol6K4
	 3PxoR79PPUqmOyr70fhyMU16wUjs5j5J7inHQ/MjsCWFnJCWUQx7m4wiwQb+mlHyK6g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6BFF11F00927;
	Fri, 27 Nov 2026 04:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795752543;
	bh=jaMTV5zX0PIAiuhK706pc5SSpEkmxr31qNU70BT6xS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=N60RVhpaxVwtfJbr3N85ArsZvVd0MIyxBg9Ol+Yx3rGAuASbAJq1Tn7phhu+RzsYC
	 C2BZ9C22Io78jT1iunZz0VPLBAqwFQh9NpRlBdTjxAbPPy41xSv1gSXLKWyPkksp/U
	 UyGC/2ha3T6RX683lzs0qQD/5kjar5/fH9sgaoisLn3NyhaNVUL+dLz9yHAzOWMEdz
	 eJbBna2aEkg8onWbA+f5E9BSls9JXasEAFwfo52Ft4XWdLvxd3Lyv8IK20a4aMso6v
	 xnJTkCneNpx4TsbHd56x5ux7n+1cPGpj1NIuXXmG5Nk7olLDIT+JPJKw3j0pYl+JS9
	 yClV7kZd1rddA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EF6994B561;
	Fri, 27 Nov 2026 04:08:51 +0000 (UTC)
From: David Crawshaw via B4 Relay <devnull+david.exe.dev@kernel.org>
Date: Fri, 27 Nov 2026 04:08:40 +0000
Subject: [PATCH 2/2] selftests/fuse: test a write extending the file beside
 writeback of the EOF page
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-b4-fuse-wt-eof-v1-2-e055e2af652d@exe.dev>
References: <20261127-b4-fuse-wt-eof-v1-0-e055e2af652d@exe.dev>
In-Reply-To: <20261127-b4-fuse-wt-eof-v1-0-e055e2af652d@exe.dev>
To: Miklos Szeredi <miklos@szeredi.hu>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Joanne Koong <joannelkoong@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: fuse-devel@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev, 
 David Crawshaw <david@exe.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795752531; l=3427;
 i=david@exe.dev; s=20261127; h=from:subject:message-id;
 bh=qOOaxwLFrTNcXJw6jwuVCpa0ioptdiRJjfw7LoJ36Lo=;
 b=lUPu83Z510dHQTNWuk9cevLfzHjsmK7gaY92o0YHNjiKjFxSVcDPgRoVktzevq2e/LUTUP+vs
 Kw2OR1BGXmUCM+tFUal4usiKBneN/Kx+87y6ynTAS0uu/Ysqp7RYc4G
X-Developer-Key: i=david@exe.dev; a=ed25519;
 pk=eQfKiR9S2peqiHuuNGCAaWlxwP+RerhKT2wVxakCrjQ=
X-Endpoint-Received: by B4 Relay for david@exe.dev/20261127 with
 auth_id=1661
X-Original-From: David Crawshaw <david@exe.dev>
Reply-To: david@exe.dev
Content-Transfer-Encoding: 7bit

From: David Crawshaw <david@exe.dev>

Add a case to write_extend_eof_test: while a pwrite() that extends the
file inside its mmap-dirtied EOF page is held by the server, write that
page back with sync_file_range().  The written data must be in the page
cache afterwards, and on the server after fsync().

Written with an AI coding assistant (Shelley using Opus 5.5).

Signed-off-by: David Crawshaw <david@exe.dev>
---
 .../filesystems/fuse/write_extend_eof_test.c       | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/filesystems/fuse/write_extend_eof_test.c b/tools/testing/selftests/filesystems/fuse/write_extend_eof_test.c
index d6d5de8dac2..cdefe459359 100644
--- a/tools/testing/selftests/filesystems/fuse/write_extend_eof_test.c
+++ b/tools/testing/selftests/filesystems/fuse/write_extend_eof_test.c
@@ -57,6 +57,8 @@ struct backing_file {
 struct server {
 	int fd;
 	unsigned int copy_ops;			/* FUSE_COPY_FILE_RANGE* seen */
+	uint64_t hold_off;			/* delay the WRITE at this offset */
+	int held;				/* ... and set this when it came */
 	struct backing_file file[2];		/* FILE_INO, SRC_INO */
 };
 
@@ -179,6 +181,13 @@ static void *server_thread(void *arg)
 			uint64_t off = in->offset;
 			uint32_t size = in->size;
 
+			/* Leave time for writeback while the write is pending. */
+			if (s->hold_off && off == s->hold_off &&
+			    !(in->write_flags & FUSE_WRITE_CACHE)) {
+				__atomic_store_n(&s->held, 1, __ATOMIC_SEQ_CST);
+				usleep(200 * 1000);
+			}
+
 			if (off < BACKING_SIZE) {
 				uint32_t c = size;
 
@@ -472,4 +481,66 @@ TEST_F(fuse, extend_into_eof_page_preserves_data)
 	free(rd);
 }
 
+struct writeback_args {
+	struct server *srv;
+	char *map;
+	int fd;
+	off_t base;
+	long page;
+};
+
+/* Once the extending WRITE is pending, dirty the EOF page and write it back. */
+static void *writeback_thread(void *arg)
+{
+	struct writeback_args *a = arg;
+	int i;
+
+	for (i = 0; i < 5000; i++) {
+		if (__atomic_load_n(&a->srv->held, __ATOMIC_SEQ_CST))
+			break;
+		usleep(1000);
+	}
+	a->map[a->page - 1] = 1;
+	sync_file_range(a->fd, a->base, a->page, SYNC_FILE_RANGE_WRITE);
+	return NULL;
+}
+
+/*
+ * Writeback of the mmap-dirtied EOF page that starts while a write extending
+ * the file within that page is in flight must not zero the written data:
+ * the write has copied it into the page cache, but i_size is only updated
+ * once the server has replied, and writeback zeroes the page past i_size.
+ */
+TEST_F(fuse, extend_beside_writeback)
+{
+	struct writeback_args a;
+	pthread_t t;
+	off_t base, wr;
+	char rd[4];
+
+	pollute_eof_tail(_metadata, self);
+	base = self->eof & ~(self->page - 1);
+	wr = self->eof + 100;			/* in the EOF page, past EOF */
+	ASSERT_LT(wr + 4, base + self->page);
+
+	a.srv = self->srv;
+	a.map = self->map;
+	a.fd = self->fd;
+	a.base = base;
+	a.page = self->page;
+	self->srv->hold_off = wr;
+	ASSERT_EQ(0, pthread_create(&t, NULL, writeback_thread, &a));
+
+	ASSERT_EQ(4, pwrite(self->fd, "data", 4, wr));
+	pthread_join(t, NULL);
+	ASSERT_EQ(1, self->srv->held);
+
+	ASSERT_EQ(4, pread(self->fd, rd, 4, wr));
+	ASSERT_EQ(0, memcmp(rd, "data", 4));
+
+	ASSERT_EQ(0, fsync(self->fd));
+	ASSERT_EQ(wr + 4, self->srv->file[0].size);
+	ASSERT_EQ(0, memcmp(self->srv->file[0].data + wr, "data", 4));
+}
+
 TEST_HARNESS_MAIN

-- 
2.43.0


