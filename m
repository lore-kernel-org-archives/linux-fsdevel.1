Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37253921DC
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549748; cv=none; b=Q/UfD3JrYUHio8Ow6KlTaVjqOyiAqMnvkr54Q4lsHAbgpS5Of05iguNBgTy0gy950Vuciy/2dQBJSxJ4NRXFH4/FoxjcJIpYXmqSRr5f/rlYckYdBt8MOyx+5KJhltAmruggdc7mPk2niOgGi2/wQ6Yih2lUhkDvDmZi4Fk1IVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549748; c=relaxed/simple;
	bh=eFnrmkaYsDaEg7ewvUnJl+9i8q96Ga8QEXuMYTx4bxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBd4dHzuLBOTLGOZA2J/53c1A7uh9ladY22Xyx4pLsBh7Ix3wV6b6No4w5eyV03jwp2tUrhDQqv5I3iUZfZLRGuqAYsiNlLX8otfjH5pZ+RFjAwVFzc2fUUEIh3uIvtHWIK3RLKcPSD1vTUiOe/ZWJIbnRK8xP49cN6nNgV3i+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5ci73Us; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ci73Us"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a337552604so3586499e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775549745; x=1776154545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0L5DxdHGgTgLV0g1fo3M5qT56sdXFA3p4Xf95pp+uI=;
        b=S5ci73Us6ENNKECtKs9y3pIcJnjIFkOWmwLQY92zqpotJhDIQy5uAXxFmZlxR4EWvl
         9RMw+y6jgkYg9vjgAgvqKPRT08vy73P2X8YitWHWTcPFblPJR58SgSaw8eoQ8RrcQeAe
         xHE9u7jgPah2rxKN63R3Ve6Lwq5MP/C20YI5PdphRmg4ca3KjTbWVg06Zc9vpBfHWLUS
         flZnMRL3QP+SlJE936kxh0FFaJm3s0vmUk/qyiQn6UrG9F4IgRfBVkkfdMexO+u10qfx
         HUsdXI3fYG67UAfFwoS9bNgBHEml88bwRFCEcDaqvtV1DkE6dkXFNN8IDeFkv0922j1t
         NY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775549745; x=1776154545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0L5DxdHGgTgLV0g1fo3M5qT56sdXFA3p4Xf95pp+uI=;
        b=o8skj2AxMBkg9zqdqVqDHCfI8jJDQG/5FzFRs7/AHqXmVvseQtvc4w0ZQX250GnrSu
         agBfnSKT8NZlw3ukjIBzZPPCzOB4l0qZdlD08RNoE4dGqTzpfpGkTrDB9n8VkLnrFIXq
         AXylui6/p7rsn2vKIVNg4tUX26zQ96EDILHxy9pT1Zl+oTIcEAScSVTE81FiXByDsq2w
         yIvwZkous32zqxedeaW4YEkDuXqKXeIl+Ba8njv9HhPpR/hWSqxu7YZq8RDxa6NQOaLj
         Y/5J5/2bmq7KW5op0doQyFqVHe0YcyUTS8XUaIPTvRrADOGlP/D6F6cb2GQEzbncDhs8
         a1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVeQfOaPwsyoityOfHvUxUi+wVJmMd5cMg7216hQCKkxRQ/5JKvt3dsKjBDmr8AB6v1E4cIQmRTbOLgJU4r@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+yOPf8ghSusuix6yGJ6tkfzAZx01d9aO5C2ZdF5OW+13aIJN/
	7X/Fg5liLjkT2PEUE/z/g1n5unVzXGkFKAh6N2wGmB/MDsejYz7IGCvK
X-Gm-Gg: AeBDieuA2kbMpTv0q6vON0GmkTiVZFxCcnjFCH0NT+e4SD6YEsgizGwStcfW+h8vKqa
	NhqigHNXA4N+6XNEg9PXWmXQrb8gbt7CzVukffQU9/oCkJAXP7sDQpAk3QTCfzltTxieO85cdaS
	XVCV955yGf/LMTWrbTRmcU8saehc00ayVN1Y+zHIGpvMveawgmSjCvNe3FrfIRybmjRDPxai/Dm
	m/fA6iZoB1tRc3Y7c/hfmZg4YP6MUiHtpzSjMQ9IVQxhGu48NM6/3cyrkIztSi2zAo5CQMJTCpt
	6IZm/l4CShPo+zAOa/QYDzipHQ7CVMQ2yMrOSzkw0ShEhBq6+GulBx3fwW+1td8Yb0vD63TajI9
	c709EuTlq8JpPjlAQP9gKIqQA3D9M4wQSwT2CMVDgKSCMUnC334zIMFD1QQ8rqB5poj/tljAf0s
	wxXh0SaNqQbFad+AGY7DC/
X-Received: by 2002:a05:6512:3d92:b0:5a2:bb45:7f21 with SMTP id 2adb3069b0e04-5a33757c21fmr5925103e87.28.1775549744839;
        Tue, 07 Apr 2026 01:15:44 -0700 (PDT)
Received: from agp-laptop.. ([5.180.139.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cd3698sm3937616e87.77.2026.04.07.01.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:15:44 -0700 (PDT)
From: "Denis M. Karpov" <komlomal@gmail.com>
To: rppt@kernel.org,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	ljs@kernel.org
Cc: vbabka@kernel.org,
	jannh@google.com,
	peterx@redhat.com,
	pfalcato@suse.de,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Denis M . Karpov" <komlomal@gmail.com>
Subject: [RFC PATCH] userfaultfd: allow registration of ranges below mmap_min_addr
Date: Tue,  7 Apr 2026 11:14:42 +0300
Message-ID: <20260407081442.6256-1-komlomal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of validate_range() in fs/userfaultfd.c
performs a hard check against mmap_min_addr without considering
capabilities, but the mmap() syscall uses security_mmap_addr()
which allows privileged processes (with CAP_SYS_RAWIO) to map below
mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() uses
dac_mmap_min_addr variable which can be changed with
/proc/sys/vm/mmap_min_addr.

Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
with -EINVAL for valid memory areas that were successfully mapped
below mmap_min_addr even with appropriate capabilities.

This prevents apps like binary compilers from using UFFD for valid memory
regions mapped by application.

Replace the rigid mmap_min_addr check with security_mmap_addr() to align
userfaultfd with the standard kernel memory mapping security policy.

Signed-off-by: Denis M. Karpov <komlomal@gmail.com>

---
Initial RFC following the discussion on the [BUG] thread.
Link: https://lore.kernel.org/all/CADtiZd0tWysx5HMCUnOXfSHB7PXAuXg1Mh4eY_hUmH29S=sejg@mail.gmail.com/
---
 fs/userfaultfd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bdc84e521..dbfe5b2a0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned_range(
 		return -EINVAL;
 	if (!len)
 		return -EINVAL;
-	if (start < mmap_min_addr)
-		return -EINVAL;
 	if (start >= task_size)
 		return -EINVAL;
 	if (len > task_size - start)
 		return -EINVAL;
 	if (start + len <= start)
 		return -EINVAL;
-	return 0;
+	return security_mmap_addr(start);
 }
 
 static __always_inline int validate_range(struct mm_struct *mm,
-- 
2.47.3

