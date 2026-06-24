Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BD39281B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782287495; cv=pass; b=TGQfv3JGNHdwiJTpd/VpjyIscgTN78fC/nOHUc6Ubbd55rhB5qU0AiO7wH9OYl90PMKkKeKS1MU6/x0pCl4TSpisFwrSqY+P2JzfpM6ij2LDB09XpM8Pb8lXqMGWz8HStrM0E2vO4y/qv43ZukeM4WD035hRe9g3/AGneqSupTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782287495; c=relaxed/simple;
	bh=3+Lj3QgLRc2bZkC2oGpAsPgZ5FnJ2bVe6GCw36JJvPs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rSLS9f6Bg50V0azF9szrKUGa0CLXXE+hpu3n2qbG6nOnoNx/o3mYQ3Mwitu2FwlSDa5D/wLcKutFbkG2jiOIpSD/fPqTmYj35BYHGXPtDpv7aHqQLBin5Rcl7T6mVTKMkHWb3L7jV6cTYqRuHN3quoHVy12SEs0LTRbUY0LvRuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+0grFvO; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+0grFvO"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7330dc1f2c6so81652137.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 00:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782287493; cv=none;
        d=google.com; s=arc-20240605;
        b=IGRT5sSShuWweHpfU8dPRxC8g9SqErqo4QAMnJqhSAOTnfc9nmZfaQ9S+hjttiyuG7
         w/YkuSLEdf3Z+7Z9OFljjP3HjfdaPnw2/sK6eTFlRt/O00EAE3wpgRwF9MyHE/UQSkwx
         w7eF8AZyCsXEGQY5aLmcZp+kRtBuSZm2ZsTzZI+nM1jF5gMJ02wr63r9b2f3mFgB3jEh
         jFrVMmUMhTMxLIjALjDNflZ7/PEtBoSCh0B/JRbabh+FOta3C8U+8le7ki5RTTjRNwLw
         7MRogs9GAXW+hV4VuQDUEyrbf/hyTvsAFDhMj2821SrEuN6m7whxKiPE0ypSZTdjl6nd
         XgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=3+Lj3QgLRc2bZkC2oGpAsPgZ5FnJ2bVe6GCw36JJvPs=;
        fh=ZgkfLCz6WeJbFt2bIwCeAhooi1wDAHPw+SIwcvR2NRE=;
        b=g5aPBgXg+vbgrASXMXuyn52l+hehRm/0SGJGQpwTwkOtjxe/p5fRNUzvQ8IHEmnZKV
         0fS66DkpWeGGRsvEnZmm9B2QefW0dSeDL2ECxuvTlb7g7ERUDXZUeZ3bYj7AdXicgdoY
         /kt4o381KQ5hK0CQWoTCjSjL8gq1nzdwNjicL41gCimjBrcp1e7162jH1MN85awecIzP
         JGRkWyLg0tSLZM4ythb1f8ZFV2039j1T6LCvYI7OgULBc95BZ/G9njTVcQxYRN1+UdJi
         +DkJrIG9MHncCxG24e+XrCVSUAHwRUCQAzES8XUB4ZLhp6k6CDE4R460sRWmhPjQmu7f
         nw1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782287493; x=1782892293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3+Lj3QgLRc2bZkC2oGpAsPgZ5FnJ2bVe6GCw36JJvPs=;
        b=k+0grFvOiPYTAL8GwcyAvoWdeeIi5XE3xoekteUU8bWo9FOYuXuzJQYqodjwW51n1l
         fv1UqJy8CSwpyeQg7AWQHIvzlHPp6MBq0Zy9fcj6y+fR51TpLtve0huB/HCd4h4ssaZc
         08RP/z8B/k99WGKfzi6wzKWQxMv2jhBnDSiDh88ODBIsh7dt9+kEHmMj+r57s3PCrbhm
         dqWOly0GW/6hHcZ2AG56H52IroWjSGiGUiRGJa4RVPVsUdC3uZkiIMV4yXQndFmuVKpz
         qwthZjmTRGvmpZMYvo5muOoLUbjDdiwuzbQTGZFgxrX0QdF9eVYRnfVOnsHYcxzvTVBj
         avIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782287493; x=1782892293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+Lj3QgLRc2bZkC2oGpAsPgZ5FnJ2bVe6GCw36JJvPs=;
        b=gxaJ1+2XUetE4DY64uOY9iHpi71iLunOnhP7hinqwzwUG4JwLZs3hBOklDt+g464mG
         w/1IG69y+bk6rocllClak7d/ErbOPZyla/qp9ZqQ1vC2Yhoz6coeA7NALYYmqbieUgBw
         lYyD38fjPb1Y1Gx0A0wsJ2/TJArHrHmrdZYRAkgO7gTknkS/5Z+IbzwImOk5Oo0LxKrI
         ibZ3R/eaJunJRcg8bf1IkSqjMBSxMW5cyCBXOk10N9FVQCeQ7uTlZZm95jF6mxlLFoIy
         xAS0GuYnZW3S2xHqmlIXDF9oLyAeWWZE/KbWP9ZmXAucfWhVgUfZekbnVvw9y0L9PlB2
         MlgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LpEMQeewcHp/DIvLPw21txnKihTm844ymdpo/ltmJAEUySl3L4X0mIu9qWUa0vyo5dFj0thpjyfQoMjVF@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwudxIRYC4V3IWAVqYjCbXaFaBrsyH5bCvEgP6NxxMJEcjBdz
	/5vUhS84qUMQZht3Y6Gwz0fh8X9qKOTfkyW7ujf+6I6AaLNk+/1LLpC6BTZRKlkPjAIWNTHIDPy
	YM806aGqYPxU0dq3CtEsgQtlzADF3MzI=
