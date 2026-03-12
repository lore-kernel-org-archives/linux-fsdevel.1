Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAE13FF8A7
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773339597; cv=none; b=sUx0rBclLA5Dx9pFpgt0peQJQ6/5DUbp6bBBdkF9OS6p0riCHtF3eSc9LPEHhW2tJ6rr/y1OuojRZw+2NBSU9+FehWFYmZdFC0faOJ30+WUmy0HH1/YJYxRwSUZcqE33N0JnRWVVYSU+4p6/tXXz4yMtV5/LlTD2+ZBAUaqLogc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773339597; c=relaxed/simple;
	bh=BTIZ5GkZGuxNEx6hKbxVq4IOzIjPNJI341McWo3MeoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R+1F5pRHpyFb5UBQAZGZMeNxWwUh/EALSvNRuv5oxlkA0uIboBLwycsxzyl/BerwP2OaqdjkHuU3ZMxE+KwsRnY418gpI2haJaaoV2gIz7RHqRvD2QPp4ozUX6dF0qpbTelHJwCpAeaDmAznIIpGWFu+JISGmquCqnfcF7eiH4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyaKv9FK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyaKv9FK"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a13d1c6f25so1439699e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773339589; x=1773944389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJeTY5HtximJl4H/EK6OxpSJa7GUKH2OzkM4yI7+cig=;
        b=JyaKv9FKj5lvDB8QI6b+QI0wjPjIcj9KQZs5qwUWzg97bahW4vw2C0ES6fX1UFUb6V
         HMgrgqlpQ7BniE3nV0ZRkFNcpdAkaPvyuVoe7QYdk43bLmPGmsoDJdQPRdqTm6JT98YJ
         lzo+vmk7I8XBxfRjs5Nnh5F8dm1rA59OR3L04teLn4pcFbHCQavHE4G9BFT2pgK9XGrS
         Nt7BxqHyHUl6iYVdqsc9fYtazr8iOIoawKxtfMOuxyE+0AKtIx5ZCJQTQbyV70i05JaI
         /bpvCpX3SyFs8PU0WVItnjx/ajjsN8tZZX/s7BGtJrWDowDhS6zfhK2aylDoYU6edOCe
         uAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773339589; x=1773944389;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJeTY5HtximJl4H/EK6OxpSJa7GUKH2OzkM4yI7+cig=;
        b=ALbr6ddlqmsyuD8BvC/E3/onYs9So99VAqkKcp0/gcm99TqWmS4pkllXn5zHepM/P4
         H4FRg5jAR/v/ccvn3nrpDiw/GJl7uObyP+DT7ODU7CmWZfR1/qajOkOmK0LLvy7xKcb8
         lSpk2gXPTAVZOt8hVgOtOVPRChqer8NilaLbTNGdgaPINNzgoVqgVsTTvZIMFEdS0vvk
         rjigPHwnuouNlXrZKV1ZJ9CPfiG3jZhFUQXEVusKtNFMvc45sOXWk6MDYnmG94t5CLW5
         2juwnEk42CuMXCNO9Ex2ZanOuaejgfLim40fzdzww5M/F7VxoLtvbpIQQz5S4ehKnd+T
         a6Hw==
X-Gm-Message-State: AOJu0YzPyL7ufLdtECW1cMixAT9agZdwPmwYJjTUqNAXlYcrNYMMizZG
	7GnIv8DatXp/PKUV1anzzI/+z4FYxJJUtzdgGJbcFZrFyMosLil9rfGqIOUA+WIC
X-Gm-Gg: ATEYQzyTI9z+qIFUJlOlNYFtgi0IGuFG/EysKcifukZxSdwm3M0Awp/RcxzLlsZMwly
	I7nqhJxPv5dY7ql9arV+R56pJNWKxPel70mjNpp4ZT+LSVHabyemWIZC1rrPPsvFit7absim8eL
	UC1II8sy9LSeweFUdRe7ZP64tb1PH9K+VoS3hNoLfU7jU9RoF6PRlUuOEifOd6p3CopH+Bmazmo
	eO31yeXuSuTdlbmcvFcbnU2CiWW/dnH1jD31tS74q6ICia7bT+ZP+1aQUr2Zx9nYY6Up57xtpNx
	nMQIuHSPWkHUXO4qBaXWbx394SfTn77spgImtb0wrzA9Yr+d2AGaZmGDrsjzma7wL2yZ9pwIu8q
	K2y7Be0Rr5UHos+n1guL3es7ps6SIxSd36P9LDy5iHwz0GM6M9bdUXiTCa7726/urIHJUOkubI/
	wH+SFZ8nu5SU2VQrIdNY/lpVatBL2c98hCZcZnIQF4OeXuV/fYKvpCNZZpAjKBriFH4UeYCY/Q8
	HPgHHpMsg==
X-Received: by 2002:a05:6512:158f:b0:5a1:27e9:3472 with SMTP id 2adb3069b0e04-5a1626a318amr226128e87.0.1773339589089;
        Thu, 12 Mar 2026 11:19:49 -0700 (PDT)
Received: from ubuntu.. (static.159.107.27.37.clients.your-server.de. [37.27.107.159])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a15602e7d9sm1085336e87.35.2026.03.12.11.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:19:48 -0700 (PDT)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 0/2] lib/idr: Fixes for infinite loop and memory leak
Date: Thu, 12 Mar 2026 18:19:46 +0000
Message-Id: <20260312181948.20020-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes two fixes for the IDR and IDA APIs, along with
their corresponding test cases as requested by reviewers.

1. Fix an infinite loop condition in idr_get_next() that occurs when
   iterating over an ID > INT_MAX.
2. Fix a memory leak in ida_alloc_range() where an intermediate
   allocated bitmap is not freed if a subsequent XArray insertion fails.

Both fixes update tools/testing/radix-tree/idr-test.c to ensure the
error paths are covered by the test suite.

Changes since v2:
- Added `idr-test.c` updates to both commits to formally test the fix conditions.

Josh Law (2):
  lib/idr: fix infinite loop in idr_get_next()
  lib/idr: fix memory leak in ida_alloc_range() error path

 lib/idr.c                           |  4 +++-
 tools/testing/radix-tree/idr-test.c | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.34.1

