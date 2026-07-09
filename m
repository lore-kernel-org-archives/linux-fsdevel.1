Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F73438038
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617651; cv=pass; b=Et1jiSGSHVT6kLWlYMnc7+NGWWs0hITF3wolOdnwG7pXUPPgU5P2AoDPv3kpC9i+pUQtjW+dVnZy7umxgMF5QnoGfTO6ltx+lEipbqyBTmn8/JsVIzgVEIe0V6ZgcFdV7Vp/NrKTxOoDw3KFUDsPM2gybTBa0E71r1/iQVVxnbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617651; c=relaxed/simple;
	bh=hZEcX9rblnHI1tsJplsNee/jZEe49yUqRXD5BZMzDas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iObnZWH0D1ERCOYa6069pTWcaLBHeYRl1uERupl0lpowwLLs1IOxO38czXtQqzU/CGXHURI1qWUR1ckdldyyWyBmFSRgnwLXxApZEoIz+0Wucv2Ccopde/Fo/jt8WUOrtB5M1FOQW3UbxjyUV7JICmsvvFVllq+dS0tqECB/0mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGO/Yqow; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGO/Yqow"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2b2c9eccso70821cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 10:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783617646; cv=none;
        d=google.com; s=arc-20260327;
        b=oFUv/7LitGPYs2ZEU9viGCVx51DPhl7XgPN0nKggD8pFTtW4DjOXKFquE21g47+MSl
         1B4h78WEh4r2exaPYsyBeNcgWy5YGFC4wpjiUzvNvSpicVpCSpYtWTAWNtNSDbfIgAqm
         Xh+BNl05hDz4ZiWL0HEJXGRlpmUGA42EeHKLclPkxBrCy2EvyEzVELq/pjgmCeALNWCk
         keh5N0dTvnOlK3wM/qenJ43SCg872GXQwiYbS2/MbPc/rBmRi772eWHEK7BA5WPDpFzd
         OQcFCdA2KTSHg/w11kGZgH14khJIysNcRb1K97RankjQJttiBmhYHjaVmwpjwTyBM/DB
         6yrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jQaRVb2grf2n8MZJwInN/ZiH3PD15ePDY6cdHPu1aO4=;
        fh=yH5tSxLXxN0Rv3Ins+LOOMWAnXK/WMtbiuu16/prZro=;
        b=KuDaCczmOnn0149CcKMK0N4+Athn667MaYsoWvh3ysrNa21uPGsBg2o8DqB9Yu85+2
         DyrURCrqr+1VCAwUxLWZvSIq8cabpmoJfsvFgAdmjGZ9Yg85dUV5nX1Vb3r8aQKZMXgG
         Yl7YXSeZncZUcTOOdGLFclLLJCIcez/erbOyVtnYcQ8itb19mZ43ROsEHexTp6Bs68D8
         5jblYdqSz7vDTKQD6it7JzFwNFyDc+4YqnG2+CFgG9imrudtmWqBU8IfCaJOb1/0Z9dR
         ngvvkIl21fkXCxnOcz2E1vlaWGNbyx3KwZnQoi80eNzM9rONYo4Bx9Eso+2P/sjb85zx
         8+tQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783617646; x=1784222446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jQaRVb2grf2n8MZJwInN/ZiH3PD15ePDY6cdHPu1aO4=;
        b=hGO/Yqowmf+zfdOA3xkz0XnaQv9IVvY9bBvb7K1wrmz0BAb/00wVT4hLSJC3bD5xbt
         Zsgx7+nenuQdcPjghInQFPPlsC74wZsB4fW6ONEp7hKspjxomUpw6gJvzo4FEvmJ7zpA
         NVY4eXkDMcxvEVJLVNkBT44ZtLwzhGIbYrZ8TsWrfWzzO53Uf0TqyLeVYcaOL+yOJAmp
         vXacGI2LsJZkh2R2yhDc524gDPx1TOENsP5QltEcPL1O4tlHJYxqR9WhzMdIdnXQ2W8C
         p5CpAaQLsAE/rpkm5Z2Ih9nIsTnY1b3HNQJdk/XZCeD1JzePWnuEVH3XsW2ifmZM+Kxy
         xAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783617646; x=1784222446;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQaRVb2grf2n8MZJwInN/ZiH3PD15ePDY6cdHPu1aO4=;
        b=n4CX0rCUMNBMfJ+bSzqKI7iRDsYGLnH4x+i14RviUC0I5mkVzh09ioH8OAMSlLO3c6
         aQLUvedwmyISuPWgXqx7QtWD4L11M1SX/yYdlYnfsJ1RSjG5lmdTDNFqHWqSOKnE3G01
         iTCrV5C71WndH7+yvY81KdaVMrw89b2vD3CV/J0qayUzHxdnOR1mYmSkWp/rUdnwzvnk
         1L8RnNnqy8r2R3Yvy4hgKiFWjgnbsNsjOoIpN9ncPgs3cv7bcUVJT5go9K3uUiO2M1LX
         ojVDxeYCqKu37WRlAHzAl1zkdO3fGBpOZ43wl3E7QujG2XmO9euETk5RvNEr7RXVjCRQ
         ZU/g==
