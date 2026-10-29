Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.171.160.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269323;
	b=qz1WlhLJnAsIqLpaOrH9a/ty7Gz7YVpzQhYdMW6qnukXqAYZeycMGmYAK8iyrVfv8+G5
	 zj60IOtAOS10WSFSxiYmqi9Bhy0ASsFWkYy17iv0NldfbbD9a3GVQaIoq//J6FQh1B1go
	 iWqFfS4X2kpW4/RHWw2oaakWDtp7cVF90mRT4YJSQ+P/fhHOXKTJUXFJb+WrmQrhmbCQ2
	 kcuXbMdfCay858pg7JyXjrRCeIfp12Qa1ja+pJac1YEtHQlDRjbOEuID2XtDF/PE82dGW
	 ZoGmffiIUOauXnIbxgv6iFoF7U4sHBOhy5PMZCIiMnA7wq4BcA20QwF+zMnSoFxq/JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269323;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=pIuIcfSKYBHqvo9P0Kpzpjm7WrFeoaXoEKcNhmaQ5Dc=;
	b=kUZXOCd+lzthubh+FW+I/daxBcgsarmi2eLyMjbPJXrjB2UGV9PMoDZrwnFfcZFkP4Yp
	 wicudD0Nrg8iVhIsGBsjRSLp+rVYqLSZG5kAKUDdu08twPav6hOFPe/8/loxFblMo6Zib
	 9FfmwC2O6TU9hHFkW6L53iDi+iuujChPr7BoaL+J1Wu8tBhwuMW/TTRPN4dS8VPE8AURn
	 aj4sqzh4uHIMQzC2KL60guFK3NMoLCfaI6yN/y6fAz1YpmHaGIfioeiA9M/w4DlNzzRR0
	 U0LIEOl2JF9gbaw9yuw3geWCD3m3SkZ4wbyc10HkRfJjD0yBDA+VRRSnToVmkqCBKRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.parknet.co.jp;
	spf=pass smtp.mailfrom=parknet.co.jp;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=qQYFkUkc;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=Ksuu9GTJ;
	arc=none smtp.remote-ip=210.171.160.6
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3A5606A31C;
	Thu, 29 Oct 2026 10:22:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=parknet.co.jp header.i=@parknet.co.jp header.a=rsa-sha256 header.s=20250114 header.b=qQYFkUkc;
	dkim=pass header.d=parknet.co.jp header.i=@parknet.co.jp header.a=ed25519-sha256 header.s=20250114-ed25519 header.b=Ksuu9GTJ
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id C132C209655A;
	Thu, 29 Oct 2026 19:21:59 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1793269320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pIuIcfSKYBHqvo9P0Kpzpjm7WrFeoaXoEKcNhmaQ5Dc=;
	b=qQYFkUkcoulJlnhefgR4Rhb9D+MLw43VSJZsRzprPfDarNy9bupe41BLey/bsFu8qvWSPl
	bBif++6wlamPuyRxZShuWv+ELfcaIgVj+7PH4tItPFQAHftdayoPI02l8/lWp1IZNZu8sg
	7/eBw+qWFckFv4hV1licv4Tu5ZxA3xmTg/UW2rRLXN9yzb5CWhOfLPJ3vCFmSThcsJ4qCk
	R/jm1Aw7svXVSyUVmJcGuZvUTr+jQWgVTm0VyQDwxA82cebgfmOWCQ9B4DdeKZAXY9NbbN
	jHzW3PLbdJMELPLr81b/1LFjAAJ2HT5w0bwvVc8Fwv+zWAU8GUtgU31UHHQyTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1793269320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pIuIcfSKYBHqvo9P0Kpzpjm7WrFeoaXoEKcNhmaQ5Dc=;
	b=Ksuu9GTJ7hAsQwoEeb2z/TRuCmzFlwSjtaa3XdnV+Eg5aKm3UCJNia/DtohP0jXSgEsKck
	04ANWUeB3iId/NCA==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 4C16AE0077A;
	Thu, 29 Oct 2026 19:21:59 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 448D022001F3; Thu, 29 Oct 2026 19:21:59 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: shaos <shawnq1@163.com>, brauner@kernel.org,  aliamemis@disroot.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nls: fix ISO-8859-14 case folding
In-Reply-To: <20261029091443.3531919-1-shawnq1@163.com>
References: <20261029091443.3531919-1-shawnq1@163.com>
Date: Thu, 29 Oct 2026 19:21:59 +0900
Message-ID: <877bj0eri0.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

shaos <shawnq1@163.com> writes:

