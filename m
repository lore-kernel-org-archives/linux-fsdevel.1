Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E852D46A1
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784402159; cv=none; b=ke8pbGE2OLuXn7kVa86rI3aKLI9/7Vpc/s+K0mQOp3HVHydQL6zxYiskaMGQ18/6axmHOElNBqBVl4vR21sX70ousZwy2CwMADTZpUjURAU6mY0Zw7QLXx0HD2DdGX1+eo8Aj1ldD6Zp5DR2yTjyFu4Msl6Do8Lx9TNjbNYQUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784402159; c=relaxed/simple;
	bh=NqNDtqGqbSZhJrGGc5At7ACd4vos50f5lT1ji/vXXxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VIVOYqw8u4QNsTYScY/JikNTTA1dZG5LI5CIGmv/p73dkD2kP3wFuWnoNXri+e0nUsueZ+S1G67foFBsMP/wcFSPebBmiNKaGmzQ2okecc1q1MzOdbBOndLrXy0fxm+8TauC8LrVGg+0k8arhRAwFStJ2+Pu5hkzqpkLP8962pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtnrMvYz; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtnrMvYz"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso12786325e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784402155; x=1785006955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iYUDcKkoJkhlHxJ16Bnz94ZFULLiEQmAk5z7Yu5ywFE=;
        b=CtnrMvYzjyWZZnS0knFZu10ePI4hGZRqe3E3eORSPo6KP0O+hPmE8cJvu1bSMeQpJ1
         cO4o0IYe+rGXr1+jma8+KNAfCVSE/jbCDB75AeQ6jZCP7SoZVfY/LTdxFDQpnTmFbGXy
         PdrPy901s8aWDkYf1TLllIjZ/urc6oP1nei9+4BMZ/RHalYHp6ctQ/VBEepNu0BHIMDy
         at8ztPehVIhxu1La+SUmq0JJaATe3V6x6iAGOYMGbfdG6AWSGWmU30zjVmyDECm/P/3a
         DxhXBGTakuA9sz+5w22gKHscSD26a/bNjhFapJbjVO3mWA8iLt90Fn3VqzuqXfuMftWm
         DtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784402155; x=1785006955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iYUDcKkoJkhlHxJ16Bnz94ZFULLiEQmAk5z7Yu5ywFE=;
        b=LksSw3uvCNmpTUeGKdjmGlTMP31Gnodqbh0pLalrLyQPfaahwTN5oKQI8XrATDMnoj
         KQiz2uE6IaO8rV6QX7JkQPF61lRposg+DhQ5qdMIx7rIYyL5d1midUTJQqiG/MOryDDq
         9hmHW+tcD0Y4ZpFZYwgUac73sKeehlSJuZn1D6x5DE75G2rQ67iBuFY+QrwcS6/MMo6t
         ldZJcIMZU9GTdboGcI+WZeJFNI9W4A/y8T99AkbLqoo2jffPo0xwqx7Pewyycw42MZBp
         2nSnnHj2C9Mug+Nl2+dAWMHXZn1gs6TOksz+6hYxZlabnOHQxnhiAGYo2dhrmjEA4GRW
         7cbA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7xcmgoMczfXfpSLlDmCyYpZyNA9bF0SiLPXm35RQA6hay455LEiI/2nKYcPywoj8mMfUxmX2ASRkRetZ/@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQa5irO1sJqc8GUMay9QjN6DUamIy4f9udTg5XNH5Kmo1Nk7W
	S8gTOYV6g0zfGpPFPgDKm1DlkhrM/EgsW5iMJRG1v6viBMnJfwrXAJYO
X-Gm-Gg: AfdE7clLReiDv8dEFTs2aqZcgQEvpCyoSqPPeSIUS4XQI3p9HocBhDPyKGNGu3kQIZT
	K0MRR3eeCCc0wgxMoZJKfIAHdy8KtY++uChUV7xVfh9uGRSLugsMSQ8CpyE2P78/vW1il59z4/n
	GI6EKF9t2tMbiUUkTUYQGZkNLlu7gCqYzylaCmP841Na6ZWxpkf2u/KFyXXYLxLWWXBreg/LWrU
	6AV8Ef19+W8BGR6calN4Ps2kGQhRQVDTIbHst/FYfE67+j/v8kvtmvgzEcAfYs5pxWC0sJQKK3B
	+1zckqZipNSLDPEGjGFbo9qf8/VU1bxBqRHsk8tIBIA9qcZ9Bpit1qB3rd+XxHzOWTg3N0PRLOT
	KMRbZW7REkr27la2jRHqPqsM2fic8Pnbi9pcw1m8FFgJqqgWewuKLmrwNbtrQ3661MS6A9bnOPu
	eKzMzRxt21zrXxJMLH
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id 5b1f17b1804b1-4954a3ee98emr90669215e9.3.1784402154743;
        Sat, 18 Jul 2026 12:15:54 -0700 (PDT)
