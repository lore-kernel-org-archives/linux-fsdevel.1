Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E434B669
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016235; cv=none; b=meV+gNsU8rSgKP7c0gaRCNuCYmYhAYzsOx2d89PaQPENcVBYktHhRDePFZPqwL3yfpJpHXUWYoW3PCh+Phz/ACqFq0wNcTodDfvfmWocFtOx7qK4ueY200xs0egIpDRX4WcSt8z1cC04RG/nl6sCo9aYf7bnCLxHWQKcTHNwDHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016235; c=relaxed/simple;
	bh=WSAeD9+GINAzh16KM2LUaC6xph/bYkCKYNODz21UYmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ku1BBS13T1++URuFaYANuKWbLtSoDqJuRek71LPgt7EodWo7BYC1IWv1Gowk8ndanwJiLO87urGJs6xpIzM7z2xms54jZuVX2jyFTyNJS7VfSMBYFoNQpvOOMVcEkHf+E9o3PixzI7zkEmEDHj1S0X7P++tPtzW6NN6y18JLwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5bBGAts; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5bBGAts"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d6ab4476eso18029941cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779016233; x=1779621033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pt++DOA6Wc2HF8ky6f3A8ACPhJyI14sNysUPXV2Ffo4=;
        b=m5bBGAtse5lrwNlkTUdq0iDZacuzY1HL6Yqf98QDiLACGwF677LJ6FD7sdyTAyeE0r
         kohyr43wDut2HNSAw3FMJKH+rox4S2NyNKVGjzkFUjwK4thT3zUdNIXCeV7Xc0RktzkC
         vCp33qVli2b16Rg9OjPErrab+wnkprWVsNo8gda3UQZacMYHO5W4wAg+xnNJTEJMHn05
         dRGsCO1buyiG1XIYNX07+zQCOtLNz9T6fzGBHVVWpPmxWDUX6ricO/jEubaEp9N0C/YP
         2Js7Ig+TcnBFgD5rGpzZj6VhiKOuThPgX8ehTY/FjzJG8koahD2CuXMDK5AMsHSVba3U
         aifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779016233; x=1779621033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pt++DOA6Wc2HF8ky6f3A8ACPhJyI14sNysUPXV2Ffo4=;
        b=ikBqtogdNTc20K/mFuT6HKMIArYfJz07JHdEtHBpKvaxkeDvISxk17B1jVcHV4o7tU
         N9GMHP8JPcYKMNCDjaElTjworJVRMMStUfNS/j234KHyvufGUwsLnObTIKhtWL30OYkO
         SPMUA+44BFGi6PmLDI/fGEQOcxN2gycGeHe7p3Ymp6vlJQaVx0y32fbUHxErj6c7YVX+
         g71JqdU7cJA3JH2mdS3COFBvmMIoNeK6bnONtOk0tbNo+0V8PfNY9owGJORDlmYsAY6O
         YOYl6ZGQ6Gj8LJQAYwaRCs9bal9MvOzcdeGrXn2K/BoUAeYnxHOzyGkv5q2bfn7Bzquc
         diGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MRK+3FbZxVoiozXxGNAQqW2fqjFjBLw/Qv8KRirIG7iFbHrPoLy8sKOWyJfDi9HeKNuV0smyZNEmwTIsE@vger.kernel.org
X-Gm-Message-State: AOJu0YzEwYjrfKDCIHkMlxoofW7gOYXOdN6YshxyMC93E9A3cJx7doFM
	pfG6LkKiHM5JKZ2XhsKH4c3+oD4ax2fjG59Tsk9D2jp9NRapmp6dIEf0
X-Gm-Gg: Acq92OGlxpAAeOLg4pJSUTUzxi+fm6a+FjfQcbHNE+yoLubINxKZvSoo4Qujemf9QaR
	/JXnehe68xcrBjyKzN9/r/JRsCZ60AVyRzx23BQ0Ip5PlxwjOEv82RUID+v50kbKsQjJ5wOFkgV
	LD56jpY8xGaOEKzHZ/EoAXnnVHgcKFc28GRAECEur/kWwbgh4tq/G2O9KUWIsdzD3+jsZXPStLt
	EhswBSpcS1cfRMTSuzZ2Swnvpu1c4Km9bJpnYwYVlsyvNH/imyuqANgQ0NQB7BkyGBafLqm+uzl
	wLUsg2IhAGo+4lHbpr4ZXJ/eVeEd6xXfoVLPq1s6Fo/bC2vqfAdVc95A3TackNRmuVz0by+H09K
	UY5A+eQoMWFzpk+NWUasjzBaDscqGAkw5NlR2sCHXvb+3qYrfAMMylYbHteQRCzlJExuI/WUrZF
	1UhgSSfVmAqA3CDLQMN9zJLnvtLfL8srUsLBlcxvPF+05Tlr+62u0mUGAtIPFkFgKvv1mffkLTS
	A9qDcPIe4fPS1wlKV9jOtn41+UBscoG7yPZT/Oy9HkSMgmKfuHZvkYRo7QllNaK
X-Received: by 2002:a05:622a:996:b0:50f:de06:45e2 with SMTP id d75a77b69052e-5165a0d077bmr145323161cf.31.1779016232644;
        Sun, 17 May 2026 04:10:32 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456df09csm100306651cf.13.2026.05.17.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:10:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ZhengYuan Huang <gality369@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ocfs2: harden inode validators against forged metadata
