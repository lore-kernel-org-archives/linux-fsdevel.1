Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD73E49F0;
	Wed, 19 Aug 2026 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181046; cv=none; b=EmX9SmzAMTuqTFFB8Qk2TL9u56ht335fAyFRPwt4YqDSjok5ucvD8Vm81yFGCmcbQsOQvWM+z086gXmlbCKjwsj7Z2PjkMQ8zxCTJa+Y+GDCaTgQZezLsXkviEGw8zcWG8OL56c0cgK59WsSIYwnoqBV4rUa3cwJEWZDeiYnlqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181046; c=relaxed/simple;
	bh=QcTKefttEJ4tcHQFZJxvLhTEIvEaSI31GPP914rVvoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fb9tu7y6vtZhmspOMPCcAehg19L6d5x2Llc/TTmhZCVpADnWMXu+Wtc4mY7joX+0S1x3LzRisPNEx8YCsLBB06ZOrNAwXMEzfY2voj+u4jFvAYNf63djvkFqj8ymJg9qBfa9xz5YQWxNLJKQkmJwjku/QGbhHgkdPf48MUId4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npJLhXeQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npJLhXeQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76061F00A3A;
	Wed, 19 Aug 2026 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181045;
	bh=aXCeFRO1r0hB0+8jo/097AeX5zU9p1RIeHyMY6Gqagw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=npJLhXeQ/IhG/+xAo/mjKtSc3G9BXlgXjQH4PjRqutdnX5peq2Nb0g350sJgmLW31
	 s7nW1fZTCAWEOV02aDamCCA7OnVHMt3/8PYOv+2ooyKorkp92y3M1IbvY+2VOhnn3c
	 Rql9x/J8AT1PJmW7lYRZFVbrrxMjFU6ss2GHkylFXuw9vHwOhtyccBcOiHWKseSBir
	 bDadGtBVR5S+Y0CToo2UjrcVSJgqPxHoB1NfH4+TIfRbf1uuSnt9x0aJmbxBdMndTY
	 Bdf2XQEqKWgZ/t9qiKUtbN/s0s3uiyg5QyQMLAkfn34/IOWtw3b+svvtxJyFoPE6QJ
	 5WVqP1YzDqhwg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:26 +0200
Subject: [PATCH v2 09/22] coredump: deduplicate the to_skip flush
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-9-ba32dd718c51@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1473; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QcTKefttEJ4tcHQFZJxvLhTEIvEaSI31GPP914rVvoI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me/b2di18GR/1eFdZf0CM6pf/jhn7NE3o91oG/ulh
 feNfzwQ6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiI/1WGfyrqXP6z/RRY9dJf
 npzw5vKU39nneQTWthU/DeTov3ansoXhn+LSGdNrfecfqOB3WFNjfEAna8Jk5fzD2TenGXde8Th
 8lR0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

dump_emit() and dump_emit_page() open-code the same flush of the
accumulated cprm->to_skip. Move it into a helper.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 156688be3df0..cd36a72be445 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1256,13 +1256,21 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	return __dump_emit(cprm, zeroes, nr);
 }
 
-int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+/* Flush the accumulated hole before writing data. */
+static int dump_flush_skip(struct coredump_params *cprm)
 {
 	if (cprm->to_skip) {
 		if (!__dump_skip(cprm, cprm->to_skip))
 			return 0;
 		cprm->to_skip = 0;
 	}
+	return 1;
+}
+
+int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+{
+	if (!dump_flush_skip(cprm))
+		return 0;
 	return __dump_emit(cprm, addr, nr);
 }
 EXPORT_SYMBOL(dump_emit);
@@ -1293,11 +1301,8 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	if (!page)
 		return 0;
 
-	if (cprm->to_skip) {
-		if (!__dump_skip(cprm, cprm->to_skip))
-			return 0;
-		cprm->to_skip = 0;
-	}
+	if (!dump_flush_skip(cprm))
+		return 0;
 	if (cprm->written + PAGE_SIZE > cprm->limit)
 		return 0;
 	if (dump_interrupted())

-- 
2.53.0

