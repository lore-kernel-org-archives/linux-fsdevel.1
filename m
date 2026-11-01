Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793512854;
	b=JCLH2SJS3mFid6nLyxPe02Zckjviy99TguxGC0oD2Bf0pfbTKaDxYGneqVrcf9Dger+8
	 DPtzxcXNxvnSqzSuXVmY7fY+USrJnwOnYEOvlJpr1/ptVgV5JkYn+jKU3SIokziJrr8wl
	 m4lp12FNxXneTtC4UUnvEpS/hK+6ZdSLdkqg36aOdMZfQ73VfggKujQ1UwjBdJexCx9EP
	 dBl7PVFs5xCw+iAeDDRnuk8KUBUuBGB7+3qx8OS828YuZ4ABfN26PEYZYp/OMg6XXVS8J
	 PbN5IKFUy2/rVeXcWyKRcZi3TXMY9CQcmEoPPsct6AYa/YtHHHhei77NWrObYPJrpRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=traUlZDriv7/XAv22io34n1BJf45r6o9C8uTIn9jXOA=;
	b=WFPzz7BxZZPooN72O9Z+/K5iy+tGyNgSdag8D+r0QYSXkUF7oNoAm334lly5Smkf+epi
	 Fy0nrWLfGHOf1FzxDRpdvsOgS6um/4Qc1h+mMd98Bv+fArpB9S1aUa7UBqGqr9XTA5iP1
	 9ejGeyZGCUMcuZzDzaJlP16n0QX0zfgh/RdVkrP1c4YkVFdsfKHoQzv1uZ1DaxyAKBkYR
	 dCym2sBcs0jA1ValUBJx0S8HrZjzqrikPjqMh4nqhsccZlQSsxEnSSYXGCME3UgfPnChE
	 M+tBrUvIXTly6ERnYKISQyikX2Cc4i109IipBE/71hp2W+v9B78MGtqio/FsSu2aksQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTDeTo2a;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBE606A325
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 06:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AEBE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jTDeTo2a
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a052aff9e9so1491342b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2026 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793512853; x=1794117653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=traUlZDriv7/XAv22io34n1BJf45r6o9C8uTIn9jXOA=;
        b=jTDeTo2al2snGPu+wZQ0QmyKxnsxmABQ+0dAR6IzciZGy2130nmXdH+Izp9pPPv0eu
         QpG7egulChny5OoPzO3dQopXrjcQ8Qzw+UXIluhEx/Lw6uR844EyslO5GYhFAd7FJlGY
         zVB8lTGNkqfEKqIw2tKIDR1cvI9yeeg6bh9L49st9d1aI43V6OTJAd5oVVwgW2z0T9Rb
         +3/31egsGu0Bupj1Xx2ub8+EFdSrQPinx9g4Y+k9u3g/eDDyJ4QzRAGZt/z8Pt6jCIH+
         ipXk99ZglpyFsXLD1ihEPBG5RoaLWKIMmi6MgjQacjRHpYWnSXLL7KRbAy8/JVXEJ/ra
         TgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793512853; x=1794117653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=traUlZDriv7/XAv22io34n1BJf45r6o9C8uTIn9jXOA=;
        b=MU7Uc07RTMRxia4UM5RiqEqVxZ/iY98nM2u/oV03Q9mPM2vnuwx0elJPqvT5rEuK7p
         OuokcFND747vy4EkFElQWIJH0QIWxW5w/rHEHnedODVf97AVS4Sgmo8NeRPGmIpi+ezB
         m/FGJVAR6RPEnug33865Mz/BwPiot+WN86OVVua0YXsQuudxDifQ/FB88XwqG6T7hfpr
         T6h2rc++tgJ13Mq4IgoKlDV4hi2vjTA6Fo5j4NRZpuZSMxnEq35fNEK6N+Z4jeWj/OZF
         Qg1zcft+fqIExl+eueFGgnC6din+nBuBRUlKcHi6OpCEoWVAgc9ZX8rzFlkmuY+XcMLM
         NmtA==
