Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE9544606D
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046523; cv=pass; b=tKkYf7MjhkrYQHH05Plyjy+s9m40LNe6tE3cLhPHmPmJ+vwYDFfXQLyIjFQ/XM+JUkS0M/o2EnDgvwWW0PX+EXHKc1mZ2H9xDCv0PONroHTAHfsALedD1Q/plaqc5vMIFnXLFOvxqzs3+X23BLWBOqr+zGGmO3znr1n9vlfXm7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046523; c=relaxed/simple;
	bh=zLg+hs+WcrfMsqdfYqBHLfvgI1GGZ+5enjuBobdEDHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbXGt6178WR0wCv1/fWDEX6FyUEue9vDr0N/nIqHOse3NghJYHTuSxIrgGBn1lR/BZ4E+EWmZxWE6n6ydSrlUlgLam7WHfsmGpohInxv852z9An3SdnX9BlHMHrOxnryUYEmJe4RpP5lwU+Kl5kyBwLIzkkQwd3Qe21vJv7EH08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahX3QFNZ; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahX3QFNZ"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b2a4359d16so3593625e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 02:48:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787046520; cv=none;
        d=google.com; s=arc-20260327;
        b=Xx8bjQf0flJkPkG862az8dU7Lg56EAn5FMK9jCjvcs7020GuCGYidAYPorgUWKmQ24
         NHyK3u6YzXYWSjc1L60nFWD/dHjquvG+hMzHDmx5W/EjHSWlfkbOGuSX3jW3GS8LrsIR
         Dy4mQU2DZP3pxxxvx6ajKW4PrWOk6FgnyBsQlUfXdo945LY/gqN6mQo8uPBigFpzYdqm
         XoLeM0/nMX3D9z6F2lcuein5WPJAY6xGp6yDSai49bcrH6k43w7gkIwbDoBKDefu8V6T
         6Zi2eg2436ExrebTPXvVkcJa21ANOchmTm7rCEUoZ/WsamLv5u8b2u9Sxb1N6Z7xymFP
         WMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rbepamhSr2jyJf19UhAs2iVPXUpahhWIzrWNBZN/cE8=;
        fh=1cTXgp84VtMd2k2eZdcYGyUYqFG7x+S9o8w9r0GojQE=;
        b=biVxQAf+oFyztV1bQw+6kCXBm38Ic+Cd2v5B8ho1qWQ1fF62uAbM0AOWH+LgHcRdKc
         3wf1KVZBorUwQViYUXZg62kYbBWaQxygVetfvrFbzbrZKRmW57WcmVG3kdHC5Bo/elM2
         Jowlc1KElrurm3mS5EjThA7B15+u73Au9n1RkCKUElIJDJyAN80eCMA8Zt7ZwSP6/Ok9
         d8QUM1VZyllHKTKCA6Ch2odD8fB+K5bjJacWqLlgnyKMhkqTlSYrc+8pELqfuoqW1AvX
         sR5tOL7wfaeDnh7iSNNujCRwwMfdBjMp2ItdfqJ3bb32Kta3viRrCjkrfyxtdBeMCl1S
         3nmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787046520; x=1787651320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rbepamhSr2jyJf19UhAs2iVPXUpahhWIzrWNBZN/cE8=;
        b=ahX3QFNZGrsTFUFjWX2cBk8k9SquNsacFL5MJ3eVdoGDKeKkEqJTBZLcfxttDcmY9a
         cbp4pBU7vmdJHmZnKlmptW0bWvNT90nDbTZw2uC7rxI4GNxcUmxFYji/tamiXzZLmrEn
         BBXx9EgAfbPGcjiqXcvkWinLQzfqm6iweh2wheviBlopR7dKRNBWu7eTD6VIFBTMl9KN
         +vxoZhAx025KK+Qx75dEeNbc8O0ssRCXd9CEcjq5v9mixauqzNxnrmUJcYKu4U7d1H2y
         nIVQZ/l/JWY7xjhN7VONOOhPMhTUzFALXhkU1abrgkPjvmAvmfspRB2TROJXNKPDnJsn
         nIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046520; x=1787651320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbepamhSr2jyJf19UhAs2iVPXUpahhWIzrWNBZN/cE8=;
        b=Gw2GVg+VL3PTgPmITEsZQxxdu4p2/WS2hg7cSpOrVI6GMfNfPredi5VTscfX9FGN+8
         DNw1r9UeCbtPm4k+zql+zXfDVZ2XPECl9pGNzzgo5nwDYMeymc8gdDuJ+wm1uPq0BATe
         ogwfMhdHisKbdQyhIWUk7SFZ8kcXKpJ3hbz97V8o8spCNmv++GpJswZ5ZHmwcRw0y/LY
         VFLnFGVqUcf+bYC9dzfa3MNQjvT7hft0ts9FfYvXi0LkoOfrVFWnUovxWjEyFcI9b3nj
         04aXi+vQpVPob/z5T2/nTYxV8tqH7Rphp/D1gxFyRH5quKLmDXJqbKUsrqZbWscgmQNz
         mDvw==
