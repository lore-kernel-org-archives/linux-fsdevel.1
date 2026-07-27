Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCD0380FFD
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130695; cv=pass; b=hRYcRctnm+gO8OP5j5eb4qdoygqdMxaOew8JUWESNhTi4ujvQJBRSv/h+d+WSWtlV1eccndtR/KKaeJ/MaT5Vmc5UenoWCVeGpGFp/HSTybW1C/W8N/Fjsfl2iz/ZiF7Wp0Dj/s9TnW+Gg1qGDzJ/S8/AMfviaW0ry8IRBsSMgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130695; c=relaxed/simple;
	bh=qO+AcQwl5LytYasXwy1YF8GBBHOuzHCq+urNgfPjAm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2HKh8DYnac5Um+WgRJdTXujlBjkqoIVfzIzhbS+laZtVrWY6HanZkpeuC42+b5Ejr8jvXGVzoo7yhv4B8j+ogfcRYs/KrE9jA05RgaRxWXuQUeJ8f/MrLb3WjSqzPrDgW8fN2OciOGd0XDsNcOSNbLJhpc82pEBlu2uBvvi0Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWyVTZXr; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWyVTZXr"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c62764c7cso28233181fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 22:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785130692; cv=none;
        d=google.com; s=arc-20260327;
        b=jbHU8V1Bn9Lnfd1XLAgKJ+g4Xy6+gBvPITSuIm4UB+GRfFO7PNhWAmLrhK0T9AV6Hc
         HQTrDwQlZpSwlcnojtInDZ5ase9+h/0GFr5OQ9FEKyEMEXOJiD8vU0VZm0mvGrL1aDld
         wBuZWzqu5UZu+Ju6JpiCdzgvffhMESprtg/WNvYKRkTbTDRqHcS+/cBh1PwjKmFaVAx0
         saxX+pZNEappSTmxJxSF8iMsay4WhQaG6tw47omVPrSw878FX7Z0eOliuNivipICVOq1
         KeamyFzEb88RXj9JO1R13M2bqz+ZIcXqQjikmRtXWzCdvnfVBKNmDQil1ogyl57spNgC
         iS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qyXEziCGZ4ErOySNPC8PwElhdgWgKAzfuETo+S54hwg=;
        fh=7/IUNxqaRdsqgqHjQUkj1w/05er67NQOMlibjgAtfN8=;
        b=HSx+L54Wzz5RdEQc0/etC4BfbXA1+2E41oDMlG0Y0/uQJugAjkijijRUTyb+ZCepG+
         DD5m8p8Wds3ZVnlJsBRyaWgNDLbxUgv7x0fHd0DbBGWQ+EwD4eO69P60XuWi83gPRYuc
         3Xt9t/93DjbMZ3JOa62vv/b9iFUvwu/znXZ8ipXTAwzOa8FE6e66lDjveJLVGj/htNor
         2sTpCGNvIQoqFTaNpALGEthpdvK4uGhvESy4R+gDdWET33gG/ztaBfrcnCHcCeBsBKZm
         1JOEa3zPE36h5X+TQ88JZ/c3SEWAKNPluFkMzmFz6k9K6LZns+cO/8/5jZtJYod4XlDt
         XbAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785130692; x=1785735492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qyXEziCGZ4ErOySNPC8PwElhdgWgKAzfuETo+S54hwg=;
        b=fWyVTZXrB9MXRz/SQ7CCvsp+YePVylGR3VukIIc6GZqre+M7fbwIUrB1MSg1UpeH6L
         0aYH9KslbGApPM20W/3QimiQMFOl+i2jXz6sz6WZR3kwXkyn3IGhDNdy2CbFFEFDX4wk
         VAIXwgGnPmMdOBBajNzLjYoyR3+Q9Ukq7UExksOOlDbJ/KXWSa8DsnmLbzc/qD+hHmVZ
         CzkZFCcLoHtv51HXf4X/Y9XoQDxFfmV/LXiMRR5+ULLj8xzihR5cZWUlRmPjdeOery6C
         +N/9yYW/8KMaAC5vmW29bnfnqYcJapRz2ZnZeLVxH/WB93xUr3VXKmuW4rFgvH76riEP
         QmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785130692; x=1785735492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qyXEziCGZ4ErOySNPC8PwElhdgWgKAzfuETo+S54hwg=;
        b=jznaB9Xb9Yf8ocnfC6p0eRqqwsrvKv6n9pTG5GaLXHere36XhDkcOPJbM7xwZ38UJi
         5pCCwyEi2zEcxA9cCB818Q0EahRodCJ4AJ6LjD8ycvLY2DDndRAuP0unKotjZ+uygZ7g
         Nyy0HQpPybWyZQSxZCuW54ua42mT++DsObEjaZUxjK9kET6TtwR1jKIHsooYy1DU/+Jj
         xUj+/VNvvPWl5nM0TgqCRoV3HtD9AHwAAmQAGeumHBivOqwwGrqE/IeFKZkIn3rowls1
         jMgJTxuoOACKQ7E6LZVuXBV5acZr0jOoE/7FC3CHsOfWBuoXWQojn+5oOlRsD+vK9fCj
         KGYA==
