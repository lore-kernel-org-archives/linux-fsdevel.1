Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.0
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793485716;
	b=vJmAgijeg9ozKJJdbF0DZKc8I3zFamhgc/cWPdWV/Qw6HwfkGXXWXayzP+bAQMQDQaNW
	 ZwB66JHSWdxo0zdD/mjQzGM6YiGAUbCNLqtQjiPwSrHFrceDk/Dhzk9jZYGi/4T1TKOkN
	 Ara2TsTi25kOLG4RB9fcjhmGnllObE+D6jOtmXV8xb/M4J+kMlyIGV4p2RkbdbzTx+PQl
	 /iK2ZDwJMweRe+cdaL1UMIbXU2tspIDB3tsPlbfY72Q5O5OyAxfNcKUGpNaDinRkHcHXQ
	 BBC20Fc5Pjg/DFkgoY9MPAKyyoyLwIE1qViRr2MOnN+qLxgUShgUM3YBEZG5jVZy64Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793485716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m0JnkbHJkuPfCHVuDrGb2+stBd0JEX0qG9o4dkUA+8w=;
	b=FUN9sgOhr+VzZLEfzG9a1jYe0qaxIF4zsxwz+u+4pNldsj70UrpK5Re2ZTTf0WLbhsdS
	 FEhbcgmTRIL8Ap0luZSN9DDLHaCSjOQP2CA03QYBEIRKW5dTB/y3C7w2+GBrrdGR7Gxi5
	 gCH3OG3GZb3hSGgFwSzPkEtxPpnj18JA8u7BpLb50mrrrsgIQtYl6OuxG9DnWu8LabIY7
	 GTAMSG1VSHsg5OY4Oye7VoYXmSAgSuf/QcGDIg+6vgE9QPrcHDLBC3lFiWHWFI3pxuH7Z
	 yq+z3dRoNafrhf2HwPzKJhEFDWuCaqQFQCjL5sooTQHayOjvuPoLz5K6bFB9ft7OCcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgBwhI3y;
	arc=none smtp.remote-ip=74.125.229.0
Received: from mail-dy2-f0.google.com (mail-dy2-f0.google.com [74.125.229.0])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EBF606A31E
	for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 22:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8EBF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgBwhI3y
Received: by mail-dy2-f0.google.com with SMTP id 5a478bee46e88-3117f9b9e64so152339eec.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793485715; x=1794090515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m0JnkbHJkuPfCHVuDrGb2+stBd0JEX0qG9o4dkUA+8w=;
        b=dgBwhI3yf26UwLuKeQmvpbcyMU2C7cg/wIucp8d0W3AG3ij8p908y0P0SnXHzdgBAf
         eDjsBGtjxZexsV9LTvsQNcgAApRVYuJSBOt70dJFXrbXMFZqIOPfv43Zf1X3q8RhkuLQ
         JzwPEExMLvjlDU8NlwAuUPLPFlxacleKM8j0ORixD+u+elvJsoaFqYr+nqiH+OroB8Qr
         WYl9YK4Iuf7nJthX3782Bm2aZi0Q34XRBMMXkJOVF00AdhVYzSEW52+Y8qEIIsLEXRz6
         yoRMLZ15xJZ/m7NHWQHvrVg0XZs4Fu8csJ4PvhxrOPRcwW9uLdb/mkJYAFo84BVK8omp
         Rtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793485715; x=1794090515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m0JnkbHJkuPfCHVuDrGb2+stBd0JEX0qG9o4dkUA+8w=;
        b=2Sm+j9NZsP4vngFgroeCSf80erUDuZFtCFPvRBFreXukGP9QmHamGKJpeJQ8ChPSD2
         P5cTFA82dfg2kLlCG3yX5ixtqY7Aa2gjGCmrZMcy1loKxfLeiF1RmIUmKM35x6FT+X9x
         BqVqs4SmGJoxcmMurnP4Cgg5Ik8MlyDELMuzS8SWGKL0vRweSYSfMnHccagxCmAyrr5o
         1QND0uzCnVrtcOZRok6wXjIKew9N9NV5o3iKC86A8RcDCmPA/fgn+QV7bSAF5i3oTIkx
         rYqDMqPM5WMFhkDqCJ8zgFNIgO90QWkWtp8bB2u5YEJmpHcbHozHWW7uGowJGSPrADLR
         fxJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJ6d1SGpO0gfo+0RnEyFYB8zZ/VXLGpOELqFm/OEnNm/vXBW0hoGkwi45jBV+QVkSbFtR60IaSJdgKriFi@vger.kernel.org
