Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754480;
	b=PnuIXPbPQ3fDUJTAbYvMcrB0Ix8BX+XUUGDTuQuM3SsC2LW8GTN8cpVsWoOnSJ4cS7+9
	 /nGH9EhYikijK/ooVsSuZy/6HO6Nro8vAXpueqGRmr81dCUJITJASbPLZCgFPLBEIuuVK
	 4b1VI8qF8BYT4qqkcoZmA8v3Qjrm4pTkuAKRVyAe2QUixaJsKR+YC9kLZR0JcCdyFveYU
	 jgFS03TT/rMbOOuZ2NIbTYJ5sA28m8c5oaaBy9cGzqtex1WtsierKFf5AieszzVecFCs5
	 IRQqnx5B+cXylH5pv6TqCVNjjvX0rx+uuHvYCkQIjzBsv1YEn9tNAUfhf/KLW1/iXjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
	b=UmKAB8PZL+WStQeAd+gS3R82/Zg2oXrZCfn01qx5exNuWPNckRGPLr76dQD6geYzEd1b
	 pW8LlQJu82ZvzET/XJZPlnzW5xTIZROo3kobrMSndkyeu4tmBGMJs0u6V6y9yLg6pcn+S
	 IO236YRi4TYqTArmkApVpSEggG9dEaop5P7u76jdxnMeKt9rwG0yWpRC1yFJOVjwHYfxv
	 rA4OdMUFhILJIJ8qCjRkx28OsTqltssTtILP/BvAMrh8aIRt8p2ujNYjUGTAjlGOxHUbq
	 OqkSua5jE0xlu+CxpBsN2qzK9uPX7wcDPkbvLbVsEgOquaINBbHp4zgRa6hWZN3grrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B5606A329
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 14:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 346B5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nene7tW5
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so3813158a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 06:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754478; cv=none;
        d=google.com; s=arc-20260327;
        b=kxULn7eMy5mw+NNzS2LMw1tz6+qEkQxNHI7lVh0jVc8ffA6wS7zBR2kG+lNF490Aw7
         w2oKmeIPhHzm7BQTlwSH8xGa7DDHVPQUM24/DaDl+dgMuVNBqa1eN1ewob3AfcHs1Y7+
         1ZQrF6OVTnBeSiJf16NZ1lvUR61UjhSvkdswgMtHQjqtAl9VM+AUcYerM9Gn4HlMSB0K
         lhPhG1v5r1HzJnl65+puKjT5L3KBozrV9zEivzclH3EAT0ezppxgeLoSItUHDGgZ/6zy
         lIGcPiXbt7lvs3qs7Hnug/gUSr1yNdBJnevymtFJzaof7/WjUo+itSRZUq4/0kN5bYXY
         Qc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        fh=gUjxs2I3pnMLEEJgJeG3aAWG5yUQjMyd794UC0ZHTuc=;
        b=DKs9t1jvGXsp3Hq1pmIU6CTNADMTBt2a/8fvUGzsi294/DsfH2Oo8yA++kOC8e1tgr
         vJSlbnwRgDFmtk7s6eQG4cGXvfxCFdCZztXutCQD7pWQ1teu6E4MfEEci8ZU+MZh0WS/
         9RbwHGcqKRhJ15pJDzu/BNPfzx6QA82GrTRKaiSFcFkAd6WKp9EiVqqAESUxVeS3DLJp
         QcOCK7kUwg6J4OcAB5gTGgetFiIgapQBSa4xve7J12AAd9m3oyNQ+tW9uXPhNGE1121p
         hPEnbJ8R2QiEQ95KyP1+kTuIr8XtEQx+UOQvs6NkGc47Gh9ZorIOfoZJOSVM1MRMOpQB
         AkzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754478; x=1795359278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=Nene7tW5gi/n28xM9GPcsrsbApaftwN+5VLijlNSUx682MtoFHHSTEvDl1z11fpu1X
         HvQApdaPQrGfQyiS3FbYQVWjhD4Evwt6P0rS5BC7bOQTZVXFLWaPO4OPsg6ddRko0o+q
         9oJBo3AXuMJZvhtMaEl5yxlnDv3/Y+/ZTOoPRzC8SnU76nRTNG9VsBQOFmcVN+eTzILI
         pLq9xeN6fA01RGoB9NuHnqix3fuxZlQryfHYntRw18u5V1gyWgLisGhonGsU8L2T6Lkf
         J6bkZRN93M/WAUT22qxzPXNMWojuGB568xJ5NJFT1QuthxcS4hfC3ctLRiOXitSCJ+gM
         bTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754478; x=1795359278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oqISismNDREzK3BapMQL3oVfFqMKLBzQ11G0pwa4rCw=;
        b=GiYemCv/2geUAgve4utAtCsQ5W6dtL6Pr1B/anTbFY3APZfQPDFNMJ2pn25lYfBeCw
         WKT68uiNriQggIUCRSlwH8IFXodnkX6j7bmche13kWUiwbti7HZe0cqTUewiynMSZcor
         JXFZnK/bKhWvHh4uj3o+zZWJrqsXF9Hw4T99TVe6RfV4b5daFrlPzxIaqOuA7qyD2iRD
         8FLCezMr+t0ZAB3SBmD/t4xPwmrl62aCz2HaiX+yaR8D0/4lonf0tkauhQOPlCiriRm6
         DW33GVhkNpO+rsl/OJLmKf66JfF9lDpfq7aSycxgvN/28ba2kKEGE/20IWtUHhwY6hXz
         XKwQ==
