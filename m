Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8869A306746
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787401024; cv=none; b=Dbs3utz8qF3l+zRySzOtHO8ABUV0v3aEZhPhMVXoCHoC2WTinRQeFLse2BXjI67K/++Yj4ZP+AFcW4iWsa3ogUnU+/J9mddoriELyZis3+apXW8eF6IQWpa5UlB3napA/YULC1VfrA9rii0u/p4Pebc508eJAgBqdsSb+WsMTvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787401024; c=relaxed/simple;
	bh=UyjqKJihcX+fex0/pp/SeTJ1UlazmQycm9DjA0TUdpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wm4dFdy0tdAuL9Eq0sIWH2bV8uMjRaY7Vs92Jo64WmLQ8mqbivXZgcTdi3FXDAQlGcb5oazw74DpxptVlESbRvYjrsjN8B4AMITnHly+t5WQVdsXGN2PUWoyufFyBcyQ1V+LcAo06ZxZRzJ34BOjncoZpkGp8RUlptf/87tfqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q8AZkByJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8AZkByJ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so3798386a12.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Aug 2026 05:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787401021; x=1788005821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jsN6LvX9NPfCQNk61W1iZUjewLQksV8dhJul9MwmJzE=;
        b=q8AZkByJ4QSNljimJH4X/bBnZYkftpiXQxowHqp7FHU4I/9TQngMrDrWHWV4Ds96+p
         W5Gkb1cT90rIJKUhpgzm+IWXm1zTBHD6/hwADeldOFAUj5ZnKpD7dmzL6YdrQ+rIRtbu
         s+BQXRhBEvxipDdDGQ4xuQHjYa9WBCeGMO6qUskk1aurJlDvL3wjWgMKJplSQFp1zZ6I
         YOTNVB6IzSG8m5SzcTW0IGqPk1c3Z5PWCgtOUceqZ91wb7JuOqL3AvrpB/GBYpaxAlfk
         vbuAhsDXGyDSUFhE2ahwnIhWu4Pyf9KfFlrgDJ6zm8VK+Z7Az201oEA0xO9IxReFXU8U
         uMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787401021; x=1788005821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jsN6LvX9NPfCQNk61W1iZUjewLQksV8dhJul9MwmJzE=;
        b=Dp1VFOp7NJYlQSYGCIs/hc/OGbCN38yIXtPklue/sFlw4Yqiw4YNInkgca+Zxp4xlh
         jD+g2SbyVp8iogYVBkvSH7Zcs868GBtheBjv+Cg0UQym7gLIhhYSUulOIHLMpPq/CFLU
         pnGzBGXooabrdkMHTwutDJi9l5HQ8vRzMSV3sF2SKd4A1+eMXzx/fwqPaEduBg8KEtN8
         pjyJKoDdaqsQPgFZt9l6mitbsbaMIMkd54giW5LxKVuSyXhzy/e5wRIeFokxOkd+p5iP
         3VsAe2tRmPtIFmrdI4SyJZcjznxUbxGA2sg67QCgs00YSZyKZyq1hWQq36lQn+pAHqJs
         2orA==
X-Forwarded-Encrypted: i=1; AHgh+RqtMo1zLUIOzvacQTjoezwckrBMWS3FByklGvIs8EmzWdIXWvZ2p8pzUwNGSX64EDUGyE9LqSMSzzpqZ/sV@vger.kernel.org
X-Gm-Message-State: AFuF++krEIg8wUhv39MpMX/K/OTYegdJihn1P+b4PgIxVRlcAK3kKdEz
	HHq+mEuWe5W4zfvvqhXcDI4AuS34IeJjItN7FFbFW/JUwC47XCtnOmDg
X-Gm-Gg: AR+sD10IeRwrRDc/BAhhSvsrUmdA6qGIMo58855g7rWFH82PScgWgt48JGAM/31NFW3
	vVCN4rWXWuuUzHN2wrGTFuqiGWhHus/2hP90YElTs1gfJU4LEq8glJEhes0L9P53oJtt+TaGJ6+
	CkXtEsV7g13fNuniAd5yIstzEyBI6403GxCMtc6ARTI7g4Fx0VGx7swHZfdD4cgeVsVbv6333JY
	wtNsvZDR3nBf5MBLRP5VtGJPtKhlIz2afhtxPSSvxl+yL7FrDaUF2fJ1MUH5zLrt4uf7xrdfRh5
	MPD6kXvqKAdlpcLtx/BFsrQT55FbVaZN8FLOKLEV5sgfU8sLM9AfGNoMv+/dCVKIB6N5frk0EKE
	tZZALAe+VPM0Z1GhPdXfW7hQIyfNCwbmFWw1zGmhQfA+ui/Icc/LRk8XFVP44LMTff6sQE1Toaf
	H83xELQT+7Fgk1fBbYVIYKxYWbdK50lCstUTM10jRBw3Yqnvx1oTWbkvY0PXP3NqrEOjkPkFXn1
	gsj0gKqPcnpDUsAy4vLFateXRq3qb4LOg7JFg8Jp1U6/a758C/4wKUs6TU+zSln9nsitvr40Gtl
	/kSAHGULOJaZxMwFo906AriK8CC073DMJPRTqoVVjlxVjDgWtrr9m/ZziG31Mhld7rIv
X-Received: by 2002:a05:6402:5513:b0:6a4:2ee:5c6d with SMTP id 4fb4d7f45d1cf-6a582b16d2bmr6451179a12.6.1787401020491;
        Sat, 22 Aug 2026 05:17:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a0f5-8c01-3de3-cd62-aa6f-2fb0.310.pool.telefonica.de. [2a02:3100:a0f5:8c01:3de3:cd62:aa6f:2fb0])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c30casm10998322a12.7.2026.08.22.05.16.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 05:16:59 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <petr@tesarici.cz>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/7] docs: core-api: Fix stale function names and a broken example
Date: Sat, 22 Aug 2026 14:16:44 +0200
Message-Id: <20260822121651.1559-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A review of Documentation/core-api turned up a handful of places where
the text names a function that does not exist, or an example command
that cannot work as written.  Each one is a plain typo from the day the
text was written rather than an API rename: for every patch the wrong
name was checked against the tree at the time of the Fixes: commit, and
the correct name exists in current mainline.

The changes are independent of each other and only touch prose and
examples, so each can be applied on its own.

Karl Mehltretter (7):
  docs: cpu_hotplug: Fix multi-instance removal calls
  docs: irq-affinity: Restore grep in example
  docs: dma-attributes: Fix dma_alloc_attrs() name
  docs: swiotlb: Fix maximum mapping size helper
  docs: this_cpu_ops: Fix SRCU helper names
  docs: xarray: Fix xas_try_split() name
  docs: debugobjects: Fix debug_object_init() name

 Documentation/core-api/cpu_hotplug.rst | 4 ++--
 Documentation/core-api/irq/irq-affinity.rst | 2 +-
 Documentation/core-api/dma-attributes.rst | 2 +-
 Documentation/core-api/swiotlb.rst | 2 +-
 Documentation/core-api/this_cpu_ops.rst | 6 +++---
 Documentation/core-api/xarray.rst | 2 +-
 Documentation/core-api/debug-objects.rst | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

base-commit: 26260251022fbc2f248a3d747a9b2b961b18d2d8
-- 
2.53.0

