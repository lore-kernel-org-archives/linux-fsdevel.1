Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE72271A71
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776633737; cv=none; b=DF4pcIlO62ql6vheuoRLGGNHWgRSiF+kXC5nkGuYdfsZB7RhRXtDyZd3yd+2IcOrjdzMq57y8d7Xlc/fTYBJrzoFQrPgGl+PqQbxr9DphGc6axe7k3Zw7+0DkIhzrdRi/DwJnsGxpVt+Wv0yXBiUZtQDn5C1YMwCdm4hBzBzZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776633737; c=relaxed/simple;
	bh=4mgFnDuqjDazkpWQSACMpuF+9o6jWUlghenOuJwyDNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WY45UGHUL6n4Sfvz8QZd0Zu0Stf3AZ5AWqDKVMPPyyvZ1gqanv88WhQNu0P0TOBiTISXXRXIi4sho1wq5YX8s2/lySRMFBnrVN0Mt0OyryBVl+UsIVyEryTBVGG+mK+uW4+JyyfoO6HGi0iWHFsCe6ZaQOUex3lvx27nNrcgT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BiRyQgcj; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BiRyQgcj"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d7e7f48499so282516985a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Apr 2026 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776633734; x=1777238534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qliX1CpRzcqySHVjBmsdzyegBGfy3s8Af3FF3IEJPas=;
        b=BiRyQgcjrt6Ok4yqnPJexgS4v0aK7KbO+dTi757V1yJOXJA90KPzeOZXMSlBnoW5TR
         /a4+iJNmDxH2lXVjM1abh408IMR/HywLKYJMDfcoIZYe87kGyT4IOOsRt9W5QLrgmGcN
         4YcOLN77KgNLHVSzbEHe1wrM9L/hqn9Edi1ex1IG7/G7EGKSP3yxQKfnTUCLPh29ZDaI
         uctsBFnIliKDbEfRLa1XtuRlViEUT83pEGGvD0O1ia04+xOqjKL84XP5XhW4pwKO2HD/
         Ml7jzqNk0qPCDJ21srpMVzF1kUMrjdShB+sdOcZL1IS0dHp4sCCoDxIJhliIgBUX93ve
         7mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776633734; x=1777238534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qliX1CpRzcqySHVjBmsdzyegBGfy3s8Af3FF3IEJPas=;
        b=jY747HWw2Lifw36h8R+mn/0+oq/HSOAXgmOV7+BE+cupU0cHbpVqY20VBLXavPB4JG
         fGjeddWTjQdfxwSqEbyNyQ3L6Rh4qplO3mmssNJtZxIm8rmB5YXvIY39iHBXGb5haZga
         vfnTCkB9//mDCpWACkWKSQETiOBRdmE/Hji+CzOtczi85IvcxGgmKsMHYjgwZAEko+ze
         5tEZ5p0Uc5ZTG/YWCi6zPJC6gHKxSYEBZgfMejFOfAn4ri2GSQ+3tVwLQRIRH0Sn8xkE
         dSQfR6nurmJOR040HZDPyoTfCep2eHlydqLPaqL8jrGdYembMUEIDFqfL/xFUPgu2Q/Q
         ZVtw==
X-Forwarded-Encrypted: i=1; AFNElJ+RPY1RaPHokKssuj4MnTMxHPA+M+Wcba+vz4hefS3CS0G5YhJ8lccFV0GLl5/+X3JgUKIbarjz6LDXkd28@vger.kernel.org
X-Gm-Message-State: AOJu0YxThqAmMRWE+Nz7wQnBkbPH5sBazHHoZvKgosmawtUhXObwvszF
	JN2uXgreG/DzjC9M+sae4O9j7+B2bLSUt3lKlKWjwPUJVDFD87t75wnP