X-Forwarded-Encrypted: i=1; AHgh+Rpdfmv/b9eobXJ5gt2kJl6D8Zg6g4IXesETA43KGlGBJb5CEXx2L5fOkEAptgHeGe+sznP8jQLngtJCfNmi@vger.kernel.org
X-Gm-Message-State: AOJu0YzQyt8Njs8sH1RrIf+6ur55hSFcQCEzxkwCYyhBnr977kNkYcMQ
	69nr+PVXBuPbubbmjGWBESEeRkoCAUUYvlD+FACMIXYNc0J4j3371zUgL70MjVyDkpBxG7dKcQf
	EHNqj+CLLYomsKD/0QR8Lip6r1RZnisc=
X-Gm-Gg: AR+sD116cp8VPBQ/+/v89xqOnRY6IBy7kecy82URgYRFesMzZFxiy5/KiuihbZFXOkR
	QhgmKbAdFX+JCaql5lmfLTMBmMbTHAK48/k31gGqx4xZ1LxqJRVI42DWUtCoNuGV6OLSFeMb+Hh
	5qJp3aHuTtmE4N9XnGEZ9dqQF4gaU8dL7Tydu7T3Qxle0+86VKvw8j56Nzuj/JAlq4Ib/6uemUb
	MbBl2VwGwvrSstuv/f7HmG4Z8sggQYRZJBmOGKb8KrPKxKPfRultlj0gaAPRg==
X-Received: by 2002:a05:6512:3b83:b0:5b2:8dc6:3ec4 with SMTP id
 2adb3069b0e04-5b2c1a3c6b2mr1330725e87.18.1785130691401; Sun, 26 Jul 2026
 22:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725042421.109599-1-wonju345@naver.com>
In-Reply-To: <20260725042421.109599-1-wonju345@naver.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 27 Jul 2026 14:37:59 +0900
X-Gm-Features: AUfX_mzC4nFA67R4p9_r6e9Jgh1Zg0QT4PD6NzKIBUrex7Ed3jd6rOiOodb6guQ
Message-ID: <CANFS6bbReuJMapSmtQSY+jASmY_di+X28rMFQuYtscBwjCie8g@mail.gmail.com>
Subject: Re: [BUG] ntfs: data race on ni->mrec between resident read path and
 MFT record mutation
To: Hyeontae Lee <wonju345@naver.com>
Cc: linkinjeon@kernel.org, zzzccc427@gmail.com, baijiaju1990@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyeontae,

Thank you for the detailed report.

I will take a closer look at this issue.

2026=EB=85=84 7=EC=9B=94 25=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 1:24, H=
yeontae Lee <wonju345@naver.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi,
>
> KCSAN reports a data race in fs/ntfs on base_ni->mrec between the residen=
t
> read path, which does not take ni->mrec_lock, and MFT record mutation whi=
ch
> does. Reproduced on mainline 7.2-rc4
> (48a5a7ab8d6ab7090564339e039c421f315de912).
>
> This is close to
>
>   https://lore.kernel.org/all/20260626014706.2840003-1-zzzccc427@gmail.co=
m/
>   [PATCH] ntfs: serialize read iomap lookup with mrec_lock
>
> but that patch targets a slab-use-after-free on base_ni->attr_list and
> guards its locking with NInoAttrList(base_ni). The race here is on ni->mr=
ec
> itself and reproduces on a 16-byte resident file that has no $ATTRIBUTE_L=
IST
> at all, so neither that guard nor the per-inode attr_list rwsem discussed=
 as
