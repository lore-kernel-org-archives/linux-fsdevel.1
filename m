Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB41A3164
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780965937; cv=none; b=gETiVnlEON2pGjcDLwwhDzrEMuRNOtizFKHOme+3VQ8Sut3r1SAsAOTICmVN3WBEAPqu6ocQRp8QOxJJeU6djcbs8aPWHR9dbQjgdnNnQ+1utyI1RPWy/DL4NWVNXOud59fvDCXZaUdBs8yb2tR3/pLQq3bhSVRsVmi/1iGi0vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780965937; c=relaxed/simple;
	bh=xrNEM0EjiG4WwgUrA2fFgzDx7hV6Xyk55L5IUpbmsnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8LTm0MRNlibS0Td5dNL6VnaD4PdfOUFKL9aeTyJn6HueS2wI81WYl/kXDq2aW1YUafXRVJzo8wD3QA2MnazEh1DsW+stpidRvokST4wc2Hvl4DF2tEIxD4lhtFkwbRgtTSZHh+Mc1JKZCfozFnOr+IrhL/0FvITMERixS9gTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=Qg0l2agu; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="Qg0l2agu"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-915c48e6ae2so179959285a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 17:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1780965935; x=1781570735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UyLuwE5CjOgpN+SHJyHEJfZ6vNufsWZyQCiPmWJ0OvQ=;
        b=Qg0l2aguvprjQ6zcjxSZn0LZplpT0HdS9hfmH+uTxVbfbXeJ/gg98suWzpHGnvJFr4
         CqEm33H6yoiS2Xawbse+C2Be8JA6EZQZErX422dEn5T30H/D1aHiyYzDUrVA/YGy01xg
         qlPBDDlFUdUGUDTn3/t+uFYruP/s4Zv0nnLYAjyuClCkHIuhWUR8HMLkRwliQz9Qy1SS
         RgdZO50sSSfeQYx3f/aRFNOePECJ254c8OVLtPe5coKwfQ+vik8UjVdMsOAWEuN1XAew
         XIW/lbdxo7TXABbsshSx51t/IwVuQv24djN1TDwTSY3wpLJyV/x7g4KwSNtwAbmAVsrr
         ZytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780965935; x=1781570735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyLuwE5CjOgpN+SHJyHEJfZ6vNufsWZyQCiPmWJ0OvQ=;
        b=a9xkzXEl36IdefFovEcA/HtTcrKyr73L5pF2zYhxkiQYefsfJizQjt4PMdo1dDWxrn
         1opPwWdDfABwhEbLJWd/rVOL7rKFRoeeves3lQQQzYBSLIM+jrhHml2I8PwBwPYRH651
         FHumqPrOeaKQ7ophljr4gJKTwXOwixJpXjmTaerXq82MJWPpBKfhrmAQ1FY/KVz6EYl9
         BzKseaMaXG+YYBxWS6Dk+CA2O74vNR1gh9Jodej36t/3JTBn5x5JjCQoDvih+ccrVins
         zscCKSnjoWEWnkG74fBZCwPBOKB1LqlqHJ1DAEP4BklCT/2KO3Fv7S0FGebghrEnyjll
         K7OQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EFmEjLRYyhdLmlWMLgpjTCdlatjcSiYzZt0aPworZEK8fK2wTORrmQDa1xMECuFXfwF0MS8/1xCP9P1Wb@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRkdOBPhMzjwWRqUmG5p9A2VFTrMLqXs3nM5LxHHFX/1MDxWt
	53DTXTY2meQBTkLeqADL0gZqy+GqVMhIuSCyPu2MU5BhsTzlOrRHGeKYv3FY1KL2onw=
X-Gm-Gg: Acq92OGVgD+cSeaSaprm405lvyzVzZJtPwYrpHTP+U2mGsLYBhNC96cNTY6sO+giX2u
	L7kXuueJKG7y1oknWFcBVOqKHMozlRIGNYL9m7EoIuinUOclPjt9Cij9Kv4Bc7z0zFn34N3my2Y
	HIc3oj+zpGj9joxFTbm+x3PXwvFsVrTxZhAvgn19Bt+za+/C77VxDpk046uMvywQT7ZZ1dGrkx4
	kP6NTJCFVJ0kythz0B5e9d328my8lpiLW3JaTFvKgPDpCIVIXFN+ULRKI7vJTJ8IY22jr066Pzf
	OCHkBSF8z13gIryFCuix2ddMtwGYAKmbNSfSrVqU3WjB5FVXfmBAY9FViY+wq2OqixGD2YcA2jZ
	oYnxpm0iw00UK0MBSr45Z6qCB3vnOljOvoWnxeYTFB/Hhsq43wMgBcvx1w0qHAwGbpemWCq6EUT
	/ILtLy0sRQXKaF0soZ5hEirTNbXVoUYaev03XQ9Q==
X-Received: by 2002:a05:620a:29c3:b0:915:75ba:179e with SMTP id af79cd13be357-915a9da93d0mr2874590185a.30.1780965935512;
        Mon, 08 Jun 2026 17:45:35 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9158a3d250dsm1913772085a.38.2026.06.08.17.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 17:45:34 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fuse: avoid 32-bit prune notification count wrap
Date: Tue,  9 Jun 2026 00:44:55 +0000
Message-ID: <20260609004454.1239911.0d61ab0f129b.fuse-notify-prune-count-wrap@trailofbits.com>
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

On 32-bit kernels, `size_t` is also 32 bits, so the daemon-controlled
count multiplication can wrap.  A prune notification with count
0x20000000 and no nodeid payload passes the check, enters the copy
loop, and asks the device copy path to read nodeids that are not
present in the userspace write buffer.  In QEMU this reaches the
fuse_copy_fill() BUG_ON(!err) path.

Validate the already-subtracted payload length with division and modulo
instead.  That accepts exactly the same valid messages, but avoids
wrapping arithmetic before the copy loop consumes the count.

Assisted-by: Codex:gpt-5.5-cyber-preview
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
 fs/fuse/dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c105aaf9ff5d..f2fca4659527 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2066,6 +2066,7 @@ static int fuse_notify_prune(struct fuse_conn *fc, unsigned int size,
 			     struct fuse_copy_state *cs)
 {
 	struct fuse_notify_prune_out outarg;
+	unsigned int payload;
 	const unsigned int batch = 512;
 	u64 *nodeids __free(kfree) = kmalloc(sizeof(u64) * batch, GFP_KERNEL);
 	unsigned int num, i;
@@ -2081,7 +2082,8 @@ static int fuse_notify_prune(struct fuse_conn *fc, unsigned int size,
 	if (err)
 		return err;
 
-	if (size - sizeof(outarg) != outarg.count * sizeof(u64))
+	payload = size - sizeof(outarg);
+	if (payload % sizeof(u64) || payload / sizeof(u64) != outarg.count)
 		return -EINVAL;
 
 	for (; outarg.count; outarg.count -= num) {
-- 
2.43.0

