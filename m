Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793556291;
	b=YosZpilVMpTje54lbNqYbAk7hO6+xO+bLRnk2SVZLX7TLefn3ImI7lSbVPL/WB7Gl28N
	 OIaJwc5oFsTJzoVqwYPiKxbJffHCt5QrchzxkYl4OLVmAsUs+VkUN0gD+RMRc1V5okJlC
	 gnkNcXq0wW5oho/+liRWLKbto7V/Uwh4+esjXna+Qi6LJJEf24Z6TK+2tu1vAnnR96AMz
	 S1tzPGlWlUGhBf5ZiR1hAL99dVMX2ajKm1YQ66NF1PZyo5uArcuBvPL576ASxpZ5nNFF+
	 JjXa02166FaXSEIoP64ty7UJR0jkR01cRuRU83FW52NWYJBIgw33BGV7XFxVt6hRMOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793556291;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:X-OQ-MSGID:Date:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=LYyqboXdIBzGq/CwwE0/RCPQD2DfivCnnBGtlUgka8A=;
	b=Of2zc/vIxbmIUUhqpEd6A6EAhP7vfCwcKa7blqfuEcAk42qNPpllgkq2rBw1T6D64zmR
	 LBNjZSiUlcm1WUyfhKWYEFMbOhTtd/P04ZGq+T9pI6GDE6J1rbfaTv91+hDIGREUERSQ5
	 JceAEcsNl16tmgQLUSL3/XGdgidnlLvZj/b2sOfL16jdyVWBAxPPTdGGH9EjXNkl4kGCj
	 p8NPp9+t79iycNZHAxG0vFsvsXwa62pzXtAZk76N7lXSFc0rEKA2rX6pOMLZ5H5XoCf1P
	 0RGjgAHuiEKAdOlNVJwiDLm2ebmonbsIzJ71k7nCNOHPWEl7/KrTTF6epK03l3pztmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=afqooPYA;
	arc=none smtp.remote-ip=203.205.221.210
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4973E606A324;
	Sun,  1 Nov 2026 18:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4973E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=afqooPYA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793556280; bh=LYyqboXdIBzGq/CwwE0/RCPQD2DfivCnnBGtlUgka8A=;
	h=From:To:Cc:Subject:Date;
	b=afqooPYAmxQH5F1YRVAj2pBrnLRT1197zCJt7xor4IsGSKBHnFXBVi8JbQ2ufPHQB
	 xb0JPYiitbd8YVaT0ItColuq07Ho9Q+C4V/LXpAZMleW/mHnlqbCWvSj2LLMPraRsZ
	 Ik0CMqSRYyHTDSLU/lXXsS9+Crojq1QHw3yIKwgw=
Received: from [172.18.4.77] ([111.31.227.58])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 1258B23B; Mon, 02 Nov 2026 02:04:37 +0800
X-QQ-mid: xmsmtpt1793556277tco5hrfpg
Message-ID: <tencent_5C7F8B8D303ABD994244C1F814473DA5B60A@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahkpsAabajIhOpaIENfCc12td3HavyUmzdgLXtc/MdrH3oMVGlBZ
	 B3SOvdJyT3d2PxlQ/Igc505LEvU9m/LRGnLTYrlqbz4/rNZvdiuK51cUSx+mwNDgINIF/0RWc26j
	 98DtjEv6OelHteu/TNsSJtlMwonR0KFpFRn9YvikFHz9fAsmvNtQ6ri1/aCRJZf/Wm6Z2/gbiWRG
	 Z7YSOfJFhJq5fMxdVaw83UiWQjlduY0R03rel3B4AXeIWPPe8ArYm7jIbFp5hDUJ/6gegtIwe1SD
	 J42yT79/pHom8QIjzIsIovl6iHfqocaEQPqyTQCuJsMe/qookhnaLhZFgv7hRQOxfnaApcbP5THh
	 zxV6mg9YsICzI3ayv81CXvj2E3Z3GSPKiuSkGgpKzUbwPSg5e1HwsXePEQPueaHdv7Y5khWQQ9Rl
	 bAknmmWeCtZ8Gepwsqb6Nw+pBTShKDLeAUpEgoOKrl+2BJ2r/WJP+bQpr1ho89ttUtdNgScwqy9M
	 xmTzUlKsLHsy/w9sEV2YxNRjujfJABd3nxhW7Rs7kfAcNbW0ZTnnpSEjaKTgrvsUE2miX+iwB5RR
	 n9Krq28tHzVH4t+JFFgwvOL3fmR5SZJ00XfWFoA+qOXIEhEBIibgI0heNudIiE46j1HQcuj/HaRg
	 6j5Xcn8W3c5ZQGcgSyWQtdhZYhysklDsMYUWX8BRggV53b/B1+yE1tohOM9pcCGj8RAa4CUrv21a
	 Q1xeQy+iQDSVqlRN8BlUZMy7Ba+HAVKk/bHp4ymsvuJ6Hgs3FQ//6d0TTfvEQmYfJmoVrXUxZjiw
	 IBdN2ARO+sAw/IFYejVemRK5PUAU9VxKqfjlzArHXxza3j6nY1chyFOMKE+NKUaKcwfS5+T4K57O
	 AwVioMDobsfk/uke4vCKuR3KGZfvl9dKveBPL4b3KkspLm4tzk2uHfjR0SVClaQm1xvhsCnMJTvD
	 CQkRVapFZM0wShYcBI+zOP4KrARE3Pie7UNwRU+CPHTzNiuFk0YEGQXPUAcqhcoBamj+Dmc97zvT
	 70b0wDkwqFxS57YCOKorfsaGUPAjlfnSqtjBypYnT7reuCjW+c
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Guikun Yang <yangguikun19@qq.com>
To: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [Bug report] ntfs: initialized_size from $LogFile $DATA drives an
 unvalidated loop bound in ntfs_empty_logfile() - UBSAN shift-out-of-bounds
 (ilog2) at rw-mount
