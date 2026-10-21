Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608117;
	b=iRxITeAB/ERHh5aKucaW2rbAbzegBqQ4JUsydX4luQ5aGkma+cz5jfnUpmOSGLid35SO
	 tzZuIviTc2nUFBc3mRcb0gZcS4J1OcDYA5+eCH/uC711MyC/YdxxnvyhwdcgJ/Gjj+XCi
	 xgkOiFBYDG0nOgD+VZsiUgs3i3cYbhtlgupHDxnAOWtOesB6wUnlG+9ezQgk6ZUuru4Ay
	 cL/0n/egYlA9tncICDIhrb4b7H3ntGS65AhXLrH2N+RIs6Q+sWA/82B5jwqYJeZ2JL5gD
	 yA+YMd1mZ8c2TZS914PRg3bHydj43Ylt9tvPGYm4wS31ZCR/jbpL1Hdw7awAgs65Nnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=jbwEUgN2SVemlffka8Ya8uCbb80Pexet3eWRm3S/rx8=;
	b=eAuXIH3nNuuHsqE8HYOEU7utpnhrAnA7e3ROO309WFHXiKB2gg7l2yPUFz5q4ay4zxX5
	 2iL4D3X+rqmsKW3O28lSeHFnvyU7e8XRQOfquYsfh5fAnBKpvqirC3xT9CUcOlOaYpl+H
	 zRhrbI8kiMGhDryVZJktIPjCtcPv35U/B+lvXLuKNR0WejjIIiy9tO1XNWN1g1hQErJbD
	 OM4ywkPJNxhKXX3SOHKtwZPC+iBdmWdnIvwmiWyLFwFNrIow7qvryEPj8HRnQKWrvVDTV
	 RRB4Lo0OH5i9mRk2GE2k14TBGCGtIjwt1t3J5jkKuBANAIDIE4uzO0hEfSAKy20jKFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=omnibond.com;
	spf=pass smtp.mailfrom=omnibond.com;
	dkim=pass header.d=omnibond.com header.i=@omnibond.com header.a=rsa-sha256 header.s=google header.b=X3ECAfc0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE853606A31A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 18:41:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE853606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=omnibond.com header.i=@omnibond.com header.a=rsa-sha256 header.s=google header.b=X3ECAfc0
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ea138a3497so6607515ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 11:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608116; cv=none;
        d=google.com; s=arc-20260327;
        b=AyBEYvQbG+wCjRYGJ/N9K+8lZdXtJ0gqQXdFB770KcPInS2Ynkt7ZHp9Qyi49xsTWA
         txEDUkrL2zjAzelPp70zEDADkXZmbKIj4sq5uE6+YwzmhyC+Gam2M3jhHwsM7Bgub9cz
         lxWOk7o6u8SoQuUEs7Mowxy9IxF5sWbxwInsLY4QH6B+AnhRCFR2ypqAcNUO1tBRlVM0
         3RxUt5GFrHBrWZApx1tr0EbLtkpXffl/bGmFl6pU/PNVuZrd1bTVXpaqVFlUTHKczsBq
         gheYs2xZeYfgQJIHUqx0YGh/HkbmaIzdmrMpvQyzGoyo78qPNEyL3yNaYHkUUgwq/43D
         aPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jbwEUgN2SVemlffka8Ya8uCbb80Pexet3eWRm3S/rx8=;
        fh=66MgICiou9MGI468SjnsJ88xX8AtBGGtHJGcOP7N9Js=;
        b=adq+ltvjI3fDxlXFew1oM+PDvEh8IDPHiEl8jsmIsfIJ2dnB+1d7Uqi7gSS4ykHBOv
         XRcMWmSJXV82RetnneqDEj4pBkXnHrJzA15SASIcIH30hONmsxeydlHO9DaZ0JgE8cvG
         X9gudfIktxZLD5F8SggcHWrcSLzZboEMTyT3tHDOeFAqrwxPtX32LVhrrPsjimv7Xt9U
         SXPHSiSqN7ZSogdQSW0hcaWnFKpibXW0ww8Yh1Ro3v0MgTox8gzx7/j3l7ZI+hxz1+o+
         CL02xsPTkWrh18v4SOFnic7k9vWWo72Y//t3I+IS0qujZal/CBC2NWrwtBokxQutSUO1
         zrRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond.com; s=google; t=1792608116; x=1793212916; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbwEUgN2SVemlffka8Ya8uCbb80Pexet3eWRm3S/rx8=;
        b=X3ECAfc0m2RERpY2gLEqTj02jVL8Kbs/xwogKt0jm9huXu3mAunSe5grtCzQ/SM/0m
         ruBiMDFnY8amOqTFI5bBDvKoYGDrF5Bksrr5AqNK8kUGFjZ1C9xsFYjfOQdYi8L8q4ds
         AtgLzhhMMQ2CewxxYalf6ib8OwEJYIfVumV2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608116; x=1793212916;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jbwEUgN2SVemlffka8Ya8uCbb80Pexet3eWRm3S/rx8=;
        b=Z+//kFstYn6P6e+Xtbw70/pCku015sttkXMVE+7m185AeQ6aUMguvUAVrvMSqmE5Dr
         6crCPLVc8i4Fy+RRGZp+Z6yAIqvVpNJVv009/3EQU4GDpHTSJhNTGp4DF8N9eK6vkit3
         iDMgxjZiRtFQQ+7uuV7bvqZTZy7ggtWDZxGYJf4UW2iN2IL1cN7cpLyRkW5aTjgTiGCM
         a4M7Dj71Jyl/Cjp/CJOrp2TokDA/CdsVHtkMggB/a/bKTHdYoixffLci3P9aMHR6pCdW
         zz4rXebrGPbIjto1IWrBhjU8w7q5CzuCd+Csa/4PW3Bs8s/bFYDd58azvVpBn4R8UkXl
         3pwQ==
