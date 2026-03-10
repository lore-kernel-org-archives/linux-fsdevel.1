Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CE8F4FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773122706; cv=pass; b=qbusQATNmaz7YMaeMnW2bpT1lEPcphvnoqqrWKiZz4sFYgi7Zi0aRILPLBdnmdDWxsep+MLEqnK4miwFDQR9RQYAjKVWJ6KPGdBiFOWAhgrU6Nd/iLIMyKSaUT4qr/mCrjWJ+HM9t29uum0XTaxkahxMbGyJxV2N6n/WmXFeg3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773122706; c=relaxed/simple;
	bh=4iGz7Lb6Hv2xcUHA9HcY/30Pcg9lN6M4cZeEpm0cTMI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=eNza/8MqKw1mfTdkWP9xSEwEf5p7XskA1gvY5iO+hyDjElQPidOlqmB+CDBFsR3SQ1kmhKo0F/17LyiucJO8wn8PhQNbpgX9JJDDnma1lWWSOxEqnCZR62WwOxr18UPnTJnP645AoQxYtjSVjMclgYWmLIICyxhYPNbzh1wUn/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDPgaVrH; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDPgaVrH"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35995cb33a8so4901807a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 23:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773122705; cv=none;
        d=google.com; s=arc-20240605;
        b=EKjEinzpjwpvrle4+x/ktOJkdoFPI7eixmCX5ynsik5pAIaH1PQDmVNfARiRBclGWC
         vShmzF+Hyh88+j5tCm4UmlPb2W368IReevKY0JioZZF2phaXcA/Mz4U20vgo+w4cRfl2
         qqrq5iA22xf4I5cF70GurSjmwKO046U+EXfW5gU9WstepbdW/Fbs834zq/qB6I4BS7zw
         G6FKF4niFA1KJ86cbR+DIBpAVb9N0QJ7sZj9V5tTR7qhKcR62h9Ooww4MuatSFY2HTpo
         ZFawO3CveRf6WG9YKvSFdDALObQHClXeo1B6V7LMNAGhFo3t1mq88Ffvy4LMO6AyIsou
         lHYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=g3oCeeNo06dVSg0D2aS0+PS/IuJ2tDlfQKjHJT5nitc=;
        fh=dL5RKLghII/g9pcli/cYcSM5zNHYNsgoUmgVVdIsYSA=;
        b=Nq5wTBByM6GAyemx8XFE4CE6gAmKPQdQWlEYWwth8l2yrOJCh/NH7bC84jDPbIkLkK
         r3IamVhGUBbv7oWY8bOIIIxwMJkpWE50+8Dk1o/hxzkFOPmwzbkxf8WBd0VLRHBXf5ps
         VgRb9vAc8YDe0HnwA4QYVJFxTUEr4gcPpP+QJSHjKeK2DJfsSKRxEAYwLkQByicv7CaI
         XJ0maSQGkUvgIzSMt4aIBIABDZDSlqZHshXEsQPHL59r8C5yhS30oPby7Nbd/fDurr5D
         DRxESXM8VbYFCz4a0Op5RZT1kzjF8MNePJ6rCEciDqIWiR37qjqZamp+9d89HF9SvHNz
         YDug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773122705; x=1773727505; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g3oCeeNo06dVSg0D2aS0+PS/IuJ2tDlfQKjHJT5nitc=;
        b=jDPgaVrHtQBtpiuiUWgcYDtIOSIYVWFB8MzCT/YclUsD31EXmKcQ0H2gPuLx/tHDDu
         Rhlh8pLpqLusskgLqomFEWOZ/WCblPV6u02rxJ7oUP8xxJsTY/cm2C21gvOD+KL4guCT
         V0YHqRGf+imDJv5yKNdMZ1K7wQ+ljQS1HIvpXkEYk9gzGC4erg2dolyZIsAkyg1i1qon
         /LzyxkWcsXpqVRQBgdrNWtoBbEGSWh7MmWLNPQBt78MEkJZya11MSpkkH0xTq4gO07/A
         71WLgplhI/a/CN5+44VBNJaArDh9YUr77G9G7HLi0rJ0OHu4yZfdtv75G1d8L9eJ5ff1
         3ZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773122705; x=1773727505;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3oCeeNo06dVSg0D2aS0+PS/IuJ2tDlfQKjHJT5nitc=;
        b=OZ2A9ZOu+3YT67V2z4TRI+3/KfXO5tFvvxAgVCroXbTLpeMTtJJMADLgRK+vgX0guS
         5n7FqbBEsD2tk0WJ/ZXzj3JBO5d6eAWZfQdOlpaRjNV/tzhVBaPvxU/p8JdEAgYPzD2y
         MHFAAAC/J9GOKy43M+HRjBuTkowpCFmjYL2ar59BJdMKX48ZGP+mmwa8lASL1VsEcoZd
         umJY/PvSPG1sTey24tl5fyaD2OfI8sz9TfE/Bn0mamtHrAo7wb5padC/L75uYKUv/HaW
         0eEA7r8+hl7Eyu9hYU+wMEB53JRLbZ1K8lZq7D0UWtGYBFjjQrRx7yUHrGztOHl0ZtK/
         4CIg==
