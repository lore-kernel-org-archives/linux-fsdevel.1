Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113F239085
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 00:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149351; cv=none; b=gJWLmU4tjhapOfYAanZ1Tuvs/EnCJ+ei60GTBHp5EkW9qqZWxI0kRiNTaj3iDm2XEc9s+FKuCgDCw8rLC/18vHSPxSjhoOXLkR5ro4ZKp1fZ+JrtbfergpmYCTyA2hphpNG/MSZK5hCDKPydjlcbqERzSOb9Xgmf+TJdphyYWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149351; c=relaxed/simple;
	bh=evGr4lXAU8wxOk3Sd8wjHipyN8A7pIn6q50Ro1n7EEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DVyVUdcVdsH8Tu6pi6RdkG9SKWeOrOCFO5NmOuX0l9JWLThvB+r7WtDyk7dSXrTp7d+9rUcXwZD5kRSs/5BRCzGPzQL4DvT8TnUIflN9rlVVqu/iX6/m3p7sCmzm1ImW+6jrLr7TvXOS5fxWVkB6Hoqw1q4JZE+PiL0l6Cy1Mgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=d5UBFgyG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="d5UBFgyG"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80dc4a68e4aso1042387b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Aug 2026 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1786149348; x=1786754148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lTUbkeLAstZXVLMcIbeCry7HvkPjiIqoDA5druseeWY=;
        b=d5UBFgyGBUuN7qvAaFawWWyqp958hSwmhLL4+fe1zcmUq+JY4MFk3HL8GVxWfcbd5R
         wctskQ4vRgAP23Y1+NIRJV/zmN3KMSTAmZnRcWsKZCeALxlpSKos48n2KQ/Swgk2/fg3
         zZj/LceVImisRKHqOU74lYB7fYBXc+/1XbkPYTOMudKwaSSdMM9P+hZ2AzLduY8ppEut
         esP/YZ+x/SmUnaFqFJukFnZc7HzQZK2gNiRHUsrGNfmq3fZJCtCJ1pUoHLuxs94lqSAd
         V5HQKLqCBAUTlKAWXz7J/DKWcDCZr2QI2xVloD1LcLoVEi3A5VR3MjIWE37mDggQGifV
         jjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786149348; x=1786754148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lTUbkeLAstZXVLMcIbeCry7HvkPjiIqoDA5druseeWY=;
        b=UCpOv1PWJhc7x07yUCFDnPi2UC6pe26/H7mvVEJ+QP21WyoWCk/YODumNfj960ELJV
         6Vzx9KpXEv2Doiiqv5tppZheYBwlgpvfuy041bXFm4FrQUfSmqHbocmpLWBJ6hIOYyTz
         NCWrbYxAggjg9eT8UHob5hKkcy0JSLyEeNeabfp/bafPlregJowiMhSwmlpx2xvwbh6v
         tpaYe6PndXAgC9NR8wmzOeN+V4zsvxZeIHOnik4JMOlO7f9gSNV/02XCBlLe9o+aBsKm
         arRIrP4EZiGdULhFcl8pm9fhbRybaGqWiGwfnd3j1BQ3Kq5h9TDEV1vwv1aFjViujwaJ
         oUVg==
X-Forwarded-Encrypted: i=1; AHgh+RpfRSYtt4gTxBGUUAZ+7vz1cwb3Ulpueo+eTTRzcLdULBa82W9rZxKr10yPjFIP/sn49QA53i6nVKt9lU5I@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUqKZAz8R5Dj8QfsgXygPrO8rHR2I5rVtT7LM2KGbcvRsmUxL
	3nl/AqvIadpmRZTAGWc4dbtekh2wQPP1WAEVfuUCDgd4EBXU48LwmasbfeHom9W8T41oTMGA1Ro
	DtVTujyKt3A==