X-Gm-Gg: AfdE7cns1ZZZPU+ySsKFHINRBxPEn6raDT8Rt2aVRgmkDdALDAiWFhUlpiSY2c4B+ZE
	YwazE+fJywIP75hBtI6NFvhIJdwH1FRkcWtW4Y6N4YRzRfoAMSO/1g9/oFncBLIdqCPcchX/3Wp
	OIC46ldTUn4MMjUih8N5WrSS0LpmLTbzYBGeIz9KR5sYZpNZBcoJxWrFygBtwM0DQWUjpx8ZsuV
	6HAq+7f4g0wSQzt4VXV3tjfOB6xFr53e9d61Qnm1zvYlLQnl9SczurQBlpqRkfv7houDoaNR7+8
	YY7H2/VpnXOeeiyQpKBjvXrB3eGh
X-Received: by 2002:a05:6102:2910:b0:6c1:85f8:29b3 with SMTP id
 ada2fe7eead31-73112dbe65fmr968002137.6.1782287492724; Wed, 24 Jun 2026
 00:51:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xianying Wang <wangxianying546@gmail.com>
Date: Wed, 24 Jun 2026 15:51:20 +0800
X-Gm-Features: AVVi8CfcOjNFoEngN-lUzUkZXOBXCk818temQbqCyDOFlHju-76RqlKMqi9Ay-M
Message-ID: <CAOU40uCiYzVu+rrvnrEmjDgrF7xcy6-BS9wtaEcBM-HUWFWdwQ@mail.gmail.com>
Subject: [BUG]: general protection fault in __lookup_mnt
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I would like to report a kernel general protection fault triggered by
a syzkaller C reproducer. The issue was observed on Linux 7.1-rc5 with
KASAN enabled.

According to the crash log, the kernel reaches the ext4
writeback/release path. The stack includes ext4_xattr_set_entry(),
ext4_xattr_ibody_set(), ext4_destroy_inline_data(), ext4_writepages(),
ext4_release_file(), and __fput(). Therefore, the issue appears to be
related to the interaction between crafted ext4 metadata, inline data
destruction, xattr entry update, delayed writeback, and file release.

My current hypothesis is that after the reproducer performs
synchronous/direct writes and a large sendfile() operation on a file
from the crafted ext4 image, ext4 enters an inconsistent internal
state during file release or dirty page writeback. In particular, when
inline data is destroyed and the xattr entry is updated as part of
writeback, some metadata or buffer state appears to be invalid,
eventually leading to the general protection fault in the ext4
xattr/writeback path.

This can be reproduced on:

HEAD commit:

e7ae89a0c97ce2b68b0983cd01eda67cf373517d

e7ae89a0c97c Linux 7.1-rc5

syzkaller commit=EF=BC=9A

d3ccff6372e07c6aabd02b5da419aa6492b5f0ad

d3ccff637 sys/linux: improve iouring interface

report: https://pastebin.com/raw/hu0BEbZm

console output :https://pastebin.com/raw/scMTFri8

kernel config : https://pastebin.com/raw/VRAFJF0P

C reproducer :https://pastebin.com/raw/m3KkHd09

Let me know if you need more details or testing.

Best regards,

Xianying
