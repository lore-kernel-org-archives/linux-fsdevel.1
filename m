Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A2364E87
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 21:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696984; cv=none; b=EHv5MIIrFZLAPyvB4NkcVs/VViFwb04chNCiRaeVsWjDwrFIYToTw3BBGKBlfBbIv8cCm0SlmdP5ZEDVJxKwem30/sZmk1Bxwsv3PTXKHtBkQhIJHCbXDgcSxAR4wbDwVkWjp0lhqmZpb5pTvozihGUm8ePxv41nNq/cdBGdm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696984; c=relaxed/simple;
	bh=ZHHsteO5AvuECau+jGB9nG1dY25l2SiYgEOKuw8Dlbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U7eZ4SdX4LmoGrR2vRm4oFSdvbr02qF2Kv6lO1XmKWtJtQMls2wQpJWIYWb0+l9fA7uj+74M6t3RFDkU+Ryaoubjx/Sh3mJnBQIOeY9vxvbT1+G1fvFXHMrCTOw/LI2gGEGynIAG4brDS1veiqMixbygbseVaUuX0LeS5QbTSzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ftw2W6s/; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ftw2W6s/"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50905b779dfso62601441cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773696981; x=1774301781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UuAmGgbfl+JV2g5jci7AOV5QImEZLcznAUEhETM+f8o=;
        b=Ftw2W6s/R7WmEhemFD+epoWcOKvY0noPp8ClwdgCGW1KwGlLWrfXWJbkzMpZyDFbUd
         aEYzSWU1pl1UIDcKppkdvYZ3KCCPdQzbNY2guJkYf2Z3pzjwVfKc/IAbPZ0S+WwMukwE
         yXfGXLHfGaAw4Li7C0rsOzDpdSUQ5RPT1HpVKE5S8VvFuNe64OPGYHKAZSqeuG5KNcMS
         3aMmEfxIya9tqk8gahcJCTNDBKja1NzqJQ7CFsqXw07X/j6vZGF7UxvSsIfnNVh2rX7C
         xFESR4xhVIfZ5cXWyVfX9T70tqG6cLG0S9Ry1BPgA0qOIPh4ifdSrUIYqzaiz1t35DSQ
         91MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773696981; x=1774301781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuAmGgbfl+JV2g5jci7AOV5QImEZLcznAUEhETM+f8o=;
        b=Mk95aMH05ARbSnDkOdALKeFjx1weNHIuHuAO2TZB5wtGAjv5Vxj8IU/8eqYfBK5Jv/
         ODpBverDrvclsfkHX1kzxkvviOG9qtbrOX3mS6vFUgLQbtQW853TGUYnDE3b8/GN2oei
         Kdi0iGn/5KMK4B/ahUSL7GYicTP+kQXpWa+Jsukn3hChw9ys3hwoI6NZxJU/eMw01pC0
         ieLTvtW6jJwYMO5Chor28UqUwhDfjPeQtbrqbJnFoMDzQmX4YD5ChQLo12TuIAzvXv5P
         LgtcX20dmuc9cuiFWKa+FCaiFPzPGrVsOCfgaiL3An9r76IubwO+iO75JBktuP/6xSRQ
         8cHg==
X-Forwarded-Encrypted: i=1; AJvYcCUo5Ah7evLGIo1Ee/rMGRNLQWYKqgvn9/7cJVxtg1T6pyMt7m1PAhAIU1S3rT0Ex2O553SuRMG1kcchwvCI@vger.kernel.org
X-Gm-Message-State: AOJu0YyJo3fBQP0twJFmz4BNnzzbXvxr0g0wP9juMlfrbtMF2V6j6H32
	aJDW+Y+uo/g0Texr0JdfSaX2yOe3NinL5ig9m3Pi9y7Hp1wx352dI/cIuScFfOk00LkQDru1MkV
	L9Y4=
