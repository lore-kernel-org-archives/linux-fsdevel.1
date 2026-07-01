Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45E342532
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 14:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915638; cv=none; b=AFREmCdOxotcV1YHBu/fWL9bcCgFNPa6BWw2iEJd/pxGsgbhWOmwO6u2t3n4gE2nCCHyvMeSTTWD3F00xz5m/vBaSZ1oc0Pzv7a32wFLAeBabtCqnx/v1WKE5FULIZDX2UG+n+09rIfDssIeRG4fmX7S607LTi1ya+owp4oR7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915638; c=relaxed/simple;
	bh=Fb4m7RM02pybVE+aIJPJZ3nvE8N/Yp2mY5olzcic/Rg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRybD3tV52bBeXFh3WDY/sZb4npRPgma7W9Kb70NIWjieF9w9BzeFZJSO9TkAh9jMH+PodEYDOm9bxgzvxzYIiyIs9jHC8SCgwSY5WYmfHj8rxZauiimE4CVQwqhU/vcIIryxS6uliZBecMpa+DCT0WpqrZDJf+4pwx3Tgr61OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY3d0JrQ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY3d0JrQ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9aaa90a791so249139a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782915636; x=1783520436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nD2OwIScAIp/QX9OAmRACvwCunUHX0Zy3/ChkfevH3o=;
        b=TY3d0JrQFTz5Kl7tfLZSym9E/+7l3FVxWvXI0FPfqnRMHHQ0m9PDzn3f0Quf+6Eeox
         2Z4ilzF5Whz/frAu2DPFd09OForpa7l7aXZQkN6WQpAypAZPS27CG0kFJTIarZtKXV3m
         9fuf+c7bDQ3UxiWwSneI6GqumEGJS8jAw4+odwhr8zLLz91TpfC2qRZ7S74xJHjDedPS
         lEf1aO+koR+dO136qO74XGJT7uaCk0wtY08SFMI/SiT7thuWtMFg2bYw0+earf3gQqJN
         KjN8qifx71sR2dN5gXHooEbHInxXn+PG/YGi2YBRWalmcMoJENSicnp1R5VjGLLU1wMx
         9/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915636; x=1783520436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nD2OwIScAIp/QX9OAmRACvwCunUHX0Zy3/ChkfevH3o=;
        b=COHIpkV99oEaphep+NIYNpvBR49h/acJ7kQc2D/ihKX9dEus7hlHlaftDxFL5F2F4J
         zM9OckFS5HEgH2dA9AQ+cfxKcSOa9TDYKO9rgZKKP6LebQTGJz49NA3M2CJxkC9KhW9h
         sSn21tCnKJwWwbKHovwr/MLLD5LPMLRPDfW8aimvWri52bP+hzdBNblwsnUjnLfzQmsc
         Z9npulujkMgfNFSLITIaDbTb7Snlxa/6I4LIMmEKEXPLh307eoPsbgn1JsClhFLW7Aoa
         KgW3ql9qIUja/btvyVWKoBpqKnfZZvgORZeveEp1gkwFPCm0Nyn6KIhcJYycORe9ZadK
         5iUg==
X-Gm-Message-State: AOJu0Yxg0DFXgWtPTB6nRsdm2Rk+83l8EkYZD5Evlenw7VsOWVbB0CtP
	i2RQsV6Vd5mrFY9LA74rPjSrHwQVKG/P/DvBMDEka3uFWx8vtmgXSAHQpyLw//DbkGs=