X-Gm-Message-State: AFq9FYIBoL60I0H1ZBn+ynKDc5da/e1Pr/xeU6elAhT4Vmq8wec70prI
	xQYUmgelH5b3m9QdnqWNP1TFscuQBlZwsr4Veeo01ULSp5aGwuj97dLW
X-Gm-Gg: AYBFou1p5mhRdRz9NNxqgmGQfPz13wHCRx4xHv1KZuSU45gnNHk3ChnkK3cRRorBJk2
	VEdo1rOMLoectJwRxbnwaSsx+Ga6SejRChTbgWPjlvNuIZ/RhdtRsDtPBvDp2NOfXPmsKvDqFw4
	2Wa07fcvRcfI6vNNda+z5g3UMauCoj0UvLPZNm0CuVhrOJoMbbBjasg8eh28XT/49uiYrN5K5CT
	MFHnxgIs970wp+0kqVvwgQgRv1DAM3ThxsuaAfII/OU0OwBJIvVYLjUahuTS6SYaPISkE7LaDxC
	yel9D0FIHoX5OFuz2x+9yPAl/km1qGid3Wey5OZEMY3AUWubtgTOs8Ta4oNVN2RhQT7o8UjPqkF
	w2CQDRzSidmanv1QptRSeoVs/MW0QBXIepSfksMr2wN8IynN7JbJHmXh+Q+I8ej/glK88CaBcW3
	3v4nUoBl4gdmH/1RkO/jtkIXY24ofLNlqf1/geKZEfc2ulJ5Avrs8D5QzYGGpZnWFzKeeyNboaV
	+whG/LIjaSMyyFwOn1T+Q9x2YCaBQ8bnIOB3m2ud470W8uFxSLMwJqR99STTWQtU2myA7DvgoaX
	Xa9zNLnkSwu38wnrEPd6Fzacce1RLxken5+RKZ5Xp9vfI0Z9QVFWt3ER
X-Received: by 2002:a05:7022:5f0a:b0:14a:a6dc:9cbf with SMTP id a92af1059eb24-1ac599f5078mr7780009c88.4.1793485714706;
        Sat, 31 Oct 2026 15:28:34 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1854d925sm33876066c88.7.2026.10.31.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:28:34 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	exfat@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] exfat: preserve the 64-bit FITRIM minimum length
Date: Sat, 31 Oct 2026 22:28:23 +0000
Message-ID: <20261031222823.223-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The FITRIM minimum length is a 64-bit value, but exfat_ioctl_fitrim()
uses max_t(unsigned int, ...) to compare it with the discard granularity.
This truncates the requested minimum on both 32-bit and 64-bit kernels.

For example, fstrim --minimum 4GiB can trim smaller free extents because
the minimum wraps to zero before being raised to the device granularity.

Use a u64 comparison to preserve the userspace value. exfat_trim_fs()
already stores the minimum cluster count in a u64.

Fixes: 654762df2ec7 ("exfat: add support ioctl and FITRIM function")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/exfat/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 1386149916bb..4e7a2fb30279 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -586,8 +586,8 @@ static int exfat_ioctl_fitrim(struct inode *inode, unsigned long arg)
 	if (copy_from_user(&range, (struct fstrim_range __user *)arg, sizeof(range)))
 		return -EFAULT;
 
-	range.minlen = max_t(unsigned int, range.minlen,
-				bdev_discard_granularity(inode->i_sb->s_bdev));
+	range.minlen = max_t(u64, range.minlen,
+			     bdev_discard_granularity(inode->i_sb->s_bdev));
 
 	ret = exfat_trim_fs(inode, &range);
 	if (ret < 0)
-- 
2.43.0

