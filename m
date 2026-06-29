Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA0439659E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 06:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716024; cv=pass; b=JVx7ysIryzDLiKzbOwj/FwCbAGV2KJGqXNtuvv3bZbN5gz17enxUVdKTPUEUch9gULV9KKHBGZl1kfT1Xo1eRizSBztX47GDPTuS2heVKkUfYQJ23BVkoXxLXDrmFBnJRtb4qpsj4+e6u1t7WxcYAVCw9kgHZ6Bfne6xcTGK3SU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716024; c=relaxed/simple;
	bh=u5k0kR2H4Km+GCf0gnTdvFRFDD6QQEK+7s9fxdxA9WA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GPjBZsv2C4csOtRjmrlxQS2/TWwi+j8uu38Ec++YPgwau0sCX8H+Yzy7wZriTlF1fdhDrIGRd2TzZCLg/DqxyaOdD0SLBWXjQRl23iBAqaPOICZ5ZOPFGuV4JRfadcaGxq7kiHdMYnY2it8iGckQzqSbzsrO+3ut1dP4QjC3gAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3UrX8Yo; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3UrX8Yo"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51a8f5ef23bso18769121cf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 23:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782716022; cv=none;
        d=google.com; s=arc-20260327;
        b=Lc/6EdSBIdf1Erd7LPStgghVKDStaEEH7Oj0SbazlujZBZTJSFtNIqphywpt9qWSMY
         /Ko8526XUGhBMLJzCjjEy96zlSkiHHRDKJW3nSlAdjkBdOcCaalabT012Z6gJQRpth+d
         Mbw3VCVaQi25biefIGg5O5C2hkjy4bccJhzcEQc2vvvPkII8UTQlOIXst/+RQpgKo7t9
         XS9Z8Lyc1V/6bLfxO53Hehwxo/70UBvjvI5jKzxWEiQxS/20t+uxJzh9zvSJleema+h6
         +fkxLvJ8ol1ajxI8qB6t8Gjn0rhTCRDEYwOn3A6SJeEsppoj/mhhZb5ZqRecvT8UhKe2
         kTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=u5k0kR2H4Km+GCf0gnTdvFRFDD6QQEK+7s9fxdxA9WA=;
        fh=g43TTHsDNz0pb6DeDO+IwThvQ3pC5D9XvJ229P2OVb4=;
        b=K3BVIHWNJ9xL21Wp5CYYBMDdBKhuUZu3ths0CY3BjEs9pd+1w2umJAU9lanlLuK5zl
         Hj5yQOpOGdiao4AEow88ID0d9tGpZGgWJlYJg+Fbg4ofum1NApnCqa1uIFvMSujONNtH
         K+KcwyT+Fg8CtkU5ln6LYs4VR8t9hOEABorKFnkPfPBdrVGiiBe4C9X4zTi1yaboCHK8
         xwqUnKe0F4yIVcFSdnyC/wzWoYRQcHgOV2gJHvwlZC3ekZyY5vlgdju94oAs7soCO+oQ
         3/JKMxtQ7uU4Tkk8YA+iH0tbU9RbDAcChE5zUUWKNzKXzBdwE5kdebRpfGdnsvFf/k+g
         lFww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782716022; x=1783320822; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u5k0kR2H4Km+GCf0gnTdvFRFDD6QQEK+7s9fxdxA9WA=;
        b=p3UrX8YoS2YG4MwaJGbMDg7BkURSNMkaLggPZYrMDbm5CQSaM0jBUCjmkQPZAPq/lf
         xLyQWLrqVkirEu2HGtvPEDM16qGd+d1DKTHDV2Phqg7IEHyFjAA5nLPtWjozmhLfCGgW
         GzLoh/iS5x8mbCv8Jbu1QJouQbGPwliGFiEw4ts5zlvpkEFCfIenLDHpguRErvadfLL2
         9Y+1z4+DkJHGc7aN8GihjLd4YvSfsQOLnyeuvIJZ4fHdtzjMunlg6FIVqib2JmAlBsDi
         Sf2N9wOPrcekcLyQDPuANyqOIWoWpLq0SY4pj1k3KEpbST02PzEA6OUksHC/OWqe6HhT
         yU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782716022; x=1783320822;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5k0kR2H4Km+GCf0gnTdvFRFDD6QQEK+7s9fxdxA9WA=;
        b=JHY2hRC4J9ymTIlZ3r8ohGs2schJ4KPh/SYl7wdRGeMVoKpqe+rNam8xwaq0g3+Yh0
         U4bU31ghWeY4rWfjfEseB9MrQIUYLgUUcHIYBZaYpGJCTtORAmpm4qFNfjyIpXwmWz2W
         7XROF0/cgWybHV6DI2I4QGCLhM6xD+Z3FfZzJNGSDM4H51LMD1bgJR1VN+lsxcA2rKbS
         bvyU7rhB6prii64JtgXIQhdqXd4KgPuV80X5pJpAMjYeZIUjz3VzrUfrTgsafPs8/OUi
         fdjZr1eQk56qpzer3lBnYK5UoZS8dx88P/jP9CI0ZqAkJUsXOEzO+OdE2fBy8NDW//cG
         VE0Q==
