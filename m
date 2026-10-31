Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793589589;
	b=SPC/XtoCAaUG2jwVqkhIxFPb8QtjgIP+xzHJvKcgTrA6qPhxefOXozBTbmFpyEB22ra3
	 gh8zbNFfYFGqMdME9JaKGPHw4doY86N0hCbnm+Swn2IX/kH360uZ56XWeRy8BUSe/vGL5
	 YEtcAclR1Dk3xVfAZFf/ZUebQJoQJjc+NvHFz5y+eCCNJu20OXtShxmjyh3e1fl63Ea8q
	 CPULZZ5o+coFmP+kVdL7UGE4hjU1A0kLaB7IVZ6ery0hbs2PnaqxFI8NqI46jRnD1+iRd
	 HFsv5U1CMTVb8/Rbo1VEUWz2aMVY+CZrykUVmhurCATQbMHolQXTFiCPMHFUKsX1Eiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793589589;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=BdwjwPAEV6EkihF5MiY4SKdrZWQzw2ZQoPGzEAYyN2A=;
	b=nRmw615hbbd0u6nNqYf0SPl70tsYCGuaImjhydPUDGFKYQY0cujfwgWVQrkcsbwgYBku
	 DBC/R0Zy7Av80CaPbriLtfl5701x6gCO95KM5eLrVe+LgHt1xjefFjWqwW2U61z+pvPg5
	 C6VRojyO0qFfvnajMwfRix9fHSiGz/n/Ok2qqh3e2gMNtW5QSd/tQsR4+5l8l7ytrlPwu
	 5cBJCmeQ+MBArDMELbRfv871h3u6avNppsTPLeImxlG0deJdo+ZpdLnXaWhrRdcZhXWj2
	 nHLN04/nL5pTpBGVm+EUuGx3MrLBLPbCViqGrh99yd8gndRlHz6l0aOMApoglwVoZeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jvhAD7cD;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13A606A324;
	Mon,  2 Nov 2026 03:19:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B13A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=jvhAD7cD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793589579; bh=BdwjwPAEV6EkihF5MiY4SKdrZWQzw2ZQoPGzEAYyN2A=;
	h=From:To:Cc:Subject:Date;
	b=jvhAD7cDnBOXdQ/IbIRq62eTHBUhA7MTS1nUYariBsd0etycIbGxHWeW4WXhRokrC
	 Nw2DxgidHJNMd7lRFNmeob3Shet9yCgacnikpNPlGySd3BtC/WtR2BhTiNlYxSrxHN
	 Uajwx5tsN63THiTiSJgVsOGrH9LDs0Mtd3f3xI14=
Received: from [172.18.4.77] ([61.136.26.103])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4E59D856; Mon, 02 Nov 2026 11:19:37 +0800
X-QQ-mid: xmsmtpt1793589577tsbw4ynw3
Message-ID: <tencent_6946E1A60E7EAF8C6439BD988E45D5F9580A@qq.com>
X-QQ-XMAILINFO: N2mW3FWpw+i+JXhJuL37TMnn/8Yb23V5GYmnYmjJuqRHnVM/AZ9NokTcVXhnhp
	 kIxWLl/xB8O3FrEK6dsUdF/HyRVgTRJnyla0uddLG4cx7i/0duCAbdvrXgGFjwkdHWnbW+Rs4FBe
	 C1Agi1SutX73omb9Dp4RaSdec9E7EZxfggT0DrY+46V8orAdRY84suTrkv3Z7Lw89np6qZ+861OY
	 D1r+jHHl0Z7i7Gub7WH7QHl4r+BVGENnl0idP2prKXZbuKPRw2Zr8FLuXCMtYtIiDuZjmi0b6SC+
	 2sDH5QyFzc+lgV3YFfPXaw87jSLDh5DlFBRnc6p01jYlsCIfvYYuV7R5qW6rJxVwsbeboMQOlMsT
	 wIVWHPr0oME/QXnZ/hSt3CH9GUbD7jneEkOSnar5Df0e2M3JqD7jlZXNvwa5t73EdWgF45TxH7Kw
	 O2UIxztaVkKghR92QnE6zt0oED7uWLushu+DOej1xmXuKmh/yBuYh9fm4ev8c/Pio+o7Dnf/Tths
	 JyawD6cqq4aAQNksrv7V9LXJxoxYAAihZTTli8DI6PR2FhDJ/7Y1bFzTzw+Ya+qIn0hbTfDQF/Ca
	 yGT84jO+C3j1Ua34T3xUHG+EXh0bo768k/88RJ35+8TJtql7vgM1sUr8xmo3/OWoCiUeTXH2h677
	 3x2sL9sMmraUb+S8uI/bRtiGu/ptriCI27obG9JOJR4eDuFe0sscR0p1/Kz5+D/ZLijicYdYf0aN
	 7mfiRHb8mLtinwDZXVaeDP641JuTsZ5REtE8s450tG3kQmuyubtdxGEnRQJ9khT93rRl57dSHvsy
	 7GlXEKLVkoRaqn0GC/9MpOgz8SSUAaq/Bp4MBRCpGAmNRq+2i4H/TCiPoFEAhSIdfxMxbusyloUE
	 pkf78k/DaA1WTEy8VNFvMaMw03qMNSWhGOx/9vDSc0eG5oWPAu/qg+xlLBpjaBwE23z+t1bxac+G
	 vag4Wh3zrZ3uRIWXvVVoyQfpcbw06FLXtunt8YxK31VzgId2WNQcCMZ1Q2Ym5jPwut8m0wGeXLXV
	 reGff6Z74VQcVa6RxU85mfkeslG6Py7AijuiUy02GW+AtaROFNWCnI5SPJDI4xM3E4Ya8f84zteV
	 tfW2dnMV/vL+cJUdvy6XV5WtaKJuZ8sSkAXwr+
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Guikun Yang <yangguikun19@qq.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [Bug report] qnx6: unvalidated di_filelevels in an inode drives a
 shift-out-of-bounds in qnx6_block_map() - UBSAN panic at first read
