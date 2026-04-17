Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23EA13D503
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776468790; cv=none; b=UtRDEn+7oEM/3nxV99ipUpnMaNoEINPQSJKOm3DhKXfnUPuDkpJZSHdaPoRefGTfqN6qHL19d0aY69g85fwV88MuWa188xIbHRbkTwieiYW99IRNUHqpXcbIdNx698/DBaimzR1vaNh5c2KOX0Eb/tAEvVMG+0l1xlPciJfRtKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776468790; c=relaxed/simple;
	bh=ZEi/cXh1iFeFEuzHRRsXi1pBdEeLdy+9xs/YHLYCT44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RCv4Jc3S36Neezm870oiTZ9k64Zy3ubBEvudvrhWFHdPpeJ58C/eO7Qg8cBapgWgqnvt1gbxTbccEkyhk2NXPB7ypJYjzsemPeLLxjdLn4N23UV0YMWtrz8OSN1/LohLlMG5ddh7pjFVa+etojhz+dMNrGliidFUJICgUAs6Ob4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY5tAm08; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY5tAm08"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89fc4147f2eso12890336d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776468788; x=1777073588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWzyw9UpnNiqz+F9Ms8EKKcgZP/weNGJV02JLocqn4U=;
        b=MY5tAm08ngFSWDjHG8LvsI7Q6wIdyJmV/q8DcV/OrEkObP6pemxhDaWMU0k0GkJATt
         uPGVY83zP+44LN1haqKnZX2ySZlR5kQdPdJ/D7GCZ6CMbiaG10dJ71ILTDAVuGJK0Og3
         iI7Gd4EFYqfSurMBI9JGn/pS8kyBs0UaTn0vBGd6rNemwdxl1Vy3vxRvGGwpL8X0tY5n
         d33Ky/A9wXYNZtmvZF0S6V7nSWvxzXEMMXUR1Wc+VrmC+GTbx4kcYZKyobJLELKn1sIY
         572Oelsgkcry/DXP+FJYJizZThP1A7VpAgrneRce7l/assX2mXIoFpwOp5tIst2JJX4u
         VBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776468788; x=1777073588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWzyw9UpnNiqz+F9Ms8EKKcgZP/weNGJV02JLocqn4U=;
        b=ixWDLcCSsoHKVfuGPkIFlnzyw8fSfb6IHR0sHck7fMgJ+pTkDjwPdtXn711OmlOLUV
         UvvyGlRRZWYc8KPaFFxKDRPD/8OoLXKKhiW1YeSe78muJ6dehkDwfd2rQkUevXBtHCe8
         pUsmepI5XNAWAZSCLEZQmDfYh20u6y+CUeO5Gwi9tUSKGJleGJw4mcFs7BcWCKMTn0ij
         uySPxyjYjFphGvoVdA1NN1TTyKvWGzwdaJuMSsV8LjzH81aXV9GM5MRp7uSM9e4kcv2Q
         bS6wLtYBgnrjiMPgj+w+VFBe4Dv/KbflRbnwiGln1HW7mQPE/UGD3hHCARvr4aI267gN
         A+fA==
X-Forwarded-Encrypted: i=1; AFNElJ/k2/PK/AcovGhP/TAOi1kqcgwQ0ur4g3w/t8lJxJHXHe2sMqecXK59ti/8NyN4kEiD7hQ3lTTfvVJcMJqy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UnvaFEv4oNme8a+7HLI+FlBSZca2AZZfc21iRogzpO1C97Mo
	pRJWIOF/qcDTq4cTAgp4t7DUOC+3MbXJa1pvuQva0SHmP66SuMLk1F13
X-Gm-Gg: AeBDietAoh8p8xoksHTcgPLIgBaU5Ihs/6aVUQuMRUgoE2YMxwQn15cFRNIA4211UlG
	qLDLJlGeKgj5rlAhp/+NN64jEHfxG0I0gbYty53Em6DmQP70DNEyZqZUQA8InuR1ICfJz9xgWIH
	jGlGbGjgfjM+zBHOqE/cOfDkEUadQoSxgLyn36hNCBPMUikVf2UTrhNwWV7bOwAt5EY6sXmLtiF
	DLu6bnW9abnuo5EyD0VeK3U491DZttIrfCW5pHqPoyCr0brSWS03r1JgZJ252puBVEcMTrg41FP
	5y7J8OhdNmE49CkmlONsIS80vYJvl/EIA9PBjElj4B58kaFI6uPmL3C6J0H8/DKBLEaHCHYa+Su
	WOdX0j6y224jh3IsRZicNaVfsHCKcYlL3Tc8Y16AfBDnZVwqJkjfP57KgQnrMgDghdEW5gQip5C
	fA02bAvWR7tQDYwCWVMsZtMRiDwLXxi/hRYyJuIPL28zbcj9+ots6AuYMtHUorL8/mrcPiJvK5B
	O0AYJjnEjpC27aYE/wHULfge4CLvvVWKTRMMVoHfIA+gSbbRnDOPQ==
