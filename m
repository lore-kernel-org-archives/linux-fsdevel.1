Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFC42D0620
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 22:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774649104; cv=none; b=R4H1WQHWNI5mX6KXqJjdw/s3HnE4J77DJBLRxZE3IZ/0pVpoe/6E0LMZU/h5B2VGfCMKWm3OINVouvjormIoBb3xy6gsKQDjfkCV/Zfbt8PbnecCb+ZEZiOhX3T2Ki7tf2HQVMSy615UUkiflyPaYG815HGb7epAyDNK7NjhHbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774649104; c=relaxed/simple;
	bh=Vzh/+jHRIGpmYHe5gU3rnLfig2+dnLv+37f6At4au3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwLuQ60Dfk8XY1MpVzjNKO1LIGGW9993Ql5AFtROan6CZMq43QHQxlyz9aP9p3W8M0EjfBbfoyvlF/drRjv+MMLVil52iWg70lOogmVN++VchLsyhWSQ4+A7BstkFr4eG0ql4MqH6+TJw94TqFFS+JNDFsirH4C10XD5C42PPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IgQPajF6; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IgQPajF6"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfc497a604so364204685a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 15:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774649101; x=1775253901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
        b=IgQPajF6Uy4Lc1BNZuXYBleA2pUwwbgrEuOvuCy/0CZabfdMsZ7+5d57l1S3FnwstA
         OTOatZXgxkh/zsiFRc04C8Z1jNXJYmNggXq5qSPGHV97szdfMiHy9H8XbwvhwaamMok0
         hl2q2i3dPAUM+MvhcX0ctzsa+FIQtCkYy2R8LzY/Ndjqt7Q7a9fL8tfYXdlDq8jPKnY1
         3biJwgyJsJEN66x5N3LeNtFT/TA5MhlHBAagM+swABLERuYdPGdO8YnDNkSt++CCbznR
         Nnqwxu+7tjSC2l5wU9Rzv/5RbRl8OnenoesZU+9FprjLc/O5y8tA265dCIfgaeAX0rVK
         xFhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774649101; x=1775253901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3S8EhNAp/M6HE2VsRMXkSr61L034glOOF85HPPP/Kto=;
        b=XU5BFtOz8Xj2TCWoWc7569Zsiy52yH249usIw/5TkS4F+1/3RcndrxGeTR+FiqL4/V
         eeTGEY/eAKgf/NDjqQTEH6cn4nIWvS+HJXxeZMUF98cyFmv+ACcO4md3XbeaIEV82wDt
         fAEgevoSzaOq4veAu07L5QF2qChMvPeYWvUs0HsW9fzZYcVpOOclCxMRGYK94GVRV9XR
         zFYFuv3xJyBWazm+7HkfGyk5D+TY0X8wwZ6uPmy1in/XZw4WSPIMKag2G7E/wN7/5OHw
         EHiWSsdMHaAcFA/AJdGtbr8CU4lVo8+a6++ysi7Uof6MG78gkUZDzuAZlZkq6ojetZJr
         VXTw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ+8HF5LzMdTYj8HnvRIzLc0r+UWVFI84Icl+MVgoWPH9/+tGnAdXhg3jm5Pa1OOq8HnhZEvgdsIzwhOV2@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPLWcCvNu63B+s24+9FJXng7YcGzAELFi3q3oS1yMO7NoQ1R6
	llj0B3TjmTN1+w4H4DImDMiLbukbKtII7TAO3oP3Sb8o+koh9ZlI/KzpCVLs2Pg35g==
X-Gm-Gg: ATEYQzyywNJMhVEv2WdSxOw6d7rjNPWhw/nhCdh+FTueZzG2lQ5IVjgWrfSdyho9MFU
	uDcWAUYRM/NT/wcV//fvNlv2elWuZ5F25fiMPtQ+H6ciJCQZX5FrTwFV5pkna/s3p0LUTgHMGSd
	o7E2ci/BxDG0FWXPT1h3jCN8g9g5qK6gerCVBkNhpZLMTe37LhFWcCtXPUc59991PxiCXhyTTsi
	cFQGhDk6J8CJ9VpNDf26fnIVdcMlV7A7ELMG91csAYYd5pT36NTCXDLWfRPnbv+itYFzvWgwu1+
	cnvb0nSevnovayjutUQoGVw1rSD0UXoJYYdYRAKD0mlI74+Sy7c+WPm++D105yTdTB07KgAXrDB
	5P298p8G8ut5uwNzaVPpLboL3iDgu7kSs4syU7BnWuZBhjGeGCdgCtV/WQCJmdpRRyTNvYubEjn
	g/sOkIZ7KXTh/4zxZUeTYFQfnJkm1aPmnuilvlidRF0qUt/0VbvqYrKiRnIydcJWNnOE6CZFMch
	/BsMqA=
X-Received: by 2002:a05:620a:2944:b0:8cb:52e0:15e7 with SMTP id af79cd13be357-8d01c621d51mr531573385a.33.1774649100763;
        Fri, 27 Mar 2026 15:05:00 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d027edb8ebsm31425685a.7.2026.03.27.15.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:05:00 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-erofs@lists.ozlabs.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 0/2] Fix incorrect overlayfs mmap() and mprotect() LSM access controls
Date: Fri, 27 Mar 2026 18:04:31 -0400
Message-ID: <20260327220446.353103-4-paul@paul-moore.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A very minor update to the v2 patchset[2] posted earlier this week.  The
changelog is below.  The primary reason for posting such a lightly revised
patchset is to drop the "RFC" qualifier as I've had the opportunity to do
additional testing and I'm reasonably happy with the results.  As always,
anyone reading this is welcome, and encouraged, to do any additional
testing they believe might be helpful.

I plan to merge this into lsm/stable-7.0 either later tonight, or sometime
over the weekend, so the patchset has some time in linux-next.  As we're
fairly close to the v7.1 merge window, I may decide to hold this for Linus
until then; let's see how things turn out with linux-next as well as any
additional review comments.

[2] https://lore.kernel.org/linux-security-module/20260323042510.3331778-4-paul@paul-moore.com/

--
CHANGELOG:
v3:
- fix the LSM hook stubs (kernel robot, Ryan Lee)
- fix the lsm_backing_file_cache allocation size (Ryan Lee)
- minor style, simplicity tweaks to the SELinux patch
v2:
- remove the user O_PATH file patch from Amir
- add the backing_file LSM blob and lifecycle hooks
- update the SELinux code to reflect the other changes
v1:
- initial version

--
Paul Moore (2):
      lsm: add backing_file LSM hooks
      selinux: fix overlayfs mmap() and mprotect() access checks

 fs/backing-file.c                 |   18 +-
 fs/erofs/ishare.c                 |   10 +
 fs/file_table.c                   |   21 ++
 fs/fuse/passthrough.c             |    2 
 fs/internal.h                     |    3 
 fs/overlayfs/dir.c                |    2 
 fs/overlayfs/file.c               |    2 
 include/linux/backing-file.h      |    4 
 include/linux/fs.h                |    1 
 include/linux/lsm_audit.h         |    2 
 include/linux/lsm_hook_defs.h     |    5 
 include/linux/lsm_hooks.h         |    1 
 include/linux/security.h          |   22 ++
 security/lsm.h                    |    1 
 security/lsm_init.c               |    9 +
 security/security.c               |  100 +++++++++++
 security/selinux/hooks.c          |  256 +++++++++++++++++++++---------
 security/selinux/include/objsec.h |   17 +
 18 files changed, 389 insertions(+), 87 deletions(-)