X-OQ-MSGID: <c7-ntfs-logfile-ubsan-20261031@qq.com>
Date: Sat, 31 Oct 2026 20:00:00 +0800
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

To: ntfs@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    Namjae Jeon, Hyunchul Lee
Subject: [Bug report] ntfs: initialized_size from $LogFile $DATA drives an
 unvalidated loop bound in ntfs_empty_logfile() - UBSAN
 shift-out-of-bounds (ilog2) at rw-mount

Hi,

While fuzzing single-byte corruptions of NTFS metadata with an automated
mount harness, we found that ntfs_empty_logfile() trusts the on-disk
initialized_size of the LogFile's $DATA attribute as a loop bound without
any check against the runlist or the volume size, and a single flipped
byte in a read-write mount sends the kernel into a shift-out-of-bounds
panic inside the readahead path.

The code (fs/ntfs/logfile.c, ntfs_empty_logfile()):

    end_vcn = (log_ni->initialized_size + vol->cluster_size_mask) >>
          vol->cluster_size_bits;
    ...
    if (rl[1].vcn > end_vcn)
        len = end_vcn - rl->vcn;
    end = NTFS_CLU_TO_B(vol, lcn + len);

    page_cache_sync_readahead(sb->s_bdev->bd_mapping, ra, NULL,
        start >> PAGE_SHIFT, (end - start) >> PAGE_SHIFT);
    ...
    } while ((++rl)->vcn < end_vcn);

The inode loader does validate the on-disk trio against each other
(ntfs_non_resident_sizes_inconsistent(): initialized_size >= 0,
initialized_size <= data_size, data_size <= allocated_size,
allocated_size cluster-aligned). What is missing is any relation between
those sizes and the runlist length or the volume size: initialized_size
is used directly as end_vcn, and the readahead/loop bounds follow it out
of the volume. For comparison, ntfs_check_logfile() scans the LogFile
using i_size (= data_size) truncated to MaxLogFileSize, but that
truncation happens on a local variable only, and ntfs_empty_logfile()
runs afterwards on the untruncated initialized_size.

Trigger: one byte. In a mkntfs-created 64MB image, flip byte 0x4947 in
MFT record 2 (a high byte of the $DATA non-resident size fields) to
0xFF and mount read-write:

    UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
    shift exponent 64 is too large for 64-bit type 'long unsigned int'
    Call Trace:
     ...
     page_cache_sync_ra.cold+0x19/0x46
     ntfs_empty_logfile+0x763/0xd50
     ntfs_fill_super+0x4085/0x71d0
     ...
    Kernel panic - not syncing: UBSAN: panic_on_warn set ...

Reproduced 3/3 runs on a self-built 7.3.0 kernel (CONFIG_NTFS_FS=y,
CONFIG_UBSAN=y) under QEMU/KVM. The function and the missing
runlist/volume bound are unchanged in current mainline.

Notes:

- ntfs_check_logfile() scans with i_size (= data_size, still sane), finds
  no restart pages, reports the LogFile as not empty; the emptying then
  runs anyway on the crafted initialized_size. The panic happens inside
  mount(), before any other syscall.
- A natural fix is to reject or clamp initialized_size (and the derived
  end_vcn) against the runlist extent or the volume size when the inode
  is loaded or when the emptying loop starts. Happy to test a patch.
- This needs a crafted image, like the rest of our NTFS corruption
  testing; we are reporting it because it is a kernel-crashing UBSAN
  violation reachable from mount, the class of bug syzkaller-style
  fuzzing of mount images finds and fixes routinely.

The reproducer bundle (image after the single-byte flip, clean control
image, a moderate-value variant that mounts cleanly, the flip harness,
guest init, and a README with field offsets and expected output) is
available on request.

Environment: QEMU/KVM x86_64, 1 vCPU, self-built 7.3.0 with
CONFIG_NTFS_FS=y, CONFIG_KASAN_GENERIC=y, CONFIG_UBSAN=y. The driver is
fs/ntfs as merged in 7.3.

Thanks,
Guikun Yang

