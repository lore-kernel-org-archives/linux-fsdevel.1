Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E7333F59E
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569670; cv=none; b=bDbnofLW/51NTzFUqpa0y7onVUWJOyDLQlt9pngkwyWO918tyohTePyz6i6+1eMov9SubV2Rz+f+XSZM6DeWqDVrXPZ0SgR+d2LGNPBfZxm+Gon4UaXasxl9uc46BAsH3b4EXvW1qFfn0IAEEJRZxNrBZleYGpsaojobQsETIFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569670; c=relaxed/simple;
	bh=Y6cqM4EvlGBOS6YziDRM0sHRZX+RsE98GsTLUFKYfi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8zp/obv53WMrRyP5gn6WmEbCq3c46THVzQrSOLVk2Vqz2Zd7j9/zVqKock14I9gthglgV4pAfrvGpjw6ghSodj72Q0+4J1/uekXjCAsajriMDPt9laDR2Sb0nRp9sGZlRk8K2QRj6r18g6H9oWOsvmwtpmiVhGKFTZ1hg9hkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nx90Pvv4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nx90Pvv4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824b03d9787so126124b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 10:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569669; x=1778174469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr3axVcnDiZy1sAOlbAWcyfqiZ/0xXxvJPVhUZbgyfs=;
        b=nx90Pvv44opU3V4qRyXp7aVoeh7IvNQQDHRXO7fQzfovzK/+ycjYt1ad9OudTduNzF
         +ZL5N3s8uEtNjNLbmd0Jev/WbbzAW5OoddGF98RIzkVD1LN9XhCKRN7xyb9qc1HmiZWG
         UgbtFQOd3IMNcE5BTZGPaay2G7dPMq2pYB8HPCGyM3TY4OuNJq8FputfcXq8eJSu/td5
         W5OculZopKGJFtGL32ch9vIc1Y9RV7vx92/MdXoC1nRvrJdahQRApTuE6h4hc8nmZ0dj
         p//XNsqWWq5hpKwdyHxs49HDCX243koCLRZqi3B8mDFLahv06Ln8VUAd5xm7NayQSTWM
         Y3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569669; x=1778174469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jr3axVcnDiZy1sAOlbAWcyfqiZ/0xXxvJPVhUZbgyfs=;
        b=dYRycPghULEFQOQUA6gzHLLRl8UrWJ1vYxGntYfklWT1VHoGbo1yq+sUFYzbhiio0e
         szqUVtvIMhMHEigp/S/gt2qShTlbESDhCcS/X6Bxb4XqLQWDfaUk4tPchmlKEkRspT/o
         foRN5m92ueGwCzFpGu3iPdVAx25LH88J1H6SDYyQCCnlg9MQ9+VYHCDv9OWgwW8QbXSq
         Bmrlvu1KxC/FPTX3F6KxQ+zmEEo7v2mBRKnmTRuGtNqDsJwGzGR2cGf8P0gbIze7ZVw8
         cn9tyWycv7M9zWDkTYPyNIsqkrB3l3kndc8GH9qvGfFRLxETWdceIbl4KOBqv+JQnFLe
         q2fg==
X-Forwarded-Encrypted: i=1; AFNElJ/VzDJK7AIAbw1hUyBnguOPL4JPUsRvnNaUZ4rTHgRxguP6HZLH4JEAJcSYBDPL2juit37MB9RDIcNa9Wqn@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEQaVOhyu95jQgE0Q69OHXqEm0G4XwUfXLNkD1SJaOdteINWD
	n/oqFn+wb46f6R0lJG/wcAQtOTHVSjIMpclOMxQtSEK7Jmrp2/V+IMpC
X-Gm-Gg: AeBDiesP7WbwrKW+0lcPb/+8HmFfDn4etlcQZpddtJDMpcGhZlYX/b1jmG022OJ6sru
	yaL1SD1rK1W1hHt5JLvLApeb6LdlymMxQYOFzlI0Z/vn/eHPvzMlHGloVIU7h4MaewWnslenPd3
	3Mnmo6o/buqTYXdlEyV+4KP1El7h7Cjuq6q8YQpnRFlDqYibSe913QzU9xX+81B0YrSF8UEb/JL
	UCdm5/EqZ4J+mjg09B0P5UW8JTu2PCvQYB3P1nrw90ZTHLfTfatdLsiFNuEMA70oOWvezsnRuqe
	zEbRDIl9AoDICS5BiuJHrKP9loQT/eNTvtz6NQUVZJCNl+36UTBxn3XsDu8iugOSmS1z3rFakqM
	Boi4gbi8cLqL798KVJzssEKM6N7kII6WPnrtxoFa/CcT/hl0dA+JPLVDkSOtxGXyejp4o5frPWM
	TqtcOJVlqlv24j11isAFsF+og34hc=
X-Received: by 2002:a17:903:b06:b0:2ae:464f:fe3e with SMTP id d9443c01a7336-2b9a2861e94mr21157545ad.5.1777569668859;
        Thu, 30 Apr 2026 10:21:08 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e7besm2043795ad.12.2026.04.30.10.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:21:08 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 2/3] ntfs: redirty folio when ntfs_write_mft_block() runs out of memory
Date: Fri,  1 May 2026 02:20:54 +0900
Message-ID: <0d61bd7f181f4e46207572c5d8a4b026e370a57b.1777568957.git.charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777568957.git.charsyam@gmail.com>
References: <cover.1777568957.git.charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_write_mft_block() is called by writeback_iter() with the folio
locked.  When the per-call allocations for @locked_nis or @ref_inos
fail, the function returns -ENOMEM directly without unlocking the
folio.  Any later task that needs the folio's lock then stalls, and
the folio's dirty state is silently lost from the writeback
iterator's point of view.

Use folio_redirty_for_writepage() so the folio remains dirty for a
subsequent writeback pass, unlock it, and only then return -ENOMEM
so the caller can propagate the error to fsync()/sync_filesystem().

Fixes: f462fdf3d6a4 ("ntfs: reduce stack usage in ntfs_write_mft_block()")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/mft.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 4051b4823162..00f172fd1b21 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2740,8 +2740,11 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 	ntfs_debug("Entering for inode 0x%llx, attribute type 0x%x, folio index 0x%lx.",
 			ni->mft_no, ni->type, folio->index);
 
-	if (!locked_nis || !ref_inos)
+	if (!locked_nis || !ref_inos) {
+		folio_redirty_for_writepage(wbc, folio);
+		folio_unlock(folio);
 		return -ENOMEM;
+	}
 
 	/* We have to zero every time due to mmap-at-end-of-file. */
 	if (folio->index >= (i_size >> folio_shift(folio)))
-- 
2.43.0

