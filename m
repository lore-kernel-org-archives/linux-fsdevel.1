Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677099;
	b=pO+CEi3e3ToR6hC9GNinTuMwxhv6NOa3ZcBqzGpvE3LmyEpD16jngjmdfWmqNEla6xW1
	 DiLi32UIsNwRBo2XYse27dIHbcoNW1sxNeRamniJkshAwvm1e9gNtHlFdwToPBSVBRqU3
	 oDwHOu87atcAByw2AeFUYe1buPfrLP5f9HYAiF/K8sabUNF8ccMS2nNDzJV0mNj3tTQ/Q
	 Jr8Xu2PLczyZVqklhrqTodn4ZTNlT6d2dHibJBaljkPcovOEYHImPkhalhSbpbI4rQ0j5
	 zOC49SHaVRU9pxv4UNqcyTR0LJDrgTH8SukDvxPebhas5gyFjztaUfkyj0BSvNzE/bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677099;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3AMzmTxZ8irr3o941QbW5F8QIQhOchreftiX6DcpbdY=;
	b=V/Q2f1Y9jt0V9CXe3N8GAhWjLDxWgW/rWoHOFY1AwqkCPtK0PKyqGjk47Eryi/r69i5R
	 qlmeEFJsbvTaMfu1gMJitbvtDqi9ObENtDPUDLBCiMwS9HgT4/Arc0PsKm2S0W9m8rsNB
	 8t8ONWF4gdUe89FtVQS7HrZGAVcWOFfaVtIuQ5/KZxmXrGCs6AZumgzfgmGRJPiteQ1tC
	 tIBZg61fBA14qeoxlaofz2EqYAgLKvCQeujj0vpmaGYAwmvE9nUAAJoHQs+yVxDCiSDw4
	 PxNZwJwkxZYiBRYvbDPYfHYDOK0p/7S75R8PHQwCdxPXc0WsoyDcZ5McpKlyUaMH8nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=P32fr4BZ;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25E606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 13:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C25E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=P32fr4BZ
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67a000ac7efso1810525d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792677098; x=1793281898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3AMzmTxZ8irr3o941QbW5F8QIQhOchreftiX6DcpbdY=;
        b=P32fr4BZjij+rD5LraykhzhDfK+ay3sYhjxH/jlCUBM+aixlrMyW9mHNIwV5haFGQv
         7R2DpV0fqFMUpQMQ2mpn2Pg/ayPsrBt0rhnSNesomauMzfy9DyTdSGB96zrhDCgdx9gB
         tSdkrzanKtOPXnR1D0GrGFYGIalJdtcRiZ1b34R3VLSBpxanlQ7jCWxgT6tg7Q7YbukY
         cK2LRg0NuIiwKnrGlBqm6PDXCQSesSoxpTfXiJW5lUoDx8iWEa+BUdE41Swxqb9sCfmr
         2Re9+tZCoz8Xhp3h1tS6jMPVLDqHAUNI9JIuD0YRtnzGCfmBb3lb9pjeuiMe59olYDn4
         nGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792677098; x=1793281898;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3AMzmTxZ8irr3o941QbW5F8QIQhOchreftiX6DcpbdY=;
        b=fiyWoYyzSeZVszLhfkhiluuhQ+kfmNKhCjMprCcjhiSXayO7yaQsVYgIv5K+SIu9kE
         N7mrTWic/41ucQn89CSC3JfcXkUfxyi3QrSJ884HomArZ1950xXYGKBDwYZ1j4z0vyCb
         BCC5V4KuMsVMOBUqqaE5+ezO5jXaUuLSxaip5hYoYY7SxuxEpFnx35MtuADOvoAsElgk
         Pim4erflBHCMfSNzkHs9SZmjbkkCH8g/NYDRbaSUFwQVaOGKCKjE5SyYsqntH3OaqsLI
         H00oEutFMrX+8q16J2IfxQehB3eHRP2p9IUJ4YmEc5afCqkf3jAqk2l1boj+PI+jQegu
         BMiQ==
X-Forwarded-Encrypted: i=1; AKwUvByDA6sja9AZOhDOPsVsshOVoK4ZjJDEaMNV/m2LgXZc+CUUvi+wVLhNCCSzY5KL2iWowqzg0En3GOE/hFRO@vger.kernel.org
X-Gm-Message-State: AFq9FYIHj2DhhaAfZZCfpUu53KAl+nV48lg/yvlZ7ihQv1ddBfvTuc8o
	T6fv3F7UWqAw3rmu7pCxmmuJdpEmirNtO/a+wwREyVoPfQVgSUPd/byAklxkxGvvIg==
