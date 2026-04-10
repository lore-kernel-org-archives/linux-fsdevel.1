Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5DB3D3490
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775831114; cv=none; b=ttdvFpG3fXjb/FAacsQdkTTRacBCJ4VsupN6VBODj76Ukxusf5Ra/HKnPEYFY+Bku2vNJCpGjpz4aQGoZQexJHdT1sYb0Ib8GRvSEwSimL1bJ+ObvrgMBXnYH4MhMiZMVB67oh64babGkGHtsiYJE/muAgeAUJKH6iZcj/E+k+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775831114; c=relaxed/simple;
	bh=qEMN3MjjGievx72nzdmQRG7S4l/vCvETGiQw8/XME9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hx2r8HrhuM43k5OLwXnVKS4ahrfWw2oFfRvoi6yuMSMX4+irQiisgi8p+eKziHQC5O+xbwa4b6TaT796rdbv07hDp5NQunLXGCrLio7BQd9PV4EKeiUkpelznfWL+tLhMBcEoNcCuUo+SbuccBoNka83bQkjbVpiZ4lEyQ0r5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSi9ctIw; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSi9ctIw"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488c21c636dso12432715e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775831111; x=1776435911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1LYsSiqwfcI0WwFJISvzyZ9hY32/RAXIyg6abkFiYI=;
        b=cSi9ctIwgb2a1clEY8goWiHCbj6CaFxgkeTpVM+/L0xo8PX00fIoS4s8sJTDPLNiBW
         a5gBuxQVDZ1mDMIQsZNAXxXmNFoZr+HG2HYlRrpetp9S78NsA6WOcHuSgy18GcAHiCyq
         tsBYzMY13dvAm7a+qyNdMEaixcNubm3tw1AA/V0nlBtX7MXEFvRia//5LE/B61wRGS/V
         3O8v+mziqixQnZtzCPhuvnwLjX97MOJ8kzPRg4XQCANofQNPGXLctug3Oqrla0DyYrIv
         Q4zpW+1heWsMSk7/gLlmpP6A7hC03gokQvyiXmUIsiVXPritQgt8YN2kMxWuCPVSJNKW
         lR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775831111; x=1776435911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1LYsSiqwfcI0WwFJISvzyZ9hY32/RAXIyg6abkFiYI=;
        b=ZJiuiJ1j45eC5Cgypqqi9g0Aw0hpLEX3u+xoOjN/hNKFHOG8VBWEFAQ1b7EeypKmyN
         wUrSyJGM8xjy3oK51pkkJCP53Vw+5g8FBxzgndLhnv3KNgtHykvrLRFbFGoSu2rtt/bF
         6+w0KFJkuII3iFXS2izc82aQtZiefYTveV4tXKQnXUnS0dxT6v1p7e16Z6uCqIqHOEN9
         V0n4r9IliNY9A/9wO2Wi0kTSAYycN/+VePWzE5r8d6NBS3vF7Goe3/gp9BpmuhAqjNDQ
         1iWrpQVLqbjP/Yf0K4iUlrXmba4TOHyIr93wDTdzRYTr0v2E1HD0YIymhjSAU2Z78bNL
         qcpg==
X-Gm-Message-State: AOJu0Yy+kY3q1PnGt7lLZt0eqLK1t1V4oupgXJcz2gb1Ybh+qgzF9BB6
	5vuCTB2CVpJV72BCITuYmmx17hkJ5BtMopVVnoxnVLq8F3YnfltY61OO12OKwg==
X-Gm-Gg: AeBDiesDs4giJC5cE59g3VCrVlZ6jPwFWKcPfyQaKiZBD3ViWU46gTcMiAeF9kL4+fC
	zQqzFmz7175ppCG4+6DMy7NcZozadJTQU+dx7v/MQUKus3co2+FSbervQ4emIZQtmrcuOneR+r7
	qNERuGPCX70euI89x4QV0EGteIs95qp4ykNj4BHOpsKZ3VPCzJogktFq9b150OeD7lf5tPX5Baf
	tkB8MeIcJ9cANtANTNclr7l8MEcVm72UDrDwpTGGfKhw+jJHsq8mgwxzHCGPDlPMxefQdF+Vf7z
	GFj/WvL7bqby1mpsSMFBmV1+ZzbbFDUihsT8dTP+2uQarx7CTRT47rC/GYC/QG3jXCJi22tbCSV
	igtOUMYu0+7e297sPG/aYOoycsCvEhUiftAJGSVHtwJaOakHsbvS4juKXa3FSGDbZIqvkrOebO7
	o+05//FqMDmyCwVVQ4Eu89bRTajx6kwcLAX33B57V9x6sniDUmmvN8sMGOVVFnlcozDmEeUVtSE
	wHdr6DpfQw=
X-Received: by 2002:a05:600c:a411:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-488d67ec72cmr34924905e9.5.1775831110402;
        Fri, 10 Apr 2026 07:25:10 -0700 (PDT)
Received: from corblimey.Home ([2a02:c7c:37d6:c100:60ca:408d:517a:4a96])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488d5344e28sm82363775e9.7.2026.04.10.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 07:25:09 -0700 (PDT)
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH 02/10] Add support for VMUFAT filesystem
Date: Fri, 10 Apr 2026 15:24:04 +0100
Message-ID: <20260410142403.308108-2-adrianmcmenamin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the VMUFAT filesystem with a new vmufat.rst file

Documentation/filesystems/vmufat.rst |  127 ++++

Signed-off-by: Adrian McMenamin <adrianmcmenamin@gmail.com>
---




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
+An executible file (generally a game written in the native machine code of
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
+Header positioning is a matter for executible files written in native
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
