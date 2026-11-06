Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926175;
	b=Fv8WN9YgphlAHzKcoGW4gnhjmQBgYJbTAYmjD1TJrXHcgdwnodHNCAyIZHCBvCn9IWs0
	 PLjSRAvwgGp3fqwVt8m2DD1NfhLAn239nT44vsq5wJr8To4jaWJTK5RhCiDTuAXZvuZ78
	 X81X9v/f6lNVNJLiHh+kPCxq+1vJEpGniOrGuDvVBok6D3tESmgWA6S3KcOqBvwPVAHmT
	 4InLO8jHnA+8NhTRP2HZTw2/GB8XJIcs48AzZ5kvbg2iqYp1s3teRzTUpqhJyxyY8upk2
	 KgPTUYUML3jGBgLE46fYG5FF58t35+1S/pRzAJMRFKgD7ZZmeSB1X5Tli/BdFt8BDJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wRHQZ34rL6dBoiypM95HljXgWyJttgXvfX9i5yF13b4=;
	b=QP9AYmMu7Xz2xJWv4XS8QurwXmTHawRuJzajWYkRDQn+UM4lZTidb/RNy2I9PiBzXKPy
	 lquok1DoBvE4zyYFXQFA6SaHZ7wdaIOOhaabKme0sQitDo903dFOcXiMA6YgjdUhmdi6H
	 FvwXomyk0o3bV1y85XqoW4gowxPD8wkXUxViVKbY+DuLma4k7hRRsXCbRKBRHiWZGkoMc
	 oUsrHugVpMjqfO88M1ESLP5z7oeJ4Ea0OQS3So6LrMigYNK4t0783pxXV0QRvAMhX1bwS
	 JmxI8jtEc2UHu4deQtm8B8husmP5cpsSJUxRyAUYF0+kXFMUqhfzjAUaePb2u4InIfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Aw0aYpC0;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8364D606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 00:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8364D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Aw0aYpC0
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b31448caccso311107b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 16:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1793926173; x=1794530973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wRHQZ34rL6dBoiypM95HljXgWyJttgXvfX9i5yF13b4=;
        b=Aw0aYpC0ChWWqe4IylSxFeQLDJ3Avu8kU49E+Frb2qRnfunxUmPKxMsK92mfjj9eo6
         +c/eeTRmgmUw28rvi8iq8IgGOsSQ9V0JDgOsCyVkiXP2cOvSYXChz9/XgKSLCVDR3KLP
         W8u6hUWScXbejML4qepU/A1aghSygtnBF0di6osp9TqmrOiYGIEyqoPh2BN/V2Gp6ybw
         7Nvzh/qAfrAmQBj7cTqDeLNc2jARg4s+B5lhGIHDM7BzzLFdFDxrIbTJ6DojjN0BMtmc
         LMH3bOBKNvSSBhZTB2ljE03sHylO+cM0ui05B6CF3D8CMd1XH0yez/GaD4hYIWt4nG+a
         4NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926173; x=1794530973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wRHQZ34rL6dBoiypM95HljXgWyJttgXvfX9i5yF13b4=;
        b=tlj2tYG/O4bfQSaqq7CNrgyRNkfwhYFjxsnaffW2KhQS3NBzeAiz5TCpc/f31D4GY4
         Dh0ugQiylqDb71x8U/Ka33u4sY0Fgs1/oSfN2bI0IZ7/tVQVz7LMzPIIVxc4q7QCMpDK
         kmxr6f2JXkJ/pRlPu5QGss7cRPlJByQW2+54Fvy2ZVK0zdZOosWWZRUzFOMoJ3MDSgtE
         Fe/GPDDqv0dJF3Mps+LZqMo0GNq4w6lf5opMb9V8FS273OIwZbm4+N7VFe6aCC88EcXk
         Iw9v36eGnyDGOxwG11FlyD1Xtd52wPb6v9eUfRiA+UnPBfpGrrWpQK6rQYGdTKhkKvvJ
         /d4g==
