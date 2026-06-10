Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53F115C14F
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 00:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051927; cv=none; b=k9uPQ4vJfFEhxGGZSwKA/YMcgxTs5UNNl19eZ4rL7Q7fMUy3FPJr8RY7Gq87Go7lHJWWfb44pOlrsoMe3WnCyLx4wXduoAH93cy8/L9/iELKr6HyIFR4zFGIz3CK9rlWFRf29oJ7KWz60JgyNTnLIjM12NBsRhvj3OJqderL2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051927; c=relaxed/simple;
	bh=8W4LSmmAd4tjAcHgGMcfpD9VPEhPb8gkaJNtbe3vw1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHPGWm7ZessugL9dWN/PjvG8DwYL+o5kaP2Bje16ajYvfV2epdvLjfqxUHmFA6z9B8LB3pEsBRWoIwpU7RIpRl66ltXIq++BpBo4ifzum/Hx1p9ye/iQkwCq8dPEANFH/0h4Ncue4XY0D4IERPdYU1MAF/6G7IQ7PiOB/p2L2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SVgEui6f; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="SVgEui6f"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5176fc0cc72so62319491cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 17:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781051926; x=1781656726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HD4CyZy0JUNR44EyaczU983Jr0FqnBLzgetNoKQtXo=;
        b=SVgEui6fE3h+dNzu5aucN1MJsBt+3NjSylE9GeKvSY3GAb7OOBbkIOjXlpzzhameSn
         ViBxRi9OLZBMgQfaPcYsPLyLqXSyJY+92j5x5I7hgXgmGCZkW/z3f+1aqD15tMOEfh5q
         fCDDgguR0dv4t0c51slBTI8fg2uXmY94YjFWcxBjmpuXlGmdMS1k+8lNRZSi8OTZfE+e
         W12Le4QSGNZR7jglmErVHv/JE+OJjMEVXKTFYRcOi5gCW+cpFo0Nev337xFTqhY7oqbR
         HjXPXoANA9jByfM2pZBnFmKYs8lbhlo+4a4ni6AzMFSk2IJ1ke+8MPHHeXVKDq7NHecO
         fSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781051926; x=1781656726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HD4CyZy0JUNR44EyaczU983Jr0FqnBLzgetNoKQtXo=;
        b=hxEtyVHC2iqLX6KQbI93ZBsSP/Wn+fqUVKgaX55VtFZdT8qQEIDuHEc1/KQW97f+la
         64coHI413MTLgW+IibgTLk2LfRymkOi9Rj+iOpManGaM9KgU2AFLVE++326chPMf77hA
         Czdei+rb3XH3DCPscZctS/s+Jq4RbsM4nnZe22H/pnul0khyQIeyc5r0JU5ZKiyZ3ESC
         iEfdCf8nw/DU1vfX4Xfqp7o341myWKweNUf1T3Yq9C8v+C9vJP6QKf84LcLl5CTMAm6L
         vrW4To8SSRBw/A862Pusy25LyIVcLs4nYx7Z/eliI8uxr7ItrUpyf0701D0Q0oThT6C7
         xukA==
X-Forwarded-Encrypted: i=1; AFNElJ/Fws6lEXHaBo0q0DmdzevhmSKq+Wy9x8Iq5J1ijcVk4yS24yWhfRGA2XCvt2X5TWDcD+Q6rT7NB73M0nrp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd45dl2MyD5NtN0gGGMRhRWQEUkaMHap8NcxwmW7Q8quQpP4Yr
	T/wOypAz/nLUEK+oIDhVHPpEx/+jZgCgFxuRRxGVQymVNmcGNMFVBWUSlYLWZs7qg/s=
X-Gm-Gg: Acq92OFyBjRyVMU25iE/1QcOh6mbxBbXsVOnR2ZNCQI1XYZmHYwhY24oz1HRZPBeo8i
	LK6ESdK0IgJva2MOTRFvFa5a1xfLeyd0jW8GPM46E85lFAaR/MchbsQA2kfQoE9SPscaYffXkWD
	6PBTlRunwPJkcW9HGIN7CTmKlyN8VxJbMreYEwNY5cpam9X5Qtba0z2sRG01oLsSJbmF0GM1O0x
	s8DsJFsj4cbLZADgNCsQRFy3kgI9z5vJ2Npeh0FgFbX80+qO5Dr5j4czip30kNiOoULgfuTzCxi
	Ow8UH1f02LysuqZaG8vlEsUCWT2N2bMoyzx5dqONJTCzXXpyITF2qhuLSpNejZkRU5m9ihye1z1
	5QdOx5PX5Qt6Rriawriq1vJ2iCi7/0WiVw6W7sjjSN/jgdwMeU2a0upiP9k/AkNHOTsdcaOeVxt
	KuECoPOGMctkAtr5JyrqUAsBd4tC/TxFQKjERr2Q==
X-Received: by 2002:a05:622a:400c:b0:517:7971:a234 with SMTP id d75a77b69052e-51795b729ffmr331041021cf.4.1781051925756;
        Tue, 09 Jun 2026 17:38:45 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51775c297a8sm196989031cf.8.2026.06.09.17.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 17:38:45 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	stable@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] fuse: avoid 32-bit prune notification count wrap
Date: Wed, 10 Jun 2026 00:37:18 +0000
Message-ID: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE_NOTIFY_PRUNE validates the nodeid payload length with:

    size - sizeof(outarg) != outarg.count * sizeof(u64)

On 32-bit kernels, size_t is also 32 bits, so the daemon-controlled
count multiplication can wrap.  A prune notification with count
0x20000000 and no nodeid payload passes the check, enters the copy
loop, and asks the device copy path to read nodeids that are not
present in the userspace write buffer.  In QEMU this reaches the
fuse_copy_fill() BUG_ON(!err) path.

Validate the payload length with array_size() instead.  That accepts
exactly the same valid messages, but avoids wrapping arithmetic before
the copy loop consumes the count.

Assisted-by: Codex:gpt-5.5-cyber-preview
Fixes: 3f29d59e92a9 ("fuse: add prune notification")
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Use array_size macro

 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c105aaf9ff5d..0c6d1855003e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2081,7 +2081,7 @@ static int fuse_notify_prune(struct fuse_conn *fc, unsigned int size,
 	if (err)
 		return err;
 
-	if (size - sizeof(outarg) != outarg.count * sizeof(u64))
+	if (size - sizeof(outarg) != array_size(outarg.count, sizeof(u64)))
 		return -EINVAL;
 
 	for (; outarg.count; outarg.count -= num) {
-- 
2.43.0

