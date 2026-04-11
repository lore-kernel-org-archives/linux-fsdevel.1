Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BB1A5B9E
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920328; cv=none; b=mJSjE2KtHu3h7NmsuknP82pxy3opvV2kPeXNVhVN3w9LhVoP1TFAbXlsVo7/Z4SvL4hIUcgFP1zLXxpu/makNqrApk1nHi/OBUOwt6s1+kLKKXpS46F2DyCkgUeDR0xEz4iDO/BbHORSpzm1UwUHZ7Ug9nwtEXsCq5HhxzPYk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920328; c=relaxed/simple;
	bh=nXjZXJf8VfeT5JDRUg6nWo55B0dSWEh3hpNRsqOHtxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TaLCANLJ/L4Kmb8suEOIcutGTpu7oT/pcGVIH35dNiB7mv07FBQCCWp7Bg3vOQxo38Qb7HFFxFa2ueR9aH/Y19Wo4NkjCJcBzlT8kURfqFrs1e0EwZleXQZiaORpEJGY1D3pTW7WgFFnbwamjOsY+7fV/9yNp8E6craO9k1S854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7FlrTiY; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7FlrTiY"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso2993467f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775920325; x=1776525125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=koZgFRj2r45fGI2cOFHy/6Y1uTwVM4TIZK1RfEx16ic=;
        b=b7FlrTiYAR/ZVWbdpS1z+cVLCPdidvYSoEGQ1bib1NV3Ti2AKYzwPwuSaoxQ3SRMkN
         ILRH/rA06y6WVFHSBFMfAjkP5eBz1vobUXZEmTQUguHLTB3O9izNiDfekog9FKfVxXrP
         ulJWkeTMDDt8QzibedaeNN1XrYb1NPjnEgX2HsBFTYTsttg/fwe5HfpfHVsn83NnPUga
         2Sp57TkF1ETmu0aMqRewyl6yifCLqzvht+sGkSk8EF7I5t5y89XpH2EwxUAECkDRDT6t
         0XpRpKu+ORQhQ+rgkjU8lKFKFkV6aMvFaqGVwF7SHKdHe2g3MxL5T1dVLG1Fvr+YsBcK
         8WOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775920325; x=1776525125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koZgFRj2r45fGI2cOFHy/6Y1uTwVM4TIZK1RfEx16ic=;
        b=RZkmDD+32smA1EJ8gmYJTJIE69ouArPky0naF5Zs4bzuHU/727b0lDAUY/agaV1Fki
         ipgCjFfgJ2LV/7rPzpilEQJD7k4YxEIHY5990f4KYSTufwSUwLvbyEg7xZSD6VC2Vz5r
         H4ftUUhnmrE5HxJovOUYkiIUArRvAuoeZ/RDYJUnw1+CSPdRjLMw4b4fDoeHEe+BOEAU
         YXYIE/3SXy4pPgaui32XtWYChuJzbdyjPzGQQENuSDI/MECLdZGPxbWGu+bd56/mqX5S
         5umdigf59KVipuSPGKQn5vT+zH7Wql6/YI9gdvXr0IamgVQZHxk3idGViBHhUI9kcm74
         hdYA==
X-Gm-Message-State: AOJu0Yw/6Jf9nEb5nLzibE8XRXCpVYF/5+5uURH0s79PODs+yTb8EVNO
	Hm1MW6EENnpqKRYKaPMep7odBMIHPcf4IEF5DSBKVJjHV9454dhKhwIlykPtdA==
X-Gm-Gg: AeBDieuzQK4iwgHRx55ylO+wlWMKQZyEdzZOyrtXQ3Sm7F48irwVBVnJ2JkJDydYOdh
	CwkarcVtEKS6RLD+HXrA4o9RTMvyc09xxmjqW31kcmewi8pqcwSIisRJWPmCO9fOzkEqtJ4vo0q
	TQNyW9o+E9wotE0rVsw6aankv8xejc4RoZ0OD2csWkAn2eqyd04kXZ+sWuMYh9SUvahORPA0ypj
	Wxs9k0NSXuofH0rGN59OCDFvDWLVOse16c3i7IGRkbn8C89/8PMNf5HYWx1xfjxRCNonq7xxKDV
	jr/6lzxfaSWc9rdfolkF6edVkHjW2/6kSUVkmAkXVGWHTJ0w9alxQ3H1a9v/eR6LLpyktMyubrz
	IOqcCK14hYjxJQ0EcQqtUoQ5egwvpQggXRyWssristcMJCwhSiCfzvVZn4N/ngtSrkvd4yXm/BX
	VOcixQQoPyCKh/yEFaeaQczQXbKxl7j9fjk1txQg0zjk3ON8VUCSggNMkzgpmGbkw86Ms3xkrk8
	8gCYXxkEWmGV6oQffff
X-Received: by 2002:adf:e80d:0:b0:43d:69ff:6898 with SMTP id ffacd0b85a97d-43d69ff69c4mr3694302f8f.9.1775920325183;
        Sat, 11 Apr 2026 08:12:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:37d6:c100:81d8:4e83:a60e:1a81])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm17167835f8f.33.2026.04.11.08.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:12:04 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: Linux FS development <linux-fsdevel@vger.kernel.org>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5 -v2] Add support for VMUFAT filesystem 
Date: Sat, 11 Apr 2026 16:11:34 +0100
Message-ID: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SEGA Dreamcasts come with a "visual memory unit" (VMU) which contains a slab
of flash memory to save games playable on the VMU or data from Dreamcast games.

The VMU uses a file allocation based filesystem - which we label VMUFAT - to
organise the data. With a control block, a file allocation table and a directory.

All physical VMUs are of the same size (256 blocks of 512 octets) but the
filesystem itself is extendable to other sizes and need not be tied to the VMU.

These patches implement VMUFAT as a Linux filesystem independent of hardware.

It seems obvious almost all users will be those working with Linux on
Dreamcasts or Dreamcast emulators but there is no dependence on SH or on the
MTD layer.

VMUFAT has been tested on a 32 bit Dreamcast and on x86_64 systems.

Tools to format a filesystem are available here: 
https://github.com/mcmenaminadrian/mkfs.vmufat

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

Adrian McMenamin (5):
  Add vmufat super.c
  Add vmufat inode.c
  Add vmufat header
  Add vmufat documentation
  miscellaneous vmufat changes and additions

 Documentation/filesystems/index.rst  |    1 +
 Documentation/filesystems/vmufat.rst |  127 ++++
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/vmufat/Kconfig                    |   14 +
 fs/vmufat/Makefile                   |    7 +
 fs/vmufat/inode.c                    | 1017 ++++++++++++++++++++++++++
 fs/vmufat/super.c                    |  581 +++++++++++++++
 fs/vmufat/vmufat.h                   |  126 ++++
 include/uapi/linux/magic.h           |    1 +
 10 files changed, 1876 insertions(+)
 create mode 100644 Documentation/filesystems/vmufat.rst
 create mode 100644 fs/vmufat/Kconfig
 create mode 100644 fs/vmufat/Makefile
 create mode 100644 fs/vmufat/inode.c
 create mode 100644 fs/vmufat/super.c
 create mode 100644 fs/vmufat/vmufat.h

-- 
2.43.0