X-Gm-Message-State: AFq9FYLW5KGFYI+maU7ZYRwULLFOEjTTjWoJhFZxg5+P1+E0NFSygDCo
	Rox13AWgzPa37w2oCdgvvgHj9qzYxOyVJ3po1eYuowmbr1yt5jw45PMsLJv1xizOzOSEvN3Dhbb
	oKpxi1aYBo5IJyrkphrbQBymcOz7QukzeEP0T3QSHFYYwdn7ynviCHTiA
X-Gm-Gg: AYBFou1iHd/VTg96a+0hr0+hGWkcg2mb7K/P6Nkg8FlKyUYeTjRN163r4cRcu/XnHsW
	wwsCUjgwykPv/Yj8U05j456xW6Kn0k2Zx/RF0EI4MHuGCgpYLDgqulc+tPt5zpnObAlW69siDgY
	vuaEFB2lThH6ZE6Su137U3eFb4XPJdNdP71aw4IOYO2Sm4CEWFx756IB2pBNOivmivmCu7jUuTj
	hQo5timcP1VVmXo2HXkOghkWmgHqOUFGnB4UqNM97u/m/3wfzv4iAt293Al6u3yFtymdfLJvRvj
	cm4UHbDYep0E+6HhHEWA+UP2cx+upZs/cdQrN75PjlEvscZu1avY1uqcPcaRoz77A48Qj5sjb/L
	0sXBR72n4WhuOdc91sgKkYn1EZQvRSMlqYwPC7qnZZNYpoHXXRCG3XSZ3gMy+X2SwWvc0Lw==
X-Received: by 2002:a17:903:2306:b0:2e5:cf33:80ca with SMTP id
 d9443c01a7336-2ea43c23484mr23449325ad.52.1792608115956; Wed, 21 Oct 2026
 11:41:55 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 21 Oct 2026 14:41:43 -0400
X-Gm-Features: AclHuK9rFl9-kimsPODWvPfwKmZWbt_8EQf2PEkI_5AKcRbPJpWrC3mHpHaIbeo
Message-ID: <CAOg9mSSxA7POTOHWrC-6Y5W-OAx=TaMLaCWuuA+e_0Y0+Mo7SA@mail.gmail.com>
Subject: [GIT PULL] orangefs changes for 7.4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Mike Marshall <hubcap@omnibond.com>, 
	devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"

The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
tags/for-linus-7.4-ofs1

for you to fetch changes up to 2bc09cb0e9e44c7e622b956332ebfb9b638fd5f7:

  orangefs: don't continue on to gpf if client dies on write.
(2026-09-15 12:24:35 -0400)

----------------------------------------------------------------
Fixes:
orangefs: don't continue on to gpf if client dies on write.
If the orangefs userspace client died while writeback
was occurring it led to a gpf. This patch allows
the kernel to finish the writeback.
Reported by Farhad Alemi.

orangefs:don't wait on service operation on system shutdown.
This patch avoids waiting an already dead userspace to
process an unmount operation if the system is shutdown
while orangefs filesystems are still mounted.

orangefs: use ssize_t instead of size_t for error codes...
This patch fixes a situation where an unsigned variable was being
used to collect a string size, or possibly a negative error code.
Reported by lkp@intel.com

----------------------------------------------------------------
Mike Marshall (3):
      orangefs: use ssize_t instead of size_t for error codes...
      orangefs_super: don't wait on service operation on system shutdown.
      orangefs: don't continue on to gpf if client dies on write.

 fs/orangefs/inode.c            | 21 ++++++++++++++++++++-
 fs/orangefs/orangefs-debugfs.c | 10 ++++++----
 fs/orangefs/super.c            | 18 ++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)
