Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564270;
	b=13k2l9QCXX49OsxB47J373QJ6In4sS/oHc7j0nOVGllw7q2fdi0NmSjPysMV2uCnOjvr
	 iO1F4+7ykqtPaMGSfva39774CPzLVnDAWe1ReMhgFy4dhyb6A4Tw293BtOmAr1MCJU2BH
	 bHr9KZzaiMGCHNAmcBMi5V27alwwbAboph+PCnxNO9WYAoY5b3I3aSCUQohMnF/iqGk/R
	 9Zg3HrF+y44stC9Uh5e8T2YWBhJeoflzg9fsP5ZMWdD+YgtTjQzfEW/vKpoMoSSYn2PzP
	 rSqtKo1gT38fXTRVWzzXnIxZQ7XOVf55/hdLA4Q+RWysNoodq//ktcYPkQuvL2DOYsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3WB24rA8ZdBO+wgJnzmfsh+oAV8Yu7u/lMoaF1dD+/A=;
	b=1gkoj1zi98ij0KZy2NkLhqiY60/ywJ52GWgN5bXuD+Cxb5DoL4kz4Fp6K9I0hYvb8W+N
	 3dOBilxtMW3grkuyOAYiOWhxd9YbSempJUBSlf+uOfnNlCGwmYP0pqcUcoOCCBlatZPlw
	 mzR/DBWAhklgQg8ZYWhheykk1AHx2ByAwx7niwRQN2DJsD+s7/QbOQBornDM+JIWowOXc
	 psq1L5mbq6DIkTyRxqRXfXOam9Nh6QGpz8guO9/2Oh1OLbn6rCM6OluyGCPBQSA3oQ/C1
	 r7NHc1fEytgQcRjVvrBWjWFUdFOeGamf8tlNH/cCWGAb7lYbOzG5Vk3K/+kNCnRxLGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RfzxA4f1;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD1606A324
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 20:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ABD1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RfzxA4f1
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so3299152eec.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 12:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793564269; x=1794169069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3WB24rA8ZdBO+wgJnzmfsh+oAV8Yu7u/lMoaF1dD+/A=;
        b=RfzxA4f1PVbX2u7sxGNuTPflLQ1fOYAhDe5z9feTMs6M6MBCAPDljBc0gP3SXfIB+R
         2xsQLHZXGTvyA1/z45TzuBtwS+ADchbD9ZyRoCk8BSoH0IDZKorT+H4m9xJNByR78yCT
         rqGrdj2cBoruwHwKAUZfc2B2yj9DEM05dkZVl6l1VbFI8EvLpf8pZaoPVS0Fo4zP8l4H
         ttKALzqg2YtgjMNAwIL+rMSXAkUrEIaS1gnluI68RTG7G0Lc3CTS1ufaaXgqsryFHRLB
         6EM9VowZdMHpzsYpOdbKTkGYBEBWXEP+VHEb4biCXUrprCzQzlLGweXcVMxkwXiFN0MZ
         IZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793564269; x=1794169069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3WB24rA8ZdBO+wgJnzmfsh+oAV8Yu7u/lMoaF1dD+/A=;
        b=zUbkssjLzytuZY929AAxhqY4dem2932P9puRgpzjOgY2bfUCybKOg0XjDs2xpx4LHi
         4DZxynQqZYEZfDQXKavB9+GoFJUYrHxJqyMUmeEqO6dwaZI/ocvKT1BmGx/9+VI7F6BJ
         1SMoKCSAjPq1gHEpp1gz0ofKgvbKhRPWZAgq94TOJ77ruTvzByk+nqJW7IlJ9ltyD/Y+
         Ep5lsDjpS/5UUw6mTjOG4kp9/GNjO6TIfifWGxnGl+KCygUPV7PoJqjEzhpJ97wayIqo
         DRzLWu6Rskgw07oMMMCTmoY291JR28QvO5+kkqES8nOhV4BhuEHb9LqJPSIT5PzX7pqi
         5r4w==
