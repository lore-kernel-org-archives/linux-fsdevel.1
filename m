Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB483EBF16;
	Wed, 19 Aug 2026 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181058; cv=none; b=QiralCH0ElwfU2nBfxh9mbOECsEBnHza7BQlQnjvGM6HvNbOGlLGFahNWaj66J8Oqj3jsZFFmFuVWlySMEmL/0NO0uivb857XBoAEXE1ShnWcMpPng/hsfnrLkcflUbJLhT1J4o1GaYGPPJPn6VqhojvvEgIc73FZlR8j0Jgsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181058; c=relaxed/simple;
	bh=6lmk01oIrCpLddgF34l1qNeK7azUHFnu6/y3MNvc9fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBWHWU0yykrHopmc3UsfDyTm3d3eVoopppoH137CKBxLStBgvZxlLLiCQCy7DKOE4YkErG4mNHmQL3u4Jnj7ZzOfPn/pKnBTH0PJHG5aBs5zdZR/rxkqIZ8e9GUPFSedKXACaTRBU6NXBmm5RDXoD87joFu/IJDQoE75VssZekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7ly3cBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7ly3cBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17171F00A3D;
	Wed, 19 Aug 2026 23:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181057;
	bh=dfXAgoL+9LBeM/3gsj9qXNECM/y7xKAoBOAjrqptYLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=h7ly3cBXNdZl7hnrgTxPREaO8oFEfhc6DvRM7kPLZVg7S7AYOKvbSlD9lhr61Eply
	 6jOr4ONLrlIllToPvALfSQHXVeXm6QkRDJsyAJAwXh0P5oEm1qTk3f2Ur8CZH0XB31
	 QU++l1mZjfVPwqPjieBgTtwk3lSZCIwowoSOdYaXBlHHSg7sC04B1d8XT23AUS4xlr
	 pg+jQwMlNP1UfKYn/aeN27+I0aDebskxj5YMCLCEG6QgxJeBSAKlu8gf8J/9gscEcQ
	 WfK2J0wv1iUVT5UsUTnDaFTNMGeJE2I63alCUTI+iAxn3wJb323FOgOGRANuP8CQk2
	 RcEKGSk7x5o2A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:28 +0200
Subject: [PATCH v2 11/22] coredump: always chunk writes
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-11-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3072; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6lmk01oIrCpLddgF34l1qNeK7azUHFnu6/y3MNvc9fs=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGqGN7+jKg8nZ84IvdAkuVaAv3pB/3A8P2ohgfbcn0M9u/3qY
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmqGN78ACgkQkcYbwGV43KIysgD/a+/5
 REHHWLX+2VlcBK70uw4E+bPFY60zOkDXluZRbuoBAKZwJlYA6NSqs/oHBznLIQErTWGeszoobly
 JDQFMN1YJ
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Right now dump_emit() is the only coredump helper that writes buffers
larger than a page in one call. For elf notes that can easily blow past
PAGE_SIZE. That's annoying because neither pipes nor af_unix sockets
take such writes in one piece.

If a signal arrives while the writer is waiting they drop a short write.
With the coredump records work coming up that means header and its data
are desynchronized. A write that fits in one pipe buffer or one skb
doesn't suffer from this.

So split all writes up, including elf notes, and cap every write at a
page. The coredump socket already raises sk_sndbuf far enough for a page
to fit a single skb and pipes always work that way.

That means dump_interrupted() is now checked once per page. So a large
coredump stops earlier (good). An empty write no longer issues a
zero-length write. The rlimit core check stays where it was. It
continues refusing whole writes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d837819031ff..d61f36239f91 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1215,19 +1215,21 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
  * do on a core-file: use only these functions to write out all the
  * necessary info.
  */
-static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+/* One write, never more than a page. See __dump_emit(). */
+static bool dump_emit_chunk(struct coredump_params *cprm, const void *addr,
+			    int nr)
 {
 	struct file *file = cprm->file;
 	loff_t pos = file->f_pos;
 	ssize_t n;
 
-	if (cprm->written + nr > cprm->limit)
-		return false;
 	if (dump_interrupted())
 		return false;
+
 	n = __kernel_write(file, addr, nr, &pos);
 	if (n != nr)
 		return false;
+
 	file->f_pos = pos;
 	cprm->written += n;
 	cprm->pos += n;
@@ -1235,6 +1237,24 @@ static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 	return true;
 }
 
+static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+{
+	if (cprm->written + nr > cprm->limit)
+		return false;
+
+	while (nr) {
+		int chunk = min_t(int, nr, PAGE_SIZE);
+
+		if (!dump_emit_chunk(cprm, addr, chunk))
+			return false;
+
+		addr += chunk;
+		nr -= chunk;
+	}
+
+	return true;
+}
+
 static bool __dump_skip(struct coredump_params *cprm, size_t nr)
 {
 	static char zeroes[PAGE_SIZE];
@@ -1247,13 +1267,16 @@ static bool __dump_skip(struct coredump_params *cprm, size_t nr)
 		return true;
 	}
 
-	while (nr > PAGE_SIZE) {
-		if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
+	while (nr) {
+		size_t chunk = min_t(size_t, nr, PAGE_SIZE);
+
+		if (!__dump_emit(cprm, zeroes, chunk))
 			return false;
-		nr -= PAGE_SIZE;
+
+		nr -= chunk;
 	}
 
-	return __dump_emit(cprm, zeroes, nr);
+	return true;
 }
 
 /* Flush the accumulated hole before writing data. */

-- 
2.53.0