X-Gm-Gg: AeBDiesN9LnOMsZBFnaK89XJt/wzV4Uu7Jyr8/kYlFu0m67HDOvVOc1p9o6M6G7CA7n
	Om6q0MGNsV6LZsSzK7jJ4bWqBbqzzArgPM826eM3NVIAR5hjHIj32acrtc+efQ6owTBijQ7z0rv
	iCUCWaZwUSQDHcwGBApdIRnkNelSDOVUFI9XLhU3zrqMneActdjxhss3qDWzY0BP5fj42przZP8
	Se/sBOpSXfR85F7ny1zH1vrKo6O1YGPqhiwrhYU1kJ95ZcVwNMYZSHB0Kk0yewQn775FcoAi5Bz
	+iIDC4Nri1n5zXJZA7Xdj8hWKII1dvjqJH52/CVdT97BdIL1JZBu5LOtlDaxypaO5+ijVOh/dCg
	bzinpojAPJ7VuMQxQuMAf4epfD9rRmVbSMhbfDrB8fLs3GkgCCbNJ/00zMKEiOdv2MT0BdkJWu9
	gc9NAtwzxaiysroCHPU9FCQaqsYsvKtWidLkjj+m4W6WHl8+JXBA/QrKWjSV3psM3dM++xANtOR
	mkKQjMWoMDd5pzn/xrZ35o+y5oQ76U=
X-Received: by 2002:a05:620a:241c:10b0:8ea:b828:350d with SMTP id af79cd13be357-8eab828370fmr236380585a.11.1776633734532;
        Sun, 19 Apr 2026 14:22:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d65c1321sm654849185a.15.2026.04.19.14.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 14:22:13 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Edward Adam Davis <eadavis@qq.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] isofs: hardening for crafted CE and NFS-handle paths
Date: Sun, 19 Apr 2026 17:21:53 -0400
Message-ID: <20260419212155.2169382-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small defensive bounds checks for the ISO 9660 filesystem, one
in Rock Ridge CE continuation handling and one in the NFS export
path.  Both surfaced while looking for missing bounds checks
adjacent to recently-landed isofs fixes (0405d4b63d08,
f54e18f1b831).  Neither is a memory-safety bug on its own; the
existing sb_bread() / isofs_iget() paths handle out-of-range
blocks cleanly.  These patches reject the malformed input at the
earliest point it is known to be out of range.

1/2: rock_continue() reads rs->cont_extent from the Rock Ridge CE
record and calls sb_bread() on it without validating the block number
against ISOFS_SB(sb)->s_nzones.  commit e595447e177b (2005) added the
cont_offset and cont_size rejection but left the extent number
unchecked; commit f54e18f1b831 ("isofs: Fix infinite looping over CE
entries") later capped the CE chain at RR_MAX_CE_ENTRIES = 32 but
again did not address the block number.  The reachable attacker model
is a crafted ISO auto-mounted via udisks2 / polkit on a desktop
session; sb_bread() on an out-of-range block returns NULL cleanly, so
there is no memory-safety issue, and the CE buffer is parsed as Rock
Ridge records rather than returned verbatim via readlink().

2/2: isofs_fh_to_dentry() and isofs_fh_to_parent() pass
attacker-controlled block numbers from the NFS file handle to
isofs_export_iget(), which rejects block == 0 but not out-of-range
block numbers.  commit 0405d4b63d08 ("isofs: Prevent the use of too
small fid", CVE-2025-37780) added fh_len checks but left the block
number itself unchecked.  An authenticated NFS peer with a crafted
fid can drive reads of adjacent-partition data on the same block
device into iso_inode_info fields reaching the client as dentry
metadata.  Deployment surface is narrow (isofs-over-NFS); impact is
primarily EIO / ESTALE with a weak info-leak channel.

Both patches are one-line (or close to it) additions; the existing
out-of-range-block check in isofs_iget() / sb_bread() handles the
read-side cleanly, so these are strictly belt-and-suspenders
rejection at the earliest point we know the input is out of range.

Build-tested W=1 against 7.0-rc7 with CONFIG_ISO9660_FS=y,
CONFIG_JOLIET=y, CONFIG_ZISOFS=y.

Michael Bommarito (2):
  isofs: validate Rock Ridge CE continuation extent against volume size
  isofs: validate block number from NFS file handle in isofs_export_iget

 fs/isofs/export.c | 2 +-
 fs/isofs/rock.c   | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.53.0