X-Forwarded-Encrypted: i=1; AKwUvBwjBoU9G0M/9IYskBqofuUwioB7UGjYmAYGyNsb6K+uwlnKjMEyYxWjsSD8VKE/aBPsCvnb0uRv/J8IYCo4@vger.kernel.org
X-Gm-Message-State: APuU4Z9oKpB7FXsZJ1GrFbobD0MOSamhqhW3/FqxWDIq5LEdyeVvgeh8
	hdQ+T9CodWV+2ON63biNnudob9Hza/oHHmqNUd9ubxLfBDMWGblHBYwY
X-Gm-Gg: AYBFou2qTFE13NcpwtQBTXr9O2+73ge3EE7J5SnMLcFGuDK+/Jwyk30jAEY8pqn+Ece
	3LfqKCQhZ7U3C96e/V4X5pcn1xfrSsIrXWfAfPDcvdJ1ylhi1T16Mg6afUoQtuvrUDzEm/yCNiS
	qFVGl2g6OdiwdKVV3mjuIcgu3XC5MWhaUmpQw3wgxAoNL1clrj/maPT5X1RLQ8N9DN+h2oa8rlp
	M7nZpLL/spfExatWrblJpnl7eiYXo6iRO9R5FnYEGEnGlXMvX/01a100D1SbHxUGvsjyBGrghwO
	nW5FDM5GOS8m+7wfiqi6ryortJJ6BHuFNAQ97qBZjPDoCznUbAB9AhKJn85GVz/tt/nW0isN69n
	9L8rVQ/k1MaMP3cL5cHFwo+gMLeA7vcMSZ+x+j52GGyOTkh2MEhrIv1bF1WhnU1cYBjy2vSKCub
	G88yEYbR+AIJ6n6kcJqHK2XxAK1D7IK/1ORe9QpSG5ONAP47nICbtuzHkC7vj4ed8BjY4tb8ysC
	DtV9YI+75xOlShZV4aLgK7Cy2BogcjrPV4rju6n+rqzH0IcCNMs8yjt0xmZGLoCNM5z4CdRsI1D
	boihO0nBj3uQnMA2nDPaP0cYaocO+hELNv5wnPCUteGiOGpv+v7y1ZVWl2BCX7Ztlg==
X-Received: by 2002:a05:7300:e9d6:10b0:36a:1e0c:e28d with SMTP id 5a478bee46e88-36a42206318mr14066567eec.4.1793564269096;
        Sun, 01 Nov 2026 12:17:49 -0800 (PST)
Received: from pranith.org (c-67-164-4-239.hsd1.ca.comcast.net. [67.164.4.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428ecb61sm26752101eec.10.2026.11.01.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 12:17:48 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pranith Kumar <bobby.prani@gmail.com>
Subject: [RESEND PATCH 0/2] eventpoll: scale nested leaf additions
Date: Sun,  1 Nov 2026 12:17:29 -0800
Message-ID: <cover.1792432666.git.bobby.prani@gmail.com>
X-Mailer: git-send-email 2.47.3
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
Message-ID: <20261101201729.LnbMHQHlKQXxY1xpkvBv2g_vE4x12fmkOnR1pF0RIeg@z>

Adding an ordinary file to an epoll watched by another epoll takes
epnested_mutex. Workers adding different files to different epoll
instances therefore serialize on one global lock, even though their
reverse-path checks do not conflict.

The first patch freezes the epoll topology with a shared rwsem during
these leaf additions and uses a hashed per-file mutex to serialize
checks for the same target file. An epoll topology change takes the
rwsem for write and retains epnested_mutex for cycle and path checks.
The second patch separates the generation stamp and topology rwsem
onto cache lines of their own on SMP builds. In the tested ARM64
layout, this also separates them from epnested_mutex.

The series was built and tested on linux-next tag next-20261016
(7.3-rc7 based). Four workers each ran 2,000 epoll
add/delete pairs in nested and flat modes. Throughput:

  Kernel                 Nested pairs/s  Gain % Flat pairs/s Gain %
  Unpatched linux-next        1,558,641    0.0%    6,736,037  0.00%
  Parallel additions          5,325,959 +241.7%    6,771,375 +0.52%
  Parallel + alignment        5,487,081 +252.0%    6,780,276 +0.66%

This patch was developed with AI assistance.

Pranith Kumar (2):
  eventpoll: parallelize independent nested leaf additions
  eventpoll: separate nested-check objects by cache line

 fs/eventpoll.c | 116 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 26 deletions(-)

base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
-- 
2.47.3
