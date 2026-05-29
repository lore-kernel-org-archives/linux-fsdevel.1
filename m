Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D2233921
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780066552; cv=pass; b=UFnrbHrhqPz7C77VK5ljUO3/qGkfHNRwkuxDJxA4BBvNZroCYvj4NUM+qc/eQDgWl2+zN92UJ43kQcTDWNbHWyMA+gWOa+Zs2tkpDqckWlX6uWSORkGeZXll56Kp81UKRULotlzqx5EVJP17hF7k9ePvs8C/KOgASysvqi2LWuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780066552; c=relaxed/simple;
	bh=LwJOnMXOw6081AX2/qRcsTPErxa/34W6EGMtFB2ROnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XH5XB640VaDJvnNxjYavNdAgOLan1vEtrQCUdxlwaNv6JgGeXQpoR/X+FJYJ8D+0JhOYq6YuPusWJx7fNc4WkLEq80/Mca+RFbBPU9v3FrrhV7DeTW6dbPz9TlbLOfIcAU5wPVFRiI9AAfScsVoJABI5Y+DPAb7kFnL4Fkruor8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G31QUE6E; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G31QUE6E"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-671f1a0d0c5so204a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 07:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780066549; cv=none;
        d=google.com; s=arc-20240605;
        b=hnQjAD+ik8ShzLWQ3EIxyDibOj0zwCUEyG3AMeGKf+uQgnc458DZqV2hyVyqy5r+hd
         xxgomjqtyPie3OkiYzeJ/CbGuVDIznXsHTYwGDtlC1OIs9A2cT6J+Sb325hjiHEKhxIW
         A99BDq2PXvoM+iZ4RYn+dOrd1KahCp2CDAq/t49Aa1s/oTCby3+KzzVJXIH0VvsyoWLF
         iLTC+YuwDIx5VMINOqleKrz5CRKn41NVsKcdIFF8fzdEcldx6/n1Ov2R2c5Z4aQ15syp
         658iwETyLZRtv8RLFH+kPttbklpeLMBpjOOI6iCyDNxZWDQ096ERNPF66J/0O+UpVVMV
         cenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v0NQbiwUs18ppXLU+jeyodzQjlwqR5G0Z1wemEqLfuw=;
        fh=+/WjqGOODrJjRWEFHLCYnr7yJLLuUBSws8YhyjZh+N8=;
        b=AGHcYDNwqFaoX8zsBnMVU8RdUZrGtWb/y+yzyIKBFMAEc5rRDssm7MDc8XwMuJV79B
         OfNk2nGp8dDJ96XcyYGH/W3+x6xacCTQtHpin8UNdKcg72eEahI4m1T/ymi8yKhz/Aqb
         uKEzyDQYvu+bKtFvNPqILcr0TDy+I/nSbrxVr7dNgbxKC5MwNTXncFHNfDOzJOEyVC1V
         6SCYbmyeQ3zSmVmBxdVVK2m52Pp079IjYZmm9KgobUQLd7ev+xlg9sCWz7CFXOeT+DGK
         6IfpfaEZIr/EHsSi1+30BthUcCv90z40PZqBZ3al0ScB7sfnJvF2R9827vN6Y60gMOeF
         Df8g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780066549; x=1780671349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0NQbiwUs18ppXLU+jeyodzQjlwqR5G0Z1wemEqLfuw=;
        b=G31QUE6EtzN4Kon/9+jOvgHGXQM4ilz88jq1v6eD5E53IbKtY9kA3yUejtHlKCxPBJ
         c9V4u3cP/hJJj1LqTLQeqs5CGGLknqCOZVd6Rwr7OM/Vr7WUHdpn6aE+ORSd6AbQ4vWT
         dJc2lfPubsc8t3h9TR0TVfMvsDp0HzxAAH8AgwJxLSpwal6hDqnc9nbT+bhEnRb+2grq
         RwyBdv7ClwZa1cwZvtOjwBL+1r+xKN3sTRTzAZP05svOSVhxnhq6YU3p6Xxre9kqCyQw
         bZ6zuiM9ALHQUdHrZoJyaN4ofJ7he0n8PriRt/ar/n+JrQYyaUKvw5jXoAXC6CSteiCT
         T8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780066549; x=1780671349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v0NQbiwUs18ppXLU+jeyodzQjlwqR5G0Z1wemEqLfuw=;
        b=mHGNcPbCL1eNJZBNkuGRHEoJ8oglR6E/279mta8vx8NmPkMX5nounev31MyDp9Sqbh
         OOWL8cfIqY2UQSKfWCCnLojumFnWkGPKIpulIn7DyRIJz0grbe8/Xp8KqBZ6naw99BRe
         h3ketD3eFMbcUGxx0mzwd65Is0x6m6xw7PdQUPBqQ/sGldgR69rCt3GweIKWteMWbfyf
         uB6jb6LCn+jG8Tpajj/12QQkcUagDn4H5gGv64nTv2D3ew2QnmPa32mjkzGwN1fZ7bvB
         KvTEB6U7+GLinHmV6NW4gR9yix8OeyAY9dQF9tNN+3igDksVW7p/vg0UaGJTBBihOFDF
         MWgg==