X-Gm-Gg: AYBFou0YV6F6E9WohTfyC4ifyQUJx16C73qwIFOdkIdBpr2oETb4IpXSdhSgKDJENBr
	36T8SlMVMIYJmrdYWgsii+YXAXILXzIX0Mkbej5Zz89/M6cxT7ll7Fao1DHaTkgbKzcPFXb4zyT
	uOn1JbhsDYZHVQi0ZqWctK6kZG6tD6D69u8PSKbOxZ6dH5RHH/+t18M/c03Xdot8VxjBXMU2tDK
	nVod8wrCwOgiVH/xdZ1O5Xl8EO27CJF8myBsQ2pmaKIRpqNugQa9EiJpV0y2WLP6FrnDyEspOhq
	vTDhwQXxSxys+kLc1usOLRNlCHA5ioK3YpH1mLoGoMS6uJoibZ5LyUi1Ebh0RFutVEK1O7ye24x
	tqNAFfWadvFPAXO1zznMs4CbNiIlML3HiK6Kk+678AmD2TFeTbTPcpJ601kjrpev4CLrclgJkZr
	7jrg6PduI3vJEoh4zDuSArQFO6dIEbHWCIMlsOZZ0DlqsELwEtjO7U2MlPAowG/HrwKSCwfc4q+
	CGuTWMaSyp6oUIt27UbxixkyOWrfLEcu4ualLHkjs6yBUdeXxahdjBVW/t1xdBz6fmWAzC9g1id
	M+4=
X-Received: by 2002:a05:690e:4090:b0:66d:112b:769 with SMTP id 956f58d0204a3-67a0e02c93fmr2630941d50.1.1792677097897;
        Thu, 22 Oct 2026 06:51:37 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e185441sm2707787d50.3.2026.10.22.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:51:37 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hfs: report errors when extending files with setattr
Date: Thu, 22 Oct 2026 09:51:33 -0400
Message-ID: <20261022135133.1411613-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2b9ea598558ed4b7dd25eb26a05f6667522c3afc.camel@dubeyko.com>
References: <20261021145627.288953-1-hengyul@cs.unc.edu> <2b9ea598558ed4b7dd25eb26a05f6667522c3afc.camel@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

On Wed, Oct 21, 2026 at 02:22:41PM -0700, Viacheslav Dubeyko wrote:
> I think now this code [1] becomes dead. And we need to rework it:
>
> void hfs_file_truncate(struct inode *inode)
> {
>         ...
>         hfs_dbg(...);
>
>         if (WARN_ON_ONCE(inode->i_size > HFS_I(inode)->phys_size))
>                 return;
>         if (inode->i_size == HFS_I(inode)->phys_size)
>                 return;
[...]
> It will be great if you could share another patch with the fix.

Thanks for the review. I made this change and ran the whole xfstests
set, but the grow path is still reached. The WARN_ON_ONCE() fires under
fsstress in generic/013, 076, 476, 650, 750 and 795, every time from
close() through hfs_file_release().

It comes from direct writes:

1. When an inode is read, phys_size is set to i_size, which does not
   have to be block aligned, e.g. 100.
2. A direct write does not go through cont_write_begin(). When it
   needs a new block, hfs_get_block() only adds s_blocksize to
   phys_size. A direct write of 512 bytes at offset 512 makes phys_size
   612 and i_size 1024.
3. At the last close, hfs_file_truncate() sees i_size > phys_size and
   calls hfs_write_begin(). cont_write_begin() then zeroes
   [phys_size, i_size) in the page cache, which overwrites the data
   that the direct write has just written.

So today this path loses data, and removing it would only replace that
with the warning, while phys_size stays behind i_size.

The issue can be reproduced with:

    truncate -s 32M hfs.img
    mkfs.hfsplus -h hfs.img
    mount -t hfs -o loop hfs.img /mnt
    printf 'A%.0s' $(seq 100) > /mnt/f
    umount /mnt
    mount -t hfs -o loop hfs.img /mnt
    xfs_io -d -c 'pwrite -S 0x42 512 512' /mnt/f
    umount /mnt
    mount -t hfs -o loop hfs.img /mnt
    od -An -tx1 -j 512 -N 512 /mnt/f

On a804c5742bff, with and without the v2 patch, the last 412 bytes
read back as zeros instead of 0x42, and fsck.hfs reports no error.
With the cleanup applied, the data is intact but the warning fires.

HFS+ has the same problem. hfsplus_file_truncate() has the same grow
path, and commit 5f63ac80aef2 ("hfsplus: fix issue of direct writes
beyond end-of-file") only covers writes that start past EOF. A direct
write of 1024 bytes at offset 0 to the same 100-byte file loses 924
bytes on HFS+.

I think the direct write path should be fixed first, so that i_size
can no longer get past phys_size. Then the grow path really is dead
and your cleanup is right. The simplest way I see is what
fat_direct_IO() does: if a direct write would end past phys_size,
return 0 so that it falls back to a buffered write, which zeroes and
accounts through cont_write_begin().

Would that be fine with you? If so, I will send that fix for HFS with
your cleanup on top, and a similar fix for HFS+.

Thanks,
Hengyu
