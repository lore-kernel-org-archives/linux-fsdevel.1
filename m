Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F422E62A9
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752970; cv=none; b=tf6cb/nf+W5RP/tCKhC8SjNS7126CPwZaDKQK+VYIW8GKibHVSWLBAvGKIumwIkwSS02Z9mcKUW8LdRxpaArd/LiuAgVxkvdBBvyztZ4t7qKtEW/yX7kW25dhinGRd+j3zkGsfNhhWTqujX0aShB4OFezMKfrFNn+jH5k2PE3vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752970; c=relaxed/simple;
	bh=ddj3yVRPREzjd1EsKGwCdJqmx5OZh38AdrNsfP+JhFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTIbmn3GVou0Ti6p/c748pWDiECBkz3r8HUT9OupCW8SW8GpuqrJlGrBGzFm1xtjFlgI7wxLSgtU0CF/Osr4qpsoGze1/Hgl2g6Gus70dkuH/YS/hsyPI0Br74VXQjbhh1z2QnrzZ9SkWp9b4b81zU2ZRG0MCucYw1HESWwogiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAC6cglR; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAC6cglR"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a498cb99b3so885175a91.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752969; x=1791357769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2sbEPlrgGV7a5zh9vVk+EqHaoIjuLa7ql4HGFcC3qkM=;
        b=YAC6cglR9yRbSZ/Q3pO23PLAojJTbuKF3w0nrDTsLNTnb8xwbrcHgey72ZAwy2rEwq
         v00qaeDa/YMtg4vF9I+McMTqceVntuczsKf5pLnR0zUDbxOkdOnrBlKRuq9RlaP7ltd+
         xF7diJEoiv1yZ8Ly+3Ogj2jqg8JnjF2+502u8RB9OKbERc1EDmmqCL+EjdW14W7U7m7e
         hH3X3FlFAwZiidoTBoQRGqoxpKYSCrsBxgqsUMMru87dQ3j0ZUHI69rxKekhKKnGc1ut
         U7caP/H/oZD2xQ0P8oqofGHt5quP14DnLioxIIyJOljQQYx7+EAE747YcXYCs1JkV/0t
         F3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752969; x=1791357769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2sbEPlrgGV7a5zh9vVk+EqHaoIjuLa7ql4HGFcC3qkM=;
        b=wm612qiFGpURo3XDXgqaSH2/CXyjoliq//5LdfsO0h6wMbxzTMIoBIQQXKStNu0oIm
         B/5YEVY147zu94EHvfS+CuXmrfHyCIl/ZzQweoXSKKU5+0y9LcuYLRBn3wpxfNykRqJb
         CMFMijHnLK6oOZ3qZVOHbX3mR9SA8DWOynJpw+vPD3+diqZXDIhHDEiq1+8STZvfugTk
         mZUfmcjGCpIe9d36Ze1OzVfj46tRgzGBk74nc9slp/zNKMHqlPmto/dSJ1v440pRiDQh
         v0pAL42rxf8kOAziy+F3b+fOIfA9p4E7LPRoLzJOAZz9ta4mJ4hknpAd+O2DISZwyo93
         31rw==
X-Forwarded-Encrypted: i=1; AKwUvBx/piGNmoSjQDpoovGUhN5hoAbOhFRe44R/3JXNNNDXjjJjztUwlI+RFJKxQK4fCuUhox8exvK8CPUi4cVT@vger.kernel.org
X-Gm-Message-State: AFq9FYJonekJBCJoCeER2G2BWq07+3i/EoHfLso0wdgripzWmCQMBUlW
	KrzWJFQv5y1WciaS6SpohY1QCGEhkXR6PbRaTWHwsfrqV1GI9jk10SyA