X-Gm-Gg: AfdE7cmAlg0Q+MRzeulC5mIqnm/elgPmEjQ0IPU1SF8W02DNuZa1WmRnUKKpMi/1i3h
	0zjekIQFj+UydieR3saz9+FJd8ct1j5oFlobYLSkTdBbWuySzEuFoxhfDWgG5HiBzgKoUrlvXOH
	jBKln/6iM9OPTly6PDdewCgVvoN33w5h4ofnDgTDZv+SOQ2IBb3wOjdRjTs+GgTwuunpijD7j50
	xXP2vOuJanUJYLJqRg3KpqNawQYLRR21I6FKYhKPYKFdl9Itd8pqmjaHItVUwl3RMS1+xQvx055
	ewucHCcR2OxUsYvG43N14IhlDiT4KuawtjzXQ6X2AJjJfKIEFhxOsw47o2HMWqfA+f+xNl20XWN
	zT9U4m50F8C+h63ae4eWeA85icjuC2XyM3VCCmMFwfDKEDIAuLGTaVoSqZKHkv6KDspcMRCNY0P
	hIv56RpMAMgUKvZ4gabWvKcsLJQV7Yoejm
X-Received: by 2002:a05:6a20:918e:b0:3bf:9fc0:f6c2 with SMTP id adf61e73a8af0-3bfed1bfe6bmr1905706637.11.1782915635572;
        Wed, 01 Jul 2026 07:20:35 -0700 (PDT)
Received: from DESKTOP-DK6PUT8.localdomain ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e32ef8e49sm383894a12.19.2026.07.01.07.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:20:34 -0700 (PDT)
From: yizhang089@gmail.com
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	chengzhihao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 0/6] ext4: fix unaligned edge handling in FALLOC_FL_WRITE_ZEROES
Date: Wed,  1 Jul 2026 22:20:03 +0800
Message-ID: <20260701142009.1510104-1-yizhang089@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

Hi,

The current FALLOC_FL_WRITE_ZEROES implementation in ext4 does not
correctly handle unaligned edge blocks. FALLOC_FL_WRITE_ZEROES is
needed to convert the requested range to written extents with zeroed
content, but the existing code only partially zero the edges and never
guarantees that:

  1) edges that are clean unwritten extents or holes get promoted to
     written extents, and
  2) edges that are dirty unwritten or delalloc get their underlying
     extents converted to written before the syscall returns.

Both cases leave the on-disk extent type unwritten, violating the
WRITE_ZEROES contract, and in these cases a subsequent sync buffered
overwrite would still observe pending metadata changes from the
conversion work that should have been completed by WRITE_ZEROES itself.

This series fixes the unaligned edge handling and cleans up a related
redundant i_disksize update. The first three patches are preparatory:
moving ext4_zero_partial_blocks() earlier in ext4_zero_range(),
documenting the return semantics of ext4_load_tail_bh(), and
replacing the single bool output of ext4_zero_partial_blocks() with a
per-edge bitmask (EXT4_PARTIAL_ZERO_START/END). The next two patches
fix the two scenarios above by expanding the aligned allocation range
outward for skipped (clean unwritten or hole) edges, and by writing
back partial-zeroed edges so the underlying extents are converted to
written. The final patch drops the now-redundant
ext4_update_disksize_before_punch() call on the WRITE_ZEROES path,
since WRITE_ZEROES is mutually exclusive with KEEP_SIZE and the
i_disksize update is already handled by ext4_alloc_file_blocks().

Thanks,
Yi.

Discussion Link:
  https://lore.kernel.org/linux-xfs/0b7f1a4f-da1c-4297-8099-98d738070ab7@huaweicloud.com/

Zhang Yi (6):
  ext4: move partial block zeroing earlier in ext4_zero_range()
  ext4: clarify return semantics of ext4_load_tail_bh()
  ext4: track partial-zero outcome per edge in
    ext4_zero_partial_blocks()
  ext4: zero out whole block for clean edges in WRITE_ZEROES
  ext4: write back partial-zeroed edges in WRITE_ZEROES
  ext4: skip ext4_update_disksize_before_punch() in WRITE_ZEROES

 fs/ext4/ext4.h    |  5 ++++-
 fs/ext4/extents.c | 47 +++++++++++++++++++++++++++++++++++++----------
 fs/ext4/inode.c   | 42 +++++++++++++++++++++++++++++++++++-------
 3 files changed, 76 insertions(+), 18 deletions(-)

-- 
2.53.0

