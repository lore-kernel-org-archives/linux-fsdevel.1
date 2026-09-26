Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7653A9601
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790412019; cv=none; b=sgkha3CxaKBqAyZ5KVAKWOV9T+eo9oiG9/qwb6GZQXzduuw0XgB/4eemAV22/P+AzbrZxXc4wk6hjfMeTnwG0j024w30Gc0tDMxItjI5cSneZL7J0JHpIypoFeXBNuK3jawmrKOXXIhOPKc21iVUcmhErFzNkulqnAqt58Zi7Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790412019; c=relaxed/simple;
	bh=ePPCsoD0eRTBS6t96YpWTMjkH+8fm6mlOUnAJoCAQTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tf3gB8MXMXqmMtCzoZEU821ViBPCoAgZ1hYv7NxB5oUjYye5xmQXaXq29ZN/AcLg/N6iCs4RW7uS00vhqCuwVROzZqoUAWsWg6YnWUQ9WbqRhAZ4cwZ9eQZ3FEMO2VXK8q3qLaGENMpDfSdSQtLdR4Qu4Ns4BleKAFIXn7iFr8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsXhEvmr; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsXhEvmr"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13fc403e373so2544102c88.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 01:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790412017; x=1791016817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4wrmq3LsiUL3Royo673LJkZAcfu0ZIAo1VS53Nr3AWQ=;
        b=gsXhEvmre/X2YawVm4hi/liBrklBalVZS2giogdvp94tFjM5Lxdj43roN6Z7LCRiBY
         CJykf9X+tyTRUqfqwYWK1TCVq3QsBUMkiHfYu2aqx05bFCg9Yl9beS5s9bhglsJZ0RVN
         LV0BZga5KTna3+1u78qNYYXl4Ow23S1sPvuIvowl2YZSUXN4YT7FeXZPwQML4whE9mf0
         AyjuCdhdG/Blbcz8pXrPklQBaQmlrEod6u2k2B1H0qewgyUO42H0nfYwQI57tnOTeBDO
         qcNlWhgiwmpzXlniciJ0f7PxQwzGkR1kfHsdHixlTh7pjVD6LqZoMVfMH7vsUR3EQVWL
         TIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790412017; x=1791016817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4wrmq3LsiUL3Royo673LJkZAcfu0ZIAo1VS53Nr3AWQ=;
        b=Qi9UHx9SNh15WJBbtp6VaumY6njrNVw4sj3lc9s22ZJTrJJwqBrTnhQt65ZJ8eh6qy
         EFynlkGRNlYnveATYXiNLqClWudTbC/GM1srHisHD76a404zqbkKQ3WxGgm3UEIc32Ok
         wJttcP+9DwmLo4sb7j12wwKyuMd2x3wwLerw+6AsXnPYtkJzNa6ESRLtERS/ar6k2qZO
         /L7GS0IT8U37UukNSpMwE8kcl7qX2UVVbqd0L6nr7HxfzOeJiGOu7uswSMHdjlRuAYCb
         yYGE6SOtR77mUebTa0UodWOjWsAQxCku4TX59V8RHr94MIcQSbtHJxOp5WZpfBk/T8Pj
         PYAg==
X-Forwarded-Encrypted: i=1; AKwUvBzDt5QULeGCTG/qYm69DasGUapuj4jC2xzO8e+d2hu7FIu79PH0GuN7v+UwVCMsdGTiETC8oTL/8/kP2UYK@vger.kernel.org
X-Gm-Message-State: AFuF++l/nz60igjuiSlqc2msZGVr67Y2RPF4rfcaShpxOIObVYS19pkW
	3lpvVIqKdRw6vfs24v5lxwjpnBVepCmyqZHaOuOzE6M7bGDEB0NRmSdN
