Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793138313;
	b=T2yVKsE3QQ3VFWGCp7WawIcpsPwivNbVG79TbSP5ukb73PApLhNm83bNl6bA1V2fPA/D
	 Rov1GfuJE/rsvRf3Gz48+5tnrw9AVH73ab2v6+hp0hO8qtS5VPLfbIXWSjej5IybrKdE1
	 lhB1CSvvUPeKJV4YZn9Z6JBDUH3fOu/ueU793jHyTKPVaYWPYTtXrM/JzYUk78tGNFqb4
	 0Zrnp4GVqRlIMMx41LDB6y8MKvkgud31J5u+0zB0qT56zKWjgy0fP2pDI2MXvZV8D1qzm
	 beKd6J1K+3iYQtBMo+X3CTnNIX6buKfIHbSBMP5yfXi/k1dyjey94G3pRZTsFTFhM1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793138313;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fKH8lEROlToWUaFVk6HBGi+a3bbRsRUnkhgJ3/v+Ess=;
	b=aJogAo5f0Pd0XlvPfE13UeOtmM5SJte3+HF7np2nCO0eCjUWeC3RTFKW1iR5zs8J/XiP
	 xuSDZxdQ35mR8TGkucRdQkElVpaFz4OzkPkHNTyv/PB2iNsl5bah+Pj0o2kjquUMWdSzx
	 UrB+bEmCZc3MLnffEixpumbeM80GvhpMynNppCBLYkYsRnvpfKsNf6ljJGksBLbn353QQ
	 nYINYuGelDUQwUX0QRaL2DOonsbIldrE6fhU/AgrvTFRfII58airW4piWerzizSIpwEoJ
	 aK5blY7CPkqHm5RR+ZzejuxmR+ry3maIWtKuG1hNv1oL8ydeYgXZkQ50ktOIyVKE1nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kktk5MvT;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF556606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 21:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF556606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kktk5MvT
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ac525c1f05so3337367b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793138312; x=1793743112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fKH8lEROlToWUaFVk6HBGi+a3bbRsRUnkhgJ3/v+Ess=;
        b=Kktk5MvTTmooZ0Q3aCi26vX768BMQ/1m/1iozUmZR0IzIeWf2BuQjazLJfG3476g/r
         8kvrHa8KOzQV8RrLyDJ1RlEwNQ7Be2n0AY1iiRRdIvzRuc1oPn4B9jjY/M5c2//4SLMj
         USKthEZZWMli+0SNU4AVBbstq5kepiLkMHCLjcclCHsvypIYeFeeQS+wYw7Tchrd69SR
         Mqo4l3cOiuk8Ls1Fk9pOGcS/WnltZVnMA+jAYh1/nSwoFzCdA70wDWhzfkrisd+SUrQE
         6YLG1ywmQCVUi4C6A9d96MuXY2i6KxrufWZylWKs6C1OPJqhIo/CTS2nFacO58n+P2BA
         axtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793138312; x=1793743112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fKH8lEROlToWUaFVk6HBGi+a3bbRsRUnkhgJ3/v+Ess=;
        b=xY01Df4nnIMkCnyLaGv4i+3uAJ1ZtVfPkM1oOez7zTmevhBMpOxevLCpIPt3DxeOTT
         BGTHD0QzSP4HufR9qpEcD2V5MIBs1Zc479PT4eQ3JSp5ueywspV+LKx4b/y19VMOYbvj
         wNQelradcPUZ08kl7ruj3Fn9qPgj5ZGVJqY3o2iA+GGwzKsZCM2SuJhJWR+SFDunG/VG
         fu9J5pODqKwBHSK/5v1/DLJv9/ltnIbioJhy7Iloejus55/xOwRAMP/KPz6qu1RY9T7G
         ZHhFYldtrldHly+1WBtt9k4KA0zIokuUMauby0VarQUeLyqNCKkUZc5UqWCandgUWnJm
         oPAw==
