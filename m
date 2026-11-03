Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717872;
	b=EIb4R+PNjrcPybHBAbp5SqTYznGVWyWB6/GuiyzDRN3DjsdLtPmtfU75THgwIe6uz7Cw
	 qvAneiYPPQR79+6Pyp/jif6SJSOAQRHMxVixbSDf2BWXVdBed/JXh/gz3tv7Bt9eAVQAw
	 TLK13ErhMg/7AnUwM1R0NZoRpPGzKlHWpDmCtPQvRwx9CMlKy3Ir/PomXSCdLy7bd/fJ9
	 mZ8v6XJiAFXBwv/rp6nM/doQQRl59S1o2XIzD4sNI67WNZ/Z2WL/vVn3oOP9wXhK3a309
	 Is6V0+BkoKFsyiv2wj3rqw5oVW4BAQDp20um6UgO5myDrJsY8z0T9kVtIAv2rWEdw7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
	b=i8hWhAQGpt0Sf76LMNC2KbJHdEMd1Pcf/4gzQnYqlma3YKO6OWwpFCZZL9y7lWBh2c6e
	 i7QInC19YWy/mmD3jO0swjjMLt04hw82wjjNTIvztNekvQioURp2P3nsmaGJ4aJ7izMT0
	 v9vC5ogrbiQAnPblI2r3kZHXpDht79hdfXDIOhvu30VwGPliFy5LM3nXS0yOQMTnUK1y3
	 GOmJ2VXk2f7OwVKwMKtPZxpNDPvVE7AxoAX4IHGegJgVvoK/ag4iBdOZuolE673uqmN2T
	 ZfIFbDogoxJFxCIRI7z2l1j6urf3MWvkfq5MTi5Wx/kSB/kDTc7xX0ijZykm5uuCARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p6WV1j5x;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AD606BA00
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2026 14:57:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276AD606BA00
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p6WV1j5x
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c3f8d72d7ceso706969766b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2026 06:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717870; x=1794322670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
        b=p6WV1j5xXG874wk7PArFP5ZRw4LM9P09fLU8fWNlvZNYsq6XeAmVW+axCc7BtE334Q
         OLYWFYNZHOeXzV42UcwdRCoa87g2vb1tbBgTpbUGK1GyzD1MzRv7By7b4ET93hkze+1X
         hWaAArnpALLpnihpMF53D8I7MR/Gu4mzaE5FgnJp2nfTWuRwTk0O7VE2qa6vTu/WR0ep
         kM5s/s1XbhhW4QrB6/NsxlZGJYoJdhye6EzfYDEd8hAMBHrJgLXLdMkhwSU2OPQgdpZ8
         RG2FvIWbDQmPS2kP2Vj52O9VhjSuNSZ1mpbotFjn6Kw9g1RdCaXFrdGOjAQzwfMGqo0L
         WA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717870; x=1794322670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYV20rPrJp1IkxIFXdFHHE13njY6A8crxl8/hatCo5E=;
        b=B+CgQj/T+M/icSt4C37ddHsaYJlCOdOJwS5VdgLUFdxK3eJBsgVr46w6xp1iY6P5re
         lywZKcmnILQeqqbkF7UglDNItwpiqfar4zXymGXpxjiuTnrKDVN5rGtag/5KPJySlCtv
         ke574u/GlzgOtPfQCNKw8dghaSLWQncJP+69P53Q0YBNZ5s2lRBsUDLABsqXgdZMkKzz
         1nak8NzzTbygcda5eHmnVSIIrOuldahv1Nua4C9Nwg4DLkk/sMNp+mzwkecXt0KX2N3i
         A3J0zf69qGXy/tru2kKpPGqZ/MFw7feMLabKxX7ZVLBGH2zz67GXdPI/v2L4QGla/IH2
         DkSQ==
X-Forwarded-Encrypted: i=1; AKwUvBxPF5g+dE6q6Mc9UFMLXjshYm1xHleJ6k6ZJImXC9iGNSxX88Q73uaEBhpIfskK0incvI//nXWWkR3+J8m9@vger.kernel.org
X-Gm-Message-State: APuU4Z/CSRfpOF0W1bdp01jVuJ2pynU0YBg/Kyj3jcWXCmlOjsoM2KiJ
	zTLrl29ScrnVspM2snkFTI3pqrZGITQN5elHhjRDCv5+MTg2484YSsIw
