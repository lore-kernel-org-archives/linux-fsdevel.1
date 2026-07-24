Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D9447807
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932085; cv=none; b=qcfngtfOYAi75cvMq081T+1gKiSbop5yio8mnZYCR6shgSB38NiRm8g/GjvIZB5JB9VH9YHdbs8sIkJdfykMuSUicYd/uejoswTngbj5WkSLo/ivlUEpe7VF4MnPzOx/Buy299KPKN9QSx90C/6UoAh/G/eUwg22n5+d3m1ryoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932085; c=relaxed/simple;
	bh=hosF7z1IjblzSdT4WinSYBZoR+ua9jNC4c9AyrOeQM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATrMq/BoJ3jU0toCFGJqkteNsfXl/ET6BsgoupvxcRFIWSWW+KsiSTn/DPTLYYScj8D02oCIiJpa7ihl0PCm+/wdkglrQfKTHtVpE2GNo/B1uXyC4xIukRucwxZnfe5Xw0l8xMRpowNsb19k+vH1Mr8on7g/IW4n72tyo2xWUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=GZinzTpv; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="GZinzTpv"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66804667af2so745941d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 15:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784932083; x=1785536883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuRKRBkTVuDLBRY/ApmyBhrmpdyr3e8z0LFxN8l5L54=;
        b=GZinzTpvjt9HHKW5UqLD052Am7zcw6AlSpI0G1jcUa+0HHhO5fu/KK6wHFhxGv8g5o
         V1dHyKCEFlIu/tuaC+wDoFDvUB09p297rkGSvJJ0KJ5chpCiU89/OafFaUdlCoJ25RiV
         jZ58er/DLDzp4ezevUjXnis5vTz4zK0CV+RO27IG+8JI4yb4N/NFDw/dt27rYZNVOQ0w
         Xxt9eg9T/Qqz3VFazS7pa7NJsyt+Vu0ZpNc1MTKglYR1BpQF4AHCiBFc8k5eWL6khSvH
         Uk3NljT/jSM77vr+Ni66QFNl7UF3JMUduvez5L14TiLecO8x8mgHujpPvLeU96tVfV/m
         IAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784932083; x=1785536883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuRKRBkTVuDLBRY/ApmyBhrmpdyr3e8z0LFxN8l5L54=;
        b=jqTSAi66PC5F0xdrjuVjPRaRn9RxnSDzC9NIQekZt2WsXPriG3Jec9PChUez01mN44
         VX7QfBkZT5FZmW2HzsnRGQYUuxCjESrTi6FCoVcxuECyLpes66lPCaDenGOrY0poyzq0
         1OJ8qabaB/hL3SB/VRogMXvUEkS/m7QB/o8CuWKTVJwKiFgkhZGNzxDXiptrYFK69xL1
         F5esU8WgAk3WzXR4U3P2JDlJJEPnM+cgSIB0TJXJDrTeV1PrdZQMaAcw2/XuTOHn9/O0
         r7dxSpDpc9H7sPK5hPtdEjJEroNR1+VXTqBSnq9QyBVcNumsmN1f3UwGClCvmyKYghnN
         xmkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrtY/Vi7RMFsK3+Sfx+VvQCY1lFI08Uv0uzFyVcY3K6OnTrP8UGjAuiO+Aq+35nOe+ZMrU0C7JgxSlHlvi8@vger.kernel.org
X-Gm-Message-State: AOJu0YywDRGku9GAbGprzbBBxgmoR6MfbqsWbcKc7wgTFY4z0g3HHR93
	FLs1czC0LWgMF+ESgT9FL1dSBmNh95Pa4/IcgxRHEBnynpDvP4kpsZk39rcpeQ5BiTE=
X-Gm-Gg: AR+sD12kyuLSFnhKpk96B4d9Ok+jSxKSUShlvhPcmXFz6lU9LixuPasvKpLeHESglFI
	JkinE76ev8010MjiQLqMUBhXVYnvXNPV0eD3mfEXcxbi1S0pISUtxNHBGkws2Y9Y2E9bEkMjTWn
	G/vYbwe2y0RXrtrzFvRyt2zTBaYnknjNi9knqJPtGSXiuTEmW7ULvoXRocwWQkq88SDfVqklyWH
	XdBQ6k9jfXyfIrE6fGFViA90Mjv5fJRgamIjB/X+BT0EOknEfVsZEZMdbbUEcBfgVvUqmKBknDg
	L0x/5VBMrlp7T5fEsQM7EiSRNQhJPIbwwdu3Ryh5NCAJwu9yTizU36JAC6h7+S2JNwdKqh5Z3iW
	gAkpH7epS5PrIt9SmTmuQDGwqj8qj/Z/aZxSJccDvXEERA0MSoqcpw0LynAKNfxqCDupyO8eaYD
	zlRnN11an4Z/NV1j2NaEjkPEkb4qp5plHpiImut+3A5sKMyhWzUqBVVFQtngyYLJAL+FNNUp6Xr
	/1p6rX0RGCUXHAf3KLBZKxRJQNug6/zcVc=
X-Received: by 2002:a05:690e:13cc:b0:667:838f:cd2b with SMTP id 956f58d0204a3-668c7ab51b5mr35323d50.63.1784932082748;
        Fri, 24 Jul 2026 15:28:02 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c7041256sm90525d50.19.2026.07.24.15.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 15:28:02 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: konishi.ryusuke@gmail.com,
	hch@lst.de
Cc: linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/2] nilfs2: convert O_DIRECT reads to iomap
Date: Fri, 24 Jul 2026 15:27:43 -0700
Message-ID: <20260724222745.2107464-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes NILFS2 using of blockdev_direct_IO() by
converting the O_DIRECT read path to iomap. NILFS2 is
a log-structured, copy-on-write filesystem, which makes it
a poor fit for a full iomap conversion. Newly allocated blocks
are delay-allocated by nilfs_get_block() and only receive a real
disk address when the segment constructor writes them out
as part of a log. The segment constructor walks buffer_head lists
directly and is not integrated with the generic address_space
writeback path. First patch adds a new, read-only nilfs_iomap_ops
wrapping the existing nilfs_bmap_lookup_contig() lookup.
The second patch wires that ops table into O_DIRECT reads via
iomap_dio_rw(), sets FMODE_CAN_ODIRECT explicitly on open, and
removes nilfs_direct_IO() and the .direct_IO callback entirely.
O_DIRECT writes are explicitly downgraded to the ordinary buffered
write path in nilfs_file_write_iter().

Viacheslav Dubeyko (2):
  nilfs2: add iomap operations for direct I/O reads
  nilfs2: switch O_DIRECT reads to iomap

 fs/nilfs2/Kconfig  |  2 +-
 fs/nilfs2/Makefile |  2 +-
 fs/nilfs2/file.c   | 40 ++++++++++++++++++++++++--
 fs/nilfs2/inode.c  | 13 ---------
 fs/nilfs2/iomap.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/iomap.h  | 13 +++++++++
 6 files changed, 123 insertions(+), 18 deletions(-)
 create mode 100644 fs/nilfs2/iomap.c
 create mode 100644 fs/nilfs2/iomap.h

-- 
2.43.0

