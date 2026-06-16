Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64237BE7A
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 01:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781574268; cv=none; b=jdLm3T2FTyfUag3ZlghlR5SR7Lpj2uCq9ODeiKPVsmlxwCQZNFG0JN/xSuRKT4c8JLHJ+gaqfk7Aid/eKlTqa2i0TGp6u+5m6IvvW1z4FXO2GFlx9DuEsFNw6qRRQJknNvC+5n3QQAT8gHOVaciqpLHjmtmiANSzXDydwwYl5Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781574268; c=relaxed/simple;
	bh=ElPvESyHtIZBIZzEQ3wF/X7fQxATAJZSTHXuF5lmzSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bv02nM12EIBnI391vuAxdhBEWx+z1S7GNfh20mm5kqun8jJUeR2G72FPiQFnAUHiq9TICXAKvXB/IKBNNerkZhQCtoWVdRO78k00eSak7rnX17I9Cf/5JcHTKPFC6bDZN/XN0Ur3MMnaRr09u1yMVUCnqgBtFH4Vwg4xyL7f/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtiKZM6Z; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtiKZM6Z"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-69d7aa0ac14so2816600eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2026 18:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781574266; x=1782179066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xi5sYG6uyveDGeVU6XwSoMZ8X3XrDX41q4nmlIH5grs=;
        b=EtiKZM6ZpW87OoiVjN4ILPvxGR3DDScYL0Ni1kgH7/2pxkLkIAChpMbD0Ltei8Irp0
         i7ujsGhiI0U3JupzlTfVxgEiwjH8HXxVJzd/uUXa4V72mU7VSH72aVgXcYSHvm2U9CC9
         MKqKPq/SEhoWTYosLr6dtRYfBJQEseBG6SbPLYXDBGxb8p7iDUFarXzyt+EpJrzCLgAx
         FHXPqb+u6EbEwVKlwk7AT6fuxJd3kUjvydz8oFJDTZHNH5tmhijMi+EkkZNRlvKy6YWN
         X/J4gyjHpyj0j3p9qG1Uusvhjmh5BqTEd3qrxI19uCdcStDpzuFlWv/bNUCUNalz6uCw
         NgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781574266; x=1782179066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xi5sYG6uyveDGeVU6XwSoMZ8X3XrDX41q4nmlIH5grs=;
        b=A9PmJ1wU6RbYRJtu/V9idOMUtN30DufHGsZ+TaKqR0+pTLzFXLNWLZh2pXkuB0v2Hc
         CHvqXhNSEEnnoPVQ0LZmn6UCA3OWz6eokxyHSf1OApCGINZ786V4gVch6RkmfhrnF6Bo
         /vUpjlKRuFZllChyrlyeye+1WrXHEzGmXHcNntguPDGE5TyGavUGwkcsfRutjSsoB9qT
         jAv0M5rkYd01Z+EmxAvIWm0wUbCwXaXGCFXjdsdZkvSppLobShAFhQGkKnJvV5zZMTco
         x4AhWGg0Hy3yK61B1bIUc+RDYKdmOx6eP5eOt/+ChlgrAmQ7CPxE8mZUixDW/ti24j3z
         3Ygw==
X-Forwarded-Encrypted: i=1; AFNElJ+5ko8lKTw8urH+z++a2NGI4Wcn2jPmtgSOTsmC5Wh2RA48FhIkhhc5nu5r+DyxH9rzgycmSoXUAFT6ENic@vger.kernel.org
X-Gm-Message-State: AOJu0YxG48mRC3Kfrpl0V+jamBYjlguMSbSGESgfbmgn9qEn5vIdf6yF
	9wE+kntOfut3+WqGgTzL+kQWUXOnNpEvlmR04pRWDN8heZt1hkS96Lph
