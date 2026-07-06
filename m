Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708D6436BFA
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362177; cv=none; b=LX4WMJiTOB7ZPNsfWPG8MZJaMe5CFfG5c6lrbMjC+43PtycEdjvqrw02pto826FtiPWyJVGo5i1DF4sm3qCpoPcA5yb0DEQmazi+/A/5otaatB4qENFSMMmS2kPAyzOEoHSlP+65ECNyh2aOvwC5AfAweRRVMpvvRyt2LFNYs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362177; c=relaxed/simple;
	bh=7jfmA0qE57WssJpK+yQBeRlr2x6BcgCUug14nPT5umA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RzXUCSQjFWQCpVWOl5jX0AdbRIjNaAIroMHoDXbbhNUpAizmqENJ4JV49SDS9q5mALEm7jbA4A/QGZGOTI5e7/fon8XsEq4rL4yVPq7o8iL/LmqtSsbUFiSBWny8oO14GifjSbSgSWUgCIVuzT3YK+wBNs25A/MKwrFHWJsA/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXaI9WcT; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXaI9WcT"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381ed661712so2941730a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783362175; x=1783966975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6LCBJeQ/X3OvVlpNV+N1M7rV6nfZslftn6jANmgfYM=;
        b=jXaI9WcTcI0tfkapCd/6UcKqS8S0lGCpJGhznrpdy8kZ4BL8zSmbZo/2FPCDI71RvE
         5OnY6uGv5YI6qxnCMw5aQPmcgSVKsUldYXVCNgyul2AIj28Kzu4Yf60bT0HvDlU3c0PY
         EQsUxDfOyQ2SvGWF7ahyffJ6UrfeAdZh4FEoD/LLahGAsjCcj/mufzAg5A2EU/SCEQFV
         OCGPgA9IZoeGH5DTOTXgMT2mDZLy+ga2e9OViPpe80NegGb+pMQxneJRNJYyKcwtNMxS
         ZuNUi8CNnBjcaWD26egBKjao94nEEbaO3KlfYpbiUjbJ9YOrEWvg4ieBKwz2avwEKlmU
         bRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362175; x=1783966975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6LCBJeQ/X3OvVlpNV+N1M7rV6nfZslftn6jANmgfYM=;
        b=seRzWtIcxMEgI0i6ggOov1mzOW4iuCd7ux5D0caPEW6yFEACNDK77Wz52lFkwqdInw
         qWgaTdf07qsNsBa0ImuyyzyeeOQXohnPYcXEX99uPWnWBfy/49QlWBoCPIXNzdeKik7O
         FPgs4QQiiB+nUyOtUpVc0kfUmWV4X1RNrfF4V7sTb432zOjzVFWgEXuQcaw5hSvRfhe8
         GjH05VDLFiGMx6zkFr4oC/hVS4i4HK3y3zZcZzC9zhXJNYk1jfoLSduuefkgfC/vLgBe
         tFdh6qt5LMqq7tgUZrhL0dIudsDitxqsbBLM8C6bC7wEzecCHPA2dJ4P18lfY9Y2C5EW
         dYww==
X-Gm-Message-State: AOJu0Yx/Kg21QvxfqPTmTJdeduOfaM475dl+I3K3TmbhUC5jWfH5tb/t
	18nWCDc2fSLn3cjlFfOicrX5jV9zp9k6+pUS//wLVew0WZb94rxNlu6ruXVGow==
X-Gm-Gg: AfdE7cluVBVh2mhBsxnBusnjaB9H0xvVW4VXKzySmuCLp1MxEMgjXk2g3oG56JBrN5q
	1CrDITmbDQibcerBhB0Ej4pxb6DtGp1FIMqOjA+SFPwoM5PoGhlyxjXrnJmyrJxoDr+xWJIQmUI
	NwIG4ruozQrpYHd1Mg0o55oJpai2Ttyx0IO+Ql+aPBnibqfOfkmvYEURxhKWJInrUXxPVBb1rAF
	6lw0erVl4xdbI8/kpqwpmVm9ZxKw6y+7Hgh4D+PrYnZlDblE1OrpzZKNPKHs18sm+dUwK0DYRaD
	MZBn9msbWLSztk0fl6Xauz9IqHuGKe7b1TdHFTifjNc0XFmSUNy3tvkXB6x78eWWef9C7sS+pYu
	LJrU8pJpmcVVs5MvtHDLQUvrN+3oX77Vp4s2VwtCyym9wSJd2RLGk7m1z/uPmGZ0wp/HyNjDvhg
	==
X-Received: by 2002:a17:90b:2fd0:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38755573934mr1709979a91.5.1783362174685;
        Mon, 06 Jul 2026 11:22:54 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387a83fb23csm21238a91.0.2026.07.06.11.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:22:54 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [PATCH 0/2] minix: modernize function declarations and eliminating some magic numbers
Date: Mon,  6 Jul 2026 11:22:42 -0700
Message-ID: <cover.1783360491.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Another set of minix patches fixing issues that I noticed while working
on other things. The various dirsize and namelen values being set in
minix_fill_super() in inode.c, which vary depending on the versions of
the minix filesystem and how it was created, were being set as magic
numbers. The function declarations in minix.h were also a mix of current
and historic kernel coding standards, where some function declarations
had arguments with types and names while others had only types. This
became an annoyance when updating minix.h because checkpatch.pl would
gripe about improper function declarations.

Create and use #defines for the various dirsize and namelen values in
minix_fill_super, and modernize the function declarations in minix.h.

Both patches have been tested by mounting and performing file operations
against v1, v2, and v3 minix filesystem volumes. Neither of them have
any functional changes.

Jeremy Bingham (2):
  minix: define constants for dirsize and namelen
  minix: modernize function declarations in minix.h

 fs/minix/inode.c    | 20 ++++++------
 fs/minix/itree_v1.c |  2 +-
 fs/minix/itree_v2.c |  2 +-
 fs/minix/minix.h    | 78 ++++++++++++++++++++++++++++++---------------
 4 files changed, 65 insertions(+), 37 deletions(-)

-- 
2.47.3