X-OQ-MSGID: <c4-qnx6-filelevels-ubsan-20261031@qq.com>
Date: Sat, 31 Oct 2026 21:00:00 +0800
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner
Subject: [Bug report] qnx6: unvalidated di_filelevels in an inode drives a
 shift-out-of-bounds in qnx6_block_map() - UBSAN panic at first read

Hi,

While testing on-disk field corruption in the QNX6 filesystem driver we
found that the per-inode di_filelevels byte is copied from disk and used
as a shift exponent without any bounds check, while the same field is
bounds-checked for the superblock's two root nodes. A single crafted inode
therefore panics the kernel (UBSAN shift-out-of-bounds) the first time its
data is read.

The code:

fs/qnx6/inode.c, qnx6_iget():

    ei->di_filelevels = raw_inode->di_filelevels;      /* disk u8, 0..255 */

fs/qnx6/inode.c, qnx6_block_map():

    int ptrbits = sbi->s_ptrbits;      /* ilog2(s_blocksize / 4) */
    int depth = ei->di_filelevels;
    ...
    bitdelta = ptrbits * depth;
    levelptr = no >> bitdelta;         /* shift >= 32 is undefined */

sbi->s_ptrbits is set from ilog2(s_blocksize / 4) when the superblock is
read, so with 512-byte blocks ptrbits is 7. Any di_filelevels above 4
already gives a shift exponent of 35 or more, and 200 gives 1400.

The asymmetry: qnx6_fill_super() does check the same field for the
superblock's two root nodes:

    if (sb1->Inode.levels > QNX6_PTR_MAX_LEVELS)    goto out;
    if (sb1->Longfile.levels > QNX6_PTR_MAX_LEVELS) goto out;

with QNX6_PTR_MAX_LEVELS = 5 (include/linux/qnx6_fs.h), but ordinary
inodes get no check at all. Note that even the superblock bound is one
level too loose for a 512-byte block size: ptrbits * 5 = 35 >= 32.

Trigger: a 30KB hand-built QNX6 image (little endian, 512-byte blocks),
a root directory with three entries, one of them pointing at an inode
whose di_filelevels is 200. The mount succeeds and the first read of that
file panics:

    UBSAN: shift-out-of-bounds in fs/qnx6/inode.c:128:16
    shift exponent 1400 is too large for 32-bit type 'unsigned int'
    Call Trace:
     __ubsan_handle_shift_out_of_bounds
     qnx6_get_block.cold
     do_mpage_readpage
     mpage_readahead
     ...
    Kernel panic - not syncing: UBSAN: panic_on_warn set ...

Reproduced 3/3 on a self-built 7.3.0 kernel (CONFIG_QNX6FS_FS=y,
CONFIG_UBSAN=y, CONFIG_UBSAN_SHIFT=y) under QEMU/KVM. A control image with
di_filelevels = 4 reads the same file normally. The field and the missing
check are unchanged in current mainline.

A natural fix is to reject the inode in qnx6_iget() when di_filelevels
exceeds what ptrbits allows, and to tighten the superblock check to the
same bound. QNX6_PTR_MAX_LEVELS alone is not sufficient for small block
sizes: with ptrbits = 7 the usable maximum is 31 / 7 = 4. Happy to test a
patch.

We report this as a crafted-image robustness issue; the crash is a plain
UBSAN violation reachable from a normal mount and read.

The reproducer (the crafted image, a control image, the run script and
guest init that mount, open and read, and the image builder with the
exact field offsets) is available on request.

Kernel: self-built 7.3.0, CONFIG_QNX6FS_FS=y, CONFIG_UBSAN=y,
CONFIG_KASAN_GENERIC=y; QEMU/KVM x86_64, 1 vCPU.

Thanks,
Guikun Yang

