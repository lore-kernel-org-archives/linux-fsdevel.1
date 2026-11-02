Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602845;
	b=prA5uKJN0un+G5kj5Ge3d/z1Iim6EhA5ufu7fKgul0a9VSduKTopUP2SzQYjivjTqAcv
	 CyifB5V7J91zSuibLhZaBIgB6SA81mnVBYX6TS5zmHxHM/Ebia3ifHfv1CZ4tdRd3wKUA
	 SwLLkhaQuMV1ZtwGeTjE2m7f4l7xYOXSdR6EsFbQdUa+OoWC9IC1km9TWQ6TEmX3+SQ6W
	 7Qzf9yq/WkM1OXQMCct6SDsP396Mlt3I9fw0TlZn76GoM28hutd4ckYm6Yvkvetkat3RP
	 zcZ0Q1qgz90EYIxsGEgdymbvKRV0tD+1dYWEbh8KY6+8prmK3qJH352VE0Kjou/O7Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602845;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=9FuBhOUoafYas5YMuPBrLXu56DIDcQY6sekzUrrW8do=;
	b=A83q0YIIAXXOw4voCXZ5HcnEs+NOOD5Qu6BKmt9aE01JVhWPiREiHl7FfbadXjAP1kfD
	 aqjj4QPT7/H1q75UFO+gOLPN0TKkNa2aEN6h5dYgdLVzRaTE7z4dTwUSwgiscm7GYJkw0
	 v39qk0boY05WKGON8YlvsjUEVyxZOD2CQlm5FfQeVNgP0hiHk9l2L11ncz4TDFDi2HMFO
	 miUof3NK2CNOBVer8COf1O19rUAjJ70xb/Bg0SrNc513Q2QqKZYHfneNxktTMJCBC8ErN
	 /tstpfzNUKP3ypB7MuYspopPTJl5FRFb6iOlsXV86pEIDJxAhqAGOb0yfimYDVum/Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961E1606A324;
	Mon,  2 Nov 2026 07:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 961E1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=9FuBhOUoafYas5YMuPBrLXu56DIDcQY6sekzUrrW8do=;
	b=bRRH1UEHijwHiuDMLEo4Q7aYUesjQzuIR6yYYtu6BVzNOGBvMreQPj2RMKrA7a
	WZlrOKnTZCD5yYBvKoMTCcxaph9nLSJx3525OVTRYLi/x9opx5K4qiMUFXKvQgxt
	3xmm5ObZyEK4LJbG65HI6kvqbkyK3afyycjc+wFpEapS0=
Received: from [IPV6:2409:8900:1ec1:a6a9:727d:9e69:8b60:aebe] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3f4UCNehq+dR4Eg--.33924S2;
	Mon, 02 Nov 2026 15:00:21 +0800 (CST)
Message-ID: <aa1d14cc-91eb-4101-a70e-b4ae5d1717db@163.com>
Date: Mon, 2 Nov 2026 15:00:18 +0800
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug report] ntfs: initialized_size from $LogFile $DATA drives an
 unvalidated loop bound in ntfs_empty_logfile() - UBSAN shift-out-of-bounds
 (ilog2) at rw-mount
To: Guikun Yang <yangguikun19@qq.com>, ntfs@lists.linux.dev,
 Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <tencent_5C7F8B8D303ABD994244C1F814473DA5B60A@qq.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <tencent_5C7F8B8D303ABD994244C1F814473DA5B60A@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f4UCNehq+dR4Eg--.33924S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4fJw4kKrWDWrWUCF1fXrb_yoWrZr45pa
	9xJrs5tr4q9ryjkwnFkw1xK34Svw1kJFWUur95Zry7Z395Grnaqr1UKrW5uayIkws5ta1v
	yayDWws2krn5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U24iUUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QUj7WroNQU4FgAA3+



