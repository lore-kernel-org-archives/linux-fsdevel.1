Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A339B483
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778433082; cv=none; b=hqhbzctM0cSv8wc+41hPpn/hLLaP0X+Q2yIxNE3J7g6LiBcsgX3Ehs4mJBGNoux0Sjf3CuAY3KwUfMvuP6lhIB8oEjUXo1GbcplBWO40jmgfRO/LmYW3SF3OigfOeAFI4rBft5uIOSD7IR0BEMEtDa+EXNkPjgyBCedGSP9ite8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778433082; c=relaxed/simple;
	bh=x9pvDzf+fY1FTfdaBgfdiihF5Jr+0DPrigW5GmWy+Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rrZV5rR6dVVbMkquhIeEprJEUo4rTV5opy0mTKAe/APYct5Yx7bgcs0AifEUxEmQBXyQAODIspO/QTdGdTBsrbbNwiarHyheyQn7TIATMpR1ULP+/ip4hU+fz6zFTsaLpYWybv1Fbroiv8Tcsv8Hi7aY2RRtmzTORBlAsFpeGp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnEQhO33; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnEQhO33"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3683157ec13so89748a91.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 May 2026 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778433080; x=1779037880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQvA8oYm5fgWSvqu1R06ttujcqV6rO1cZ19fO+2xVDo=;
        b=jnEQhO33yQFay/H6JXaPUTX8OsZCI/TGYR2CrXEDu8Ip82K8b9tGRkNy2xNL0dCuuk
         EsGBl8BH5mec9pg9G+v4mw/kon/85p6QpG9zbBwBnUd701D0DWWngE5Z12ABkdIR2ybj
         wdUjMsxStbLBK0JzZeucCQIvkQ3ISwx78ro73DyvwO1aTWjrb+zw434gb060H3CmPraV
         qc18E32BQrzLFDTh7M57BQAkQ5EloYU7w5LjLwwpXNiGPQ0JQTGlCMXtVQX+bQV+SiwJ
         PK72KzyR+A7goRtFCCNJHPf+4eKSdtziRR2DVzdfzdhWI8IU4oXC77d+7vXAgLcjzdpX
         onDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778433080; x=1779037880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQvA8oYm5fgWSvqu1R06ttujcqV6rO1cZ19fO+2xVDo=;
        b=PY8FRzqtTtukvC9Cusdt0dVdBk3RUrcTHPMioClantNqobOGZE6QS0QdJrKTp/vGJd
         6DDqnHk5AUGOlWJDYI2ZcDFJZUC+41HeoaAeAFeeMS5Rtw7peoRpVkg6DQq2sxG+afkH
         9QesBGAHaEi9Y7sxxABfUAJxcU0PcsiPWdbu8MgD+EJwggKsIPoJa7fjQo5r9LOFWf6e
         qzNx0dCppLuJS8HMt40VkyuBsQoTcarmCznOrVtIlp5+YoskVp2HYs2ZGc/I4kmWmIce
         dIuv9CZWQQhs9yC8z4awdJx3RxwjIzCJLfWVOchEcbz2pVFQjqSldw4JYrk2fg35hiIu
         vGng==
X-Forwarded-Encrypted: i=1; AFNElJ8kF8fwYrzZRV+oqs+qC4jqbXrFvBU5OuGgAVkFh2xz9245PwQlikr/O7YeveONdXuWwx6ZEmxIeMWqVWw1@vger.kernel.org
X-Gm-Message-State: AOJu0YznIe56sUBRAxCD62YlAn9wpLlypod7t8o+45d1WRQ/jhtGNjvb
	SVnSJuS6kyH8febjdwQFK+3vXdn1HZtD5xmZxfYXFWNAWc3B4yO1TBgfJ0u1Ig==
X-Gm-Gg: Acq92OE6yZFydmu3gL2fLOhsIieg+Fn9bpSBEzdZRvrG0FrMDok3FBk627DVl3LClUi
	d/3QLVVzLkseBtAv4bt6klOAxjety39O1HiewOGTDv7xhGcnM2jeK2PBbSQ1KdEzOy1E074qYdJ
	cv7hyuBa/0Kv0n9ER8+qLbhJdOsLDbWWGQEvkqt0qadPK8sie/Qk/cVm02t9vY9sHTT3W7AyY+K
	zFz2/9/rVMDfEhCuNQuPKkLoZmGCgCih6wxZbJ/aY3/MqzJAI7G94QCNkbxhcp9CH/u6s3xCs62
	abWOf/1cr/Hk5hiCoVLskBg1NCNLDFX6qqpKPsG3VpR9GFyfTujec8rVjxqW+fj1BA+Ig8K7VoZ
	6SwB9CxjNCoOkH/mAbvNAtSf5ftBPHawzD84vHTB+SpPfVbLm2/hfIIFVhYdZgrPRh8+ZqPfprg
	eycqsEeSDzyNKYfQj1Uyh+gVcIRJYYHreL33lQtw==
X-Received: by 2002:a17:90a:d004:b0:35f:b8e6:6398 with SMTP id 98e67ed59e1d1-365b4f5bda0mr11628329a91.7.1778433080188;
        Sun, 10 May 2026 10:11:20 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367d623fa47sm5120690a91.3.2026.05.10.10.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 10:11:19 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ntfs: super.c fixes for MFT mirror check and sync_fs
Date: Mon, 11 May 2026 02:11:13 +0900
Message-ID: <20260510171115.368494-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes two regressions in fs/ntfs/super.c introduced by:

  6251f0b0de7d ("ntfs: update super block operations")

which switched the driver to the fs_context-based mount API and added
->sync_fs.

Patch 1 restores the missing memcmp() inside check_mft_mirror().  The
function still walks both $MFT and $MFTMirr records and computes a
per-record byte count to compare, but the actual comparison was dropped
when super block operations were updated.  As a result, mount silently
accepts a stale or inconsistent $MFTMirr as long as both records pass
the structural baad-record checks, defeating the purpose of having the
mirror.  With the comparison restored, a mismatch is reported at mount
time and the existing on_errors policy decides whether to convert to
read-only or proceed with NVolErrors set.

Patch 2 stops ntfs_sync_fs() from clearing VOLUME_IS_DIRTY.  sync_fs
can be called while the filesystem is still mounted read-write (for
example via sync(2) or periodic writeback), so clearing the dirty bit
there marks the volume clean before the mount lifetime has ended.  If
the system crashes after sync_fs() but before unmount or remount-ro,
the on-disk image is left looking cleanly shut down even though it is
not.  The legitimate clear paths in ntfs_put_super() and the RW->RO
remount path are kept intact and gate on !NVolErrors().

Both patches apply on top of ntfs-next.

DaeMyung Kang (2):
  ntfs: restore $MFT mirror contents check
  ntfs: do not mark the volume clean from sync_fs

 fs/ntfs/super.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

-- 
2.43.0

