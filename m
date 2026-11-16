Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794836349;
	b=q8zGZDMUJK6NmN6dpB93mshb3BLU4W6XD4G4LinrLVto4HnT3KGIL789f7vHzBp1PFzH
	 6aEBuUmigeE3ROclW51zD4N5QVz0ljUDVtglTkOhY82Vqz8rswA3IZn21E4wJakz1yTmx
	 xjaGyBwRELDE5yZSlvwjYBwM8j056ZJXdf3OD/YwH/FBoNXigODlJ36npCjt3zEqHlxCH
	 8C/uL3aJ0Ac0ZQkzAFFCexr85t6USBlTkOA4EWeH74PIUIv8PspPn2QAA+fde9GUO720b
	 R66iroPjNHaGiES8BhrttOBhHTfSJgmJCp2rQoREuulcDs4kL47tSm14+T6bSyWBlTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794836349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
	b=w3ubUSMgFSOfBPrYxTrCQM7+CHhnPyxXfR06DhLja8kR4RqSn+/B50j9fn451ccWhcJn
	 6PngxSZbn9yrJWQOE0NlkdScJWPZVZTi2NHla5NmlHXDjOFLsBR3PrA/YR6mahtlOTcba
	 dPJlU+a91JeISqTsEpL1AVFQUINr1PkIdoFvcuL7CYAFgquPC3uhRZXJ84WDDQ7dsaQwH
	 ucTbSYQekyPEMOqgg2NFUJZ9ayQVhB0P2HJvgPWZkpmsIoOTWBSVQvYN9EGfaja9TKbR6
	 CT5ID1uxTPfSqvP1EFznCT+6ooaL38+4/3SzwY6ZEAR2W++3gjLwKdnlkQqUYCt7CGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQVNaGWY;
	arc=none smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500C606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 13:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A500C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fQVNaGWY
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50e26763a4so111056066b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 05:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794836347; x=1795441147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
        b=fQVNaGWYmeClC+iZ5aQrT2xu4pWQ7xor+FJzP7Vz2OIGAYwCe67gtufjbbImSINN3n
         UO2jkZ0DKhUwCsCd6coLqb1Gx+xCqWEmzecVe4PczqQzaQ7wPLknCr9JLQDRw6xeG3uV
         eboCkLF6AGb4CQORCOgxrK42uN+sd05JmMv1vySKwmu/TTu3Y1k4xAf7gaT6mlVRO74I
         nhqQJOqydmzv32StJKgB98cKraU4xkfgTz9FLErM5Yad2WAfzVeegpVRb2Q2xvmzvAR5
         cz7rmKlTQCyfCvBBicYeyMcX1rNWfvRmVZsMdxx4c8NcLD5x7IbT55qvjnX4NmBQgj7h
         RBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794836347; x=1795441147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsELSAnxZihj6ZkiimEvCuTIFKXoiz4Ga8/+1nOu6fs=;
        b=pz7+3bRlC2p6s7MRHM52yXlnwouI2m+0s2OrYVD4Z5XYI6/vbzGX0z6rpJvyzub97B
         FDesPpgMIHpSeqB87kKVEKqfor7aUCBE60IHM4Le71QnSdbc3hzDY4lLG/f4ic5NxMkO
         l4IhNeWeZWWr+sdOKbRbjtonWTsBUVESCJ6U7Quz7Yqp8pG7e9c0SB7A9ih88EqUvibp
         DmYtkIXwvxDyP+BMhLwut0SlWnqnKHDANwsOQ7/fURXL7cxmUCoOJ3ZKuil15D8BxaPk
         6uIVpS/tE+KKcCQVJw/DJlA1vP6Cu+DZw0tBpN+yb+W1HrSaEh4lJxi4MBTsj6EvghY3
         ampg==
X-Forwarded-Encrypted: i=1; AL+hErGmZ2slsPLdmuA7OMtTutFG3Ntt70sEt7n+YtL87WrEHGZdJeEb/Ay35psNPLvwI/DutGlnRlvzYsou1aj9@vger.kernel.org
X-Gm-Message-State: APuU4Z8CqvS9AnH2rDOBDRuVJKH03cAFaRqpCdEIiib2M4/W0T7TiwLs
	qt1iKGNwhjYKSdODE24Sngxh/KZfjag7hlulMb+03zDfmxYfJGFrWbMm8y/seXatw5P3bg==