X-Forwarded-Encrypted: i=1; AFNElJ+pAVIOGX6K6L7A9tnY4JR0McDZ9Kr2mAVV/rQbM5XfVxdBjJI/Q1myX/0E7Q4xt2gWbTPYbmJrCbI8hnc4@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDtacsrbNski2oL7ULxNJ99dotc8fzJZkrHHKFk7DGjgAeBgv
	kou9KvLpO5SOBjZtWXkGQImRS3xgc5YhIHe5tuehLyrqbbF/gR4y8B2Sk1B0Y5cuAJwrJgmO6Md
	Y2Q/SyF7nSIup63iuklsHHlhBZNfNp/k=
X-Gm-Gg: AfdE7cnjg1gid03Da4Xkz4GI7cz22SiigtDCfIOyPYvIU8PVBgdVU0OycfNrqU5Im7D
	rh1xdkCyPslQ5H4waQsZSOBezJa6P1WIesLQqrdDBOZQxn7VrsxFj4v3DlcfJhimOTlaUFw7IO7
	PjNLroB8G7K6QTROSGwgmGwv5UiuJYkYChTe0kPtFwGEAwzFs8UIquisd0fEnUvZ05HOHuwmPqd
	0DF0YC58o6v1n2/hVY1nCKImfd5/Bf9q3dj8DFh7Ht9QIpMb8tg3PfADm6xb2P8bWyVT2I6sVC9
	RM3anW0=
X-Received: by 2002:a05:622a:5987:b0:51b:f635:9a9e with SMTP id
 d75a77b69052e-51bf6359e75mr46903621cf.46.1782716021660; Sun, 28 Jun 2026
 23:53:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: ZW Tang <tangzw515@gmail.com>
Date: Mon, 29 Jun 2026 14:53:30 +0800
X-Gm-Features: AVVi8Cdilo9hJn-TZNrUqndpV-x1jka5A39NRYG_B4xwJKqHrJv4Tx0NTkPIhtU
Message-ID: <CAA2SOT4K-Z6FwsmLjYDuNa8y-XGOG53H5U6rZdOkAFzwOM1G1Q@mail.gmail.com>
Subject: [BUG] general protection fault in __lookup_mnt with crafted ext4
 image and bind mount
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a general protection fault in __lookup_mnt() triggered
by a syzkaller C reproducer on Linux 7.1.0-rc5.

The reproducer mounts a crafted ext4 image on a loop device, enters
the mounted directory, creates and writes to a file, performs a bind
mount involving the loop device, and then continues with file I/O
operations. The crash happens in the VFS mount lookup path, followed
by additional crashes in timer/ext4 writeback paths, which look like
secondary effects after the first memory corruption.

Reproducer:
C reproducer:https://pastebin.com/0bseRsBn
console output: https://pastebin.com/zpfwbgYA
kernel config: https://pastebin.com/raw/fUwrL2uz

Kernel:
HEAD commit: e7ae89a0c97c
git tree: torvalds/linux
kernel version: 7.1.0-rc5 #2 PREEMPT(lazy) (QEMU Ubuntu 24.10)

Crash:
EXT4-fs (loop3): mounted filesystem
00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode:
none.
operation not supported error, dev loop0, sector 0 op
0x9:(WRITE_ZEROES) flags 0x10000800 phys_seg 0 prio class 2
Oops: general protection fault, kernel NULL pointer dereference 0x1:
0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 2102 Comm: syz-executor Not tainted 7.1.0-rc5 #2
PREEMPT(lazy)
Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010+0x0/0x10

A later crash shows memory corruption / wild-memory-access while
handling ext4 writeback and inline-data/xattr destruction:

Oops: general protection fault, probably for non-canonical address
0xed0157dfdffff115: 0000 [#2] SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x680adefeffff88a8-0x680adefeffff88af]
RIP: 0010+0xb6/0x440

Call Trace:
<TASK>
ext4_xattr_set_entry+0x12c2/0x17e0
ext4_xattr_ibody_set+0x380/0x570
ext4_destroy_inline_data_nolock+0x253/0x550
ext4_destroy_inline_data+0x78/0xd0
ext4_do_writepages+0x579/0x3580
ext4_writepages+0x2d7/0x590
do_writepages+0x1f6/0x500
filemap_writeback+0x1de/0x260
ext4_alloc_da_blocks+0x176/0x1d0
ext4_release_file+0x15b/0x320
__fput+0x3e9/0xb50
task_work_run+0x161/0x240
exit_to_user_mode_loop+0xf6/0x540
do_syscall_64+0x3be/0x5b0
entry_SYSCALL_64_after_hwframe+0x77/0x7f
</TASK>

The first reported crash title is general protection fault in
__lookup_mnt, so I am reporting this primarily as a VFS/mount
namespace issue. However, the reproducer uses a crafted ext4 image and
the later crash reaches ext4_xattr_set_entry() through inline-data
destruction and writeback, so the issue may involve an interaction
between VFS mount lookup/lifetime handling and ext4 error/writeback
paths for malformed images.

Thanks.
