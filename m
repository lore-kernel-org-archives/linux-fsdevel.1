Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793629044;
	b=ZOvzr+QYlc+0ZY1DO0aSfyjKxjY64PkhlLOn/AOMCXr9oZU5PgkmlNN4/+5VpJtAHQ7h
	 kpqEEewUNUvid9SaPZj0Gs/0CjkWs4LGLO7k7Tne3Oe+UOH0gxgOtvi/U0QBl56TbFdvt
	 XMn/nZOZBBJDuGbAGNINaZ9mcEVEWOy83wXSJSna7JUJ+NI+mhyEuEuS0ULw0kahEQE9o
	 XE9apZQeIXoxdmjzfNE4wznH34jkzul/nFuOj9rvfFmZQeg56EiCw1JQgKl1OllpVRSo5
	 8hM8toNqWa55a9j5XTuY0Lo+561wJZn/D1hOh0GzSPgPIkwFDV6aHjZMbpgy1ChIC8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629044;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=72eIKdcoHcSjaeNfWyReTenXL5eyw3RcNYR1V1ALc0s=;
	b=DLLjdovlgpbjjpYTlW4QdJG+yw85ZMN1mB+oMLHqBgLYgxjdB4KOG+D5G81TMaxTuUfi
	 VbeB39SfzZRVhZ4XbOf25DvP0T/NuRHZkqgWQtMFCuThpll7TeneGIgXAm9rPeHw/Kpmv
	 RCFRBfrUmYNg1bPc9ITzHmcz1yVNseidFEmNtZwXc1jUNi4lnMYfo0i0xEeFPvaC4PANi
	 iZSz6SG5JMGxlZSRRksXDDUpJjGbDTiqA1pND2lXB6zu60y+4P7QKQ7fyluoxijylf3Ru
	 Y96AwBjtuhs88SJ4K6VGDYd+7z+OBI3fws+5zm7lo3EmC42ZJZ/ghk9PSvVX3/zBliQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pinc-software.de;
	spf=pass smtp.mailfrom=pinc-software.de;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=NVhScJVg;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rO6QbZtT;
	arc=fail smtp.remote-ip=85.215.255.52
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119A606A33B;
	Mon,  2 Nov 2026 14:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C119A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pinc-software.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinc-software.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pinc-software.de header.i=@pinc-software.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=NVhScJVg;
	dkim=pass header.d=pinc-software.de header.i=@pinc-software.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=rO6QbZtT
ARC-Seal: i=1; a=rsa-sha256; t=1793629035; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i6RpYNOmT+OwQSCmAWoX2gw2XUBHcmMPi3skdJoxxZMpJYfd4EgyxeIbzuBOdM0Bkx
    +JBfDWyMJuTClTOLic0p0bweWqUk0f7lBxBiGj1N0HQ+QbI3eQhCtrPkBW8fxQDkQ+it
    W1hzmadEc5vVR7w0uVW+mck3afWuFOb8zdGUQ4u9nqoyjs/ubEu76fKFDqhn5SPbPLVz
    nSdvdyc2bixRcmarQLeJJspdgJMg0pLxjPx5tU14hWegEC4NigNpn+f9pz/TX09/e5ZT
    djYW3KbM0BTMGRyQ2Krkcjf0+gxM8QEclU82ERIqJ2pySR83WA2R4tmADtTqYXv78Hdr
    x2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793629035;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=72eIKdcoHcSjaeNfWyReTenXL5eyw3RcNYR1V1ALc0s=;
    b=Tef7ZWXo3w/u+iJg5euY+Qa5Qeu2zTQjrTSERtaVqTmpZaqc8ZESs8uFhd6tN9T4kK
    yPR7PctXl+gaoH/TMV5L1xi3TtCdZz9xNH9ytZaBvMYC2L6by6cTFOvJWJNH8jYmg0/0
    co5JKWqoM4ppKkc+ZbFRSV28VSDYMlwz/dimN5Hh06b9BXM2JGMnxTBRHYdSpkRbwbaa
    cYMSknhyNsIny6IOupgQj1mLNlYWK5OCzEq8gwWUk5ZO+SUieBpXvuBBK5n4F7TgkdAB
    mA22UdpZDMBRSTu7ql13a6c5K8WyGzZW4L1FpFQ6zUEvRSFqDfCXydIvjNZmJdJFoYQi
    4xOA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793629035;
    s=strato-dkim-0002; d=pinc-software.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=72eIKdcoHcSjaeNfWyReTenXL5eyw3RcNYR1V1ALc0s=;
    b=NVhScJVgjXceXEb6RNEwZGV+6p6ZDoL/Ci+jVDasvGM6PnlXW031yDwNWs+OZDKyOH
    QcnT/no/xJctCgCdQ8y1yYrPaCF7FDm+CVAec//Osp/VrEBi4lPZ4wLe0NiiD2a65ds6
    Fy8BAdIJvzoBbb35fPr4gMoA37bfMD8w8RTlSVH1IQVBKyIh6kBNUssAGbCfjXW9SuHo
    N9/Vl+tLjHJlaiKVgIjzczSEtEp3spQj3gfLS4eYQjYZ8Gp/ABFSXQgrEFCdUv/cnRCo
    Ldqm5Q6EFNmTSnKVeM7N3/m9/mRhmM7YdDBrWatAdQ7aetYzZG/sQgBq4G8J1qEA4sB8
    XQiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793629035;
    s=strato-dkim-0003; d=pinc-software.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=72eIKdcoHcSjaeNfWyReTenXL5eyw3RcNYR1V1ALc0s=;
    b=rO6QbZtTR7dDjkD7He5NHtlwnlMi83zcythRLlbcRs/XwhLK2zkKBzAhoNuEAIxgs2
    gs22R7RRgO55VpwKkeBg==