X-Gm-Gg: AYBFou2Q7vEyLY8co7jyUYTaKRXLVXL5f6dpud41+yXXH0aQctarlq0ylFrVVHv1yIo
	PM3dCWLls0jXAnkyxwltXYy62afDiKUK4wuc4EZFpU8e401yZWulNqFacV7fHnmwqZm9W92yyMc
	/QbXLeXH0UIRNIPpd1PTTRK9KEJn7SfQjVTevlNcJUMAp3DZKZ8QNpWW5wx7tkpJ4XT+iVseXl9
	qOSKpqqQUiqioV+OUUAiaiy7WS83OWE5+0zIPgrE++ZuivIkSEVHQCVoFbNcb6rHeXucpM14Cko
	i1IRG/Vly5jzJDCa3aVjES3JzFaESjAd51kb1IPQaKI8SfGniBGnf4hJVsba/WR2oPkFHlpzWA6
	MaezcUXT5lTzUa8JaUlO8llUjLGNb9EGy9CQWYWJqFcAt4l2/M/0Vw/U8hz0c18fsSH4NTsezGU
	eEtqo9Nx8+D1VZdOBQ+xsuZ1GSxKyQKP8TvzV8qndhqxuX9c1j34MQHqBz33MHrNJWz8kMN+XKy
	n6olQUxVA8BHCQANCpTocT+XLVMv0R/cm0U5L7+pRD/10paT/q/3oWuRpo27pRQQ+xVCn5J9jyY
	ToqaJJuL42vRAn6clc12NVDmBCKOvOouL71/IsFckrzMiIHX5Jyd5t2ao4w=
X-Received: by 2002:a05:7022:108e:b0:143:48d9:a0d4 with SMTP id a92af1059eb24-146cb5025ccmr2243720c88.0.1790412016539;
        Sat, 26 Sep 2026 01:40:16 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145a7318afcsm10487044c88.0.2026.09.26.01.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:40:16 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hfs: bound the partition-table hop in hfs_mdb_get()
Date: Sat, 26 Sep 2026 16:40:09 +0800
Message-ID: <20260926084010.569552-2-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926084010.569552-1-matthias.goergens@gmail.com>
References: <20260926084010.569552-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_mdb_get() loops "while (1)" around hfs_part_find(), rereading the
volume header wherever the partition table points.  A partition entry
with a zero start (pdStart or pmPyPartStart) leaves part_start where it
was, and the loop reads the same blocks forever.

An Apple partition map sits at the start of the raw device: the boot ROM
reads it from block 1 (TN1189), and nothing Apple documents nests one
inside a partition.  Follow at most one partition-table hop and fail
with -EIO after that, as for a table that cannot be parsed.  A zero
start is caught on the second pass, when the loop comes round again.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
A partition entry pointing at its own table hangs the mount forever
without this patch and fails at once with it:

  img=hfs-partmap-loop.img
  put() { printf "$2" | dd of=$img bs=1 seek=$1 conv=notrunc status=none; }
  truncate --size=64K $img
  put $((512+0x00)) '\x50\x4d'          # pmSig 'PM'
  put $((512+0x04)) '\x00\x00\x00\x01'  # pmMapBlkCnt 1
  put $((512+0x08)) '\x00\x00\x00\x00'  # pmPyPartStart 0 (self)
  put $((512+0x0c)) '\x00\x00\x00\x64'  # pmPartBlkCnt 100
  put $((512+0x30)) 'Apple_HFS'         # pmPartType
  mount -o ro,loop -t hfs $img /mnt
---
 fs/hfs/mdb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 277de712f9d4..1704f332e28d 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -134,6 +134,7 @@ int hfs_mdb_get(struct super_block *sb)
 	sector_t part_start, part_size;
 	loff_t off;
 	__be16 attrib;
+	bool part_hop_done = false;
 
 	/* set the device driver to 512-byte blocks */
 	size = sb_min_blocksize(sb, HFS_SECTOR_SIZE);
@@ -152,11 +153,18 @@ int hfs_mdb_get(struct super_block *sb)
 			break;
 		brelse(bh);
 
-		/* check for a partition block
+		/*
+		 * check for a partition block
 		 * (should do this only for cdrom/loop though)
+		 *
+		 * The partition map is at the start of the device: follow
+		 * it once, or an entry pointing at itself loops forever.
 		 */
+		if (part_hop_done)
+			return -EIO;
 		if (hfs_part_find(sb, &part_start, &part_size))
 			return -EIO;
+		part_hop_done = true;
 	}
 
 	HFS_SB(sb)->alloc_blksz = size = be32_to_cpu(mdb->drAlBlkSiz);

base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
-- 
2.55.0

