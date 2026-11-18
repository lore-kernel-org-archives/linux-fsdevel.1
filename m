Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962940;
	b=I7cfeuKytXXKKRQySSFjZATPhq2AhfcsCG+DuL0jlagQlAwgqK3js2pULeJzzK7OKCh7
	 VsB8I2qhLcpKrAmBOWlQ/yLv1ydr2W/22m7uworOGRlGt0qtpVcrvVTfsbaVhTpLlxust
	 4p/upXGMT1+b1sVtH2RzvyYEiYk+uJLpU2sJ3ktrOS4r8P6Yw38HjLuUgbsqcS0zi3+9L
	 qa/Y/77W/A3xgFyMfbgJufhXqBty/r5U0tQRkxVr8Dnzr4MFjcpFgy5uAK3JrVPVosuLD
	 zolcC1eDuQZ9l4aHDMPwjXfH3i9je2kJ46wumQH7cnFQIaDGaRQszk10B9Mn1Ch0VmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8V2XOZmn0Vctd6GGoq9tH0tWyX2ZAclwzJyrOF4lr5s=;
	b=R/aPkc7rmWffIrEhQ9Vuk+xs8S0T9EfviIL7+YU6KRjF+DwUWKV16uH+h4fUANjH4XLQ
	 zDPupD9FI5tA994XfUVOjBdbqdpKkYWkz+VWt9Gip6M1MaYktiK+iJEe0VXbvuLuTPvL+
	 XDy2iEGqQbHhfs9tYsSDgvPobP1ElDZRrZmeEexuXQKFOTEzoSGDfa7C+1yiLATXSo62h
	 hl+cflVrPVY4GFTi1syyauYS7sVF8n9YHY9YIu/tx2VnIl333TJnz47IV8Dnh3GsGYDrS
	 LPwIVupdOADMYY8aNGpXw5xcs3j3Cn4FPQGOQdsS2gdaEHxL9Q+Vtra5RLxTZvMA26w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j5niG9jT;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1881B606A881
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 00:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1881B606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j5niG9jT
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c58f18765so225932d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 16:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794962936; x=1795567736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8V2XOZmn0Vctd6GGoq9tH0tWyX2ZAclwzJyrOF4lr5s=;
        b=j5niG9jTnJN1+gZWK21jVz+cw+yHDsYF54ZwSy+ffCeVmvhUtigihjzMA3Mx/izRsI
         /fZJgCpHIIkkY5Wf1lmBFZ+Xe3paQzu3YFRsTVJyq7eVhJ6kqpBhSocstjZb7M11xhbh
         3WlkURETSQgnt/vNwX8lpuJcDbb2BuCoCXjQjs9GaHZcER53/T0+PJmZD0EutNvY67P7
         I2L+M2GDcmp4rGU+5p53p6w9sYjfjw+kkZAfFDv0qc9Eh0iECvt+7tLG+asujOUE5UTg
         NTb9cCWZGl9BCi2FGlAKXt5SDnOw5zR7Y0jnh7rD3cPAZV0I5b2KoDTK2BcZMcQqoLyw
         bf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794962936; x=1795567736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8V2XOZmn0Vctd6GGoq9tH0tWyX2ZAclwzJyrOF4lr5s=;
        b=JrPDH4OZ0UtRBhwqn5/dPGVK+X7kc3attm+wLTnfIukkaYLT2kQS6hjma/J5lDrolh
         SHYXcqxflS7Gc9VNGJwDEFPY7a7Ek/m9eSmGgTRfC0YGM/avn+/PjVGDs/uvEGrcul+N
         kL/LtMOtbz2p612zDDuT2p69BjrMvxKTfr4lESBmgZIIybccFre79+6MNEywCECv5pQN
         xAEN8UYwcfU2h3C2T6ymlun/K56qyrUatPrVnd+pgb5BfBpSugYCp9sxg8fj5htADImt
         WlqYNbFuy5u7cl71uD03T5aDU6Rr1c36P9AnozY9NKX/+raBKUF57FocoU/cTThjVUpI
         3hsw==
X-Gm-Message-State: APuU4Z/ev+lPJ1J5ZTQMqLVxMIfzVLa+iidaw9EWM1JB5ff2bqdb8+vw
	e5n/fDl3IrWny/tTjyLrmQo9wB155yWQmno9fKWDGHcqVRlawgrDMfsTGRQSQXQO5trKGja7Z54
	0hxOWHdo1QA==
X-Gm-Gg: AZFdTZdu6EvC7rbsvRaZ0X+Ghgs6Y/KcPXZb4pKhlC04adbSFSivCD+krMjs9n6QqnT
	xqrr2Q9lAAc4hxUaElnB+9N5AMd1juP8KLM2+LfnNWWaI7KZ+wfgFH9eQjUIfXxkJitr3mdyY4e
	UM2qgCDnG4ycwdk7YZ3GgQ67KJHTOiSEvgt2l2c6XHk1QRIwWW1Tt9tELvrXaXG3QTivg3quEB5
	eY+CH1bPXj68UkKbIZvuo1AgAevas4xiSovmW/IhpuIip/YIPBhtW5CA0DG/IqvSUnHvlhxF5oS
	2HNV517qqxv1dAOimo49GuHwm4gBqcGHr/tT32Vy3TKe76K3JPRQMuAFGYQ+1jaEinzVrcCKqWe
	52iG9hajpcn1WlHUzSna3biphgPWpQzZ9pLb0OTK91GUn6FjtrxX4j8N/7mw9QyYAQE/MEgyfBP
	AJ4uLbYaA4KUkN/mH10UBAW7QtxNbmCk4vxWFfnuZ2ajiE9GIBC2kOa3C1Hqh0CbJJz17WwOLE8
	nlGXD72hCYkw4wBfYZdZxSD6A5d+Ww/crJ87zVxIe2Fhk8/Y+KP5u2KrfcmnfIL4zc8Gly4/FtQ
	WX/G/7et1tZiyBjwPavZ95NyjUNOTsLRCbYW++438MMUUa1zrIM0+Eol7yMgqGIICkyFP0rKOFs
	xun4ZWrB7PzAgsihPYXHxsc1q7s+9F+IGmGApnNJ/ixujbJXMnzpuGt8OX9jIRBxmoDza9htEVj
	g/rufu/jy7FDwPhhHI