X-Gm-Message-State: APuU4Z/8Wd7F7m1g5p8zgLi/osd7bhVJqhCC3IxMYcXS3Szh4Jn71Uxl
	DDgk5RHYWIvYQuqWt3SaWdnTsn4FxtJDcXTT3sZYuHS823PBlGKXZLgXzElpil/aKcc=
X-Gm-Gg: AYBFou2Is8W1xN5a9APQ4Hb44cfxj1EIYCxM0jgPgL+EJWTzKqfyXNgG18K5f0KYROl
	VodD9dJBn2cm/INWHHjtJpy0hVOUqCilLINHpWSU0CDlzrElJdBnmTUF8rfNYH4pYYOQgWvPXYE
	pZpQjhjGx6BX6AS1GyBOMa9zrOCwg4IYojRuHU37rCWP91nZYVRdz4801OH86xkcbWAocXHFPY/
	2nPL0ikxRfuTvjECoAmdUcdS/7ZDVg2cVg5IRHOlt4LQyMSKXKLAxy1PMb+1qKOo3jaNcMdA6HA
	7ht05ZLESmo2GLtiPqkgTk8GtADRnN0Vaomuh8pcvbI0vUSltiTwBcAzH48qNmwbWrCIpWWhpRi
	PbBq2d4fAiVCXeAWlt7hpXQOWuJBXC8X1/QdTSnrEecP7NCcXaMZt00x9QmgsxE6EnbTRarha8S
	O9N066afx9wp+tsf61QS1G6ncg1N/H9lAAtIyqWR+OuGTH01bkInVQ9oUkHPttWI2BJR4CGjEE0
	EYgpmrcJn7SVESl3opwmgyE0nsAgvhrL4B3DZl5atBm7W3G77KrkfdCKRptgb48sQbUu1vvVhHt
	1OjKN7sKY23YyL0MVYGZpufmg6fKVQlfweZD3zuKjuDAC9+vdgspJOVirbO73e1PqNI2mSOWAju
	mSnFiog7pS8iwqkxvipri1uHXgImOGDNRgBca+7yDudR6XtxZ86r1sy2FNHUI
X-Received: by 2002:a05:690e:12cd:b0:67b:9a55:3382 with SMTP id 956f58d0204a3-67c14556c15mr801493d50.56.1793926173044;
        Thu, 05 Nov 2026 16:49:33 -0800 (PST)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:62d1:9ddf:24f7:e87e])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c134f0e5fsm851304d50.5.2026.11.05.16.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 16:49:32 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 0/2] hfs/hfsplus: set s_maxbytes from the volume capacity
Date: Thu,  5 Nov 2026 16:49:21 -0800
Message-ID: <20261106004923.1844283-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
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

HFS and HFS+ do not support sparse files: every byte of a file
up to end-of-file has to be backed by an allocated block. As a
result, a write, truncate or copy_file_range() far beyond the
current end-of-file makes the driver zero-fill the whole gap,
which runs out of free space and fails with -ENOSPC rather than
reporting -EFBIG.

Since a file can never be larger than the volume, this series sets
s_maxbytes to the volume capacity instead (capped by
MAX_LFS_FILESIZE for HFS+ and by MAX_NON_LFS for HFS). The VFS then
returns -EFBIG for write(), copy_file_range(), truncate and
fallocate beyond the limit, and trims writes that straddle it. The
now redundant local checks are removed.

Viacheslav Dubeyko (2):
  hfsplus: set s_maxbytes from the volume capacity
  hfs: set s_maxbytes from the volume capacity

 fs/hfs/inode.c     |  7 -------
 fs/hfs/super.c     |  8 ++++++++
 fs/hfsplus/inode.c |  7 -------
 fs/hfsplus/super.c | 10 +++++++++-
 4 files changed, 17 insertions(+), 15 deletions(-)

-- 
2.43.0