在 2026/10/31 20:00, Guikun Yang 写道:
> Hi,
> 
> While fuzzing single-byte corruptions of NTFS metadata with an automated
> mount harness, we found that ntfs_empty_logfile() trusts the on-disk
> initialized_size of the LogFile's $DATA attribute as a loop bound without
> any check against the runlist or the volume size, and a single flipped
> byte in a read-write mount sends the kernel into a shift-out-of-bounds
> panic inside the readahead path.
> 
> The code (fs/ntfs/logfile.c, ntfs_empty_logfile()):
> 
>      end_vcn = (log_ni->initialized_size + vol->cluster_size_mask) >>
>            vol->cluster_size_bits;
>      ...
>      if (rl[1].vcn > end_vcn)
>          len = end_vcn - rl->vcn;
>      end = NTFS_CLU_TO_B(vol, lcn + len);
> 
>      page_cache_sync_readahead(sb->s_bdev->bd_mapping, ra, NULL,
>          start >> PAGE_SHIFT, (end - start) >> PAGE_SHIFT);
>      ...
>      } while ((++rl)->vcn < end_vcn);
> 
> The inode loader does validate the on-disk trio against each other
> (ntfs_non_resident_sizes_inconsistent(): initialized_size >= 0,
> initialized_size <= data_size, data_size <= allocated_size,
> allocated_size cluster-aligned). What is missing is any relation between
> those sizes and the runlist length or the volume size: initialized_size
> is used directly as end_vcn, and the readahead/loop bounds follow it out
> of the volume. For comparison, ntfs_check_logfile() scans the LogFile
> using i_size (= data_size) truncated to MaxLogFileSize, but that
> truncation happens on a local variable only, and ntfs_empty_logfile()
> runs afterwards on the untruncated initialized_size.
> 
> Trigger: one byte. In a mkntfs-created 64MB image, flip byte 0x4947 in
> MFT record 2 (a high byte of the $DATA non-resident size fields) to
> 0xFF and mount read-write:
> 
>      UBSAN: shift-out-of-bounds in ./include/linux/log2.h:57:13
>      shift exponent 64 is too large for 64-bit type 'long unsigned int'
>      Call Trace:
>       ...
>       page_cache_sync_ra.cold+0x19/0x46
>       ntfs_empty_logfile+0x763/0xd50
>       ntfs_fill_super+0x4085/0x71d0
>       ...
>      Kernel panic - not syncing: UBSAN: panic_on_warn set ...
> 
> Reproduced 3/3 runs on a self-built 7.3.0 kernel (CONFIG_NTFS_FS=y,
> CONFIG_UBSAN=y) under QEMU/KVM. The function and the missing
> runlist/volume bound are unchanged in current mainline.
> 
> Notes:
> 
> - ntfs_check_logfile() scans with i_size (= data_size, still sane), finds
>    no restart pages, reports the LogFile as not empty; the emptying then
>    runs anyway on the crafted initialized_size. The panic happens inside
>    mount(), before any other syscall.
> - A natural fix is to reject or clamp initialized_size (and the derived
>    end_vcn) against the runlist extent or the volume size when the inode
>    is loaded or when the emptying loop starts. Happy to test a patch.
> - This needs a crafted image, like the rest of our NTFS corruption
>    testing; we are reporting it because it is a kernel-crashing UBSAN
>    violation reachable from mount, the class of bug syzkaller-style
>    fuzzing of mount images finds and fixes routinely.
> 
> The reproducer bundle (image after the single-byte flip, clean control
> image, a moderate-value variant that mounts cleanly, the flip harness,
> guest init, and a README with field offsets and expected output) is
> available on request.
> 
> Environment: QEMU/KVM x86_64, 1 vCPU, self-built 7.3.0 with
> CONFIG_NTFS_FS=y, CONFIG_KASAN_GENERIC=y, CONFIG_UBSAN=y. The driver is
> fs/ntfs as merged in 7.3.
> 
> Thanks,
> Guikun Yang

Hi Guikun,

    Thanks for the report.
    I had a look at the latest ntfs-next and think this may already be 
addressed by two commits.

    8e9137915220 (“ntfs: reject non-resident attributes whose sizes 
exceed their allocation”) adds the size checks you mentioned. With the 
layout you described, setting byte 0x4947 to 0xff would make 
initialized_size negative, so loading the LogFile inode should fail 
before we get to ntfs_empty_logfile().
    Also, 749357bd48c16 (“ntfs: mount hibernated volumes read-only 
regardless of errors=”) makes the mount read-only if errors were 
recorded earlier. This includes a failed LogFile check, so the case 
where no restart pages are found should no longer proceed to emptying 
the logfile, even with errors=continue.

    Could you retest with the latest ntfs-next and see whether it still 
happens? The current tip is 564c77536477.

Thanks,
Baolin.

