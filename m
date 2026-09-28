Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6DD17557E
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 02:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790560935; cv=none; b=cZaTs2EMNna9OAK+ENTQRNOsa2QIxVN0x2htdepLT2I8OcB4fqaoeeL08PKmHlnh2XxtyfyFZ//3X/uKNWB2aqHYE/YEJo4NYUEL0omMcBAAH/hZRTOegulHtIXt/6qtNrQuOcRC3QVUnufxcFtKNpxSSEESxhIyW5Q3oHaYps4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790560935; c=relaxed/simple;
	bh=urQbLGCXrd0ZFZeVKewiensfGBXy6svoBuruqY3dA68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUf4U7eRjGXdb6o8DEgOxUkEU5DFyqQOqfGsvBygGrUm1JQeoCjgNIey5b9awyuTIGpZ6OIRatixDmW84uyP0LWY27XXIDDTWkI2KMjAUliM3+99FgMw6sdABfkG5UbG6lZYgOc2W8u0YhZyHOKISitRN/ZtoHVMOj/KGHmXMZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDS3JOxU; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDS3JOxU"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e69so549730a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790560933; x=1791165733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ASjAUGOmT1ysmFExBD7PO6pvYBzwb00czBt2hidD9U8=;
        b=sDS3JOxUXnhYUEQ8AWzYnafjzU5CaYdRWCy5KO7z9GP32l3d+CQ3JouXbIIaHnijmV
         ybagc3WuN7c+zt4SawiNjSPmNy0Kje7D9rUg2h17YVQDjoV+RFq+OXlljp2fYsdjI0DZ
         SMfJmOH87mNfgFqzg9nUAZaGHlkqVsi1uXWIosbiGe1H+ccbmTxp+uJQHCDt41i7eyU0
         nMP1kJEmy79W+A+m0lXhaG657Z86k51ZyWicXgmFCSMEoT7GYTOJRxvOdGNKd3UNvIpN
         w2cnNWjhh7EZ3+jkK2L9pHMED/elCkFnxF3g811t74ozGFbnaqoFE7bpa6An/XFPYOI9
         Gwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790560933; x=1791165733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ASjAUGOmT1ysmFExBD7PO6pvYBzwb00czBt2hidD9U8=;
        b=Oo7ZY5Rr3bhPjeQYBlhTR7IIGrSTzzMQQhF+hrZ3WrLrR2jegEGygxmlWY/pPh7tPv
         GYMbKARy1/zzpH/j0r4jOo4+4lMTzd2UQfC0xyPj4cmor0YJBqQfLUpQzu1kxCh+Xt3m
         QpXPmzaII6LoKDvDzn6wqOOsLm6ZGPxblYDv73LvMCR4SrPfo0KhUJ6kelBWnEbTxjKG
         NnAlUB9w64ZIJIkvHDwcvuVsVauqZKodyv2xgUZA3XIej7d/zcu0ONvWI3x21vv/mFhk
         RJIzIOrmWHk2BUjSCwnWd7/3++kInmonHa8tcXHF5Vp7RZb8tfclrgNY+QnbNvIdwded
         Zmuw==
X-Forwarded-Encrypted: i=1; AKwUvBwKkKrGKHEFDWq3/ZruvymkdCZaNo+Np6KadhFhntQM8iIRKMphJaDX+R3+hQRTaN7obKYaNObyUm7duJUa@vger.kernel.org
X-Gm-Message-State: AFq9FYKMaNj1y0Qdi9Jv+YTb8Q8VUx8O50WxeU0k76drFr5qzoIGp+9x
	9LSMLIcZFw1ZR2WlReIhdLxYA7b0wkIyyDoNmm0Yo8Gc9Awvgjw4z6gKQ1B1lg==
X-Gm-Gg: AYBFou0L9j7jBw5CZBgKyLw5+2mqdq9XzgqiD3MIwWqSYXYTXx74HVFU/EFKKcCOcl3
	E1+HkZ4Q9lKSNU1hQy9y5vI+dL12YosPtAYtVeAqK5EpQ563E2p+D/bD8GjUJjR1a+hMcXv2vYO
	OAzZb0qhHUw13pXt8WVNJY2A9VKP0YjC1atSPeYrnWCATyq4nkEQUJAsuRG8zc7uig1VvryLCJB
	wW3vEOpQeeFvD5hoS5IomcMtVJbB8Gm3m8PUphWWJoECmlNCy1J6KkVlJr912965xuxbHEE1+qa
	KluhEm9E2ATRxCLTvK9sNE5B5N2cYl74dGoc3I1RhrBU1+MwytTXVWh0y5AC8GiBPo+n35DxJGz
	+IVLJpzLhHb228gwm7Psonrers/ss5v20Qog9Q+17218/eht1+MQMaShNKgGoj5+7r+eCP+a5nO
	Of9fKdzsuoSWC82QCneP6S4Rfo8syY1mGW3ekSK8ElbLNxtSTBm15t+pxdRxOKnQAZ4DxzRmTfY
	J+pS6r0UhXDX6djl3H1eA==
X-Received: by 2002:a17:90b:2b83:b0:39e:6c6a:208f with SMTP id 98e67ed59e1d1-3a09896d0aamr8645055a91.48.1790560933535;
        Sun, 27 Sep 2026 19:02:13 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0e05d674dsm4631129a91.4.2026.09.27.19.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 19:02:13 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Joel Granados <joel.granados@kernel.org>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Kees Cook <kees@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/2] sysctl: Two jiffies converter regressions from 2dc164a48e6f
Date: Mon, 28 Sep 2026 10:02:03 +0800
Message-ID: <20260928020206.977522-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yes, the fixes; the tests are already in sysctl-next.

Only the changelogs changed.  1/2 now also names
proc_dointvec_userhz_jiffies(), and 2/2 labels its reproducer with the
CONFIG_HZ it needs.  The code is identical to v1.

Based on v7.3-rc4+ (62f4c998b297); applies to sysctl-fixes as well.

Link to v1: https://lore.kernel.org/r/20260922031229.2300283-1-zhanxusheng@xiaomi.com

Zhan Xusheng (2):
  sysctl: Negate before converting in the int read path
  time/jiffies: Saturate in mult_hz() instead of wrapping

 kernel/sysctl.c       | 2 +-
 kernel/time/jiffies.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.43.0

