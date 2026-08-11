Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E53B8945;
	Tue, 11 Aug 2026 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462102; cv=none; b=jwBWqxM1HrCm5l7/z/cb6uxgRFIo6jV4ZkgWNq2dgaArsEK7RFK4daN5kQO2JX4hks4gPTPaw17XOUBR6yEXHPYiTxMN8/0FBsnGl0FjtS6SPAbroZNkF1WWn48Eqpr85s65/YGGrRkEALKxVmGKA2gozCqs95BpuenDaaMt1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462102; c=relaxed/simple;
	bh=ZREoaOSeNd4qGwZma6jQbBcL6Gnn8lrPJS0/WXVe/dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cal/QehVQlWr+v+zlJOkA2p0Oh5e4SktWA4b7jC/5VkUkQ2Ua0rlKRXfbxeUsnb7WhezXKJE4qZ5VsDeMLskavdFXfVmfdwXf3dEs0GaApkA6sdHgQ+HAW6q/25ZnkHrJ6+/i/9iDkLfy4Guf4MR64igTxikoh+g5lOQEC1rR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mb9S3/Uu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mb9S3/Uu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111561F000E9;
	Tue, 11 Aug 2026 15:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462100;
	bh=PxUCP2iDYTzzrW7IUVfims64s4a5dm9b+PmFryUZrZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Mb9S3/UuLLKJmdNADIKN4evkrOh/0EM77aCNrmNn633IfCAUbYFAxtYpdMaXve6am
	 YxJ+hQYiJVAPpvYEDPlXZN/Pam5Fh62zyP5Pqj2uetgNrxWIFNqdtSZn06pJvluFem
	 ukBxj9q5MRxR1PPdhIJ10WbiCM4eIJUvq3p3Cqm2VMgn078PEr8LRNVqGKEwAXMgGn
	 gtssV3mDKmP80P5EBQtpjqj/zEvfpXVhrVNCuZC/suMFbE0NgJmYrLIEZYOkM8Nsq9
	 gYKR0wu6cKCTCIPBQxvUQFlXWp6IZPlb6Pv2rUxP9SCm7WD5l31dNFtkqXNbPd1WcT
	 Khn/HCmSQNcNw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:31 +0200
Subject: [PATCH 10/11] coredump: describe the holes when COREDUMP_SPARSE is
 negotiated
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-10-cd3e8b1e356d@kernel.org>
References: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
In-Reply-To: <20260811-work-coredump-sparse-v1-0-cd3e8b1e356d@kernel.org>
To: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3730; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZREoaOSeNd4qGwZma6jQbBcL6Gnn8lrPJS0/WXVe/dw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2yfULnTvMQy5H/pvOYOhvdqC1Y7mYRd3aoYlG2/M/
 HT9QJVSRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQUzjIy9DF+ztB4382XpKfD
 tyKd353h6EQ/x3kM2gX6EpJaPlMXMjJ8OrvFTP3VHUExebEJF2tsphmdO/cobtXuKI105e6Z55n
 4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Offer COREDUMP_SPARSE in coredump_req->mask now that there is something
behind it. Refuse it without COREDUMP_HEADER. A zero frame cannot exist
outside a framed stream.

A trailing hole is flushed by coredump_write() the way it always was. So
its last byte goes out as a one-byte data frame and the frames cover the
whole coredump.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                                      | 34 +++++++++++++++++++++-
 .../selftests/coredump/coredump_test_helpers.c     |  3 +-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 364c89c5f82a..bdf2eae948d0 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -799,7 +799,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		.size		= sizeof(struct coredump_req),
 		.mask		= COREDUMP_KERNEL | COREDUMP_USERSPACE |
 				  COREDUMP_REJECT | COREDUMP_WAIT |
-				  COREDUMP_HEADER,
+				  COREDUMP_HEADER | COREDUMP_SPARSE,
 		.size_ack	= sizeof(struct coredump_ack),
 	};
 	struct coredump_ack ack = {};
@@ -854,6 +854,12 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
+	/* Zero frames only exist inside a framed stream. */
+	if ((ack.mask & COREDUMP_SPARSE) && !(ack.mask & COREDUMP_HEADER)) {
+		coredump_sock_mark(cprm->file, COREDUMP_MARK_CONFLICTING);
+		return false;
+	}
+
 	if (ack.spare) {
 		coredump_sock_mark(cprm->file, COREDUMP_MARK_UNSUPPORTED);
 		return false;
@@ -1229,6 +1235,11 @@ static bool dump_framed(const struct coredump_params *cprm)
 	return cprm->mask & COREDUMP_HEADER;
 }
 
+static bool dump_sparse(const struct coredump_params *cprm)
+{
+	return cprm->mask & COREDUMP_SPARSE;
+}
+
 /* Describe the next @len bytes of the coredump. Returns the header size. */
 static size_t dump_frame_init(struct coredump_params *cprm,
 			      enum coredump_frame_type type, u64 len)
@@ -1292,11 +1303,32 @@ static int __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	return dump_write_iter(cprm, &iter, nr);
 }
 
+/* Hand the server the length of the hole instead of the hole itself. */
+static int dump_skip_frame(struct coredump_params *cprm, size_t nr)
+{
+	struct kvec kvec;
+	struct iov_iter iter;
+	size_t hdr;
+
+	if (dump_interrupted())
+		return 0;
+
+	hdr = dump_frame_init(cprm, COREDUMP_FRAME_ZERO, nr);
+	kvec.iov_base = cprm->frame;
+	kvec.iov_len = hdr;
+	iov_iter_kvec(&iter, ITER_SOURCE, &kvec, 1, hdr);
+
+	return dump_write_iter(cprm, &iter, nr);
+}
+
 static int __dump_skip(struct coredump_params *cprm, size_t nr)
 {
 	static char zeroes[PAGE_SIZE];
 	struct file *file = cprm->file;
 
+	if (dump_sparse(cprm))
+		return dump_skip_frame(cprm, nr);
+
 	if (file->f_mode & FMODE_LSEEK) {
 		if (dump_interrupted() || vfs_llseek(file, nr, SEEK_CUR) < 0)
 			return 0;
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index bfe10bc51618..ee669969605b 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -290,7 +290,8 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
 /* Every option the kernel is expected to advertise in coredump_req->mask. */
 #define COREDUMP_REQ_MASK_ALL					\
 	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
-	 COREDUMP_REJECT | COREDUMP_WAIT | COREDUMP_HEADER)
+	 COREDUMP_REJECT | COREDUMP_WAIT |			\
+	 COREDUMP_HEADER | COREDUMP_SPARSE)
 
 bool check_coredump_req(const struct coredump_req *req)
 {

-- 
2.53.0

