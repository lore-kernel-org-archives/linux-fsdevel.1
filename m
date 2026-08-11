Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924CA3B5302;
	Tue, 11 Aug 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462078; cv=none; b=OcwMuEck/vSDIHpxh01VuNTXpDUOGW4CCbkDa8I0v8OBPzej8T60mqnLA7mVf+/3+AWXCOCHT3njg78KihAcIH/1RISrgI3FuFbPLviPqdisDOhhQlyfbkHui8PGHR2MEPD7WwNiHmDvJy34zxFDSn0hZ+Sm7XGhppuLqUSEIyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462078; c=relaxed/simple;
	bh=eVMaTke3Zp4rPM/gpT2jPr6BY6R4nqbkomTRcFn86hM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dNqALU5DTo7ZJawbBf7DFTuF2oTenPsfshK3nLz/MBDjsuRzf4JFEHygQwYFwoRT39L1XHIihdGwCM4W0OjsSmWJjo4wmgQtr7OQvJcllEVJlOHnTK6JuFxmhj52x4WxpJZRuJlcjmG1Qc1g/Kr40halI8w/Ki3woj59L1kr4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jePYbKst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jePYbKst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01F91F00A3D;
	Tue, 11 Aug 2026 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786462077;
	bh=wC90oFJa7Ier1ZIhf5weT54crOnc3p7uwLYcRogSj00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jePYbKstnrnoDIjieNdlMvUl5SIrd0wrHkgAuTO3eaOIgdr7AFT4TKPO1sJIRxYin
	 TdSEGeMgruFr2uzZMrInAsZf9k89iH3drJCAnciUoAlKTFyGGyjkAzdy2dwvkfEylg
	 34xPZP/lsSRvTh3SgDH0B9nNEkYVkGN/3/iKEwC8WvX+4pFlLO7uZvaMwDaM8CYFZH
	 AtUdwbBKc4Y/5PRUTymt9mEOZpL8nl40HMdflIIq9AufEZ9p4YW0q09j0ETb+aMMca
	 aPYNbi3Y+rslqxcoKgcukBCTvhREbcu+IMUvI0wi0yI8JLhRjo2Ipexv6cRSgB/HkD
	 89Kz7qrNZtclw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 11 Aug 2026 17:27:26 +0200
Subject: [PATCH 05/11] coredump: deduplicate the to_skip flush
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-work-coredump-sparse-v1-5-cd3e8b1e356d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=brauner@kernel.org;
 h=from:subject:message-id; bh=eVMaTke3Zp4rPM/gpT2jPr6BY6R4nqbkomTRcFn86hM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRV2yecezmdOV++aOm/PzzVsc3bOO+z3+3x2j/NxrDwm
 52aZODMjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlk5jEybFbY9nK5xe7db/95
 HLnn+nh+v9jxeXf8VBRd7oTk/hJ2ZGRkOPP64DMLb48I+4n3d7LprE+21v4swH47QGiPXfgLIYY
 GHgA=
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
index e5463e3b3f4b..6de18bc49925 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1249,13 +1249,21 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	return __dump_emit(cprm, zeroes, nr);
 }
 
-int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
+/* Flush the accumulated hole before writing data. */
+static int dump_flush(struct coredump_params *cprm)
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
+	if (!dump_flush(cprm))
+		return 0;
 	return __dump_emit(cprm, addr, nr);
 }
 EXPORT_SYMBOL(dump_emit);
@@ -1284,11 +1292,8 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 	if (!page)
 		return 0;
 
-	if (cprm->to_skip) {
-		if (!__dump_skip(cprm, cprm->to_skip))
-			return 0;
-		cprm->to_skip = 0;
-	}
+	if (!dump_flush(cprm))
+		return 0;
 	if (cprm->written + PAGE_SIZE > cprm->limit)
 		return 0;
 	if (dump_interrupted())

-- 
2.53.0

