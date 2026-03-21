Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313B913DDAE
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774068335; cv=none; b=rHSFxBZn+G9FZUzho3GLj3nxtl4tskhxNyd9tWchYIF8ux4m5brXfGkSGyLv3UqaIetQGFljXVpiunT7GBn1lYP0vLYOydF3URj6JIVS2Tz4sQFPFNV9a6n3tALuBUAixVFFqouwGLHn3MaJeCMuVKp/+6/Oozn/Otlq99nU6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774068335; c=relaxed/simple;
	bh=l9uZtlPLb41kctCnjLr4AzYtVimH6eYU8R7RNcvCnYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZpb5IGVYr+TBzJi7GsPAvRyFTYTN0fIKE85mYdTb3MJfOh/XJXEudTlMXCLWErtDQbesDfNomrfdz/jW9EkdvNlsBfjQMH7xRsSXXBrqo8MsAg/lENvOOetQxoEFWqaRe3a5bNaqnu9eXhlbCTIlqV+6+XowW8dUp+5zA5iTZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDTCuf5U; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDTCuf5U"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c742882d2a4so523729a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 21:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774068333; x=1774673133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2LlKYUAtiABOZvAUle20IIBf1OJJzxfLipXWlkNmow=;
        b=dDTCuf5UTdymuZpLn8KPyLQy2LrmrrFdL+0HJ+XqmwCVm871rtDv5WIL38w0DGoar0
         yjIoy/2mEtV0CPxM6EX6LKtib4yt9SPefN86mR/mtbqnFxEpX8B5VHn2RfroovkIRY6X
         5M4L9wojyH1zYdR4g9e5AyF6jjI6j77o/WqEj6DdY0rPQwzwD9+uOubeAGSqw2kRD60B
         3fgM2r0etqh4Xw9cJfSjNj6yngP3aBmI00FA7VWJMs9LE4SEc4N1frtbP3jhJX47yBuo
         rbdsGVIlkmDcTfArWwg19RODLBPV9KYqBy5M3B5rR+vSSEhA/n1m8RiPx1tLkqOrocVs
         mdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774068333; x=1774673133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2LlKYUAtiABOZvAUle20IIBf1OJJzxfLipXWlkNmow=;
        b=sXXCIZ1ziEA7cTt1Vz418pj/3Y+BLBwRsGbc4Bm2qiyb7Ba0dNv/VRkkJ4Lm1v/7CW
         FgPU1KAUQm30I9eqcMbgta6hFAb19zBfsqb9forV5fBev6Od0BBpcWsmlNNDahXI4yGq
         zIXFcRB29tUD1nFY93rYn7BoF0z2YRWtTxM64svi3cjhPeWp9U6cyD4VhPVK2/gOc5gI
         8cBsnrMUhH/HWlRgy6jzNIjyt2HKLRdOWscmuoMBU4l/+uj/1Zi/FzyYHLthq58XI/fV
         9XORGu7p8zDLzvU1Qp2z11zQQI26Tiu0ZaxZCiYMgl1DD3n4c2TO3LabgLJxjTP+9Ddf
         k+bg==
X-Gm-Message-State: AOJu0YwnDVRbVeUTBEbXlfFkTBdR3ox73JkddygrCtLYREA9MqQQgBiA
	HxkM2TjGxeweS0lje86D1x8cn7cMZF80GBYI4Pgekxw0f0lEECRCxVaO
X-Gm-Gg: ATEYQzze5p/GCm+x4sufJ1Fl4DT4INuIijn/cwk4LB2i7fcvOCoFKZ3vEyS5AQXA9cO
	sgueYh2PdaG7WcWMOBzy0vArknxK/MO4zvPFvJ1xT5MyGRcInHuE3nraut/g68+SGpz1vAX1mt5
	Gly68Y9K3aZ/GtBXQADH752KTN1kj5xoNbSGEEKHInAeY+/wblRR10lkJ8kQe6KRjZg+/5/X+XU
	BgGbp3oWwSDXjEZ8XpgdMU1fEPdqYlrp+Hz0nmkhMn8tgzOwGMgYmpzXU4hXAZHeXIVvMV6q+41
	8MkvSv2SuZZe1vupjny+8kU/TuwaCN85CIzR6I8FgPUrn9Agy9uTPfStSO0BE0+gAe14GfzZk2J
	8rl2QZo8iHMIWaFdTt3tJ4XfRNc4Ht5mSLnM64ylVaQbYkebNHM9+VfCSiE7el0iw9lmow/SxPm
	/AlAGdWqImjOuZk+E9oxOrLe1X
X-Received: by 2002:a17:902:dac7:b0:2a4:8cd:c3cf with SMTP id d9443c01a7336-2b0827f0290mr50326555ad.49.1774068333457;
        Fri, 20 Mar 2026 21:45:33 -0700 (PDT)
Received: from paeyz.Davolink ([49.172.60.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836554a1sm38761765ad.53.2026.03.20.21.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 21:45:33 -0700 (PDT)
From: paeyz <iwasbaeyz@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@kernel.org,
	Kees Cook <kees@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3] adfs: validate nzones in adfs_validate_bblk()
Date: Sat, 21 Mar 2026 13:45:02 +0900
Message-ID: <20260321044502.2988-1-iwasbaeyz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026032025-mouse-gestation-876a@gregkh>
References: <2026032025-mouse-gestation-876a@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bae Yeonju <iwasbaeyz@gmail.com>

Reject ADFS disc records with a zero zone count during boot block
validation, before the disc record is used.

When nzones is 0, adfs_read_map() passes it to kmalloc_array(0, ...)
which returns ZERO_SIZE_PTR, and adfs_map_layout() then writes to
dm[-1], causing an out-of-bounds write before the allocated buffer.

adfs_validate_dr0() already rejects nzones != 1 for old-format
images.  Add the equivalent check to adfs_validate_bblk() for
new-format images so that a crafted image with nzones == 0 is
rejected at probe time.

Found by syzkaller.

Fixes: f6f14a0d71b0 ("fs/adfs: map: move map-specific sb initialisation to map.c")
Signed-off-by: Bae Yeonju <iwasbaeyz@gmail.com>
---
Changes in v3:
  - Drop redundant Tested-by

Changes in v2:
  - Move check from adfs_read_map() to adfs_validate_bblk() (Russell King)

 fs/adfs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 4d3015e3a..b5522b862 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -343,6 +343,9 @@ static int adfs_validate_bblk(struct super_block *sb, struct buffer_head *bh,
 	if (adfs_checkdiscrecord(dr))
 		return -EILSEQ;

+	if ((dr->nzones | dr->nzones_high << 8) == 0)
+		return -EILSEQ;
+
 	*drp = dr;
 	return 0;
 }
--
2.43.0
