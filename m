Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4489F43F0A0
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784369841; cv=none; b=lO0X2o6eGE1pFFD/bzoS/2dH+QPQNKr+bg79WeffGr2vl4EJXJ8Odk8kZ48QK2xhB3BUFKys27gtGYGxIrqQbx/r4TYT8E5Ip2swN7m8mTap68W5W5AESJsdvD0EsNEjP+FUjSVs5WymE5g0Ec64c0OihOHH0qRp6OQdN/kPs0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784369841; c=relaxed/simple;
	bh=7zVFnqj1IOlr1FIe6x9u1+yIsQlFpQzZsRLG5pL0ukE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBKlQNuewtram4X3Vo9PwTG/5mPGFvYrYKF655/azZcasPo7lSIN5DbXxeVn5vigaeO9xrxK6LuBmSxlJ37CIl5+wg14Mxc5A/nVq4rkcS0wmjTX0w8pvELPbMNfYkKs5TwRo8tCFRz0UhprJrwdvTEKdgHin9oOwvLHm8Eq6xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPSbgkD9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPSbgkD9"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84874b52eabso7187691b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784369839; x=1784974639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OucpGeCg3o38qUxtqbNVrYsZh3geEUQhy4DnGK8pnV0=;
        b=iPSbgkD9hDDvA96sqAqB5Vkqn7llssU1aglrKUCqBTRK/TEO0Z9m5e3YZkiiDLaZZk
         EQe9OzQtw9JL6EzWFeB1VG7ICVdOYk6I1PnTS+nY1MOq7UIwdmx6paUCBrywfep9Ztsz
         9pUc1/tnOdzdISaaWQphLeZkCed3Kqd0b8BH/Zkayk6SMnE9HMRuelJYHDZvLzqHdsqX
         6CobL+QcrnQi8sCYmXKnVJuU5z1+WGY+dWQ8yfejiu2sgzcblwZaljmfT6juz9GujZH9
         Svrxy29gfJhhD3UtpFeroea9gKpUfAeH6BrSvMmxKyF5V51AEM/t38dKRt8lsMLvoJuj
         Wt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784369839; x=1784974639;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OucpGeCg3o38qUxtqbNVrYsZh3geEUQhy4DnGK8pnV0=;
        b=Ze9r9CV0sJMeses8ABLa3O+u8rX7UFOCe+/BSCXS5dvJsnNhDb7D/Hp72fiwtoeUZF
         YqVRLZW2l5gHjSk1usLdBBSBNXssHUzpG/NwInQvFK/W3grgQS2VAblcCCJQ59hGip2w
         nqGjfzlZTQ7K+YpnJ2CX2ckAsWoag7DekyXU1o6h2x3kV9NYFyO6HaGXXD+TssOPyHOs
         PtIYE6WmG2kqe4C/dkrfn53Edrv2CbM8KGOLcvOfJchNHD6CKmCTL0f/DQVLqajV1URd
         Au9cdmwpYFGgmlKvR5hwk0tShNXr2x8wqlQFKyrllN6G6/RsuMKZNkc+aPdGCDNICIw1
         6Zmg==
X-Forwarded-Encrypted: i=1; AHgh+RrM+ExU1RUQu3SsAoxSnpo+o7cwiu/cSyyyl/8hma4Sy5oXJvrNYNT6vHbQBiV8gVRh8zHBydGnsyzKAowK@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTFaQtb26aJfch2gl8Am/ZlPV5By2VscBdtHMSTrHEueX82JH
	XDCr36t/tV5t3BuLX2L9EOZwIr3H+Hls3l6HBlzxWT4JYKAhgt2Z+oBL+qOjDP3HPe4=
X-Gm-Gg: AfdE7cla2XvR6UI001AfBKhSHq5v4eOOGV6RHb1odSZh8MXvn1ZTTLKYa2Nc+i6tT5+
	W/cd7AcqKeUJvBwsv/L6biTpX9o/PANM7PcLdM+YVBQA8PuPkjvTFFER2VKp9nHdYHeGR8IKWrM
	ri2A5u+ooGLw9beV/WuXLIcigJ0GeCS69JQI2S7sfh2IWl/IBdSD8DwLxA5PkonbWVBEcbowmyY
	cTIz/zq1O++YTrTVDOqQrD1L50t+xLCaOpQmUDSlU11nABnt63AY0IMeeP6Y2acoXqtQzJYClMB
	HcSjwnxu01V9sYy9PsBrhFsARU7CQBkLHK3HvKu4Zt7/Y4haQnXe5wnbp4qniTFUY7rXkQEKcL9
	xSn60y3T0z3iacQXllQEhmwBR/9ECSWQ5+QHqjD1D2er/3qU08eN5eW589oucTI9jyq8ypO7vnN
	P9yXubQ3lm7lIgIzSE+A==