X-Received: by 2002:a05:6214:8085:b0:8ac:a2f6:fbf7 with SMTP id 6a1803df08f44-8b02812ba4amr64724626d6.40.1776468787802;
        Fri, 17 Apr 2026 16:33:07 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac429e9sm21701246d6.3.2026.04.17.16.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 16:33:07 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ntfs3: bound to_move in indx_insert_into_root before hdr_insert_head
Date: Fri, 17 Apr 2026 19:33:05 -0400
Message-ID: <20260417233305.1787096-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

indx_insert_into_root() promotes a full resident $INDEX_ROOT into
$INDEX_ALLOCATION and copies all non-last resident root entries into
a newly allocated INDEX_BUFFER via hdr_insert_head(). The source
byte count 'to_move' is summed from the on-disk resident entry sizes
and is independent of the destination buffer size, which comes from
root->index_block_size (via indx->index_bits).

A crafted NTFS image that keeps a valid, full resident root but
shrinks root->index_block_size down to 512 after the root has been
populated makes hdr_insert_head() memcpy attacker-controlled resident
entry bytes past the end of the kmalloc(1u << indx->index_bits)
allocation returned by indx_new(). For a 512-byte destination and a
resident root whose non-last entries total 560 bytes, the memcpy
overruns by 120 bytes and a following memmove extends the highest
written offset to 136 bytes past the allocation. The overflow bytes
are a direct copy of on-disk entries (via kmemdup), so they are
fully attacker-controlled.

The write is reachable from unprivileged open(O_CREAT) on a mounted
crafted NTFS image: a single sufficiently long create in a directory
whose resident root is already full forces root promotion and
triggers the copy.

This is a controlled out-of-bounds write of 120-136 bytes past a
kmalloc(index_block_size) allocation, with attacker-controlled
content. It is a bounded adjacent-heap corruption primitive; it is
not an arbitrary-address write. Successful exploitation into a named
victim object depends on the surrounding slab layout.

Reject the copy at the sink. The destination's INDEX_HDR already
reports hdr_total (the payload capacity of the new buffer) and
hdr_used (the bytes already consumed by the terminal END entry
installed by indx_new()); require that to_move fits in the remaining
payload before calling hdr_insert_head(). On mismatch, fail with
-EINVAL and mark the filesystem as having a detected on-disk
inconsistency, which is the same behaviour as the surrounding
validation in this function.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---

 - FYI, like the sp_size patch, I have a larger refactor that might
   make this easier to avoid long term.  It's a mount-time variant
   that adds the cross-check between root->index_block_size and
   the resident root attribute size to indx_init() instead of the
   sink, closing the whole "root entries do not fit declared
   index_block_size" class for any future caller that reaches
   hdr_insert_head from elsewhere.  Happy to send it as v2 if
   you prefer the wider change;  otherwise, this minimal guard is
   scoped to the minimal memcpy overrun site and is easier to
   backport.

 fs/ntfs3/index.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 2c43e7c27861..b7633b721d19 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1740,6 +1740,22 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	hdr_used = le32_to_cpu(hdr->used);
 	hdr_total = le32_to_cpu(hdr->total);
 
+	/*
+	 * The destination INDEX_BUFFER has 'hdr_total' bytes of payload
+	 * available after the header, of which 'hdr_used' are already
+	 * consumed by the single terminal END entry installed by
+	 * indx_new(). A crafted image can present a resident root whose
+	 * non-last entries (summing to 'to_move') exceed what fits in
+	 * this buffer; copying them unchecked would overrun the
+	 * kmalloc(1u << indx->index_bits) allocation backing the new
+	 * buffer. Reject the copy in that case.
+	 */
+	if (to_move > hdr_total - hdr_used) {
+		err = -EINVAL;
+		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
+		goto out_put_n;
+	}
+
 	/* Copy root entries into new buffer. */
 	hdr_insert_head(hdr, re, to_move);
 
-- 
2.53.0