X-Forwarded-Encrypted: i=1; AKwUvBxL4hlCxl5x0lGg+1/hTAdzX1TjOEW2DsvSPQ3xvADvfLZHTZrqCwOiXjHiUv6v8jSEM6V7hKpjQQBPC/sj@vger.kernel.org
X-Gm-Message-State: AFq9FYKeftsBVzpE75nrWMDSHuWSwwAYegfJI3fxyMS/4o2kkeuvX6zt
	t/rOq7wK68YdVcTxu03HMuQVHjMXBXb8RBSo6M6Yuqd+8NKfzASM22Bn
X-Gm-Gg: AYBFou2kGSEjeWgxe78cWWwSzuj4h+GF65ePfkUZ9Wwq6DbuPGgvzQEDUtEIjFOIkMd
	wpnEUm1zaC0PNsol85mNHIyGVNwbjKsplXikYp16+VTzZ09WYpZtd5grVGxIO/T4FY12EtnZzCr
	+jAigZXiIkp6NB0ZsAxDNxUUtX0vFgonBHHrBcWA9+A2oYCffeCeDExNOWyOdRr4+Ab6De9FeoU
	8RZvPmZ8M8sYWFW84SlJJrSXZ2e3Wd++vVVNbVo5YvmLsCTsLNZ2O7rjnMSTQiEiIQeIyY667ye
	ARZzNEOF00UEN8VLQvSZ8UYnjQ3ern/4qqogeFHGQ1slYtOcqTdBCJ1st9g8+KM5ytfZHJiWgKa
	duPquCUl8HOlgaliQuTF/xEP0z3iF3cfdloGgHKpqRk7YRnsOWFth2Ndoo9rYUEYeAqvpNmA+Rj
	64KLN/+UBiHalb6z0NV+qAzkILSfoapD2Fawa14OPG5iMPbBSwRCvAmEJLIIuuMH+YCPLltICNE
	mtzo3xG2VKFZySkvc9RC23lo1v1wT3zuZ+9DHL+l4GoynX6WA8OKBL0wfcnWGD3xAYIsRcY44WO
	uBCTe7gJMzFM+rrc5vxK1jxuFnttAqqKQS4PPpalyIrgfuoj+v4nFhh/+Kj2ewotfsMMYj+SQy5
	JupmUIz47cCPvPJyt92zwTVwZu6J0u6oZJj2eZ9L7R7Rxn91q7DYevAS9htQMbHyx8EwYuRftSs
	c4RqBFG7jIPw==
X-Received: by 2002:a05:6a00:3a13:b0:886:ac28:3bd0 with SMTP id d2e1a72fcca58-8a9bed5c4dfmr5042593b3a.40.1793512852697;
        Sat, 31 Oct 2026 23:00:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:9201:5fb0:4dc4:c510:e576:213e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad9d067cesm1062706b3a.29.2026.10.31.23.00.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 31 Oct 2026 23:00:52 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@microsoft.com,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH v1 0/2] fs: fix and deduplicate whence handling in default_llseek()
Date: Sat, 31 Oct 2026 23:00:47 -0700
Message-ID: <20261101060049.81441-1-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.50.1
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

This series fixes negative offset validation for SEEK_DATA and SEEK_HOLE
in default_llseek() and deduplicates its whence handling with
must_set_pos().

Patch 1 updates default_llseek() to read the inode size once via
i_size_read(inode) and compare (unsigned long long)offset >= eof for
SEEK_DATA and SEEK_HOLE so negative offsets fail with -ENXIO instead of
bypassing the range check.

Patch 2 replaces the open-coded switch (whence) block in
default_llseek() with a call to must_set_pos().

Siddharth Chintamaneni (2):
  fs: reject negative offsets for SEEK_DATA and SEEK_HOLE in
    default_llseek()
  fs: use must_set_pos() in default_llseek()

 fs/read_write.c | 48 ++++++++++++++----------------------------------
 1 file changed, 14 insertions(+), 34 deletions(-)


base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.50.1 (Apple Git-155)

