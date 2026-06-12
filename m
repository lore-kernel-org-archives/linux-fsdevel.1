Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453CF2FE066;
	Fri, 12 Jun 2026 06:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781246402; cv=none; b=BGZoPu2BqHNmtrNNSPJtmYFDlXwGge/zGZmawZZ3WzqfFEtvuZDZlhNaUucknlgGK7kDgzA10ShS8jB/IErE0q4NabDmFzFbPe9iZc8kKgZokGIPb/iM3+4QgyATOAPBVSftYqNMDtJ8WyTRZolgGTrr5260aHNzQ6JkV66sOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781246402; c=relaxed/simple;
	bh=/FMZmzisIYrYqAZV9o1QLgrZANzLbObETDZTDmiK4/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XTXYw/OJyl7ketsNncH20w2J2xFwUFEk/YCMp8zBPls+RYfm8Emec3WHhT3M7EEcPS77vsxyW9o/t+4BRDzLKoDDXJwVNA1IjwZri52hr2xELr6F9bTEjuZn30DAUzMHpFDZZctOp4xaD/NqU+suUII45tD+QTZ5sQ6/wE1XVmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWZgBnkZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWZgBnkZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA731C2BCB4;
	Fri, 12 Jun 2026 06:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781246401;
	bh=/FMZmzisIYrYqAZV9o1QLgrZANzLbObETDZTDmiK4/A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=IWZgBnkZ1D6Xuvh8XvVBzO7sNvPkkDb3IP0ahh3kHasiPw3ahynFHBXjnQob//rey
	 axnYS07sIAzZJtSgjS6oUqFXyoL+Vz2pQQVyXuYDMxm10/LMFvEm/mgS7ZxOqgZaBQ
	 s67fY3IPN5YRxxwSXuirT52l1A3EX/c37UWM0VO4T8YXDO/5n7XIFDE7sf2DW2BYLy
	 KQ7weQLgmCeKbfDX70r7KZiX6rCK4U9cZemFLxfClC31mTWnZi6IasJ4HJ/AOqEXpB
	 u+BbLSOp+Nhuoen5NTJkq3KI+I7nZ9aTI6+eMsop2c5uerPY8tvrwhskLk9dCZJJOo
	 9DxdoscJoUf1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA9CD98D5;
	Fri, 12 Jun 2026 06:40:01 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 12 Jun 2026 01:40:01 -0500
Subject: [PATCH] udf: validate sparing table length as an entry count, not
 a byte count
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-b4-disp-91780c4e-v1-1-f15112ff6882@proton.me>
X-B4-Tracking: v=1; b=H4sIAMCpK2oC/x3MQQqAIBBA0avErBtQMa2uEi00x5qNhUIE0t2Tl
 m/xf4VCmanA3FXIdHPhMzXIvoPtcGkn5NAMSigjjFToNQYuF07SjmLThNEPylltwhQitOzKFPn
 5l8v6vh+CZBI9YgAAAA==
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781246400; l=1995;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=zBe8mptXEujMyjU6qf+RIqq+0ZlZo1cMKaiqend5j20=;
 b=WeqmhVEN3wupw9o9mRFUUMvTq3vhpzEk39WiJnCSMVuHt7PGWYysDe+ok4w5S2ZGiQHdevz6s
 Jlj5N0Ea7tYBvy/QaKuPdBwTgdtD4u7TLZcYIYQXvZBAEs+PoZt2Jwc
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

udf_load_sparable_map() accepts a sparing table when

	sizeof(*st) + le16_to_cpu(st->reallocationTableLen) > sb->s_blocksize

is false, i.e. it treats reallocationTableLen as a number of BYTES that
must fit in the block.  But the table is walked as an array of 8-byte
sparingEntry elements:

	for (i = 0; i < le16_to_cpu(st->reallocationTableLen); i++) {
		struct sparingEntry *entry = &st->mapEntry[i];
		... entry->origLocation ...
	}

in udf_get_pblock_spar15() and udf_relocate_blocks().  A
reallocationTableLen of N therefore passes the check whenever
sizeof(*st) + N <= blocksize, yet the consumers index
sizeof(*st) + N * sizeof(struct sparingEntry) bytes -- up to ~8x the
block.  On a crafted UDF image this is an out-of-bounds read in
udf_get_pblock_spar15(); udf_relocate_blocks() additionally feeds the
same length to udf_update_tag(), whose crc_itu_t() reads far past the
block, and its memmove() through st->mapEntry[] is an out-of-bounds
write.

Validate reallocationTableLen as the entry count it is, with
struct_size().

Fixes: 1df2ae31c724 ("udf: Fortify loading of sparing table")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 fs/udf/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index cad2e15d633b..d75bfc733975 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1418,7 +1418,8 @@ static int udf_load_sparable_map(struct super_block *sb,
 		if (ident != 0 ||
 		    strncmp(st->sparingIdent.ident, UDF_ID_SPARING,
 			    strlen(UDF_ID_SPARING)) ||
-		    sizeof(*st) + le16_to_cpu(st->reallocationTableLen) >
+		    struct_size(st, mapEntry,
+				le16_to_cpu(st->reallocationTableLen)) >
 							sb->s_blocksize) {
 			brelse(bh);
 			continue;

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260612-b4-disp-91780c4e-fb52a746d9df

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


