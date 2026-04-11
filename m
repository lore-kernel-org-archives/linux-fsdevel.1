Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248E38C43F
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775920339; cv=none; b=BZd5dd8ToVol/FAQSbk5KXgoTF728DQFqeVA+9QI/3ydi00LAbp0ggVfY5wCIE7jU8VSaoz0F62gPKYceXt53UX1JeJPoTNctDyKCRwPosHzklnm1lR7tZjIvFKFXQ8VOiVDqYadv2H2eYbtiKwGPGxYGPy9MlMuQ5q3cggXIA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775920339; c=relaxed/simple;
	bh=lbJIgS8JoP7yrdxL3apU7ip1p1tcoU9c8Z0Q5PBZu1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izWcBewWN7R23cEZwG36GzttLmYqoRq4gt14pStYgfl3oNJd4gbaKv1zgjK5vbSKV/UY371x0d8H3KGkGuDWeL+aIFnejQ1q0puDuwc0XJI3QgeqnOugqY26jX7cKefMSvjeirXZkE9nrfT+Rvfiej7+mLSLtWLj8aW0/8gMRmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGF/o8+l; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGF/o8+l"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43ccda008cdso1679492f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 08:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775920336; x=1776525136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zgbfd4qk9eHr8cYBg6jrVQCT/+PJttNZMyaURX0hWw=;
        b=mGF/o8+lzTr35OGrTVFkvni0glNpUBmUEr6dsciaQnu11H7wQs14rXTTMufcT0kuBu
         MZqrE+aeU3RZg/0zD3vCDdVQok6WoottTbCsRnKCUji0xEfmxeisK9S91xegRFk1fsVu
         oJeskDYlZ7x/1ijJ5MOygHwPxMd7jrQQj1hw7Iigjo4LZv4P2gsqzMMxLnculoy9ub1C
         mGRaahm/XjaVRl5q8A3lM1H93TNE1zqOoH2gjlbYyVB1mzOUkyqd86WNIDJ4unDBaq0G
         9UgNZzp+NkX+R0nKmC97XOILsXlAE/TEkk3oGsnryBXy9/OK7+p6WDVxnyAoceR3yVXt
         TuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775920336; x=1776525136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6zgbfd4qk9eHr8cYBg6jrVQCT/+PJttNZMyaURX0hWw=;
        b=gjhxjHENngpMULDoNqrhD1Q/JVk+mbFbuhXcRl9BsjdRkgl9GhVqzFvFZXn9hya0uj
         7aOLaYKGeNVukOS0RSSRj7wcKpzXVsbzxF0jcIRN7cdMJN9mrjXu6jJJf3kU5TK/tNUH
         mqZUDjMw4017yZbF2OOd/P/n/IadxVgHUhbtS1A6uLVpv9SOayyE0ygewpngIsXxVPE5
         wXj67ocj8SNNmHra4DXMBgGj/cYCRq9TYxipek09GREIR2T+r1vGOXM5xhfsqi2iXQyH
         TbO8xTk9UMj0V+S3nU8kM7otSBzfL8UXBSLoSRdDJZc4YnNw0CR2YM77Zqp46DAVdp+a
         FJ5g==
X-Gm-Message-State: AOJu0Yw3r0BJ0xMVfO5iANppUU9RhIrhkCricqW2jRvBcdHXeL+260b7
	bwgP/FKjyepXsNBCMn5Clmvdt1/QQzZJu4z6wgzPWDvfX4nbE8DVgZ/whtSHAw==
X-Gm-Gg: AeBDietIlRjuy0Kv7uLFkZVL9g/t0Sdd9TwxZi3W7DEOwUiN99nz6wNSWv3aAlXUXoi
	Vh0e5ZgoAy0ihFASQMyzvB6PSOL/alQ0IXp77wO/riGn6Oq60+dKTtvyp8pQpGAAdU4bOHk+L7Y
	C3zDi782be+YinX+FfEsDh9QoDier1/d3XBbQ2TN/XtB01ghD9Nqx+BKLvV/9r4uSXTyYZJ6Zrl
	swuMqjX66YJRGWCqlQnj+zl1XX3fuL0FygavtzWCu8Zt3Ls/LAwF/1zdRwzHfb0dp05e8msCcjI
	b39E9ZH4+DwPR2P1cQRytj5BHSVeioKAl+pM+tAaz+/3I8XgcFyiBdc/5d7Qii/S2AgIKpxGOSf
	mCfyi4vLBq7phc97m1wSnEQIeG2DrAtj6fQcsO0/ZgIdlC1KGmhkAZSX4cvBhpFphennzNS72Tc
	bZyyuZnGtqPnGEKp8AqU9C7ZtyW8/8a75SQ3LbNnfG9joqglyGga/hRfP5J9DKSf/Ajmwj6QNt+
	6ZoIQcTP8v6Rwu4bzJy
X-Received: by 2002:a5d:6f04:0:b0:43b:4951:6b37 with SMTP id ffacd0b85a97d-43d595c4c41mr16183829f8f.15.1775920335644;
        Sat, 11 Apr 2026 08:12:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:c7c:37d6:c100:81d8:4e83:a60e:1a81])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm17167835f8f.33.2026.04.11.08.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 08:12:15 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: Linux FS development <linux-fsdevel@vger.kernel.org>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5 -v2] Add vmufat documentation