Received: from spark.Home ([2001:8a0:7280:4000:c2b:a5ab:a31c:e0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2e8529sm140037005e9.11.2026.07.18.12.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 12:15:53 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	fsverity@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Curtin <ericcurtin17@gmail.com>
Subject: [RFC PATCH 0/2] init: boot image-based systems without an initramfs (rootimage=)
Date: Sat, 18 Jul 2026 20:15:49 +0100
Message-ID: <20260718191551.1703670-1-ericcurtin17@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Image-based Linux systems (bootc-style OS updaters, ChromeOS/Android-like
A/B schemes, embedded appliances) keep one or more immutable root
filesystem images as sealed files on a writable filesystem and pick one
at boot.  Booting such a system today always requires an initramfs, even
when that initramfs has nothing else to do; its only jobs are to parse
the kernel command line, mount the state filesystem, verify the image,
loop-mount it and switch_root into it.

This series teaches the kernel to do all of that directly:

  root=PARTUUID=... rootimage=/deploy/a/root.erofs rootimagefstype=erofs \
      rootimageverity=sha256:a9548f4c... rootimagesrcdir=/var/state

Patch 1 adds rootimage= (plus rootimagefstype=/rootimageflags=/
rootimagesrcdir=): root= then merely names the "carrier" filesystem.
The image file on it is mounted read-only through the filesystem's
file-backed mount support (available in erofs since v6.12), so no loop
device is involved, and it becomes the root that prepare_namespace()
pivots into.  The carrier mount is detached by default, or moved to
rootimagesrcdir= inside the new root, which image-based systems
practically always want since the carrier holds their writable state.

Patch 2 adds rootimageverity=, which requires the image to carry a
specific fsverity file digest, reusing the fsverity_get_digest()
interface that IMA and overlayfs already use for digest pinning.  With
a signed or measured command line (e.g. a unified kernel image), the
chain of trust extends to every byte of the root filesystem with no
userspace boot stage: the pinned digest authenticates the image's
Merkle tree root, and fsverity keeps verifying reads against it at
runtime, so later tampering with the carrier is caught as well.

This is the file-backed analogue of dm-mod.create= (CONFIG_DM_INIT),
which moved the equivalent block-device setup out of the initramfs for
verity-partition layouts back in v5.1.  For file-based deployment
layouts nothing similar exists, so distributions ship a dracut stack
whose only purpose is the five steps above, and which remains the
largest and most failure-prone moving part of an otherwise fully
image-defined boot.

Tested on arm64 (qemu -M virt with KVM), with no initrd= at any point:

 - control: plain ext4 root boots as before
 - rootimage=: an erofs image file on ext4 is mounted as /, the carrier
   ends up on /var/state, PID 1 runs from the image ~0.18s after kernel
   entry
 - rootimageverity= with the correct digest: boots, digest logged
 - rootimageverity= with a wrong digest: panics with expected-vs-got
 - build: defconfig and allnoconfig (!CONFIG_FS_VERITY, !CONFIG_BLOCK),
   both with W=1, no warnings

Open questions for review:

 - Should the carrier always be detached, dropping rootimagesrcdir=?
   The image mount pins the carrier superblock either way, so userspace
   can re-mount it, but a conflicting ro/rw state then needs a remount
   dance.
 - Should this be behind a Kconfig option like CONFIG_DM_INIT is?  All
   added code is __init and freed after boot.
 - Naming: rootimage= vs. extending root= syntax (e.g. root=image:...).

This series was developed with AI assistance (see the Assisted-by tags
and Documentation/process/coding-assistants.rst).

Eric Curtin (2):
  init: support mounting the root filesystem from an image file
  init: support pinning the root image's fsverity digest

 .../admin-guide/kernel-parameters.txt         |  42 ++++
 init/do_mounts.c                              | 221 ++++++++++++++++--
 2 files changed, 250 insertions(+), 13 deletions(-)

-- 
2.43.0