X-Forwarded-Encrypted: i=1; AHgh+RpWrKrvGnoX64u+Dt/qlpi5gMc5O80jl4evVsrk9fhFHRGSDs2/9w/nXYZp49SgJAbnKWgm8igKeNWch4y+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/wtlPJPwE2ItAlfujU932WZdjOTTy6Y9iImHTVHjnvlWWJ3t
	gqIohCLyeWqprGiKYXqCXOKjQ6o0wmNI+8CjcTdHSx1lDn7bOysEZ6U/k/9qoO+Aeb+a6v42Wds
	6dAqVZu5rDDy2/pqAvfMbNy/G9EYAsxw=
X-Gm-Gg: AR+sD11JZjnbWGJy4/5QlELaFLUWuVJ76WxO+ncrSxPFPRm8NtsBIcrK7HWduRamJYv
	ST8VF33McYiMqE+C+d7uwGNmO4IfEQK5WcVm8PC6BlEjMO5qTlFuXcilPnIv4MkFpD/PeIYo1U0
	XtAuZlQQevlO/QHMGAPK6cp+FXtil20rFDUdvS6VY04XPO2Seg9Q+Z628XRkksVcyxlrpnI8ezb
	PFeAOMPpOKf1vFNi/zQUxgAt+xvcXt08TbOBC/VKt++COJ/CEW/wBdpEQDvVkk5gk4ukZ2XF/zR
	/PwDFVoarsCB2Oyt4HnOlOIZ8sR4rCWYqGshIepXZ1G0CcLj0sOvdwg=
X-Received: by 2002:a05:6512:68e:b0:5b2:a21a:10e7 with SMTP id
 2adb3069b0e04-5b45917eb10mr5417552e87.25.1787046519894; Tue, 18 Aug 2026
 02:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <57514.1787000602@localhost>
In-Reply-To: <57514.1787000602@localhost>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 18 Aug 2026 18:48:27 +0900
X-Gm-Features: AcwNN1Wq4WsjekeUWoiDTiADmgGx55T21q4xIow67L6ZiGH1QVdB_JZBRBr13ac
Message-ID: <CANFS6bZdGn1unRQY535ntWFK8Uds8UygZfRZKGwRGdz9OTjUwA@mail.gmail.com>
Subject: Re: a negative ntfs superblock mft_lcn can cause a wild memory reference
To: rtm@csail.mit.edu
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robert,

I have submitted a patch to fix this issue:

https://lore.kernel.org/all/20260818-fix-negative-mft-lcn-v1-1-b7b0b206f2da=
@gmail.com/

2026=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:03, <=
rtm@csail.mit.edu>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> If the ntfs superblock's mft_lcn is negative, that will pass tests
> such as
>
>         ll =3D le64_to_cpu(b->mft_lcn);
>         if (ll >=3D vol->nr_clusters) {
>
> and
>
>         vol->mft_zone_end =3D vol->mft_lcn + mft_zone_size;
>         while (vol->mft_zone_end >=3D vol->nr_clusters) {
>
> because the variables are signed.
>
> The attached corrupt NTFS image exploits this to cause index to be
> out of bounds in ntfs_cluster_alloc(), e.g. for
>
>                 if (vol->lcn_empty_bits_per_page[index] =3D=3D 0)
>                         goto next_bmp_pos;
>
> index is derived from mft_lcn via mft_zone_end, data1_zone_pos,
> zone_start, and bmp_pos.
>
> # wget http://www.rtmrtm.org/rtm/ntfs8b.img.gz
> # gunzip ntfs8b.img.gz
> # cp ntfs8b.img junk
> # mount -t ntfs -o loop junk /mnt
> # echo x > /mnt/x
> ntfs: (device loop0): check_mft_mirror(): $MFT and $MFTMirr record 0 do n=
ot match.  Run chkdsk.
> BUG: unable to handle page fault for address: ffff80010e38ef58
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
> CPU: 10 UID: 0 PID: 1264 Comm: tcsh Not tainted 7.2.0-rc7-00016-g3d6d8176=
22b0 #40 PREEMPT(full)
> Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
> RIP: 0010:ntfs_cluster_alloc+0x376/0x12a0
> Call Trace:
>  <TASK>
>  ? inode_io_list_move_locked+0xa1/0xe0
>  ? folio_mark_dirty+0x33/0x60
>  ntfs_mft_data_extend_allocation_nolock+0x15b/0xa30
>  ntfs_mft_record_alloc+0x921/0x1790
>  __ntfs_create+0x1c4/0xd40
>  ? ntfs_attr_put_search_ctx+0x3b/0x50
>  ? kmem_cache_free+0x207/0x2f0
>  ? __mark_inode_dirty+0x16a/0x3b0
>  ntfs_create+0xc1/0x170
>  path_openat+0xfe0/0x12f0
>  ? do_syscall_64+0xf9/0x540
>  ? do_getname+0x2e/0x180
>  do_file_open+0xdf/0x1a0
>  do_sys_openat2+0x79/0xe0
>  __x64_sys_creat+0x49/0x70
>  x64_sys_call+0x1bfa/0x2130
>  do_syscall_64+0xf9/0x540
>  ? exc_page_fault+0x76/0x130
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Robert Morris
> rtm@mit.edu
>


--=20
Thanks,
Hyunchul
