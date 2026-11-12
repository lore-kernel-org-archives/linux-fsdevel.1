Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482271;
	b=hitSKmXpvnhfuNG2Oj/JCd8+bsmx8NSsddQScijEeh7pPBF6rfoPSWcU7/UuMabLCjHj
	 SLRE8mYHlREtbK0vGVWFnw8kEFgLrl6yfPPm0dGFWAvRne38ZHverBmXIkpmhQ2guAZqw
	 pQxsOkFE6RKRD7c1PINSe2uFUOjbj9LbsNqUx8nFfFIhHS3rVtJqELTMz3enyY4B4A98q
	 Re+z5e7nE9nc4+vn0LiDYJWDSVg2s0MyDnjqoB3+9i0j87DsU1+Br0tE1miD633pExB1g
	 nQq/qZjXP7EGcRyOjltAC6rsLhYRMWeJIjABEAzR2wPJl7Vibt/SdMBY5BGvyq6ZgaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tR3skobAr2sMjA6rolhmHaYXFJaHuy9h+iD9zoIL62I=;
	b=3ElVIkwX2X1mT07w5FTERTbt+K7ODNojOcNTb/tMDznKTv62n+USVgiJCY1JP/YN7RSV
	 Z+H4sHMNEMmxWpN2pKOhYXgH6dNIb+NVJG/nJ+z3fvE72ynp/mArXVusjHLbeWn44ZJmG
	 5WP0v4MQrB0OXKrE4ovxnCGTIiwPMJIH9mjAoygLD0mjGzf8XzD5gfuAp/lFqB4Ablnmw
	 F3HyWXhc9r/fFqWmavk/c6zNVnVeU19NR+p2LbhlIdNwZGRCv40laGPYD1UPfNZDNkH/U
	 ULkjky3WQNLiIQeBt4s4ZP8v1mdlyPedi5r1Ji3e/OLExo3Z/ZQTwrJn5drz7wQyLFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=GPZHYsQn;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4ED606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F4ED606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=GPZHYsQn
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f3c616c84so390155685a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794482269; x=1795087069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tR3skobAr2sMjA6rolhmHaYXFJaHuy9h+iD9zoIL62I=;
        b=GPZHYsQnIlFOia1laiYlcQuWc76+tu+NFBvZ1ns75K1PPcu6dRv7LfhFgko9dOLLf5
         SON1kfue0V47sPzCBPIKn60Ylres9661af56ioKIc90wQmwD690Vhdfk5dtvlIfcrQg/
         mCSW5cI1hS+0tO8PfqjVupgz26ygMR/GOEvPYCrzcuVyndSjPOkOyl8hwIkXt5z86ZFL
         xfeN1fgWP3vnDczTdrtUpLere4HvHit33PbUMBicCF7VDrFZW20QTm2jiSMBYfSXFif2
         Vz0CrH1p+I1vWQPUScHbHfPmp1il+5/NiuMDjM13usmJY6jIfYlxLPEUIGL/TKdlVlUT
         cVPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794482269; x=1795087069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tR3skobAr2sMjA6rolhmHaYXFJaHuy9h+iD9zoIL62I=;
        b=CffChZHwv2ApO0EV8QvZNwQtq3Pr5ADMHA9ONwjgcWT8ZPZXN2pZmmynVwRoBQncEW
         ku6j4ou/tUTbUiurrFeIP2W34EzPZhpwHshb8ikwF/fAnw6TdOHzQh4t2NrKj8z7wqR2
         2paXhS4NGJlmG9GYZVK6JOQh2CmM/Uz3ntrl2pVD4Ya3Cku8mTyWeKbLkK6Qj5gqyBjl
         sdpV5qdF9cxeUHzPwuWwnyp02OxRW3NEIB1pOkBHMoIMNd0t4dsvunxIhKBepapICIdO
         QYmGWy9y5dMyvJYjxHJD7DJY/xUhhYwo8VqIVIfra1ieActZ2BTPADp7I6kyuXVTOE1+
         mrig==