X-Gm-Message-State: AFq9FYJyd8B4TLsA/5vdHU4jv9+wPg2Sel/h99lgCy8LxjzU9QEvCObN
	WSPVFhP+GqVnixkCO8eaDKw8fOnLttZ7hffnjCD9nfr/Um6GXtXqNMpb
X-Gm-Gg: AYBFou1UmVxanEAv1pHEN/I8SB8+FMuo9N8ThBs0c3KrNWNwiku3qVr2cGY7ur8R3Hb
	9tMLldArF9K2kSyGq8c3L1A8017sMJIm1A5oS69m5R3eoKvqzCeebjXdtfBlvdf5/GyQjv0t7xh
	f+1aGzSWx/6nX4bOElfdNHeCFj6/5gSAjJ/ReYhsV4MLfu1BT8peo5cpwwZfm/M4I8VCdecp5ZW
	Dti2zI8SpOzbWY26ODPex28UNX6VOe0CJfIrFKQhf8obV/DgqY74I3uknlA+flver1jp3XdjOQU
	LWQXwB4vD7N7ITqulGpBUBriNEmVlR2XelUiwNB3WgQvCxwmBxcHwux3ZftuADs5GD3KyJROYa3
	SXLbMHrWhnYpcxAfE/80LdqT88n+/cCGPf2l1h5TJkEfEi5Gl6wTuYc1bnDM4DN3XyiKFpN6Lse
	aHioxr6zZpLU3tqoEdvGDU6pjZrgs5Vw5Ci/OP7hejUXhoOzQVYzVowXpNuLbFxcvafPRyFEdlS
	uGZfpIx3dEG0kQcoWFZDnT3weRFrIwECTKdEf24Lpz94Qr8WqNgH89a6JtEoJnas1xzApNQkfyi
	TaAGsuuSpBl7f01rPU6CFLanF7DwdbZ6
X-Received: by 2002:a05:690c:7108:b0:8b0:7c36:4afc with SMTP id 00721157ae682-8b1b5e81826mr2719877b3.58.1793138311531;
        Tue, 27 Oct 2026 14:58:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e59400csm19360677b3.22.2026.10.27.14.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 14:58:30 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J . Wong" <djwong@kernel.org>,
	changfengnan@bytedance.com,
	kbusch@kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	David Sterba <dsterba@suse.com>,
	Gao Xiang <xiang@kernel.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	libaokun@linux.alibaba.com,
	bfoster@redhat.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>
Subject: [PATCH 0/5] iomap: remaining patches for iomap_iter_next conversion
Date: Tue, 27 Oct 2026 14:53:21 -0700
Message-ID: <20261027215326.2693300-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Hi Christian,

This is a resend of the last 3 patches from the "iomap: convert to in-iter
iomap_next() model" patch series [1].

Those 3 patches are rebased on top of current mainline (commit 83f32c773255
("Merge tag 'erofs-for-7.4-rc1-2' ...")) in Linus's tree. They require two new
preparatory patches (patches 1 and 2 in this series), which are trivial
->iomap_next() conversions of the nilfs2 and fuse iomap code that was added
during this merge window. There were conflicts with "iomap: pass
iomap_iter_next_fn directly instead of struct iomap_ops" (patch 4 in this
series) during the rebase. These are resolved in the patch, which now also
converts the iomap users added this merge window (ext4 iomap buffered I/O,
exfat swap activation, nilfs2, and fuse ext_map). Jan's Acked-by and
Christoph's Reviewed-by on it predate these changes.

These patches are being sent out now in case anyone wants to look at the
preparatory patches or patch 4. This series applies cleanly to both current
mainline and next-20261027. If anything conflicts by the time you pick it up
at the end of the merge window, I'll rebase and resend.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260729192737.3190206-1-joannelkoong@gmail.com/