X-Gm-Message-State: APuU4Z/OENF8hsX0d0Oz9T03g0yuWDJeYgaZlIFENeuL47FPKDH+Xczm
	JAxTPAzFCHCoSlp/6+/Mrb2AVxBpTNn+czP02YxoImsumb6Oh93xQnnSErEawllTYRFIGMKwTvl
	at72i8NahQ2qbrOwH6q8QE7wBwXPo5VM=
X-Gm-Gg: AYBFou3I4gQq4dXs3S+p4R6XMaUlyWRgHL47iCyYe5EwGRalX7OJ22hAEwTbUniVu70
	+wETvneOPrISPJ4kT8iCz0slNw2nWhmr+A4K4mAfi6pCPNtq++TAhMq8nhP8wsG96k1V2jlPBYU
	7nirTSl3JOsPGBHJ9hbG10HDi4c4HI7WEwLxuaA1BP4S23WjWfgTcioAsajHnrFg3hfGrLSbNEt
	5YsIxexVO5fCTsIw5mnulug8IEBhOOv7FKMlk0PR1U8NClcAHA7nJqKyTtgQ86KwY4Y0V6r/0TK
	3KSD+Hvk10hc0vOXrzs96vPtpLi66N9F0erbAj2rzIWCn6+8/z6DmLNuV+t5/W+1S2k2dCCPE2h
	xzlnDmK93QwhUGGf28tVEnUXPFOfIYObfUagqa1NMzLc5eAJHqNiwIovd5wualHobiPrC0g==
X-Received: by 2002:aa7:d1ca:0:b0:6b1:c2cd:db0c with SMTP id
 4fb4d7f45d1cf-6b7c0957c1emr4306146a12.10.1794754478075; Sun, 15 Nov 2026
 06:54:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-1-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:54:26 +0100
X-Gm-Features: AclHuK8KXHVL-duO-F-YZ8XPwW63n9hxew9z3khJWwo4KtxA0bTnHEz-HW4OPxU
Message-ID: <CAOQ4uxhkqQE+ONrcgJNw2Jah59bKruxUAsLohTtKnsgTVQBw-A@mail.gmail.com>
Subject: Re: [PATCH 01/13] ovl: don't warn when the lazy lowerdata lookup
 fails in ovl_d_real()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> ovl_d_real() looks up the data of a metacopy file in a data-only layer
> itself if nothing has done that yet. If that lookup fails it WARN()s and
> returns the overlayfs dentry.
>
> Commit 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in
> data-only layers") assumed that the file would be read before
> trace_uprobe places a uprobe on it so the data would be there already.
>
> But nothing actually guarantees that. trace_uprobe takes the path from
> kern_path() and calls d_real_inode() on it when the event is created and
> again when it is enabled. So a uprobe on a metacopy file whose redirect
> points at nothing warns twice:
>
>   ovl_d_real(/f, 0): real dentry not found
>   WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210, CPU#2: sh/27=
9
>   Call Trace:
>    <TASK>
>    __trace_uprobe_create+0x1869/0x25b0
>    trace_probe_create+0xcc/0xe0
>    dyn_event_create+0x46/0x70
>    create_or_delete_trace_uprobe+0x3c/0x70
>    trace_parse_run_command+0x1a6/0x320
>    vfs_write+0x1cd/0xfa0
>    ksys_write+0x116/0x250
>    do_syscall_64+0x10e/0x5e0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> bpf's uprobe_multi does the same.
>
> A failed lookup isn't a bug though. The data can be missing, its verity
> digest can be wrong or a signal can interrupt the wait for the inode
> lock. ovl_open() simply fails in that case and
> ovl_maybe_lookup_lowerdata() already warns ratelimited about failed
> lookups. So return the overlayfs dentry without warning. That's what the
> WARN() path returned anyway.
>
> Fixes: 42dd69ae1af4 ("ovl: implement lazy lookup of lowerdata in data-onl=
y layers")
> Fixes: 184996e92e86 ("ovl: Validate verity xattr when resolving lowerdata=
")

Nit: 42dd69ae1af4 came first and opened the possibility of goto bug
and then 184996e92e86 came later and depends on 42dd69ae1af4.
I don't really see the benefit from stable POV to name the later as Fixes

> Cc: stable@vger.kernel.org # v6.5+
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/sashiko-outbox-214581@kernel.org
> Reported-by: Chris Down <chris@chrisdown.name>
> Closes: https://lore.kernel.org/all/20261114120557.4bc1eb6e57218cdc@chris=
down.name
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/super.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 08695a99f4f93..1985b553a47b7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -58,15 +58,13 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>
>         /*
>          * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry.  The only current caller of d_real(=
) with
> -        * D_REAL_DATA is d_real_inode() from trace_uprobe and this calle=
r is
> -        * likely going to be followed reading from the file, before plac=
ing
> -        * uprobes on offset within the file, so lowerdata should be avai=
lable
> -        * when setting the uprobe.
> +        * the real lowerdata dentry. Callers may ask for files that were=
 never
> +        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> +        * here. Return the overlayfs dentry then.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               goto bug;
> +               return dentry;
>         lower =3D ovl_dentry_lowerdata(dentry);
>         if (!lower)
>                 goto bug;
>
> --
> 2.53.0
>