X-Gm-Gg: Acq92OGqpI3OBHKyJd+NNa1cex+zgMfO7ts4+/aNmF/pXfuiS23KIP/skashgpWfIkT
	XfJLp51IW1h3Pb6vt5XghrQ+xmwNJP4DqscE/yIFtn5Hh3U65Q8BVz2BWqxpJYWHDrceUbXEr0r
	mu0+KoUNdY4+n4ISOKGuvaIkTfgn2wqjQaKHb/SIK3rm1/9dEdHEbMJziP8HHwRUSqhrpnQTMei
	XGgNOOTrQ1Myrqy0cKL1vw58CgLYmBN1C8EFGDaaQLXJemysEhiU9YVjdtB2ahEq6V6/iX/6Jr1
	0tDChXuwxvhsOkOLsRerfvWaFlCM+kPz/FsU2teHE5NumasO/Eu69Hf5dDeNRtrybtPp5zCmcL6
	8udWMxOuaatCg1ApDoraa+KbOd963UoG73+wfaYoJzLEVCKBKaxAYS4gXziw+X7QoJDVvW8ZbnP
	//mk4KHsEuvXtZPWjR8BVpCbO+bRGWSO5TheRs9XHcaR2ZEnqmgL75hYDEKjSNhIa5JqyDKEXip
	nghqzBuJBbi3i7XxRWzLOmsKOfWurVCk4hXVOQsybmIbZbT2pFAo0o=
X-Received: by 2002:a05:6820:4deb:b0:69d:fee4:2381 with SMTP id 006d021491bc7-6a0a40ef256mr1280037eaf.55.1781574266486;
        Mon, 15 Jun 2026 18:44:26 -0700 (PDT)
Received: from rdf-gcp2.us-central1-b.c.storage-xlrait-66065.internal (163.80.112.136.bc.googleusercontent.com. [136.112.80.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00b41ed1sm4093011eaf.0.2026.06.15.18.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 18:44:25 -0700 (PDT)
From: Russ Fellows <russ.fellows@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amir73il@gmail.com,
	Russ Fellows <rfellows@xlrait.dev>
Subject: [PATCH v2 0/2] fuse: fix passthrough parallel direct writes with a minimal series
Date: Tue, 16 Jun 2026 01:44:17 +0000
Message-ID: <20260616014419.7913-1-russ.fellows@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260529031918.7361-1-russ.fellows@gmail.com>
References: <20260529031918.7361-1-russ.fellows@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Russ Fellows <rfellows@xlrait.dev>

This series contains the current minimal submit-ready fix for passthrough write
parallelism.

The first patch preserves FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens.
Without that, fuse_file_io_open() strips the flag before passthrough writes see
it, so the kernel never reaches the shared-lock path.

The second patch keeps the lock decision local to passthrough.c and allows
shared inode locking only for safe direct overwrite writes. Append writes,
buffered writes, and writes that may extend EOF remain serialized.

This intentionally replaces the older broader patch direction. The current
minimal series does not export fuse_dio_lock()/fuse_dio_unlock() from file.c,
does not add declarations to fuse_i.h, and does not include the separate
iocachectr/fi->lock cleanup work.

Regarding fuse_passthrough_end_write() safety: the shared lock is only taken
for within-EOF direct overwrites, where i_size does not change. In that case
fuse_passthrough_end_write() -> fuse_write_update_attr() only updates mtime/
ctime, which is safe under a shared inode lock. Past-EOF writes still take
the exclusive lock, so i_size updates are always serialized correctly.

Validated on kernel 6.17.13-p4min with fio 4K random direct writes on a FUSE
passthrough mount backed by XFS on a RAM-backed null_blk device:

  numjobs | FUSE IOPS
  --------|----------
        1 |   481,837
        2 |   931,883
        4 | 1,533,058
        8 | 1,730,477

Raw XFS on the same device at numjobs=8: 1,693,406 IOPS.

Changes since v1:
  - Removed use of fuse_dio_lock()/fuse_dio_unlock() from file.c; the lock
    decision is now self-contained in passthrough.c using inode_lock_shared()
    and inode_unlock_shared() directly.
  - Added explicit IOCB_DIRECT check: parallel locking is only allowed for
    direct I/O, preventing accidental shared locking on buffered writes.
  - Added explicit IOCB_APPEND check: append writes always serialize.
  - Added explicit past-EOF check: writes that extend i_size always serialize.
  - Removed all symbol exports from file.c (fuse_dio_lock, fuse_dio_unlock).
  - Removed all declarations added to fuse_i.h.
  - Split into two patches: iomode.c flag preservation as a prerequisite
    (patch 1) and passthrough.c locking logic as the main change (patch 2).

Russ Fellows (2):
  fuse: preserve FOPEN_PARALLEL_DIRECT_WRITES for passthrough opens
  fuse: allow parallel direct writes in passthrough write_iter

 fs/fuse/iomode.c      |  7 +++++--
 fs/fuse/passthrough.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 4 deletions(-)

-- 
2.51.0
