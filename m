Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469C432572F
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 05:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785560481; cv=none; b=n8MpE5P1vuDqCIEXOGXGSP4/jSmJI3n/srUgHZ4Y6oVtF8wV+3ZI2t7VifAueL6oo2oGxycyRRpTiTSfrIc5m95bpVVQmFrtLEzqjdhZ9pfEtvUKdi2h986p3GJWVCLEDKfjSy/lmoskHL5qXHNphIUGbxwpvatUZ6qjvo4IGyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785560481; c=relaxed/simple;
	bh=Mj7OCN/CqugKHviMxyCCSxtzDCQmT0E1Lm6McMTRgns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGmgn41ahwiCLVZxjTwkDrgvbc/CzGn8namYHT1H3C+6axI93SeOibvCAheJcITApVpodj21rahfJFzFpPcx/DysyXBYbeeYUAXLVfndtkVYqTeBdS20gswSrIUH8vhJHSTEHb5vsgiCKXjibBpvp5X+qgCtOjG8zoblsM1xhe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=labXcmKF; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="labXcmKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1785560469; bh=SjGhzSP+TxiJZz3xQCI946KoIrb+IXfUmZLW2rjZskA=;
	h=From:Message-ID:From;
	b=labXcmKFkZsDSuxMutHi9IWBlPb8KQoa1Q+e2K5TWYP6ahp/6TliXZlyswQYaOKud
	 mfvLbMHZWhG+EPaPdTGETwm+GSFFy3Y2LUteDmgrhayW6gG3NQ7qb8INQmjtL4lq8S
	 ZWqo97i7nQ/5n8sBNNbjdHcck4NPZihCQaQeoLWE=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id AAD66C0D37;
	Sat, 01 Aug 2026 07:01:09 +0200 (CEST)
Date: Sat, 1 Aug 2026 07:01:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: Research & Development <research@zerotracelab.com>
Cc: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, security@kernel.org
Subject: Re: adfs: stack buffer overflow in adfs_fplus_getnext() (F+
 big-directory)
Message-ID: <am19lUpuDSEFGp13@1wt.eu>
References: <CAGpo96PO4DPJJZtRj9vnR-ZzcWwv=oHyfM7i2Ug+A_CjR3z4+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGpo96PO4DPJJZtRj9vnR-ZzcWwv=oHyfM7i2Ug+A_CjR3z4+A@mail.gmail.com>

Hello!

First, thanks for your report. A few comments below.

On Fri, Jul 31, 2026 at 10:15:33PM -0400, Research & Development wrote:
> Hi Security Team,
> 
> I am reporting a security vulnerability in the ADFS filesystem driver
> (fs/adfs/dir_fplus.c), which is maintained under the FILESYSTEMS (VFS)
> entry. It is unfixed in mainline (v7.2-rc5) and, as far as I can tell, in
> all supported stable branches. I am reporting privately per documentation
> process. A tested reproducer and a tested one-line fix are included below.
> I am happy to coordinate and would like a CVE assigned once a fix is
> applied.

Note that the documented process says that there's no need to Cc security@
when sending to a public list (that linux-fsdevel is).

> 1. AFFECTED VERSION RANGE
> -------------------------
> Present since the 2020 ADFS big-directory rework (~v5.6);
> fs/adfs/dir_fplus.c
> was last touched on 2020-01-25 (587065d) and is unchanged since.
> 
>   Vulnerable, reproduced:      v7.0.1
>   Vulnerable, code-identical:  mainline v7.2-rc5
>   Affected:                    v5.6 -> v7.2-rc5
> (5.10/5.15/6.1/6.6/6.12/6.18/7.0/7.1/7.2-rc)
> 
> I verified the vulnerable sequence is byte-for-byte identical in current
> mainline (adfs_fplus_getnext() + adfs_fplus_validate_header()).
> CONFIG_ADFS_FS is shipped as a module on typical distros (confirmed:
> adfs.ko present under /lib/modules on a 6.18 kernel).
> 
> 
> 2. DESCRIPTION
> --------------
> adfs_fplus_getnext() (fs/adfs/dir_fplus.c) reads the per-entry name length
> field bigdirobnamelen (an unvalidated __le32, struct adfs_bigdirentry) and
> uses it directly as the copy length into struct object_info.name, which is
> char[ADFS_MAX_NAME_LEN] = char[260] (fs/adfs/adfs.h). struct object_info is
> held on the caller's stack -- adfs_fplus_iterate() declares it locally
> (dir_fplus.c:212); adfs_lookup() uses the same on-stack pattern
> (dir.c:434). adfs_fplus_validate_header() checks only AGGREGATE sizes
> (directory name length, total names area, entries*stride); it never bounds
> the per-entry bigdirobnamelen. adfs_dir_copyfrom() bounds the source only
> against dir->nr_buffers, never against the destination.
> 
> Therefore a crafted ADFS F+ image whose entry has bigdirobnamelen > 260
> overflows obj->name on the kernel stack. The path is reached when the
> directory is enumerated (readdir/getdents64) or an entry is looked up, on a
> mounted image.

Is there an fsck tool for ADFS, and if so, does it detect this modification ?
As per the documented threat model, most file systems trust images and rely
on fsck to check them before mounting, and in this case, such bugs are not
handled as security issues but just regular bugs..

(...)
> 5. PROPOSED FIX (inline tested patch, applies cleanly on v7.2-rc5)
> -------------------------------------------------------------------
> Bound bigdirobnamelen against the destination buffer before the copy. This
> stops both the KASAN overflow and the RIP-control variant (a
> bigdirobnamelen of 512 or 388 is rejected with -EIO before the copy). I can
> add a second change to adfs_fplus_validate_header() to validate per-entry
> name pointers up front if preferred.
> 
> [PATCH] adfs: bound big-directory entry name length in adfs_fplus_getnext()
> 
> Bound bigdirobnamelen against ADFS_MAX_NAME_LEN before the copy.
> 
> ---
>  fs/adfs/dir_fplus.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
> --- a/fs/adfs/dir_fplus.c
> +++ b/fs/adfs/dir_fplus.c
> @@ -192,6 +192,8 @@
>   obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
>   obj->attr     = le32_to_cpu(bde.bigdirattr);
>   obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
> + if (obj->name_len > ADFS_MAX_NAME_LEN)
> + return -EIO;
> 
>   offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
>   offset += le32_to_cpu(bde.bigdirobnameptr);
> ----

Could you please resend this patch in a format that allows it to be
applied ? This way if maintainers accept it, it would save a round
trip, and you'd be credited for resolving this bug. From, Fixes,
and Signed-off-by are needed. Just produce it via git-format-patch,
as explained in Documentation/process/submitting-patches.rst. Also
be careful, your email client replaced tabs with spaces above. You
will need to check Documentation/process/email-clients.rst to see
how to fix this.

> I'd be grateful if you could confirm receipt and on request a CVE via
> cve@kernel.org once the fix is in a stable tree. I will not discuss this
> publicly or with linux-distros until a fix is accepted.

Ah, then maybe linux-fsdevel was not intended then :-)

  https://lore.kernel.org/linux-fsdevel/CAGpo96PO4DPJJZtRj9vnR-ZzcWwv=oHyfM7i2Ug+A_CjR3z4+A@mail.gmail.com/

No worries, for this one it was the right thing to do anyway.

Thanks,
Willy