X-Forwarded-Encrypted: i=1; AL+hErEbcPVlA8NgWRS8u1SqQAzH0WyhZqjcNnsIFLdyRhJPLk7xD5CAhKEqvnuGYF6YS8I0tia4xKFOu+Lnk3cp@vger.kernel.org
X-Gm-Message-State: APuU4Z9UWnTqcbU6FB0o9aNLmZb3H/1qQ/5Ag4bVP/U6jIt55gYNFpC1
	CQ7H7Q1zLOP8dj8VDbpm2FlJDvdX100D83LJ8baKFem6f9ebAGCjxvVhjrkbuzO02GkoiSWcHK5
	mojlEyg==
X-Gm-Gg: AYBFou28jFN2UnhioUaz/bd7zo7+uDotBcrCasWJI+8qI95s1maiMd10kMCSj3xAj4i
	U6cr34XYcnFFoBrWH5mLLHOQHWAhej50lHThzku/xoUZBRE9dRgD7n0y0GEi9WvqEvKTJDcugeG
	Yuvk4wmZaizT2s5iis1CvFgfXA05lT4JNCwhKnKOctKIBtPTGll3JGxlAaiGG7lWjuRpSLNgJiS
	CulYuQIeMBRAXR+/OK+PYukBgXgR9dtPvC2H0KJWIKdFmDDkXb1LFw7wRw9LibdiWkPZmsmnb8h
	4YlfxTuP29YPZXQnDPGFQYClCErm+gDpCDfLdhy0mhteg7yS6eE7nT+PfVkczSb5dUoQr7+LeFt
	UUJKcgmLi41wENOW2s6+xGYXWRGpl2d0/v2dO8Fs821E5EMyiiciThJKq8IzHhG6dWuhhwvv/dl
	MXeHP8hH1twh8pt5jcsxNCeKkAbGp0kXfvOnKYuC5JZmiCDswEsbBBGHJOp5S/TmQJMR+G7Dy6+
	d0NUk3lB/U7/9evFUCml5BsF00QyXkEIQhTgD7ynH5ArBkzEmQXHPjCy1q6ekwvPe+KeTVhOu+J
	Fod1hjIE8rzTnrdxVvQZE4DiJSSQgWrvJWUj1w25R650W0/LieDz
X-Received: by 2002:a05:620a:4712:b0:93e:c12c:9dd0 with SMTP id af79cd13be357-947b000ce09mr893234785a.80.1794482269108;
        Thu, 12 Nov 2026 03:17:49 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c3ddsm710100585a.15.2026.11.12.03.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 03:17:48 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] hfs, hfsplus: do not end readdir early after an unlink
Date: Thu, 12 Nov 2026 06:17:43 -0500
Message-ID: <20261112111745.4094283-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
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

Since the readdir rework in v7.2, HFS and HFS+ end a directory walk
early when the caller deletes the entries it has read. Both filesystems
got the same change, so the two patches make the same fix.

Tested on hfs for-next with KASAN and lockdep. The reproducers pass and
generic/637 still passes on both filesystems. A run of 30 generic tests
gives the same results with and without the patches on HFS+. On HFS,
fsck finds the test volume inconsistent also without the patches, so I
ran generic/013, 028 and 637 on fresh volumes six times each: 013 fails
and the other two pass, with and without the patches.

Hengyu Liang (2):
  hfs: do not end readdir at i_size after an unlink
  hfsplus: do not end readdir at i_size after an unlink

 fs/hfs/dir.c     | 27 +++++++++++++++++++--------
 fs/hfsplus/dir.c | 27 +++++++++++++++++++--------
 2 files changed, 38 insertions(+), 16 deletions(-)


base-commit: 34ee5f8c2198db9585da6c181c50869d2eb43c3a
-- 
2.53.0