X-Gm-Gg: AYBFou3Je8vUWBiMcft9qTtwizkbbbrRig1N4M+j/1OqiQ8N+DMQbHyXtz6BkwXedDM
	YnNjQN/uxZcfe7a8R+QS9I5+IfH1UVbh0Mjy0NwIA/2vJzQ+sbYc+Lj/mkWqF5JbIeEuv+K1AU8
	oY2DQJ+CwKWt+pA0y4LM5IsxVE7lOR1jCU06GgaA6oPW/OXwLNfFd9NE0Obn1RE5NHbBnknOSM7
	urPO1zi30Ex748ifeWMmKJGJs0ZGspuF+xX0C6QAVkIYzeR8FJPPi4s+4O0gsXUIszOwZAi8rUc
	nBhKxlj54MrsNaXCCdshR4RKLnWSNt8HeCWDwHR93EBnMPRz5qDdkJN1LATnKfVJR+u0QYq19NH
	uBz8Nph31zoqsO+7e8yrbiPxXExpAh8oThIMf0am2aAvlEwTe++nx1f7ElP5BQbU8UlyqWZMN3l
	g5aVzM5CDUgCvXgVZaZ8wHjv72KEVfG2A7CO/rdaAovFEYErejgNsTKGxQLHkT3cpl7XmrdSzoC
	Hlr6fpW9hipqNKvSsK/SzWQw63MnPQpGq93ye2CkaXajSEI6phkN7D6l27tr3jWS9hm1ap8G9Ix
	6u8K9i8tdzyZS3r5UFEsxvKyZxpvwQF2SXKL7I8WTqEugnZZPX9j/69YV0g=
X-Received: by 2002:a17:90b:1d43:b0:3a0:bda2:d54b with SMTP id 98e67ed59e1d1-3a4d1534cadmr291708a91.19.1790752968674;
        Wed, 30 Sep 2026 00:22:48 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4cae71827sm2122585a91.14.2026.09.30.00.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:22:48 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/6] fs/qnx6: fix buffer head leaks, double free, and inode validation
Date: Wed, 30 Sep 2026 15:22:45 +0800
Message-ID: <20260930072245.1167477-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-1-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hui,

I re-ran my v2 tests on v4, applied to mainline 551c722f4080 (fs/qnx6 is
unchanged since 62f4c998b297): a userspace ASan/UBSan build of fs/qnx6
over my test images, and a KASAN/UBSAN kernel under qemu.  Apart from
the 3/6 problem below, every image gives the same result as on v2.  I've
replied with Tested-by for 1/6, 2/6, 5/6 and 6/6.  2/6 and 5/6 are
unchanged since v2, so they keep my Reviewed-by.  6/6 is a different fix
from v2 and 1/6 has the wording problem below, so I've left Reviewed-by
off both for now; 3/6 and 4/6 get no tags yet.  My two follow-ups [1]
and my levelptr fix [2] apply on top of v4 as they are and still pass
their tests.

1/6: the description now says that a large di_filelevels makes
qnx6_block_map() read past di_block_ptr.  On the unfixed kernel,
di_filelevels 6 and 255 give UBSAN shift-out-of-bounds reports at both
shifts in qnx6_block_map() and no out-of-bounds report for di_block_ptr,
which is what the v2 description said.  Could you go back to that
wording?

3/6: the new release at out: reads sbi, but with mmi_fs the levels
checks right after mmi_success jump to out before sbi is assigned.  That
is why v2 4/6 used qs there.  gcc reports it with -Wmaybe-uninitialized.
On a crafted mmi_fs image whose Longfile.levels is 6, a kernel built
with CONFIG_INIT_STACK_ALL_PATTERN hits a general protection fault in
qnx6_fill_super(), and the userspace build with zero-initialised locals
still leaks sb_buf on that path.  Using qs instead passes all my tests:

	if (qs->sb_buf && !bh1 && !bh2) {
		brelse(qs->sb_buf);
		qs->sb_buf = NULL;
	}

4/6: nothing in qnx6_mmi_fill_super() jumps to out after the active
superblock is chosen, since the qsb allocation and both checksum checks
come before it.  So the double brelse() in the commit message cannot
happen, and the patch only clears two pointers that are not used again.
Could the message say so, or would you rather drop the patch?

Thanks,
Matthias

[1] https://lore.kernel.org/all/20260925151449.1517608-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/20260927225002.509062-1-matthias.goergens@gmail.com/
