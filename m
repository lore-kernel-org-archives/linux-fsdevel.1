Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297003;
	b=DSNdZcNiPkTqcQiMUevXgjHZOQau4oUNbJC88joePdMDxkAOLlZZmrbvTLHy/8jhijCo
	 GAcN9aCbia50nbyAHY7cv6FEd8RtudJLhxvYrR1TuNDLRSvmdsL9i+ulth3XmYeovNxD0
	 5QbbafZWO9F0h2bTxm/7Tf/eMLuvVZg/WwrpcL8TnUQj6KAHejztq/BWyRktcbpkMB09m
	 w7JLhnqzU8FW/gsiJOAq69uHh8ts6PSt0TSezg6Svh2xmOBYogNna31/Zn8obsHmaSUxj
	 IPHCLMBjS/KgL/thbhII+xNW4lKdZ3carZIt56LYTPU0rELELcnwfOVfbSMjo+6NPwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VPSwyQABsxDeIKe15KWcg49fMkA5mZOjf5WHg6hn20w=;
	b=MeDeJ4oQSSrfLnLOa0eNLGEf1vNXvz89mJU1VVI//22paPirL/vzSizQB6UjnsVOfaIT
	 7HwIDPRsItGaK+gs500dXU0scjxRDX70kdO2gjI2Y2uQOk3UVHTnpcx8Oxert3E9b3BDq
	 q0VhjzzKRvLAcue9/BGCJQqk8/VM0Gt3K3Sk+Gw+L3PDzda2ofTeRtEPyDasoZh2olbju
	 2ZYGSEDfvuo1h+ZqXNFD0p+x9HnjuzAC/zxL3f9YkFfeF950a8TRxLYfWfcxHwSanVVS3
	 yZDQX72WDrxP0z6p5FcLhOAhUu0NL4+ctch8Gp5csK/YuvCH0SYePnc7bkXSgyRmNKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSsrL1ec;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE630606A31D
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 18:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE630606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZSsrL1ec
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c43373ae89aso396829966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793297001; x=1793901801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPSwyQABsxDeIKe15KWcg49fMkA5mZOjf5WHg6hn20w=;
        b=ZSsrL1ecNekN3zaxWylXVh3KMWw3H1DckiwhWZhQsH2Fjxq/KCRzXlEdBL++OKYd72
         /tT9WcgWdzlhXV3VUmMy6OtAgikfoNKRY/W45ycj3ICAf166SZysPvClGAwBH76+my3L
         6h0z8Xr0XyCrBpYuC87CFbto4rYfuv+EkATe7hkSMm4Str6blamnW4iH2xjaoJ7hrjgA
         mgwhp3WnIm5ZEFEiriXois1iPfdcUpHWoY6VXmPKaP2TJbU5uHTNsFxZirU0f+269bgU
         iiKCBnrU7Ie91OvpnHRsU3ZORrqv+p/+CmbLEDrsHmazHn+YOumaD1rnmfAOGw1Ow7Kl
         2BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793297001; x=1793901801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPSwyQABsxDeIKe15KWcg49fMkA5mZOjf5WHg6hn20w=;
        b=SUmglVRpiquOzYGJ3FEbMa1RBXHbJbN5EUrVRTBx/vTXAm6StDOzj7IBGMrBk1/v/m
         W/Od0L8CrYZ3F50HwgoRkfrEeDsJ0NsJ4343Ucisv+J0OKJO0t04/NoqR46ntrUkuiU1
         /+cMI320yl4JzwhXrv5PN6DIX0fb2euT5LKYM5f1nf5GsNquNHmS2Oq4XiTG/XSsRvUQ
         6eI8OhIzskl4FZPwN5oqHraUhoZTOh3rb36Z973XOroPUowm16M6cvL5mRBXq+KDVftz
         9NEHHLyFQayCA1i1iZtSW5lS88FIgbTUAqJ2rIRF1CUTu1MNtMamd/DQsCqS+WZQ6b4Y
         Mgkw==
X-Forwarded-Encrypted: i=1; AKwUvByI5MYes6y7kEYrHk3T7oG6zW6mb1hM7g5WbgsYsFIiUx+rzv63IPbB18SFRw/TElxJgF1gx3bM0f8v9CrF@vger.kernel.org
X-Gm-Message-State: AFq9FYKx/8wzddaur34KgYmy5X8Y0FBrns5cP91KlqR9yKbPFymx1ryS
	lA5uSC7PnUpUYWgxryuDVb7HZe3yjRHatCqe9rqM43gZtGzzaL3gapOe