Joanne Koong (5):
  nilfs2: convert iomap ops to ->iomap_next()
  fuse: convert ext_map iomap ops to ->iomap_next()
  iomap: remove ->iomap_begin()/->iomap_end() legacy path
  iomap: pass iomap_iter_next_fn directly instead of struct iomap_ops
  Documentation: iomap: update docs to reflect iomap_iter_next model

 Documentation/filesystems/iomap/design.rst    | 140 +++++++++++++-----
 .../filesystems/iomap/operations.rst          |  68 ++++-----
 Documentation/filesystems/iomap/porting.rst   |  16 +-
 block/fops.c                                  |  10 +-
 fs/btrfs/direct-io.c                          |   8 +-
 fs/dax.c                                      |  48 +++---
 fs/erofs/data.c                               |  28 ++--
 fs/erofs/internal.h                           |   3 +-
 fs/erofs/zmap.c                               |   7 +-
 fs/exfat/file.c                               |  14 +-
 fs/exfat/inode.c                              |   6 +-
 fs/exfat/iomap.c                              |  22 +--
 fs/exfat/iomap.h                              |   6 +-
 fs/ext2/ext2.h                                |   3 +-
 fs/ext2/file.c                                |   4 +-
 fs/ext2/inode.c                               |   9 +-
 fs/ext4/ext4.h                                |  10 +-
 fs/ext4/extents.c                             |   8 +-
 fs/ext4/file.c                                |  22 +--
 fs/ext4/inode.c                               |  58 +++-----
 fs/f2fs/data.c                                |   6 +-
 fs/f2fs/f2fs.h                                |   3 +-
 fs/f2fs/file.c                                |   4 +-
 fs/fuse/dax.c                                 |  10 +-
 fs/fuse/ext_map.c                             |  11 +-
 fs/fuse/file.c                                |  10 +-
 fs/fuse/virtio_fs.c                           |   3 +-
 fs/gfs2/aops.c                                |   6 +-
 fs/gfs2/bmap.c                                |   9 +-
 fs/gfs2/bmap.h                                |   2 +-
 fs/gfs2/file.c                                |   6 +-
 fs/gfs2/inode.c                               |   6 +-
 fs/hpfs/file.c                                |   6 +-
 fs/internal.h                                 |   1 -
 fs/iomap/buffered-io.c                        |  40 ++---
 fs/iomap/direct-io.c                          |   8 +-
 fs/iomap/fiemap.c                             |   8 +-
 fs/iomap/iter.c                               |  13 +-
 fs/iomap/seek.c                               |   8 +-
 fs/iomap/swapfile.c                           |   4 +-
 fs/iomap/trace.h                              |  12 +-
 fs/nilfs2/file.c                              |   2 +-
 fs/nilfs2/iomap.c                             |   4 +-
 fs/nilfs2/iomap.h                             |   4 +-
 fs/ntfs/aops.c                                |   6 +-
 fs/ntfs/file.c                                |  20 +--
 fs/ntfs/inode.c                               |   2 +-
 fs/ntfs/iomap.c                               |  42 ++----
 fs/ntfs/iomap.h                               |  10 +-
 fs/ntfs3/file.c                               |  16 +-
 fs/ntfs3/inode.c                              |  13 +-
 fs/ntfs3/ntfs_fs.h                            |   3 +-
 fs/remap_range.c                              |   6 +-
 fs/xfs/xfs_aops.c                             |   8 +-
 fs/xfs/xfs_file.c                             |  53 +++----
 fs/xfs/xfs_iomap.c                            |  55 ++-----
 fs/xfs/xfs_iomap.h                            |  16 +-
 fs/xfs/xfs_iops.c                             |   4 +-
 fs/xfs/xfs_reflink.c                          |   6 +-
 fs/zonefs/file.c                              |  22 +--
 include/linux/dax.h                           |  18 +--
 include/linux/fs.h                            |   7 +-
 include/linux/iomap.h                         |  66 +++++----
 63 files changed, 492 insertions(+), 557 deletions(-)

-- 
2.52.0