Date: Sat, 11 Apr 2026 16:11:38 +0100
Message-ID: <20260411151155.321214-5-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
References: <20260411151155.321214-1-adrianmcmenamin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vmufat.rst documents the VMUFAT filesystem

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>

---
 Documentation/filesystems/vmufat.rst | 127 +++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/filesystems/vmufat.rst

diff --git a/Documentation/filesystems/vmufat.rst b/Documentation/filesystems/vmufat.rst
new file mode 100644
index 000000000000..f2dfb15c0cfb
--- /dev/null
+++ b/Documentation/filesystems/vmufat.rst
@@ -0,0 +1,127 @@
+==================
+VMUFAT FILESYSTEM
+==================
+
+VMUFAT is the simple file allocation table (FAT) based filesystem used in Sega
+Dreamcast Visual Memory Units (VMUs) and various Dreamcast emulators and
+Android apps etc.
+
+It is not recommended for general use, but does not require a Dreamcast.
+
+All the physical VMU devices that were made were of the same size - 256 blocks
+of 512 octets (8 bit bytes) - 128KB in total. But the specification supports a 
+wider range of sizes and the filesystem in the Linux kernel is capable of
+handling volumes of a size between 256 blocks and 65536 blocks.
+
+The standard 256 block VMU is described below:
+
++----------+---------------------------------------------+
+| BLOCK NO |   CONTENT                                   |
++==========+=============================================+
+| 0-199    |   Space used by Dreamcast to save files     |
++----------+---------------------------------------------+
+| 200-240  |   Space used by the Dreamcast system        |
++----------+---------------------------------------------+
+| 241-253  |   Directory (can hold 208 file records)     |
++----------+---------------------------------------------+
+| 254      |   File Allocation Table (FAT)               |
++----------+---------------------------------------------+
+| 255      |   Root Block                                |
++----------+---------------------------------------------+
+
+The standard VMU filesystem has 241 blocks which can be used for file storage
+but a Dreamcast will only use 200 of these. The other 41 are for Dreamcast system
+use, though the filesystem can access them if set up as a general file store.
+If a device is formatted as strictly compatible with the Dreamcast those blocks
+will not be accessible. Most use cases will want that strict compatibility.
+
+An executable file (generally a game written in the native machine code of
+the VMU's microcontroller) must begin at block 0 and be stored linearly in
+the volume. The filesystem driver seeks to match that policy but it is not
+absolutely constrained by it.
+
+=========
+Directory
+=========
+
+The directory contains records 32 octets long (format detail below from Marcus
+Comstedt's website - http://mc.pp.se/dc/vms/flashmem.html)
+
+0x00      : file type (0x00 = no file, 0x33 = data, 0xcc = game)
+
+0x01      : copy protect (0x00 = copy ok, 0xff = copy protected)
+
+0x02-0x03 : 16 bits (little endian) : location of first block
+
+0x04-0x0f : ASCII string : filename (12 characters)
+
+0x10-0x17 : Binary Coded Decimal timestamp: file creation time
+
+0x18-0x19 : 16 bits (little endian) : file size (in blocks)
+
+0x1a-0x1b : 16 bits (little endian) : offset of header (in blocks)
+
+
+Header positioning is a matter for executable files written in native
+code for a physical VMU (an 8 bit Sanyo microcontroller).
+
+BCD dates are encoded as follows:
+
+Century prefix (eg., 20)
+
+Year (eg., 12)
+
+Month (eg., 02)
+
+Day in month (eg., 29)
+
+Hour (eg., 20)
+
+Minute (eg., 49)
+
+Second (eg., 22)
+
+Day of week (Monday is 00, Sunday is 06)
+
+=====================
+File allocation table
+=====================
+
+Every block in the volume is mapped to the FAT eg., block 0 of the VMU maps to
+the first 16 bits of the FAT and so on. Blocks marked 0xFFFC are empty, blocks
+allocated to a file are either numbered with with next block or, if the final
+block are marked 0xFFFA.
+
+==========
+Root block
+==========
+
+The first 16 octets are marked as 0x55 - we use this to provide the *magic
+number* for this filesystem. The octets at 0x10 - 0x14 are used to determine
+the colour the representation of the VMU is displayed in by a Dreamcast and our
+filesystem does not touch these.
+
+Octets 0x30 - 0x37 contain the BCD timestamp of the VMU.
+
+Octets 0x46 - 0x47 contain the location (little endian format) of the FAT
+
+Octets 0x48 - 0x49 contain the size (little endian) of the FAT
+
+Octets 0x4A - 0x4B contain the location (little endian) of the Directory
+
+Octets 0x4C - 0x4D contain the size (little endian) of the Directory
+
+Octets 0x4E - 0x4F is Dreamcast specific (icon shape)
+
+Octets 0x50 - 0x51 contain the number (little endian) of user blocks - NB this
+is marked as 200 in a physical VMU. A filesystem formatted for strict
+compatibility will respect this boundary, one formatted as a general
+file store will not and will instead seek to use all writeable blocks.
+
+====================
+Formatting tool
+====================
+
+A formatting tool is available at https://github.com/mcmenaminadrian/mkfs.vmufat
+
+A physical, factory-set, VMU is unlikely to require reformatting, of course.
-- 
2.43.0

