Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB359381B01
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 22:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777154941; cv=none; b=RkvHR0cz66Yl3MBGgzqj3LqTdaO5zSZU2XegTs9CIg/74jFsQ56GDqdfxH2JAMuXaroxXX6hg21/SO9QtGp0YTJVgjJYuIDnb4KkiBVDxrvMYIhy61jDkerpX7Wylsb7AXTsw1YekwvfkLESzoLejp7t28aQ3Gr3VB01z/PYfAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777154941; c=relaxed/simple;
	bh=sXJ+slPMLJ9Nq4h3XwfVUMfde/mNfD0bnXs0kmZePnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dm4dRrk9OU8nKAcBPkKRe2UJf6sqwhbX1W9fwtWiWzcBu60RA3eEOcMyaPLlMvqznfHRLwjGQy9g14PwLg9tEGOXeRQNYxt84fWDre7eHyoiFOdrdZ4lXpnOfEalHpemIzFLHwOtcXZinMJcHkUg1oeb8AimCzjclOMrKrfrgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5VaY2JS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5VaY2JS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48909558b3aso87091185e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 15:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777154938; x=1777759738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4aq4vscdrQ5L+2eiMv5OyfdzLMbZgfj63SCCR74zP4s=;
        b=n5VaY2JSJz6V7aMFc4rfkr5q1v9vPu/Fn0Dg+cmoKs1y3eBiixNpVdWkXw2bn/7eDK
         Cqc3ks+4X1qe1MCQcTor6tiCEdnJynH2bOG4NiDeqId7uVNCCMou4Z3o8pHHVW2XIAQE
         aSawBr+z3uyNECxm8McLGuZ9/c88A0brY6ELcP0C13/fSX2SB0TOv98kZbDA+pZcimUH
         6KMN/1U2jJNDsrCigdycXW+f7ZQ3aWQK7X3CljrZQ3vwfnVKr4Lr4OvjnllonaVBCv9g
         oCMzPARDgiaqwms6FL01G8UkF+mwxzrnq+WBagGktiiHHuA32d4dU5jE7UCQ2nzq+yRI
         bnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777154938; x=1777759738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4aq4vscdrQ5L+2eiMv5OyfdzLMbZgfj63SCCR74zP4s=;
        b=OOFIMUfpQGnvDZqwOlCrcuOnSvd0xhlik7RFLR+zBf6UiMBE5VyzNncYbzFMSaaPC8
         BE2L/D65NrxX6shW896w1Yaqu07hS9kb1rlnFJglBTUH2sNM7qPi6ciQyhuC23jew1UO
         Cb0LESNhi+P40OdqrYcXnxARDf9qdvHZ3LQyg0ttwBnQBtg2Z7gJ5ELdW1HA+Ld1atNd
         vae5ybfR125ArI5Y8RPRcYQf965x0OyCSmCqeXzPdtO7T0VELK5vPcxZiMsX+TOXgqBH
         lhqxlb5BsLeQSRrxQjqwWmLdxZMy0liGXhDg0oBmMwI8QhpKjrAtmEGJfZA5k2RtM+0t
         VEdA==
X-Forwarded-Encrypted: i=1; AFNElJ+JCbW3XNWriwwLV1HGjpDRwb2gzf9RtQKwTYOlFgjR5XmaZ8zy1PST/oLPwDaFV+RJKvQyLZS0YKKDBxEf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gz5pdUs9ICMIAT0MawfSGA3sGWb5dHMyYiJE+Po4ngFL2gpr
	DV4PvzEmuX2XwFOhX1OUMYxuA+F1XreNvj1//SHFYZSyQEzreKBRXQdW
X-Gm-Gg: AeBDieu8JQtDmgQbJlcrYJLLN5vDEdT9nGnFsEqIDFZgXACaVO2PR8jg2C6QWM5yW1O
	26OOGt5LfmrlmBiRPB5EPw04urmysCvHlKuG6qcQDmCnVmOa2Wco3UP1x/7yoYD+X2C4+G7e8yZ
	tHHdkyX+9mIXCyLFidckXMxiOBs1zvdBaQ/D6LVvgATG6W4nJyhJcr4EGCYWdCGo5xC7A/i7jLr
	nELmBJeiuZS1OL3r13Tzo5wA6W8M569mlstidHlyFBdrE1xrqzGJfHcxu4MKJ7w+CuRh8OO+J+I
	ecAACCqFanPEQPxGrQ6BZLGGAOWu8hjwmuLJQ2jiVAcH0CBcPmakL4BsvPo6n2PvBsd1dhMXKVg
	j/GtEG9530b9hFGYUXPilDQS6QPnlCGYnsyHBoAJEsWJ2sMPtr4aOAAtagFavjWhM7af9nqeRM5
	0DqsnuJkegbVLBdRaGNzalyxcLiE1CEdvPtnAhHK9fusc6EPmn+ptMgydtwk3dL56hDkQp10gIJ
	K8iI3i4ZLQ7/zKU3xOlF2w=
X-Received: by 2002:a05:600c:621b:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-488fb742e74mr571402565e9.9.1777154937911;
        Sat, 25 Apr 2026 15:08:57 -0700 (PDT)
Received: from f.. (cst-prg-93-232.cust.vodafone.cz. [46.135.93.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0b4c85sm651984545e9.0.2026.04.25.15.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 15:08:57 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	adobriyan@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 0/3] revamp fs/filesystems.c
Date: Sun, 26 Apr 2026 00:08:41 +0200
Message-ID: <20260425220844.1763933-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file is a mess with a hand-rolled linked list in a desperate need of
a clean up.

The code to emit /proc/filesystems is used frequently because libselinux
reads the file, which in turn is linked into numerous frequently used
programs (even ones you would not suspect, like sed!). In order to
combat that pre-gen the string instead of pointer-chasing and printfing
one by-one.

open+read+close cycle single-threaded (ops/s):
before: 442732
after:  1063462 (+140%)

Additionally scalability is also improved thanks to bypassing ref
maintenance on open/close.

open+read+close cycle with 20 processes (ops/s):
before: 606177
after:	3300576 (+444%)

The main bottleneck afterwards is the spurious lockref trip on open.

Alexey Dobriyan (1):
  proc: allow to mark /proc files permanent outside of fs/proc/

Christian Brauner (1):
  fs: RCU-ify filesystems list

Mateusz Guzik (1):
  fs: cache the string generated by reading /proc/filesystems

 fs/filesystems.c        | 332 +++++++++++++++++++++++++++-------------
 fs/ocfs2/super.c        |   1 -
 fs/proc/generic.c       |  12 ++
 fs/proc/internal.h      |   3 +
 include/linux/fs.h      |   2 +-
 include/linux/proc_fs.h |  10 ++
 6 files changed, 252 insertions(+), 108 deletions(-)

-- 
2.48.1