X-Forwarded-Encrypted: i=1; AHgh+Rq5jnUQq1sNiMqHO9W0U1JnI0CG0BddRmLgG2+gTgfUgXZZjHbWAR+NccY2Fw5Y9ie8YTlHRNsqT0GaQJqH@vger.kernel.org
X-Gm-Message-State: AOJu0YzRvdY+uN+qzmE2HL0WdHR0zQj6VV7mt5TOTooBXuyZQdnhJN9h
	7Kn+XXwhLjHijoyJIcKRx1OiRGeJw4dkSwccBk4ObFnREb+iTW6ygc6kKes6XXhtDjDHFywt07K
	MiKKp8qaGrW2x9TBkQN3leqbfK6b/UAgaLOiGs/U=
X-Gm-Gg: AfdE7cl5DHZSLuh2Pb7avh9BNx89sAJjl+w6AatEOIN4Hv+tsyrZQNC6TfgVlIOP+S+
	nyAMKLI3BWdEFfIYz29HRbmSO1H+ToDeUS1NMbW+rO4weizKhn0GgSEdmc6ceOTOdBH+IP8rd4w
	biN98xnqiGufH/VTU9MHUMTNV/K73XF2vdgsrc+aHctB3bNdaYfigId5M50In3SuOK2/4tOuRpk
	Qgy7XAV6n1pIVNYBhiFE1+SJcSA12ZV7tZpLd3XZgG+Wf3P6FSrKtFmSNbh+B782ue3AjCOuagK
	1ZA898BxjgllHQYFZHSMHxjyXcyDNm9dV4SJb30xRsiM3n8K9Cs8DQMoPFYjQystKcyer6lVn6A
	5Leqr9jJAkPDGsYZgR2u7E51m8M67+zhf6mWS85dknSSh46ixoADcHC1bwk/tBZ8iu8tM57V2AX
	9X07Bdtmb4Smg=
X-Received: by 2002:a05:622a:5812:b0:51c:241f:a6ee with SMTP id
 d75a77b69052e-51c8b3f5885mr82413791cf.62.1783617645460; Thu, 09 Jul 2026
 10:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709155440.2132459-3-doebel@amazon.de>
In-Reply-To: <20260709155440.2132459-3-doebel@amazon.de>
From: Steve French <smfrench@gmail.com>
Date: Thu, 9 Jul 2026 12:20:33 -0500
X-Gm-Features: AUfX_mxl_KFuVChnk7HcmXkZiK3KIvyhwjAH-myKz4uegSqaarxusCibAKEfqT4
Message-ID: <CAH2r5msvEGdEJvyV5sWcZjQ0SjMOwXP_Ad4eKN7etHtXS1vwbA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: set SB_I_NODEV to prevent device node injection
To: Bjoern Doebel <doebel@amazon.de>
Cc: Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, nmanthey@amazon.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Setting SB_I_NODEV is apparently not done for any remote filesystems,
and AI search confirmed that it probably isn't a good idea to set it
for remote fs.  It is more of a thing in pseudofilesystems and not
needed for network filesystems.

e.g.

"Is there any benefit to setting SB_I_NODEV?

Today, probably not.If you grep the kernel, you'll find SB_I_NODEV is
used in only a handful of places, and those places generally involve
pseudo-filesystems or internal VFS assumptions rather than remote
storage.  Setting it on CIFS or NFS is unlikely to change behavior,
because those filesystems have worked correctly for decades without
it. Most remote filesystems don't set s_iflags because almost none of
the SB_I_* flags are intended as generic filesystem capability flags.
They're mostly internal VFS state, and SB_I_NODEV in particular has a
very specific purpose.  SB_I_NODEV does not mean "this filesystem
contains no device nodes." It means something closer to:  This
superblock is not associated with a block device.
or more precisely: The VFS should not expect a backing struct
block_device for this superblock."

Has something changed?  How did this question about SB_I_NODEV come up?

On Thu, Jul 9, 2026 at 11:05=E2=80=AFAM Bjoern Doebel <doebel@amazon.de> wr=
ote:
>
> From: Norbert Manthey <nmanthey@amazon.de>
>
> Set SB_I_NODEV on the superblock by default for CIFS mounts. This is
> consistent with how other filesystems handle untrusted remote content
> and prevents the server side from injecting device nodes on the client.
>
> Fixes: 2e4564b31b645 ("smb3: add support for stat of WSL reparse points f=
or special file types")
> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
> Assisted-by: Kiro:claude-opus-4.6
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/cifsfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index ea4fc0fa68cac..35eee2f9899d5 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -208,6 +208,9 @@ cifs_read_super(struct super_block *sb)
>         if (sbflags & CIFS_MOUNT_POSIXACL)
>                 sb->s_flags |=3D SB_POSIXACL;
>
> +       /* Prevent device node opens from remote filesystem by default */
> +       sb->s_iflags |=3D SB_I_NODEV;
> +
>         if (tcon->snapshot_time)
>                 sb->s_flags |=3D SB_RDONLY;
>
> --
> 2.50.1
>
>


--=20
Thanks,

Steve