X-Received: by 2002:a05:6a20:9397:b0:3bf:6c08:2843 with SMTP id adf61e73a8af0-3c3ad97155fmr6864882637.50.1784369839524;
        Sat, 18 Jul 2026 03:17:19 -0700 (PDT)
Received: from vivek-LOQ-15IRX9 ([2401:4900:8ff9:29ed:7266:cb8f:1472:70bd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdcaefsm16271280eec.10.2026.07.18.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 03:17:19 -0700 (PDT)
From: Vivek Parikh <viv0411.parikh@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Vivek Parikh <viv0411.parikh@gmail.com>
Subject: Landlock: mount_setattr(2) is unmediated by LSMs (ro-mount confinement bypass)
Date: Sat, 18 Jul 2026 15:44:50 +0530
Message-ID: <20260718101540.309387-1-viv0411.parikh@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël, Christian,

Note: this was found with AI assistance, so I am treating it as public per
Documentation/process/security-bugs.

While auditing Landlock's filesystem-topology restrictions I found that
mount_setattr(2) is not mediated by any LSM. It only matters for a
sandboxed task that holds CAP_SYS_ADMIN in its own user namespace -- the
rootful-container / userns-root profile that landlock_restrict_self()
explicitly supports (security/landlock/syscalls.c). Fully unprivileged
callers are not affected.

do_mount_setattr() (fs/namespace.c:4928) -> mount_setattr_prepare() has no
security_* hook anywhere on its path, whereas mount(2), move_mount(2),
umount(2), remount and pivot_root(2) all do (security_sb_mount,
security_move_mount, security_sb_umount, security_sb_remount,
security_sb_pivotroot). Landlock hooks exactly those five in
security/landlock/fs.c (hook_sb_mount, hook_move_mount, hook_sb_umount,
hook_sb_remount, hook_sb_pivotroot) but cannot see mount_setattr(2).

Documentation/userspace-api/landlock.rst ("Filesystem topology
modification") states that sandboxed threads cannot modify filesystem
topology, but such a task can still, via mount_setattr(2):

  1. Clear MOUNT_ATTR_RDONLY on a read-only (bind) mount and write through
     it -- subverting the common ro-bind-mount confinement pattern.
  2. Change mount propagation (shared/private/slave/unbindable).
  3. Request MOUNT_ATTR_IDMAP changes (narrower in practice: gated by
     can_idmap_mount()).

This is a mediation/coverage gap, not a rule-evaluation bug: Landlock's
filesystem access-rights checks still apply on top. The issue is that the
ro-mount / propagation / idmap layer of a confinement -- which sandbox
setups rely on -- is changeable despite the documented topology
restriction. It affects every LSM, not just Landlock (SELinux, AppArmor
and Smack cannot mediate mount_setattr(2) either).

A self-contained unprivileged reproducer (userns+mountns, no external
privilege) is available on request; I am not inlining it here. Its output,
on 7.0.0-27-generic (host) and reproduced on 7.2.0-rc3 (QEMU guest,
CONFIG_SECURITY_LANDLOCK=y):

  [1] write via ro mount before Landlock: Read-only file system (expected)
  [2] Landlock enforced (all fs accesses allowed via rule on /)
  [3] mount(2) under Landlock: Operation not permitted (expected EPERM)
  [4] mount_setattr(rw-flip) under Landlock: SUCCESS  <-- gap
  [5] write via formerly-ro mount: SUCCEEDED  <-- confinement subverted

mount(2) is correctly denied (step 3) while the equivalent attribute
change via mount_setattr(2) succeeds (step 4) and makes the previously
read-only tree writable (step 5).

I could not find an existing LSM hook for this in v7.2-rc3. If this is a
known and accepted limitation (the v30 Landlock series was synchronized
with mount_setattr(2)), then documenting it in landlock.rst -- the
"Filesystem topology modification" section currently names only mount(2)
and pivot_root(2) -- would already help. Otherwise, the consistent fix
would be to add a security_sb_mount_setattr() LSM hook in
do_mount_setattr() and wire Landlock's topology denial to it, mirroring
hook_sb_remount(). I am happy to prepare that patch (plus a
tools/testing/selftests/landlock/ test) if you agree with the direction.

Thanks,
Vivek