> its replacement would cover it.
>
> The read path reaches the MFT record buffer via
>
>   ntfs_read_iomap_begin_resident() -> ntfs_attr_lookup() -> ntfs_attr_fin=
d()
>
> map_mft_record() only does atomic_inc(&ni->count) and does not take
> ni->mrec_lock, so ntfs_attr_find() walks the record - reading each
> attribute's ->length to advance the pointer - with no serialization again=
st
> a writer that holds mrec_lock and memmove()s the same buffer.
>
> In fs/ntfs/iomap.c, all 15 occurrences of mrec_lock are in the write path=
s;
> the read paths have none. The resident write path in particular holds it
> from __ntfs_write_iomap_begin() through ntfs_write_iomap_end_resident(),
> i.e. across the whole iomap operation, for the same IOMAP_INLINE pointer
> into ni->mrec that the read path sets up without any lock.
>
> The non-resident read path does take down_write(&ni->runlist.lock) around
> ntfs_attr_vcn_to_rl(), but that protects ni->runlist.rl, not ni->mrec.
> ntfs_attr_record_resize(), ntfs_attr_record_rm(), ntfs_make_room_for_attr=
(),
> ntfs_resident_attr_record_add() and fs/ntfs/namei.c never take runlist.lo=
ck,
> so those two paths hold disjoint locks.
>
> KCSAN on 7.2-rc4 produced 40 reports in about one second, with three
> different writers reached from both link() and unlink():
>
> BUG: KCSAN: data-race in ntfs_attr_find / ntfs_attr_record_resize
>
> write to 0xffff888100af1018 of 4 bytes by task 96 on cpu 1:
>  ntfs_attr_record_resize+0xd2/0x130
>  ntfs_attr_record_rm+0xad/0x530
>  ntfs_delete+0x224/0x640
>  ntfs_unlink+0x14d/0x280
>  vfs_unlink+0x157/0x520
>  filename_unlinkat+0x1d9/0x350
>  __x64_sys_unlink+0x2f/0x50
>  x64_sys_call+0x1d43/0x1fb0
>  do_syscall_64+0xed/0x450
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888100af1018 of 4 bytes by task 95 on cpu 0:
>  ntfs_attr_find+0x104/0x5b0
>  ntfs_attr_lookup+0x39c/0x10c0
>  ntfs_read_iomap_begin_resident+0xc6/0x230
>  ntfs_read_iomap_begin+0x5d/0xa0
>  iomap_iter+0x2e2/0x6e0
>  iomap_read_folio+0x147/0x2a0
>  ntfs_read_folio+0x108/0x170
>  filemap_read_folio+0x35/0x100
>  filemap_fault+0x993/0x1000
>  __do_fault+0x65/0x110
>  __handle_mm_fault+0xc06/0x1590
>  handle_mm_fault+0x126/0x2e0
>  do_user_addr_fault+0x173/0x680
>  exc_page_fault+0x63/0x130
>  asm_exc_page_fault+0x26/0x30
>
> value changed: 0x00000250 -> 0x000001f0
>
> BUG: KCSAN: data-race in ntfs_attr_find / ntfs_make_room_for_attr
>
> write to 0xffff888100af1018 of 4 bytes by task 96 on cpu 1:
>  ntfs_make_room_for_attr+0xaa/0xf0
>  ntfs_resident_attr_record_add+0xd7/0x460
>  ntfs_attr_add+0x3a7/0x850
>  __ntfs_link+0x471/0x730
>  ntfs_link+0x148/0x260
>  vfs_link+0x23f/0x590
>  filename_linkat+0x20e/0x350
>  __x64_sys_link+0x58/0x80
>  x64_sys_call+0x10ca/0x1fb0
>  do_syscall_64+0xed/0x450
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888100af1018 of 4 bytes by task 95 on cpu 0:
>  ntfs_attr_find+0x104/0x5b0
>  ntfs_attr_lookup+0x39c/0x10c0
>  ntfs_read_iomap_begin_resident+0xc6/0x230
>  [ ... same reader stack as above ... ]
>
> value changed: 0x000001f0 -> 0x00000250
>
> BUG: KCSAN: data-race in ntfs_attr_find / ntfs_resident_attr_record_add
>
> write to 0xffff888100af10e4 of 4 bytes by task 96 on cpu 1:
>  ntfs_resident_attr_record_add+0x10b/0x460
>  ntfs_attr_add+0x3a7/0x850
>  __ntfs_link+0x471/0x730
>  ntfs_link+0x148/0x260
>  vfs_link+0x23f/0x590
>  filename_linkat+0x20e/0x350
>  __x64_sys_link+0x58/0x80
>  x64_sys_call+0x10ca/0x1fb0
>  do_syscall_64+0xed/0x450
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888100af10e4 of 4 bytes by task 95 on cpu 0:
>  ntfs_attr_find+0x186/0x5b0
>  ntfs_attr_lookup+0x39c/0x10c0
>  ntfs_read_iomap_begin_resident+0xc6/0x230
>  [ ... same reader stack as above ... ]
>
> value changed: 0x00000068 -> 0x00000060
>
> Reports were also produced with reads originating inside
> ntfs_attr_value_is_valid() (offsets +0x20, +0x32, +0x106, +0x122), so the
> bounds check that would otherwise contain a torn offset is itself reading
> concurrently-modified fields. These 14 were reported as "race at unknown
> origin" - KCSAN observed the value change but did not capture the writing
> stack - so I am citing them as evidence that the validator reads the same
> unlocked buffer, not as matched pairs.
>
> Observed transitions on the raced length/offset fields include
> 0x00000010 -> 0x80040001, 0x00000028 -> 0x00040600 and
> 0x00000050 -> 0x01000000 (3, 3 and 1 occurrences respectively). The recor=
d
> is about 1 KB. CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY was set, so these ar=
e
> observed changes rather than merely concurrent access.
>
> It is also visible without KCSAN. On a freshly created mkntfs image that =
is
> not corrupt, the driver logs attribute corruption while the race runs:
>
>   ntfs: (device loop0): ntfs_attr_find(): mft 0x40, type 0x80 is corrupt.
>         Run chkdsk.
>   ntfs: (device loop0): ntfs_attr_value_is_valid(): Corrupt 0x80 attribut=
e
>         in MFT record 64
>
> Reproducer:
>
>   # mkntfs -F -Q ntfs.img
>   # mount -t ntfs -o loop ntfs.img /mnt
>   # printf 'AAAAAAAAAAAAAAAA' > /mnt/f
>   # gcc -O2 -o race race.c -lpthread
>   # ./race /mnt/f /mnt/l 30
>
> Adding or removing the extra $FILE_NAME attribute resizes the record, and
> the attributes after it - including the $DATA attribute the reader is
> walking to - are memmove()d.
>
> ---8<---
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sched.h>
> #include <pthread.h>
> #include <sys/mman.h>
>
> static const char *path_f, *path_l;
> static volatile int stop;
>
> static void pin(int cpu)
> {
>     cpu_set_t s;
>
>     CPU_ZERO(&s);
>     CPU_SET(cpu, &s);
>     sched_setaffinity(0, sizeof(s), &s);
> }
>
> /*
>  * Fault the resident $DATA in, then evict the folio so that the next
>  * iteration re-enters ntfs_read_folio() -> ntfs_read_iomap_begin_residen=
t().
>  * MADV_DONTNEED is not enough here: it only tears down the PTE and leave=
s
>  * the folio cached, so filemap_fault() just re-maps it and the read path=
 is
>  * never re-entered.
>  */
> static void *reader(void *unused)
> {
>     pin(0);
>     while (!stop) {
>         int fd =3D open(path_f, O_RDONLY);
>         char *m;
>
>         if (fd < 0)
>             continue;
>         m =3D mmap(NULL, 4096, PROT_READ, MAP_SHARED, fd, 0);
>         if (m !=3D MAP_FAILED) {
>             volatile char c =3D *(volatile char *)m;
>
>             (void)c;
>             munmap(m, 4096);
>         }
>         posix_fadvise(fd, 0, 0, POSIX_FADV_DONTNEED);
>         close(fd);
>     }
>     return NULL;
> }
>
> static void *writer(void *unused)
> {
>     pin(1);
>     while (!stop) {
>         link(path_f, path_l);
>         unlink(path_l);
>     }
>     return NULL;
> }
>
> int main(int argc, char **argv)
> {
>     pthread_t r, w;
>
>     if (argc < 3) {
>         fprintf(stderr, "usage: %s <file> <linkpath> [seconds]\n",
>             argv[0]);
>         return 1;
>     }
>     path_f =3D argv[1];
>     path_l =3D argv[2];
>     unlink(path_l);
>
>     pthread_create(&r, NULL, reader, NULL);
>     pthread_create(&w, NULL, writer, NULL);
>     sleep(argc > 3 ? atoi(argv[3]) : 30);
>     stop =3D 1;
>     pthread_join(r, NULL);
>     pthread_join(w, NULL);
>     return 0;
> }
> ---8<---
>
> I did not observe an out-of-bounds access under KASAN. The full dmesg wit=
h
> all 40 reports is available if it would be useful.
>
> Given the above, protecting attr_list alone would leave this case open. I=
t
> may be worth deciding whether ni->mrec needs its own serialization on the
> read side, mirroring what the write path already does. I have the reprodu=
cer
> and a KCSAN build set up, so I am happy to test a candidate fix against i=
t.
>
> The asymmetry is present in b041ca562526 itself (0 mrec_lock in the read
> paths, 17 in the write paths), so it dates from v7.1.
>
> Test environment:
>   Kernel:  7.2-rc4 (48a5a7ab8d6ab7090564339e039c421f315de912)
>   Config:  x86_64_defconfig + CONFIG_NTFS_FS=3Dy + CONFIG_KCSAN=3Dy (non-=
strict),
>            KCSAN_SKIP_WATCH=3D500, KCSAN_UDELAY_TASK=3D200,
>            KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dy
>   Guest:   QEMU/KVM, 4 vCPU
>   Volume:  64 MB image, mkntfs -F -Q, mounted -t ntfs -o loop
>
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Reported-by: Hyeontae Lee <wonju345@naver.com>
>
> Thanks,
> Hyeontae Lee



--=20
Thanks,
Hyunchul