X-Gm-Gg: AYBFou0aX959fE4EuNgMQFmr3aj0pLM7cURY7C/efGS3gATTx4F7a7K3rejtN1gfHyd
	20iv006D4ubUkzVWO+NtHWQkun7MaHN4WsrKW6QaJ8Mvu/um6DEzQFuesEGc9OaAZgQKaQInL0K
	Wpj+ytBcgDYF1UsKtYiTP77Uv45xB+QGx35M8zhzVD9bog7Ph93m8iAJAstz93t+EUQaz23uTKd
	D9qcp3Dktum+2dWIc4YZlHUd1jEx4CLSfpAjeJBWae9hVZLZaQJvnqpLvw9Pwrl4aZHmpPGVoWX
	vUtm1PjcDBuf0uuFEsouPTRa/9kpBLVITX2zUHVJ2/LfIf7oDkUUHY9rbzyk+liU3SSFd/q+jWj
	290G++wwp4aNpculdL5yuxeQWduKfBoycWGlTUxGEtRgZ4pYC2+xB5iK1u9LwQgbEFACPhZgl+j
	kOAABrZ7JYopZQN6nvsBqap6sbHwB48GPb6yVr7eWB+KgwWL4znbk/3eEUcv7ZOxAI0h+Idm8qd
	IHiXgnwr8d+tInS3UOFExKbG/4qCx4p5RlliNH9Lgze/dn/Mj/m64LE4lUkpe7CFTVtCWtwaJbj
	A+CcBeilsZ+oKdfM2aCGjZhtQ3VnpsOuX0q5b0uV6nS4dOMX0POGsI2ieiGPDiaEHlMRQ54I6JM
	pN31TKO5Gxk1IIV3QI85d1s7RR5wcmdEU6hXrzYjH0RCG4YUECTKrBAI2iLYCqgM9tZTsVsJSrg
	dFumfUviQAJYM2WUNIreKaG8oiOO0XLW6YVMmH3m6xha2x8YWvMg==
X-Received: by 2002:a17:907:7f90:b0:c49:bc1f:fe2d with SMTP id a640c23a62f3a-c4ca7a858f3mr1272502166b.28.1793717870207;
        Tue, 03 Nov 2026 06:57:50 -0800 (PST)
Received: from Ubuntu (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebec78f3sm93656366b.23.2026.11.03.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:57:49 -0800 (PST)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ian Kent <raven@themaw.net>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
Subject: [PATCH v2 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Tue,  3 Nov 2026 15:57:41 +0100
Message-ID: <cover.1793715774.git.krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Hi Tejun, Ian,

This is a narrow replacement for the earlier kernfs serialization and
autofs changes. It follows the suggestion to refuse splice only on files
whose write callback can look up arbitrary paths and to give those opens
separate lockdep classes.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A normal
write to /sys/power/resume records of->mutex before the autofs pipe locks
when resume_store() resolves a relative path.

Patch 1 adds SYSFS_LOOKUP and kernfs_ops->may_lookup. Writable opens of a
marked file refuse both splice directions. Their of->mutex and seq_file lock
use separate classes. Read-only opens retain splice support.

The new property cannot be combined with mmap or preallocated buffers.
Kernfs rejects those combinations for direct callers, and sysfs rejects
SYSFS_LOOKUP together with SYSFS_PREALLOC before selecting operations.
Binary attributes do not support SYSFS_LOOKUP and reject it at creation.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs.

Other stores also look up paths. They remain outside this minimal series and
can be marked in follow-up patches after the interface is accepted.

Tested on v7.4-rc1 in a QEMU guest with the syzbot kernel config.
Without the series, the C and syz reproducers trigger the reported
lockdep cycle, and a splice from the autofs daemon pipe into
/sys/power/resume deadlocks. With the series, neither reproducer
triggers a lockdep report although autofs receives the same requests,
and that splice fails with EINVAL. Plain reads and writes of
/sys/power/resume, read-only splice and splice on other sysfs and
cgroup files work as before.

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: refuse splice on writable files that look up paths
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 54 +++++++++++++++++++++++++++++++++++++---
 fs/sysfs/file.c          | 29 +++++++++++++++++++++
 fs/sysfs/group.c         | 12 +++++++--
 include/linux/kernfs.h   | 10 ++++++++
 include/linux/sysfs.h    | 22 +++++++++++-----
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 118 insertions(+), 12 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