X-Gm-Gg: AYBFou0zzoTZ9wL/oXlhTGnaF+wNB/tF8NK5zbyws38pt2jIPUREbt07n9nzYc5f4iC
	/E/3sbfSXxW3rpkEe3qc8lSFwA106NyloVanJ3+1bquh4zb3EJS6IGr836LUFN17/0BzZgkCSxi
	RHXYsZvmtnLJbB67ltw+uQN+q6Y2zRI/yNkRvrZicxD4eJIp6KNJuMpptVwj5qkyr+8q2FKCCWf
	l8IdrPOC/3G5pVOr7LCP6vqq8zMSMEVcyPRbvX1v4X2eNZRjqElf2gj0vcZSKgKE+GcIvZTC5nd
	t+MOSU9qI+48OiHnRsXnu8xhpnp65Ni5fbfrN4DwKZjpK01+BHUaD3lTHHxsP1kDiID7HhxCYIY
	P6HZjFWRBcrm8YDhvZcgajEftuqvbxdE8VQ66ETFnwXtTUG+Csa7BIuRtKbuiqZzCoDSEWd0Ne1
	BitP4KGjqqiCdpEIm9YVBfsFjWos2boWLVjC3cg+lJ0qvZwAb/zUO866Gn9YAZaRbgZek6O2N9d
	8NhFx9RgKxN1WO0uwN8J5l1MXVQOymLwVLHpQ7O4+x1kx1E9GYy8EpR9qG9LVwcZI12PLBpgp9f
	2gX8DxVrFMkKmdd3wonGYnGdT0oedN1DQdOS5PWc5zi8Kp0h+I6IQWyjwdGj7obPabH+R/0ZdkQ
	GHJ+KBgzK5mA6owUqnuyleKle2dgF/NYe8Eim7AwHJnYF+aFmjuUscT48KiK3Xh+5CdWpvSsU1x
	Kg27azkmwq+6BMfGJlVWXIpvPO297h7e8Tt6g1+H9tWJA6xgzk38yB0s3tDNZrAD4GW9kS43rgt
	A==
X-Received: by 2002:a17:907:1c8f:b0:c31:fb29:a137 with SMTP id a640c23a62f3a-c5096313a83mr870027766b.21.1794836346930;
        Mon, 16 Nov 2026 05:39:06 -0800 (PST)
Received: from Ubuntu.tail0f733b.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c50e9b2b5fasm61267066b.35.2026.11.16.05.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:39:06 -0800 (PST)
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
Subject: [PATCH v4 0/2] kernfs, sysfs: refuse splice on /sys/power/resume
Date: Mon, 16 Nov 2026 14:39:01 +0100
Message-ID: <20261116133903.400202-1-krystianmkaniewski@gmail.com>
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

This series refuses splice on /sys/power/resume and gives writable
opens of that file separate lockdep classes, as Tejun suggested in the
v1 discussion.

The reported cycle is assembled from two operations. Splice into an
ordinary writable kernfs file records pipe->mutex before of->mutex. A
normal write to /sys/power/resume records of->mutex before the autofs
pipe locks when resume_store() resolves a relative path.

Patch 1 adds SYSFS_NO_SPLICE and kernfs_ops->no_splice. Every open of a
marked file refuses splice. Only writable opens use separate of->mutex
and seq_file lock classes, because only they can reach the store
callback which creates the reverse dependency.

Patch 2 marks /sys/power/resume. Normal reads and writes stay unchanged,
including a write which resolves a relative path through autofs. Rafael
acked it to go together with patch 1.

Other stores also look up paths. They remain outside this minimal series
and can be marked in follow-up patches.

Tested on v7.4-rc1 with fresh builds of the exact base and the patched
tree. The original C and syz reproducers report the lockdep cycle on the
base and run without a lockdep report with the series. Splice and
sendfile from an O_RDONLY open of /sys/power/resume return EINVAL with
the series, while read() still works. All 33 QEMU cases booted and
completed in both phases. The builds, W=1 checks and Coccinelle checks
introduced no warning or report.

v4:
- Refuse splice for all opens of marked files (Tejun).
- Keep separate lockdep classes limited to writable opens.
- Add no-splice operations for read-only regular sysfs attributes.
- Keep Rafael's Acked-by on patch 2, whose code is unchanged.

v3:
- Rename SYSFS_LOOKUP and ->may_lookup to SYSFS_NO_SPLICE and
  ->no_splice (Tejun).
- Drop the mmap, prealloc and binary attribute checks (Tejun).
- Add Rafael's Acked-by to patch 2.

v2:
- Replace the v1 locking changes with per-attribute splice control.
- Preserve splice on read-only opens.
- Split both the open-file mutex and seq_file lock classes.
- Reject incompatible mmap and preallocated-buffer combinations.
- Reject SYSFS_LOOKUP on binary attributes.
- Rebase onto v7.4-rc1.

v3: https://lore.kernel.org/r/cover.1794479968.git.krystianmkaniewski@gmail.com
v2: https://lore.kernel.org/r/cover.1793715774.git.krystianmkaniewski@gmail.com
v1: https://lore.kernel.org/r/cover.1792577179.git.krystianmkaniewski@gmail.com

Krystian Kaniewski (2):
  kernfs, sysfs: add SYSFS_NO_SPLICE to refuse splice
  PM: hibernate: refuse splice on /sys/power/resume

 fs/kernfs/file.c         | 51 ++++++++++++++++++++++++++++++++++++----
 fs/sysfs/file.c          | 23 ++++++++++++++++++
 fs/sysfs/group.c         |  4 ++--
 include/linux/kernfs.h   |  9 +++++++
 include/linux/sysfs.h    | 22 ++++++++++++-----
 kernel/power/hibernate.c |  3 ++-
 6 files changed, 99 insertions(+), 13 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