X-Gm-Gg: ATEYQzw0mtm2Zr0H9JMDcJom+5nl0eFtNR0W2ngbyLUoThRgUX9wD/tx+WAgM98EnGx
	zYZ39Lkn3NjUMQUXUIERoQoB4zfYDvKeSWdNPaFyX82/2du4nSCbhIEFhSt1WTe1wv0DCMGwiX8
	fy1nUxUdWdZ7BmzEMQIwlZKQVqk5AMO2KEf1v+jHZMbwiSO4oYRgqK8dVIDewuTWgk1UlUqMF/N
	Gfg21yd2PTejgSqMqobuFvzuDAvQK6cmTqedgax9o1tz2Jx1GDwV7kjAsn1mj/zMyV6rWrlDdz4
	Zo9v0XFlTxBEb172yUoJZF4UIUXjdkYxMBb0mmqlWPWwzg169dk1uFNHMj+EfQGsIT1qxtYDxh7
	O3WR7e0qrU1+Fd7vJtcmgc/O2LXLfigCtSfe1THGZX9Rxlh5+0zZ9FLq1D52l7P6iffPCXrQ6ak
	ulZFzqaaBKby/ov6MCDz8dorbDu9Z5Q69rTlacm8iPMFUEeBraCzK327DJiFBFRtBB3xVW
X-Received: by 2002:a05:622a:199d:b0:509:99c:2cbc with SMTP id d75a77b69052e-50957e1106cmr194434801cf.63.1773696981096;
        Mon, 16 Mar 2026 14:36:21 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5094a03556csm105356641cf.2.2026.03.16.14.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:36:20 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH 0/3] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Mon, 16 Mar 2026 17:35:55 -0400
Message-ID: <20260316213606.374109-5-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing mmap() and mprotect() LSM access control points for the
overlayfs filesystem are incomplete in that they do not cover both the
user and backing files.  This patchset corrects this through the addition
of a new backing file specific LSM hook, security_mmap_backing_file(),
a new user path file associated with a backing file that can be used by
LSMs in the security_file_mprotect() code path, and the associated
SELinux code changes.

The security_mmap_backing_file() hook is intended to allow LSMs to apply
access controls on mmap() operations accessing a backing file, similar to
the security_mmap_file() for user files.  Due to the details around the
accesses and the desire to distinguish between the two types of accesses,
a new LSM hook was needed.  More information on this new hook can be
found in the associated patch.

The new user path file replaces the existing user path stored in the
backing file.  This change was necessary to support LSM based access
controls in the mprotect() code path where only one file is accessible
via the vma->vm_file field.  Unfortunately, storing a reference to the
user file inside the backing file does not work due to the cyclic
ref counting so a stand-in was necessary, the new user O_PATH file.
This new O_PATH file is intended to be representative of the original
user file and can be used by LSMs to make access control decisions based
on both the backing and user files.

The SELinux changes in this patchset involve making use of the new
security_mmap_backing_file() hook and updating the existing mprotect()
access controls to take into account both the backing and user files.
These changes preserve the existing SELinux approach of allowing access
on overlayfs files if the current task has the necessary rights to the
user file and the mounting process has the necessary rights to the
underlying backing file.

--
Amir Goldstein (1):
      backing_file: store user_path_file

Paul Moore (2):
      lsm: add the security_mmap_backing_file() hook
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c             |   28 +++++---
 fs/erofs/ishare.c             |   12 ++-
 fs/file_table.c               |   53 +++++++++++++---
 fs/fuse/passthrough.c         |    3 
 fs/internal.h                 |    5 -
 fs/overlayfs/dir.c            |    3 
 fs/overlayfs/file.c           |    1 
 include/linux/backing-file.h  |   29 ++++++++-
 include/linux/file_ref.h      |   10 ---
 include/linux/lsm_audit.h     |    2 
 include/linux/lsm_hook_defs.h |    2 
 include/linux/security.h      |   10 +++
 security/security.c           |   25 +++++++
 security/selinux/hooks.c      |  108 ++++++++++++++++++++++++++++------
 14 files changed, 231 insertions(+), 60 deletions(-)

