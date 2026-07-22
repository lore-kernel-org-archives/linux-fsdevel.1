Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC75349CEF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756299; cv=none; b=UoJO7G2B8E/sRu4VFixApReLZQlm4l/0W4O2tTnLqEl2+YyxnpoBYnrjLRlwXGf9aYnH7yYAqZ3H5/OxBi6qTfvP4pxcy0Q4ep+pgjJvT1h4ObSqyrAlEfMdadfosoClx20d2fZyxgWADXkZlrUoIFrmG2pb+jcx0uVM5FtLujI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756299; c=relaxed/simple;
	bh=KVIp2ULWPflKzQBzWukmKWBTOwh7qI8LMtNd3O8gDHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s4eXzLIend2u2Bshi3L8j7yt4hArM2vJZ3Sf/cOuDO0fAx+Q8yd0Z6iNLpNRwSTGzOtBy8UI+q4+I/Z+djVTaM9XX36fNW4i2uNOLUQYJKDDgE0Qwh30b0tRK89l/Gf8iJ9XgEiTPtu0RXUw5HDcYy3Ay19QIEpn4Dq+BIAAxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=ytWLCF1K; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="ytWLCF1K"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81e9f7491ffso90197b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784756296; x=1785361096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fsSye4updKy2/E7CIQXq4eEPdO/+UuubSImGFd7H8iU=;
        b=ytWLCF1KpninZ70Wuf93PcGFrq4RKdPYXzBm8HxigfXuGCaDO8lxaLo5FDZY+qQjUk
         l1lKdS3GJDit8/zCtdG9aNDwNv3DVCXcLqXuCGkKXR9AkZrOxDiAJjiYB+NiGCzNi7R6
         73EYBKOBpvxXLZUTFMu4Ojuo9LSeXQ1fIzLjo74o7iaMJLdIxa5Wg7HD5/kG79F0T+RF
         nfzhvtMxD8Y95H0/BFPrB1hvKto/em0HW3BiYJdCR0I1rxIHp6XzO61ph6vgpusTqZVu
         GOplgSzta/biBhKROXoUhafdmS8x33rAQSmpIdzixXdO12ECS1cjVpPhNVaPrgezPnyo
         PvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756296; x=1785361096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fsSye4updKy2/E7CIQXq4eEPdO/+UuubSImGFd7H8iU=;
        b=SHOn4M4xgjrh+GKCpRyh+UPp2CR/QOocmkV1XFksGvX6jBZhVwg16eMx5MBdlsMFoO
         luXCpfBiFJzIIRZ0EigmZMgKIwStggCrIiYARu6vrEC1VAb3UEr8fqX4CWsqKUiLzm0t
         v3336/UzFBLdV3PqJNDb0FWMBwkCbVQNOMcyyJUl+iSH5ca5DMexzNzZLqSqSzvVLWy4
         0N9+AwCO2V6QTbUosoX7uRNTow3UcvHpIhD7VL4yw8whITyK7lVZSEesOBBOZr3jBWtN
         YAvGpyFkgx/8ZR3gHvhJH0dmwvHtgIMjR5xLsagPygrq2+T43jH542+eb1E6QWiCJFBq
         K7OA==
X-Gm-Message-State: AOJu0YyB+MJjL5dpQXJKAwkNl0to6Fqswt9v88O6+rT3QSAOm0/E8biP
	zh5yNweTryJdW5BboN1XarL9Hofgzc6q3+/XziJfzHfXRYU8U85Z13/Wt1A3cVLkyCs=
X-Gm-Gg: AR+sD12tU9HcI4k1Vr2CD2LYUMx6nkQ9TPDZk5nfIuSHHV5mSLV8aCTwqh1iuI1xZyU
	lKud5sZDqFVjWb62aFEscLLJem3jd3Y2wTQo/ghULh/gRAHd0WHH0cTz2OkMO3Z4oC15ZhTkWnQ
	s3j5V0M5zvsDmM385k52GLxSRoWObrJIPh2blQsYy05IvPajyrUGo0KnGm80saDRa6QGguwz9aN
	o57eX9OlJ91I8wzI49sOdFCV4dHta7fqNGjRbWn9jNQM1dwQ4bTThP/UUYTcl+TqiT0k5WyqasN
	jlJGVNYrJMjdm53leyC471J89D3AG8sznkGQ0j4/PFQ2COIujFn6g9WYOGOsN7831sq3bqpdLhN
	Rkv5+VuGyl6EeW0xh1tfrb86HXD7yzjk1MYW4u8yXEzULjuWqT+WDQdhIMSgSNLpVvc5VAV6CQl
	9ahLWMwzOB9i+0loOqSBRnM8+4pPTtyuE88wzSgY9kq9cR/zYpG75QwNTZ3QsIpG78LEe7RXOxU
	Ztg0X49/ZhjRmwFpvCgeLNAr92TJIlXeUo=
X-Received: by 2002:a05:690c:d07:b0:7dd:3463:6872 with SMTP id 00721157ae682-81f4c2d9004mr1258937b3.41.1784756296356;
        Wed, 22 Jul 2026 14:38:16 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:12d8:c69b:ed00:1fe4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c7706dsm20034827b3.21.2026.07.22.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:38:15 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/6] hfsplus: convert regular file I/O to iomap-based operations
Date: Wed, 22 Jul 2026 14:37:52 -0700
Message-ID: <20260722213759.1360225-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves HFS+ regular file data I/O off the legacy
buffer_head/blockdev_direct_IO() path onto iomap-based operations with
the goal to retire the older buffer_head-based direct I/O infrastructure.

Patchset is based on for-next branch of HFS/HFS+ git tree [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git/

Viacheslav Dubeyko (6):
  hfs/hfsplus: exchange hardcoded number of extents on named constants
  hfsplus: rework hfsplus_get_block() logic
  hfsplus: take the bitmap page lock for allocate/free
  hfsplus: add iomap operations for regular file data
  hfsplus: add iomap-based file_operations
  hfsplus: switch address_space_operations on iomap-based support

 fs/hfsplus/Kconfig         |   2 +-
 fs/hfsplus/Makefile        |   5 +-
 fs/hfsplus/bitmap.c        |  13 ++
 fs/hfsplus/extents.c       | 157 +++++++++++++------
 fs/hfsplus/file.c          | 309 +++++++++++++++++++++++++++++++++++++
 fs/hfsplus/hfsplus_fs.h    |  26 +++-
 fs/hfsplus/inode.c         | 264 +++++++++----------------------
 fs/hfsplus/iomap.c         | 209 +++++++++++++++++++++++++
 fs/hfsplus/iomap.h         |  20 +++
 include/linux/hfs_common.h |   8 +-
 10 files changed, 765 insertions(+), 248 deletions(-)
 create mode 100644 fs/hfsplus/file.c
 create mode 100644 fs/hfsplus/iomap.c
 create mode 100644 fs/hfsplus/iomap.h

-- 
2.43.0