X-Gm-Gg: AYBFou2xmPoqum6cRy0471MnpZM2FBhqnKUA/rm1Kj22ZB9JUvKdmUKB0yRK0uuH6aS
	RFYHfWTEKHYM1ys7xC5kRVhEoGDd2lI9RNJziV76x7JgLyKWyutgNTJ5r0GfSRpsNiQ+B0mw8Ee
	anrP/9pW/IoklEUCR8a/e9b9m+x4Uqpouzp4g8GqHN5W7jK10/z5DbCzcFOJS0cMzUnrB1iTqir
	49yYARQVjdBVOfEdDcqTuxp7HIYkOY+HTf4Rl/jeBbMf0mWSyJqGMiKW5eEvC99mxTNNBmaj5lW
	QSYxvG+wcJn0QXiPVfCaSgdbCDRdt0HUi4wIruv9F7M/2k7vXrnSnFbMUaEmsrV+m12hQnnaWzk
	L/ajRQggTjBkxkZPxPQf4hFtzZhX7xy49vTSmyWW8eifHdcgMg31JFOkDUhslNEJV881PwZuj10
	sxeA47dMhkiYf9tNgg6D0hp3ZIEE+QFw2NEQ1vzm004W0d3zQnuWrL+wRiVTMOV8ILO1TEH7IFo
	VhAfoYd8lVj/csGbtGNnKRsWdO5PHhdvfnaDMmTAId7mWBFc1pzquIBxin9VbUPuPFoAoUFmUZj
	7DMuIR8lUBEPhuFlcRkBqXdPQI7hvjn+M3miVdd/EvEiPJtjOi3UM0tF4aiuvhfG3deLf7HvxKu
	Z8y3G7iXaoFso
X-Received: by 2002:a17:907:d92:b0:c41:26b8:c49c with SMTP id a640c23a62f3a-c49bdf0b4aemr514913166b.10.1793297000979;
        Thu, 29 Oct 2026 11:03:20 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4ca3003e65sm8631466b.21.2026.10.29.11.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 11:03:20 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] backing-file: always end a queued write
Date: Thu, 29 Oct 2026 19:03:19 +0100
Message-ID: <20261029180319.2852090-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mason <mason@kernel.org>

Writes to a loop device with direct I/O on an overlay file make the
next freeze of the upper filesystem hang for ever.

Every kiocb_start_write() needs a kiocb_end_write(). For a write that
is queued, vfs_iocb_iter_write() leaves the end to the completion, and
backing_aio_rw_complete() only calls kiocb_end_write() when IOCB_WRITE
is set in the flags copied from the submitter. In-kernel submitters
such as loop do not set that flag, so each queued write keeps the
freeze protection of the backing filesystem.

Direct writes to a loop device with direct I/O backed by an overlay
file left fsfreeze of the ext4 upper filesystem, and a later touch
there, blocked in D state. It takes write access to the node of the
loop device, which root has by default, to attach the file and to write.

The fix used here is to mark a write in struct backing_aio and to call
kiocb_end_write() on completion of every marked write.

Reproduced under qemu without KVM, on v7.3-rc6-21-g602042bf29f6 with
earlier fixes of this series applied, with and without this change,
once each. The kernel was not changed for the run. With this change
fsfreeze finished in about a second. Not run: the nvmet and LIO file
backends, which do not set IOCB_WRITE either, FUSE passthrough, and an
xfs upper filesystem.

Fixes: 2406a307ac7d ("ovl: implement async IO routines")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[amir: use aio->is_write to explicitly mark a write aio]
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

This fixes a nasty little bug.
It is not critical because it cannot be exploited by unpriv, but
innocent priv users could hit it by mistake.

I could carry it via ovl-fixes with your ACK or you could take it with
your other backing file fixes.

Which way do you prefer?

Thanks,
Amir.


 fs/backing-file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index cc101143f9212..ca8654fa1d83b 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -84,6 +84,7 @@ struct backing_aio {
 	refcount_t ref;
 	struct kiocb *orig_iocb;
 	/* used for aio completion */
+	bool is_write;
 	void (*end_write)(struct kiocb *iocb, ssize_t);
 	struct work_struct work;
 	long res;
@@ -124,7 +125,8 @@ static void backing_aio_rw_complete(struct kiocb *iocb, long res)
 	struct backing_aio *aio = container_of(iocb, struct backing_aio, iocb);
 	struct kiocb *orig_iocb = aio->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE)
+	/* Pairs with kiocb_start_write() in vfs_iocb_iter_write() */
+	if (aio->is_write)
 		kiocb_end_write(iocb);
 
 	backing_aio_cleanup(aio, res);
@@ -239,6 +241,7 @@ static int do_backing_file_write_iter(struct file *file, struct iov_iter *iter,
 		return -ENOMEM;
 
 	aio->orig_iocb = iocb;
+	aio->is_write = true;
 	aio->end_write = end_write;
 	kiocb_clone(&aio->iocb, iocb, get_file(file));
 	aio->iocb.ki_flags = flags;
-- 
2.55.0

