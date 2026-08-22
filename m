Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1825493650
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787401032; cv=none; b=Xjabx0JE+P4VERLOIsa1rHpt1pJ7HQ1JnXWE2x2PiYEGFMUco9amKC0aeyGuyWCooaaB8mCHVzSbhPkpPb4IJSGjC+VkOqEMAnP+4dWvxDQ9jujw2Yxt2uAycQmwKGay/5+xDWHdD4gk4VboQ2+ScjE9tGh6UmeVk+DGmxblIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787401032; c=relaxed/simple;
	bh=S0snZ8uKMMHY2KvFdwdzpAL19mHXE6f76vdtkx3uAYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AKMrQMzQV2+0Lfv7Xv05vONSVxOd8cKOIfvumXJj0y23zxj0lNsaoWraUpEfmwVTdhQ5vyDK2wQfioYMheT6c5/s4Fb06QObXqdDFmGdVMW1OTWsQBiIfDkIrM3+iIoZX3nQAlhHEw62VHHt0ppHWssPg4RcYGI23FXTR/alr4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNnzjQkH; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNnzjQkH"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a051b737d8so2543903a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 05:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787401029; x=1788005829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8zamBZylGLfyBrf2U8aA1K+M4CwgpdMHKvZaU2DV3CY=;
        b=GNnzjQkHEMpUlBlX0HS+ZiOrXzdf5/b3IH75IiEYYfMHBmEFBDTaPzzfzgiuJCIHOL
         uEr0eEVpq6xaz0LPvG9gy43lFLFt3P6G9iK57RdL8t/JZwlobuPmPcmBzrMWg274HuSD
         ie+ozhiPEDFG5cmj047lwHmZl6ss8tpGdaxLsFUkKnW5hDoMbTiLx/W/wf4vM5Y5LaAw
         x431/+GdvRv5EPPczvW5f0oCI3m1sGjuTShp8Wuu6O0dTBGP7SPiXRiEcQYnSU+bJpKh
         zLFp6XxaP/3jHnQ1pB4toHWMGEnJP5jVR2Oj0/Vu+wSfNuPp+NHEPH4HYJhr/Ye/Fzkw
         WiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787401029; x=1788005829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8zamBZylGLfyBrf2U8aA1K+M4CwgpdMHKvZaU2DV3CY=;
        b=a0K/7k++6lr4TJSQDNhmDE0cw1VmWN/6zxLcyMkmWcKc3ohWGnFcA6aRK6jmJn2tRT
         uWH5H4Hb8Q8z3brox7NObijnSsYOHXCemw5PdbJNfTseLGx+fqiKUF7qjqpHR2QqsrWV
         nLDGl3Z2OxgvJOu7hRrHHmJ/vOS9IvHF0Exji/UYDtrdMId9fOD/+8uDQ8QAdv4gYtkh
         e4CF+MUKX64D0cJhOzNRXQWzcEh6kVPYIuX7BbShD2QlTAQgQQjCJdtmbEW1Y9MglVlg
         qgGi5RIXS+9o1tTGdK3L1lpDaVxrcf9xWm++TTzvMJZ6Lzc3QkdQDm7+g4semZRoFW+d
         clQw==
X-Forwarded-Encrypted: i=1; AHgh+RpgzMEqcUIaNdouFnLzDDBBS1VnGXFCU7IWSJ61ELFf+euGSHKw06x0wxq1KZp1ChJUJ4KD6DBF6Jkih2Gi@vger.kernel.org
X-Gm-Message-State: AFuF++mm9o+Z+vS/NxXOzYBHQZs74k2WrUSxd2q/Sy2tnm1yz7IJqHyt
	UHkxDVSE6KI4OYjLiaH1IVHozjc2O1pqklyXuRIeShit24rIEE2POvfq
X-Gm-Gg: AR+sD12bQiKM2l8TdOJuq6f4+bZjZnHGdXB55LaRPm5gTqb/dTu/TdWwSZTEAoo+czP
	RccFdtnBSVfXPdVvl++vYbpV7EdKZ48JQWeh5taaqfuPYlyrBBTKldfDs26uhVWIs3xEFUe4QWa
	IC+8l+beBV7B0sFfBo5pPbp5kXYF7ymQxsyIL1Yp7S0FAIeqgTY4SWgqAv2QTwuWVOG/3FfqGVm
	yC/PscV+oeFbuFZ7005wZ3MsSnd6xQD+7GbVNTp44pZrgWt3ptsvAv5RO0C14XycGAzMhBdrCod
	VNtmkuzNk5RVcfwUC0qMjnx6va+I1mskWynf9JxtTKAxXfe583+BkgqYm8i6ExYsQXuHTwyuB9+
	Q09vx6WH+4YdltVdvxgoqozqJlvYl9Qdqn0h+eZl9dKPJG1VnKrSbpLP6yHvylsUAcuDUqLAPFg
	6bdz/v7nYgDoKAS9FHSnj52CE/QRq1QnE2Lnffv1rZS67eBjU5jH/HaeE841hOkH3DcWIyGqzUu
	TXHZcvMOl4rA9k+8lZHDT6SkmpPvOZXtNX7b+yrj+fathirc7xFBPCE6MwWZnsJc7gB578kD2Sb
	jBEbk86uoNBtIf53onH6qU2EkQ6Vp203GX88md0IwYq0hdC5qDqYP+YAbftzvF0pTYVE
X-Received: by 2002:a05:6402:5042:b0:6a3:eb58:dcfb with SMTP id 4fb4d7f45d1cf-6a42f1ddad2mr14242382a12.10.1787401028842;
        Sat, 22 Aug 2026 05:17:08 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c30casm10998322a12.7.2026.08.22.05.17.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 05:17:07 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] docs: xarray: Fix xas_try_split() name
Date: Sat, 22 Aug 2026 14:16:50 +0200
Message-Id: <20260822121651.1559-7-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260822121651.1559-1-kmehltretter@gmail.com>
References: <20260822121651.1559-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iterative split helper is xas_try_split(), not
xas_try_alloc().

Fixes: 3fec86f8aa8c ("xarray: add xas_try_split() to split a multi-index entry")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/core-api/xarray.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/xarray.rst
index c6c91cbd0c3ce..3d2b20c05a937 100644
--- a/Documentation/core-api/xarray.rst
+++ b/Documentation/core-api/xarray.rst
@@ -490,7 +490,7 @@ entry at every index to ``NULL`` and dissolve the tie.  A multi-index
 entry can be split into entries occupying smaller ranges by calling
 xas_split_alloc() without the xa_lock held, followed by taking the lock
 and calling xas_split() or calling xas_try_split() with xa_lock. The
-difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
+difference between xas_split_alloc()+xas_split() and xas_try_split() is
 that xas_split_alloc() + xas_split() split the entry from the original
 order to the new order in one shot uniformly, whereas xas_try_split()
 iteratively splits the entry containing the index non-uniformly.
-- 
2.53.0