X-Gm-Gg: AR+sD10vJppVWoHBv6pYoMVBhpkED7GE9VG+NpyufD62GypAv3uHv6reYFBtkIyK/BT
	2kXPLpviNRjrfggWakdHvo/f8kK01XB7e/yRVKr8xGcaeGvRoYm5gVW4RoM5gLdjjFcjRtospUz
	OdCQStMPO66edTR9Dshb4L+ht/1AmZCRMDp2L8f9aFIW2whlUQPrtiSkRBYgDFLOcUBUx3iKZsg
	vRvTJ77KIX3YORF7i6HX0r9Mv3kfyeVaxKSwUrYq8GL8gJ9wNK/dWJscCpUV9Lx/WslOuwtSwSL
	qpVO6BbaCUC7V3D7KFYIBo/MGXUh2FQKLUvrb1OJouNvRbQ5qXwI7oAxBC8AKUYpzMknA/fNEU+
	OxIRiki+3ke1WpyEkHPRqA/yHHfhhpAlUfJoNcBwusulVXR/OdwZHvJ9D4UCcJw62vXw6g522sZ
	99al6s1JA3nYloWhxC/XIh8VENHV5oe9rQQeYqEzD7HAbGcbUIz2qRtYSJ74qvtFlqgNPZRWHAP
	MCtOlhkwTpd1s7MD+Np+K/RoJjEdxDBFLC7d8feZi/dUja0xWT9wf7KYZjerthQTWjdofy7RAV4
	uz+dYB1vfSi4uPtHTQ==
X-Received: by 2002:a05:690c:e250:20b0:81e:f825:5840 with SMTP id 00721157ae682-820224da2d2mr123482867b3.21.1786149348132;
        Fri, 07 Aug 2026 17:35:48 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:891e:7b31:87a7:701f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f577c580sm19024407b3.27.2026.08.07.17.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:35:47 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: konishi.ryusuke@gmail.com,
	hch@lst.de
Cc: linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	lilinmao@kylinos.cn,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 0/2] nilfs2: eliminate blockdev_direct_IO() call
Date: Fri,  7 Aug 2026 17:35:21 -0700
Message-ID: <20260808003523.2760509-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patchset eliminates blockdev_direct_IO() from
nilfs2 entirely. It adds iomap.h with declaration of iomaps
operations and iomap.c with implementation of
nilfs_iomap_begin(). The nilfs_direct_IO() and the .direct_IO
callback on nilfs_aops are removed. The nilfs_file_read_iter()
dispatches O_DIRECT reads to iomap_dio_rw() using nilfs_iomap_ops.
Everything else still goes through generic_file_read_iter().
The unnecessary "select LEGACY_DIRECT_IO" has been exchanged on
"select FS_IOMAP" in Kconfig.

v2
The bug has been discovered in nilfs_iomap_begin() of patchset's
first version thanks to Linmao Li.

nilfs_iomap_begin() looks up the filesystem block containing the requested
offset and returns the physical address of that block.  However, it sets
iomap->offset to the original, possibly sub-block, offset while leaving
iomap->addr at the start of the physical block.

iomap_sector() adds the difference between the I/O position and
iomap->offset to iomap->addr.  For an O_DIRECT read at offset 512 on a
filesystem with 4 KiB blocks, the two file offsets are equal and the I/O is
therefore submitted at the start of the physical block instead of 512 bytes
into it.  iomap direct I/O permits this alignment when the device logical
block size is 512 bytes.

Describe mapped and hole extents from the filesystem-block-aligned file
offset.  This makes the physical and file offsets refer to the same byte.
It also prevents a one-block hole mapping from extending into the following
block.

Viacheslav Dubeyko (2):
  nilfs2: add iomap operations for direct I/O
  nilfs2: switch O_DIRECT to iomap based operations

 fs/nilfs2/Kconfig  |  2 +-
 fs/nilfs2/Makefile |  2 +-
 fs/nilfs2/file.c   | 40 ++++++++++++++++++++++++--
 fs/nilfs2/inode.c  | 13 ---------
 fs/nilfs2/iomap.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/nilfs2/iomap.h  | 13 +++++++++
 6 files changed, 124 insertions(+), 18 deletions(-)
 create mode 100644 fs/nilfs2/iomap.c
 create mode 100644 fs/nilfs2/iomap.h

-- 
2.43.0

