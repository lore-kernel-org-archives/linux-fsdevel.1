Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E526E173
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734090; cv=none; b=t01dJ8qifd5iR6QE6himCl49haHJMpTmIqkJ3UuTNE82kSscO6KM57PE4BOoeEJQEqOlFYG/+CldxWI9070XLkdpXB4ZSnFlmQ3AMDlWzkMmxe7E7O2ZVjvGW0eAAc2/JgM49wVQSIiI1gIzMxnjXNTTP7g0vfgmtHJwiIVvTZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734090; c=relaxed/simple;
	bh=hQroYglAXp5kjNwQAoXo8q4HKGWUpjQ8hTZejsQpsYE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HDRf7MTrRZ6ZAxe/zNdqStXj7c6+/iYCQMviiMfwHgn9/DIuR/rlNv4hbV6sKy39KedpTrOluT9daaMIIMdtIslKk/OSHsbIMNDpinTDJEwuaqPAFUvKtlGK+d4mFHBY73ptwP4s2SUfFcr8mKu6+Px6nTE1IxQ07YoBSZhfEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BjWO9Rvj; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BjWO9Rvj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780734083; x=1780993283;
	bh=q+nXm+6BI7VDbIxQDWD1ZL32f9mClcxdpAAY6W9j0c4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BjWO9Rvjx7afDbNAlg4M5IN2rRNkF7h0WLirLd8i0FvQJ7VkPZhqMF7SFCnC2qTOS
	 fl40RcGQS1BUomJ61yqhguL5Nao6/8McP64FxbD7WT2eedyMzmv56R9CqVAVuqii8t
	 AQt/7IP8zX1usAc7022l9oW7Ne9GmUk8z3XOKj8Dlav54SOTnzXb5fKSaLs1JSxFnc
	 Rp7xZkhvDn/iZTcRqc/OJFYAk5Usu3akjqLTZTTkFJWzAVLHEDnJHdbhYFCRLDQhfK
	 CuBu+4D/zZ3lsiPC4N3dRXcYKXUiYj0n25l0lbh/gbSipp8UlvewD1VIBZ7yEMAh1t
	 jypIw7pZOoreg==
Date: Sat, 06 Jun 2026 08:21:18 +0000
To: Anders Larsen <al@alarsen.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fs/qnx4: fix bh leak and extent-count OOB read in qnx4_block_map()
Message-ID: <cover.1780733712.git.hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: ac04d36f56ebe11224519b98fbc7da95824d6edc
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

While reviewing qnx4_block_map() I found two issues in how it handles a
freshly sb_bread()'d extent block (struct qnx4_xblk):

  1/2: the "IamXblk" signature-mismatch error path returns without
       releasing the buffer head (a leak on every malformed extent block);

  2/2: the per-block extent count xblk_num_xtnts (on-disk u8, up to 255)
       is used as the walk's loop bound but is never checked against the
       fixed QNX4_MAX_XTNTS_PER_XBLK (60) array size, so a crafted image
       can make the walk read past xblk_xtnts[60] / past the 512-byte
       extent block (CWE-125 out-of-bounds read).

Both are reachable only by mounting a crafted qnx4 image (mounting needs
CAP_SYS_ADMIN; qnx4 is not unprivileged-userns mountable), so the practical
impact is robustness/hardening: a buffer-head leak and a bounded read past
the extent block. Patch 2 is the security-relevant one.

The OOB read was confirmed with KASAN (the on-disk block is 512 bytes;
reproduced on a kmalloc(512) copy of the walk -> "slab-out-of-bounds Read
4 bytes to the right of the 512-byte region"; a live mount packs the 512B
block in a 4096B page-cache page, which hides the over-read from KASAN
there) and with an ABI-invariant (-m64/-m32) AddressSanitizer extraction.
Both are fixed by rejecting the malformed block early.

Bryam Vargas (2):
  fs/qnx4: release the buffer head on an invalid extent-block signature
  fs/qnx4: validate the extent count before walking the extent block

 fs/qnx4/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)


base-commit: 43370e89f7a896a583bf33d1cd171d02630e61bf
--=20
2.43.0