Date: Sun, 17 May 2026 07:10:11 -0400
Message-ID: <20260517111015.3187935-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This series adds three structural checks to
ocfs2_validate_inode_block() that catch attacker-controlled bytes
in a freshly read dinode before ocfs2_populate_inode() copies them
verbatim into the in-core inode.  All three checks fire on the
mount, lookup, and read-after-cache-invalidation paths and reject
the block with ocfs2_error(), the same error-propagation
mechanism the existing suballoc-slot, inline-data, chain-list,
and refcount checks use.

Direction
=========

This continues the validator-hardening direction visible in the
recent in-flight ocfs2_validate_inode_block hardening series,
e.g. ZhengYuan Huang's "ocfs2: revalidate the journal dinode
before toggling dirty"
(<20260512024115.4036371-1-gality369@gmail.com>), "ocfs2: add
extent tree depth validation"
(<20260416110229.3283682-1-gality369@gmail.com>), and "ocfs2:
add extent list validation v2"
(<20260423094116.876696-1-gality369@gmail.com>).  Each of those
adds a per-field invariant check against bytes that downstream
code paths trust unconditionally.

The three checks in this series cover three more fields whose
attacker-controlled values currently propagate into VFS-visible
state without question: i_mode (type bits and reserved bits),
i_rdev (cross-checked against the file type), and the
i_size / i_clusters pairing for regular files on non-sparse
volumes (patch 3 is gated on !ocfs2_sparse_alloc(); sparse-
allocation mounts legitimately commit i_size > 0 with
i_clusters == 0 via ocfs2_zero_extend()).

Threat model
============

The validator is the chokepoint that protects
ocfs2_populate_inode() from a malformed dinode whether the
malformation got there via:

  (1) An attacker-supplied disk image mounted by a privileged
      user.  The mount path runs every dinode through this
      validator before any unprivileged user opens a file on
      the volume.  This is the same threat model the existing
      inline-data, refcount, and chain-list checks in this
      function were written for.

  (2) A compromised cluster peer with raw write access to the
      shared block device.  OCFS2 is a clustered filesystem;
      the on-disk blocks behind bh->b_data live on shared
      storage that other cluster nodes can write.  The local
      node's cache-eviction re-read runs the newly fetched
      block through this validator before ocfs2_populate_inode()
      runs again.  Oracle's BlockErrorDetection design document
      scopes the existing CRC32 + Hamming integrity primitive
      explicitly as defense against memory and wire corruption,
      not as authentication of peer writes; the field-level
      validators are therefore the kernel-side defense
      whichever path produced the forged block.

The three checks in this series are deliberately structural:
they each express an invariant mkfs.ocfs2 and the kernel
maintain unconditionally, and they reject any dinode whose
header violates that invariant before its bytes propagate to
the in-core inode.

Scope note: these checks block forge patterns that touch i_mode
(outside the canonical envelope), i_rdev (on a non-device file),
or the i_size / i_clusters pair (regular file with size but no
extents, on non-sparse volumes only).  A forger who keeps the
dinode within these structural envelopes (for example, flipping
only the permission bits and uid/gid on a regular file that
already has clusters allocated) can still produce a dinode that
satisfies the field-level invariants; closing that residual
class is outside the scope of this hardening series.

Validation
==========

Each patch builds on top of the previous one against mainline;
the series as a whole builds clean against v7.1-rc1 with zero
new warnings.  checkpatch --strict reports 0 errors, 0 warnings,
0 checks for each patch.

The series was exercised on a two-node QEMU cluster (virtio-blk
shared LUN with share-rw=on, both nodes joining the same o2cb
cluster, mounted ocfs2 with metaecc):

  - Pre-series baseline: a peer-node raw-write forge that adds
    S_ISUID and flips uid/gid to 0 on a regular file is accepted
    by the existing validator chain; the unprivileged user on
    the victim node exec()s the file and gains euid=0.  This
    confirms the cluster-peer write primitive is reachable in
    today's mainline.  Per the Scope note above, this particular
    forge stays within the structural envelope these patches
    enforce and is NOT blocked by them; closing it requires the
    out-of-scope keyed-integrity work.
  - Post-series, structural-variant forge: a peer-node forge
    that, in addition to the setuid + uid/gid changes, stores
    i_rdev = MKDEV(1,1) on the same regular-file dinode (the
    cleanest cluster-context attacker primitive patch 2
    catches) is rejected by ocfs2_validate_inode_block() with
    ocfs2_error "non-device mode 0104755 with i_rdev N".  The
    buffer-head propagates -EFSCORRUPTED to
    ocfs2_read_locked_inode and the user-visible result is
    Permission denied on subsequent stat / open / exec of the
    forged file.  Analogous post-series forge variants that
    flip i_mode outside the canonical envelope, or that set
    i_size > 0 with i_clusters == 0 on a non-inline regular
    file mounted from a non-sparse volume, are rejected by
    patches 1 and 3 respectively.

A separate cluster regression (mount, peer-write a regular
file, drop_caches on the second node, read it back) runs
clean post-series, so the checks do not regress normal
operation.

In-tree selftests under tools/testing/selftests/ that
reference fs/ocfs2/inode.c or any changed symbol were checked;
no matching selftests exist for ocfs2_validate_inode_block(),
which is consistent with OCFS2 having no in-tree selftest
coverage.  The subsystem's standard regression coverage is
xfstests (the generic fs group) plus ocfs2-test, both out of
tree.  Those were not run as part of this series; a full
xfstests pass before merge is recommended and I am happy to
run a representative subset and report results if reviewers
would find it useful.

Patches
=======

Michael Bommarito (3):
  ocfs2: reject dinodes with non-canonical i_mode type or stray bits
  ocfs2: reject dinodes whose i_rdev disagrees with the file type
  ocfs2: reject regular files with non-zero i_size and zero i_clusters

 fs/ocfs2/inode.c | 118 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

--
2.53.0