X-Gm-Message-State: AOJu0YwhGqBhAEFc7qtyOhSECrWGSiDEkTcu0Fb9gmCVlozIX91P16Tt
	lcql2wPdDp+GfLRz9gi3Xif2/FmuJ0L3BsEIeJ7G4whMvXYP7riHf6XHOEM1QqeDATc7+ubNwiS
	V655yJwV/PbEASqQnekBgmbN+NGN2NdNdhAsj/Q1t7xcspo83CEP8pkuZ
X-Gm-Gg: Acq92OFaohLqXCa85UroI8brLn8Zdca/Y4cDt/RGmSkQX78Zbyh4DWznBONSiFihq1p
	7fITMR74Z1Lg6bs1g8FMfwPpAdlb73QliX4dG9MBqTzQa6Pt3Y1rhsK1Utff4AxOcIvbMCP2rHf
	qtCwP0th6LqOJdztE+4JDD6pzx1UKgrQKEmp8r5eAHBPXNSMJ6TfzWPTsn0WTf7Cxg7DMiRSbtz
	fti9muobCAYfch3xJ4khp2Zi8G9WQ2PAfYK5xtg8bWqC5n6SoIWjjJ6w61Lw6VYAy+zzgV9Rdjh
	BPxHZink/erdtU0eigh/QFW7YFl619zarL4tIawER3AX+zE=
X-Received: by 2002:aa7:c989:0:b0:68a:7046:e64 with SMTP id
 4fb4d7f45d1cf-68c16347f25mr38871a12.3.1780066548782; Fri, 29 May 2026
 07:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org> <20260311-work-kthread-nullfs-v3-26-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-26-3dd2cbe92ad0@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 29 May 2026 16:55:12 +0200
X-Gm-Features: AVHnY4JPftso9nO08E6XXE3kBylHk0XbZE0x7sDGtn0bJWnN3iIsyuWGqxOj9YM
Message-ID: <CAG48ez2-V62qga0ma7Se1RhH1Hr0RubmFfWK3HV20T76QB6rjA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 26/26] fs: stop rewriting paths for PF_EXITING | PF_DUMPCORE
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 10:57=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> If the task is dead or dumping core stop messing with its fs struct.
> There's no point in doing that. Worst case it'll be stuck in a stale
> path until it calls exit_fs().
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/fs_struct.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/fs_struct.c b/fs/fs_struct.c
> index 2a98cfbedd32..34699f3b6f88 100644
> --- a/fs/fs_struct.c
> +++ b/fs/fs_struct.c
> @@ -61,8 +61,7 @@ void chroot_fs_refs(const struct path *old_root, const =
struct path *new_root)
>
>         read_lock(&tasklist_lock);
>         for_each_process_thread(g, p) {
> -               /* leave kthreads alone */
> -               if (p->flags & PF_KTHREAD)
> +               if (p->flags & (PF_KTHREAD | PF_EXITING | PF_DUMPCORE))
>                         continue;

If an exiting/dumping task still refers to the old root, that could
prevent unmounting the old root, right? In the case of umount2(...,
MNT_DETACH), it would just delay destroying the old rootfs until the
exiting/dumping task is gone (which hopefully won't take long); in the
case of umount(...), it could cause an error, though I don't know if
anything would do that - I guess that'd be very brittle, and the
pivot_root.2 manpage suggests MNT_DETACH. And pivot_root isn't really
a syscall one would use when anything is concurrently running in the
mount namespace, so this probably shouldn't matter in practice...

So I think this change is probably fine, but I wouldn't say that there
is entirely no point in updating exiting/dumping tasks.
