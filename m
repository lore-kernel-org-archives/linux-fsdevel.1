Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540104779B9
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 17:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569673; cv=none; b=ZAJogkTvImAC8xebMrV5RugLQGhblAB/wJWN93WvJkSiMqD1cZp9EYiqDtHwRRMOrLf0HtZCghq9yFigsgUvTRgoVAwzLlsX8d8KdHF4YOstxNfDahbY+yztm++BtafcWZeU7QUFGpTWPE3I9+56AbDhqjhyzfeluoQ+7Y2yg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569673; c=relaxed/simple;
	bh=umo4zIPzLejFoJtAFxdj3s7yRQi2X8Xhk9rRZgAVPcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IahmiclgRh9ha/+fPFlRuZP9PnhECy3Oip4MRAnzbgSzlG8p4iZmw8dPjiMaRua5deAkhlNxxjh6RdKiq8Z0F5Iht9Vf8leeu1f5f6pAuYhCiYTMVbHou8UiAEkwTVIShjhKKukQT5VinGRaxlyg1H4KFtqFA8UfQUn6HoXUkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+4B8sGY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+4B8sGY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b249d6ba0bso338195ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777569671; x=1778174471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6IbrhHuu9LdihQtZR7Baqf3GnWs6lIG8jJXLzb7smA=;
        b=p+4B8sGYdZkBwT7u1Ri4neTsu00fmKitfGh5767VBrpUEpLHwDPXXNuFHE4cixHVL4
         lsoEZNAsP618HIjTYJXHfNC4V2DpJMPaFdt87I0yp7OmyqM0NqeDb1d7MtEqkK2AzoQZ
         +jyRgxFIIR7gYC91lPzLxvQ0tDAQHu4k5rNY5WZPOH8JEffUPkftp0+tmbl1Y8m7s9Go
         sz2dtgf2ZgLHnHs2ytCaUTNQYH0yQFfdSLJZu66uycbZs1lzWmgckYSqr7L7OTffJTWr
         cTXZ8RtTcabSMNmX2O+FaR6TZxOXu9cPq1AtdR7MBhXZFoBco5wuwd1TLK/+VD80p2rp
         FSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777569671; x=1778174471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J6IbrhHuu9LdihQtZR7Baqf3GnWs6lIG8jJXLzb7smA=;
        b=PwbaA75rJ1uRWLGHePcskffiTBIIFWyd0PU0Gpe8mTLF0HT22GsSxEJtuJbmAJ7s1i
         qSNh0rBokTYkVxrzjSCPDhm8JqUTIEin6wmb6r23UQfqCPvkWHHaLo/g63Mx1CgItG7a
         OlrAb9dAy2qmJb43CLhCUHseVsj7+8c9Uyc5bEfVnWObvmxbte+Ll+SxIBYLXIKJk4h2
         3FHusDjRKuXkqBizk4pYTtedoq9HC0LumpCaicFH5GzbIPMAlV0PQQ/cFmrhfQ9hEhG/
         XVs5aCSlAJiJMhFVolJOlt9HWkFDQlp+S9hykJpnowI7NYnmBIS5ISzae8PZurcR66j+
         wOqA==
X-Forwarded-Encrypted: i=1; AFNElJ/QXLiNGAIMXGQAta18TiwLcHyH7KD4MFLGDHdZ8oV4fnYA2AOsw2w/EpUUzasj8Vpbvts03ixRCVGZGqjk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41DuwYowDO99SvYE6dbKn9tchVqGx5he4/rflYZhBCJ6hzLNP
	HBT5s4zD0R/kfi8OVi7TURFt9Z1xx8MiX/LqTOXelj4PdPeEIS9g9qiZ
X-Gm-Gg: AeBDiet8UcX65JCskY8RD6M/+4oEcyCq++GVRsgToXXuDS2F6hS6GymiFfHJ0gblqQn
	dzhzna+YE+cYfIqp3XEWG8sPOgSBl0yEI7AE3aBt4JrtNNtzF2orymo2Nj+jkA5QvK6fQUdBUPs
	h1s0QqmuxZBb6hxfNg4EmZMsO2bQc4YmFsD/Sjw5B+ZLioUPnASsEKi1rhIuTbPjqB2Hu/sRVve
	d3/2pE062XDDfikSYndvv8sEzNp9ORduqjn+6lR0ln2iYCdrJx6XCoQVbjrqMsdBrDJFLkNbBva
	F4XL0qD4UjuOgmnpmnCEYdMRVc3Hx/2fj1n0hwRgV1BtqO7c5KSPT0A0ZfwDPWnKlKMpHitsydp
	JG7ZkWTTuhvFub8uGpk4xykgzQH/tpxLtKbEM6eZYw2ejBAbS/auAIBk6MVnYNGxlNBF0zlwFRX
	S0gr+Sny1xK7sgWjNe8Zi0rOV+Tbg=
X-Received: by 2002:a17:902:f650:b0:2ae:3f3f:67c4 with SMTP id d9443c01a7336-2b9a1cf7d35mr21854375ad.0.1777569671378;
        Thu, 30 Apr 2026 10:21:11 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e7besm2043795ad.12.2026.04.30.10.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 10:21:11 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 3/3] ntfs: capture mft mirror sync errors in ntfs_write_mft_block()
Date: Fri,  1 May 2026 02:20:55 +0900
Message-ID: <f83cb152b97cbc98a4850caf0a23a229db5b9e98.1777568957.git.charsyam@gmail.com>
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

After ntfs_sync_mft_mirror() became able to return real I/O errors,
ntfs_write_mft_block() still discards its return value at the call
site inside the per-record loop.  A failed $MFTMirr write therefore
leaves the volume looking clean from the writeback path even though
the on-disk mirror is now stale.

Capture the return value and feed it into the function's existing
@err variable using the same "first error wins" pattern already used
on other failure paths.  The error is propagated to the caller and,
via the existing tail of the function, sets NVolErrors so umount and
chkdsk see the volume as inconsistent.

Fixes: 115380f9a2f9 ("ntfs: update mft operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/mft.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index 00f172fd1b21..866816f710b5 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2862,9 +2862,13 @@ static int ntfs_write_mft_block(struct folio *folio, struct writeback_control *w
 			}
 			prev_mft_ofs = mft_ofs;
 
-			if (mft_no < vol->mftmirr_size)
-				ntfs_sync_mft_mirror(vol, mft_no,
+			if (mft_no < vol->mftmirr_size) {
+				int sub_err = ntfs_sync_mft_mirror(vol, mft_no,
 						(struct mft_record *)(kaddr + mft_ofs));
+
+				if (unlikely(sub_err) && !err)
+					err = sub_err;
+			}
 		} else if (ref_inos[nr_ref_inos])
 			nr_ref_inos++;
 	}
-- 
2.43.0