> Hello,
>
> The ISO-8859-14 charset2lower table maps byte 0xa4 (U+010A) to 0xab,
> the lowercase byte for U+1E0A. VFAT uses this table for its default
> case-insensitive lookup, so a lookup for the distinct, absent byte
> 0xa4 can open a file displayed by readdir() as 0xa6.
>
> The PoC mounts a small VFAT image with iocharset=iso8859-14 and
> uni_xlate=1, creates only :1e0a, and then looks up byte 0xa4. On the
> unmodified kernel, readdir() lists 0xa6 while stat(0xa4) succeeds and
> returns the created file. Remounting with check=s makes 0xa4 return
> ENOENT. The issue is in charset2lower[] and is independent of the
> page01/page1e conversion-table fix in 8e17b922aff0.
>
> git tree:       upstream torvalds/linux master
> source version: Linux 7.3.0-17714-gc339f4010dea
> architecture:   x86-64
> compiler:       gcc 11.4.0, GNU ld 2.38
> QEMU:           6.2.0
>
> console output:
> https://gist.githubusercontent.com/shaos26/4115e33780bb1ea2a0e042aa6e6588da/raw/9dfb43bd1f99e1d9138cf8147fe29eb0f131978b/console-output.txt
> kernel config:
> https://gist.githubusercontent.com/shaos26/4115e33780bb1ea2a0e042aa6e6588da/raw/7481bf507133c8dcb3549ed04ef4abe8de69cd48/kernel-config.txt
> reproducer:
> https://gist.githubusercontent.com/shaos26/4115e33780bb1ea2a0e042aa6e6588da/raw/54bd8643014abaaa49a24cbc7ff8c93329dd62b6/poc.c
>
> Build the kernel from HEAD with the attached config, then build the
> PoC and initramfs:
>
>     mkdir -p build rootfs/dev rootfs/mnt rootfs/proc rootfs/sys
>     cp kernel-config.txt build/.config
>     make O=build olddefconfig
>     make O=build -j"$(nproc)" bzImage
>     gcc -O2 -static -Wall -Wextra -o reproducer poc.c
>     cp reproducer rootfs/init
>     (cd rootfs && find . -print0 | cpio --null -o -H newc | \
>         gzip -9n) > initramfs.cpio.gz
>     truncate -s 32M fat.img
>     mkfs.vfat -F 16 fat.img
>
> Run the guest with:
>
>     timeout 120s qemu-system-x86_64 -machine q35 \
>         -accel tcg,thread=multi -cpu max -smp 1 -m 2048 \
>         -kernel build/arch/x86/boot/bzImage \
>         -initrd initramfs.cpio.gz \
>         -append "console=ttyS0 rdinit=/init" \
>         -drive file=fat.img,format=raw,if=virtio,snapshot=on \
>         -display none -serial stdio -monitor none -no-reboot
>
> The same PoC prints RESULT: VULNERABLE on the original tree and
> RESULT: FIXED after the change below. In both cases, the check=s control
> returns ENOENT for 0xa4 while byte 0xa6 remains accessible. Mounting
> VFAT requires the privilege needed to mount a filesystem. This report
> demonstrates filename lookup confusion, not privilege escalation or
> memory corruption.
>
> Link: https://lore.kernel.org/20260909121032.76647-1-aliamemis@disroot.org
> Signed-off-by: shaos <shawnq1@163.com>

Looks like the bug of this table.

Acked-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

> ---
>
> Validation: Fresh QEMU runs on unmodified c339f401 and on the patched
> kernel, both with one vCPU and the same configuration, printed
> RESULT: VULNERABLE and RESULT: FIXED respectively.
> scripts/checkpatch.pl --no-tree --strict reports no errors or warnings,
> and git apply --check succeeds.
>
> diff --git a/fs/nls/nls_iso8859-14.c b/fs/nls/nls_iso8859-14.c
> index 60b9400f915af..c9bc4e0d30603 100644
> --- a/fs/nls/nls_iso8859-14.c
> +++ b/fs/nls/nls_iso8859-14.c
> @@ -240,7 +240,7 @@ static const unsigned char charset2lower[256] = {
>  	0x88, 0x89, 0x8a, 0x8b, 0x8c, 0x8d, 0x8e, 0x8f, /* 0x88-0x8f */
>  	0x90, 0x91, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, /* 0x90-0x97 */
>  	0x98, 0x99, 0x9a, 0x9b, 0x9c, 0x9d, 0x9e, 0x9f, /* 0x98-0x9f */
> -	0xa0, 0xa2, 0xa2, 0xa3, 0xab, 0xab, 0xab, 0xa7, /* 0xa0-0xa7 */
> +	0xa0, 0xa2, 0xa2, 0xa3, 0xa5, 0xa5, 0xab, 0xa7, /* 0xa0-0xa7 */
>  	0xb8, 0xa9, 0xba, 0xab, 0xbc, 0xad, 0xae, 0xff, /* 0xa8-0xaf */
>  	0xb1, 0xb1, 0xb3, 0xb3, 0xb5, 0xb5, 0xb6, 0xb9, /* 0xb0-0xb7 */
>  	0xb8, 0xb9, 0xba, 0xbf, 0xbc, 0xbe, 0xbe, 0xbf, /* 0xb8-0xbf */
> Thanks,
>
> shaos
>

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