X-Received: by 2002:a05:690c:6f84:b0:8b3:4b09:f4ef with SMTP id 00721157ae682-8b4febd981dmr3810477b3.13.1794962935978;
        Tue, 17 Nov 2026 16:48:55 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:5fae:4d02:7055:94ad])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67dd56ead87sm729575d50.1.2026.11.17.16.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:48:55 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v5 0/5] hfsplus: convert regular file I/O to iomap
Date: Tue, 17 Nov 2026 16:48:39 -0800
Message-ID: <20261118004844.3849979-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
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

Switch the HFS+ regular file data path from buffer heads and
blockdev_direct_IO() to iomap.

(1) adds a generic iomap_dio_end_io() helper to
include/linux/iomap.h: a direct write ->end_io callback that updates
i_size when the write goes beyond the end-of-file. It can be used by
file systems that issue all extending direct writes synchronously
under inode_lock.

(2) moves the file related operations (open, release, fsync and
file_operations) from inode.c into the new file.c, without functional
changes, to prepare the place for the iomap-based file operations.

(3) splits the extent lookup/allocation logic out of
hfsplus_get_block() into hfsplus_map_extent(), which reports the
mapping without a buffer_head, so that the iomap path can use it
directly. No functional change for the buffer_head path.

(4) makes hfsplus_map_extent() return -EIO when no extent covers
the requested block. On a corrupted volume, hfsplus_get_block() mapped
such a block to allocation block 0, i.e. the boot blocks and the volume
header. The iomap path relies on this check, since a zero-length extent
would otherwise produce a zero-length mapping.

(5) adds the HFS+ iomap operations, implements iomap-based
llseek/read_iter/write_iter, switches hfsplus_aops to iomap (removing
hfsplus_direct_IO() and the LEGACY_DIRECT_IO dependency), and rolls
back i_size and the allocated blocks when the zero-filling extension
or the data write fails. HFS+ doesn't support holes, so extending
writes and truncates zero-fill the gap up to the new end-of-file.

Changes since v4:
- iomap_dio_end_io() is extracted into a dedicated patch 1.
- Rebased on top of "hfsplus: don't take inode_lock in
  hfsplus_file_fsync()", "hfsplus: set s_maxbytes from the volume
  capacity" and "hfsplus: release preallocated blocks in
  hfsplus_file_truncate()", which are already applied.
- v5 patches 04, 06, 07 and 10 are squashed into patch 5.
- The -EIO check in hfsplus_map_extent() is moved out of the iomap
  conversion into the separate, documented patch 4.
- The phys_size change in hfsplus_get_block() is dropped: it is not
  related to iomap, since after the conversion hfsplus_get_block() only
  allocates blocks when phys_size is block-aligned.
- hfsplus_write_iomap_end() keeps fs_blocks and the inode byte count in
  whole blocks, as hfsplus_inode_read_fork() and hfsplus_file_truncate()
  do, while phys_size stays byte-granular for a partially written block.
- __hfsplus_iomap_begin() ends a mapping of initialized blocks at the
  block boundary above phys_size instead of at phys_size itself. With
  an unaligned on-disk size this used to produce a mapping length that
  is not a multiple of the logical block size, and an aligned O_DIRECT
  overwrite failed with -EINVAL.
- The fsync locking change is dropped from this series, since it is
  handled by the separate prep patch.
- The volume capacity check in hfsplus_file_write_iter() is dropped,
  since generic_write_checks() enforces s_maxbytes, which is set from
  the volume capacity.

Viacheslav Dubeyko (5):
  iomap: add iomap_dio_end_io() helper
  hfsplus: move file related operations to file.c
  hfsplus: rework hfsplus_get_block() logic
  hfsplus: return -EIO from hfsplus_map_extent() if no extent covers the
    block
  hfsplus: convert regular file I/O to iomap

 fs/hfsplus/Kconfig      |   2 +-
 fs/hfsplus/Makefile     |   5 +-
 fs/hfsplus/extents.c    | 163 +++++++++++++++------
 fs/hfsplus/file.c       | 308 ++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h |  26 +++-
 fs/hfsplus/inode.c      | 274 +++++++++++------------------------
 fs/hfsplus/iomap.c      | 254 +++++++++++++++++++++++++++++++++
 fs/hfsplus/iomap.h      |  17 +++
 include/linux/iomap.h   |  20 +++
 9 files changed, 823 insertions(+), 246 deletions(-)
 create mode 100644 fs/hfsplus/file.c
 create mode 100644 fs/hfsplus/iomap.c
 create mode 100644 fs/hfsplus/iomap.h

-- 
2.53.0