X-RZG-AUTH: ":LXQBeUSIa/ZoedDIRs9YOPxY4/Y41LMYtYgA+S704E62CSg2BLG6dk+k8/0cpS1xrQjovw=="
Received: from phoenix.fritz.box
    by smtp.strato.de (RZmta 55.6.3 DYNA|AUTH)
    with ESMTPSA id a2f6e42A2EHEALJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 2 Nov 2026 15:17:14 +0100 (CET)
From: =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
To: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] befs: Fix allocation group consistency check
Date: Mon,  2 Nov 2026 15:17:13 +0100
Message-ID: <20261102141714.306719-3-axeld@pinc-software.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102141714.306719-1-axeld@pinc-software.de>
References: <20261102141714.306719-1-axeld@pinc-software.de>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

befs_check_sb() complains if (1 << ag_shift) != blocks_per_ag, but the
two fields do not describe the same thing: ag_shift is the log2 of the
number of blocks in an allocation group (which is also how befs uses it
to convert between inode addresses and block numbers), while
blocks_per_ag is the number of bitmap blocks per allocation group.

As a result, the check triggers on basically every valid volume.

Replace it with the check the BFS reference implementation uses: the
number of allocation groups must match the number of blocks divided by
the allocation group size, rounded up. Also reject ag_shift values
larger than 16: the start of a block_run within an allocation group is
only 16 bits wide, so larger allocation groups cannot be addressed, and
such values could otherwise make the shifts in iaddr2blockno() and
blockno2iaddr(), and the division in the new check, misbehave.

Like the other structural checks in befs_check_sb(), a mismatch now
fails the mount instead of only printing an error.

Signed-off-by: Axel Dörfler <axeld@pinc-software.de>
---

Notes:
    v2:
    - Replace the incorrect check with the one from the BFS reference
      implementation instead of just removing it, and limit ag_shift to
      what a block_run can address.
    - Explain what ag_shift and blocks_per_ag actually mean.

 fs/befs/super.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/befs/super.c b/fs/befs/super.c
index 7c50025c99d8..6496b4d9338c 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -99,12 +99,24 @@ befs_check_sb(struct super_block *sb)
 		return BEFS_ERR;
 	}
 
-
-	/* ag_shift also encodes the same information as blocks_per_ag in a
-	 * different way, non-fatal consistency check
+	/*
+	 * ag_shift is the log2 of the number of blocks in an allocation
+	 * group, so it determines how many allocation groups are needed to
+	 * cover all blocks of the file system. Since the start of a block
+	 * run within an allocation group is only 16 bits wide, an allocation
+	 * group cannot have more than 65536 blocks.
 	 */
-	if ((1 << befs_sb->ag_shift) != befs_sb->blocks_per_ag)
-		befs_error(sb, "ag_shift disagrees with blocks_per_ag.");
+
+	if (befs_sb->ag_shift < 1 || befs_sb->ag_shift > 16) {
+		befs_error(sb, "invalid ag_shift: %u", befs_sb->ag_shift);
+		return BEFS_ERR;
+	}
+
+	if (DIV_ROUND_UP_ULL(befs_sb->num_blocks, 1ULL << befs_sb->ag_shift) !=
+	    befs_sb->num_ags) {
+		befs_error(sb, "num_ags disagrees with num_blocks and ag_shift");
+		return BEFS_ERR;
+	}
 
 	if (befs_sb->log_start != befs_sb->log_end ||
 	    befs_sb->flags == BEFS_DIRTY) {
-- 
2.56.0