X-Gm-Message-State: AOJu0YwFZrW4CKXmcIEpZK/FGn/dsdWrRFT0+L8fqcjKAK1AFZ1EVbAj
	YUcnww1M7vcURWTj96YkixJpEoBXX8UZOpDKkkuMUaCU0PYEfEjbXtT+BGRcEnA7jNGmqQ9303v
	xcHJhd3GThJ3o0X3emeQia32pSoo44yeV2OPY9NCE6Q==
X-Gm-Gg: ATEYQzyk4ZJRine2QmYvVdC5dWnukJGj8maynu392NWqrSudr/facmon9odmCWrD4zx
	Ltla8V9EMCobPR6VxTKJjo+FYMRhtSnHlMpYxXzVD4bVmVEpczewFTrkP3qotyhyQwfhMMdZzCB
	Q/ONGgh1LJ957iWAOw1Wf1Zm+7VyiyX3H+wY9cIXXuxmgPwZU/CAndgRapNhYSV5DnnrB4Fdio7
	3YSt8p/UC+X1f99oPhFfQ0qds5pWkuTUh5GJuxzAc49s7C6wmJoZ2fvswgcczS56LtdBZOgP/Kn
	Bi/7bu0=
X-Received: by 2002:a17:90b:5111:b0:359:806c:7aa1 with SMTP id
 98e67ed59e1d1-359f01055c3mr2012257a91.2.1773122704838; Mon, 09 Mar 2026
 23:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hyungjung Joo <jhj140711@gmail.com>
Date: Tue, 10 Mar 2026 15:04:53 +0900
X-Gm-Features: AaiRm53mYaXIQ8qWjXdBi1eosiU_u_6TluL-VvLrQDegzGPKZbVHpsrXp4cErJA
Message-ID: <CAP_j_b9BqyQrk3D5nj6RSa=eGcs2HkRYsWc3WdXeXp9O3=z4nQ@mail.gmail.com>
Subject: [BUG] adfs: stack-out-of-bounds in adfs_dir_copyfrom+0x173/0x300
 during getdents64()
To: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	viro@zeniv.linux.org.uk
Cc: kees@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a filesystem bug reproduced on current mainline with
KASAN enabled.

Target file: fs/adfs/dir_fplus.c
Subsystem: fs/adfs
Git head: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
Kernel release: 7.0.0-rc2+

Root cause:
On F+ ADFS volumes, `adfs_fill_super()` selects `adfs_fplus_dir_ops`
when `dr->format_version` is non-zero. `adfs_fplus_validate_header()`
only validates aggregate directory geometry, but
`adfs_fplus_getnext()` trusts each entry's `bigdirobnamelen` and
`bigdirobnameptr`. It copies `bigdirobnamelen` bytes into `struct
object_info.name[260]` without checking `<= ADFS_MAX_NAME_LEN` or that
the per-entry offset/length pair stays within the declared names area,
so a crafted entry with length 261 or larger causes a stack
out-of-bounds write during directory iteration or lookup.

Reproducer
C reproducer: https://pastebin.com/raw/dNisuusg
KASAN full log: https://pastebin.com/raw/y2TZ2iQH
Kernel config: https://pastebin.com/raw/BdHAvXuF

Key config options:
- CONFIG_KASAN=y
- CONFIG_KASAN_GENERIC=y
- CONFIG_KASAN_MULTI_SHOT=y
- CONFIG_DEBUG_KERNEL=y
- CONFIG_FRAME_POINTER=y
- CONFIG_ADFS_FS=y
- CONFIG_BLK_DEV_LOOP=y
- CONFIG_KASAN_STACK=y

Brief KASAN call trace:
[   71.334335][  T144] BUG: KASAN: stack-out-of-bounds in
adfs_dir_copyfrom+0x173/0x300
[   71.334563][  T144] Write of size 261 at addr ffa0000001417aec by
task poc-bin/144
[   71.335206][  T144] Call Trace:
[   71.335273][  T144]  dump_stack_lvl+0x95/0x100
[   71.335320][  T144]  print_address_description.constprop.0+0x2c/0x3c0
[   71.335377][  T144]  print_report+0xb4/0x280
[   71.335482][  T144]  kasan_report+0xcf/0x140
[   71.335550][  T144]  kasan_check_range+0x3b/0x200
[   71.335575][  T144]  __asan_memcpy+0x3d/0x80
[   71.335598][  T144]  adfs_dir_copyfrom+0x173/0x300
[   71.335682][  T144]  adfs_fplus_getnext+0x360/0x500
[   71.335800][  T144]  adfs_fplus_iterate+0x1ac/0x2c0
[   71.336012][  T144]  adfs_iterate+0x196/0x480
[   71.336035][  T144]  iterate_dir+0x238/0xa80
[   71.336035][  T144]  __x64_sys_getdents64+0x132/0x240

Reproducibility notes:
- observed crash: stack-out-of-bounds in adfs_dir_copyfrom+0x173/0x300
during getdents64()
- rootfs mode: busybox
- guest /init runs the case-specific trigger binary automatically

If you need anything else, please let me know.
Thank you.

Best regards,
Hyungjung Joo, jhj140711@gmail.com
