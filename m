Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5746A437107
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791788138; cv=none; b=WZxOWYpMbDzUmg2ynPFicXOUNg4By0y//tRqaKSlA1o1B/8eb/c37pH7VJh3iTzZqWKWSXvhJi9qWdW4wzvtQ11NtpUgnNhDSFHnSwiLJzToi3e8WFlFJ0uzUSTyN43BOr5us5vfYxBN0UqUDtR0Ulrij2EZGYizaMmrZYSSNWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791788138; c=relaxed/simple;
	bh=NEFbbYwMlEdUbHxTICN0UrosG/K/dEi17kI/baQmbEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhZ5zfktzh9qvCWToLh4WTyFCGozF4HqAYYaQOtODouVhnyH09MJ99vTCzr39rreJmr7LA4C7ySLPiFRUX5OrVdsGJ18FxgOE7c8X0s3web9I9IXRSjlJbxMauJRuLRan5ujOS7hU66oZN9HfFLT8sGGEpoN2kNnyvnRoTYBMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pDPNPPEw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pDPNPPEw"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so569015a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 23:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791788135; x=1792392935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kZWnzdY1xyRAwbdLE48p0TO13sHkNvGJeQW51X4a6/w=;
        b=pDPNPPEwOhgNQfLUV3CpPou6+SEq5utFL8KBd7l88Q3X6PDhpddnQK4icSD+7OYxs5
         nTs2W/z/80s7SX1zO2/9nHcxB3/0t2KB0pOj85ffOy//qkchllFMcK7KsZ8iIDDvQNXN
         OUchwd772FRL+BDa64C9DVcJJZ9X4tMAxqvYA7ObFXF9rcA5dxh2noN/bTvH3YDMGcKv
         GWKzWGbpheMGzO1FLi7TXPXFo1WQStVH4wgGRKHr1J8nYbUHJ1VUB2QvbsSD8wPTs2Bw
         ScT/yX7G6+zNlIdjwl86UI5tSD2XVH4ifE3N62omJpRRdpxKbZ1e4ZUuNZC/fwG/25ns
         A1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791788135; x=1792392935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kZWnzdY1xyRAwbdLE48p0TO13sHkNvGJeQW51X4a6/w=;
        b=U8XVoM2AxVUit/sFfg21o3aQvAb5YBAaF39D9IodCU9v2nZa7AwKW/rb52+Mjoh0G2
         tHID+Aqv124pR0LtsnCvAnlTZ9EFiElL4/AzY3uEhMlw+fN1jJkOaDKIehK4Twyzsg3p
         yecqG2qfvBoqo8braUE1UiaLoexR4xtXb5dIHwgBoh19gpqvUyzJot1Tqk/bIlytvw9z
         vFYRImODbAUo3cPr/7cB4IMmsABGcr6RoFG5DuoUFX+sgBBnKrnLFOhqycZfdNk5T1+G
         0ugzoJZy16fgjvxRw/OgRnfUsNQsKvkFilQ81Z1LpxChKV+Od45x2/jU97shD8fbscGe
         RArA==
X-Forwarded-Encrypted: i=1; AKwUvByP/Q/wjEi/eyu2Xnza1WcyQgXcufrcVGPTXFir74YyPUHt9e/xZ3tOdP3yKI0HpkDBGsFyySyNup+DipHc@vger.kernel.org
X-Gm-Message-State: AFq9FYJhCi9lUYAxIigfbpt/rtcuVHVck5HvD/ZUyRx23aySb0WigJUp
	zEOUJwIR192X50KO98fGX9epw9lct2gJEwdn9fahMNBLEnTP4CyCFlnF
X-Gm-Gg: AYBFou1RbUgHDotamABznmO5LlLR0lcPFT3bsg281LK43uI3vr/NvONS2F32UVJ+V7x
	/alJxMhWmptCSqWJNBimXqT4JnxUoeOdqrcj8LsNUSGHV8PxLBjY15l20zpq8UnRGMfFiVZhfv+
	XAbD7OzYgH8nJq829TQsrvVrZVSY7GDTySC14J80s6+M8ytLNe2LeR87hMZxPch9dGGvSQv7JRL
	N+uX572d/5q+EuJ1DaLDEu50JSZgu+/+HdqSv2xEjwjEVDdmqd5t2/qUroMRaWCoaO81EyGA4Pm
	0nT7IeHYyxposTfIvuzDOdYNXn5oLWll1oqFS1O1cGkNgvqHOfCjAGq47XStFayFl5lOZLFhAPT
	BnxOppYUSzToJ+INhLE479C28I8OgPCoVfrq+7bHiNHszsXoNWa9kdud8gGf+zYtwGhCZ5Y1Xe7
	AUUHDE3sPNeNvpWbW6ML4JkgMpbn6EECkclazI1NMflzIABtPiEh1Sr6eUA2gi/zRSaCzNB1d/z
	ihlL1kdl20=
X-Received: by 2002:a17:90b:5444:b0:3aa:fc22:8aa7 with SMTP id 98e67ed59e1d1-3ab3ac72e81mr6831001a91.53.1791788134635;
        Sun, 11 Oct 2026 23:55:34 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab421566acsm8094947a91.3.2026.10.11.23.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 23:55:34 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH] iov_iter: validate first nonempty segment for bvec alignment
Date: Mon, 12 Oct 2026 15:55:20 +0900
Message-ID: <20261012065520.1089147-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iov_iter_extract_bvecs() checks the current IOVEC or KVEC segment against
the block device's DMA alignment before extracting pages.  Empty segments
are valid, but the check uses iter_iov_addr() and iter_iov_len() directly
while first_iovec_segment(), used by the extraction path, skips them.

An aligned empty segment followed by a misaligned nonempty segment
therefore passes the check and produces misaligned bvecs.  An unprivileged
O_DIRECT preadv() reproduced this on a regular ext4 file above brd.  The
equivalent nonempty-leading vector returned -EINVAL, while the
empty-leading vector completed 4096 bytes.  This bypasses the validation
added for CVE-2026-89584.

When the current segment is empty but the iterator still contains data, use
first_iovec_segment() to select and validate the same segment that page
extraction will use.  Keep the existing constant-time fast path for the
normal nonempty case.

Fixes: 14b007e17881 ("block: validate user space vectors during extraction")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 lib/iov_iter.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2072c04e99d052..893de96de8ab6a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1938,8 +1938,13 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		   iter_is_iovec(iter) ||
 		   iov_iter_is_kvec(iter))) {
 		unsigned long start = (unsigned long)iter_iov_addr(iter);
+		size_t seg_size = iter_iov_len(iter);
 
-		if ((start | iter_iov_len(iter)) & mem_align_mask)
+		if (unlikely(!seg_size && iter->count)) {
+			seg_size = iter->count;
+			start = first_iovec_segment(iter, &seg_size);
+		}
+		if ((start | seg_size) & mem_align_mask)
 			return -EINVAL;
 	} else if (iov_iter_alignment(iter) & mem_align_mask) {
 		return -EINVAL;

base-commit: d6d3455d8751854e0d1820f14184682e23ac4475
-- 
2.55.0

