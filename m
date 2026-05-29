Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FA376A08
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090706; cv=pass; b=gpXdvv2FenycZ5a03zzxvJuthCNw1vMlLZHQhs+hcHHzj+V9BCpd23kmGSWw6NBrDvV3pisuJl2h1e4vCCjJPFld6UwU43adx1hcwvWvm1eOIjISrJ4c37VqBmOdJzoPCfbJsgD+VqRLFcsa7HQNJdMqdloI7/ITxPjABh69jV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090706; c=relaxed/simple;
	bh=8ZmyDBgWyn0w1p7LMue51akVQhiMgzd0DRPW3vstQhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj0k8HrkDWK0bBKnGjoCnq+rviabDVKQMXrdXuzQ1xqRVFq/HQAmfNDuttjpURTpHgxIJ5F015/BtXSWS9qe66eei2T1Noo6S0fuh1egzZGBo5d587VTeztNzASMqQlSZQaRkbNFhyFQDtF+uokVttJy7eE+4TC2d3ihrbgOxr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2khV0LH; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2khV0LH"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68b73f1a8ebso3261575a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 14:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780090704; cv=none;
        d=google.com; s=arc-20240605;
        b=bmqvQvKxeUhlIUbjPD5c4BY7UsOLxzoRpzWejMc64XXO8RGGHYiKFwvS7lDfWjOB/s
         hMByGqVi4nvoCIx+Rd12JYqVKgAV8Pi3b1N5Za7CinH0/a2v0TYGkSnj6EBLgsGWXqpa
         VfSFU0dJJSh9DZuMoXAzgrCn96EtrLcRR4NLBRJTfswzx2vQvDlyzl4CUdfwnzwSc6d6
         biERV/nrwLZKcBfAe9fPOQZVlYaIDvv2PLrUIZPAa8+Yaa43p3vde3vdxdBtvLI0EmoD
         Tkh3EVeF8UivMQPPL3QszOEXDPU7m6tjYeJMSjdX6HPei7bc2MIbLv5TDfhCDzAd+ZP6
         qpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DbBtnQB2xzOUBn9v78yWFAqjuautwv1sgcJptcZKuyQ=;
        fh=3u7Ql+gUin0X2HQicBBJhPXhzgD2pvpwBiC1VH+/YQI=;
        b=IbFym8MJSvSBZE3NNBqiVh8n8313zE5B6PIfx1cwbGJ/Zk7EdsDEOllFQ2l9rvGXyB
         67hmz0eHhNisnSof3eW2i9Zx+ArhbWOcNJB4GQUE2qZsA1sNK4TmXGnT38AAck02kdVm
         y1u6Ctq9M3QoMw9mxoG5X6J0gGhJD9wtW+uy0OIitUQoWxR1E7sUFgUQibiUnfuk5jPF
         Y72XGlJ3iReXTmIqo9TlWHbakS3KX76lhPy/XLV8s6mO27TlsBhQUAyZSqMDEtFpjkgn
         yaGs9hzt5P3xdaT8MFw6/Bd56vHSbWljcpTiTIM868Rd+rGjsT3Mj4XZEaiMtHv3C3GB
         3XgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780090704; x=1780695504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbBtnQB2xzOUBn9v78yWFAqjuautwv1sgcJptcZKuyQ=;
        b=o2khV0LHjLPL8flsSk+GOQCiBAVjckJgYK5nF9E8pfG38BoWmZOZzy2McCTbsrzij8
         BppYdBuVZCJ9UuCxAc89v1q3ZsR4VwMOzFdw6J5x6qKHpnOMmQ69sp5g/OsXQREMp8Ao
         NJi41dxHDdnTga5PE8y4fWdkDPwO9ycLoLVSZBRXVJq/vZUH5Um8njycKYRhBWtDGt3y
         NlOAXVQGu0MR4YK6XJ5KWeqIbZtD6n7qgN/PE+uL8nQaJzh3fuHwbwGk3olnmJaT8VJX
         3TZ/I8nVicZjGtQzRKo04Wlbfy7S14a09cMkPJaKw9E/gLkrp8Pi5pov454Tr34V3MAM
         X+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780090704; x=1780695504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DbBtnQB2xzOUBn9v78yWFAqjuautwv1sgcJptcZKuyQ=;
        b=aJGzGXb6xbOBPPEa7PY73x+V5QNyePbYO9Kz3HEV+4vei97C444x5nuuwxq6NjlSs/
         I0UaBmR3OM8tCjxmunH0UjlJukSY38JgUCG1bgtK/ecjLMvHCHxzyH4weYeo2NWYEYY7
         cDmRWMPmy9W9afKUaaLnA7w7EHS7ZJOCDjtEiQCLv4Fv2tFIoYiwh8Rl21gQpOX0v/W8
         FC4OaZ1K0xgcEUkqhg1YFL1HsLV5pEbm5hb0549s/Pb3EYEU7y3ac8mvS1tbBxJbj4YR
         QIXx2czrA6rYQUIu9dGAy24iuJCHZ8D1htkVMWGQy8o2HYuOidxoiAANPq9+gPUxwges
         SgYg==
X-Forwarded-Encrypted: i=1; AFNElJ/itUekEbDaUwg7YDb7KOyCZxdKjjlhiG2vlMtuv5JGgynJluD903Fu8NycVtCN9M5zr6CzhEWG76FoeFPp@vger.kernel.org
X-Gm-Message-State: AOJu0YzbArk+gbsEyj0+gahE18a3ZnxXjeVIfRKKFHKNHcFPFaTzO7ii
	UHdAaap9ajzO81zcEZ3LSRn0TF+ZDyFuvZyd7zC+7kBhWPC9I1LeQupl3+RL9/2cqMPkVckFzYg
	apSPOTPn6WEPHZnF0U8hETJ1MQLoyV78=
X-Gm-Gg: Acq92OGzNioutja1DSAA4IiUH8Fx63UxcT/Ne1G3yHrnxni3gndXkMMnQr4YU6k/xWx
	wPFBSgRvrdw2fxfEU198J+BkLgj/DItYKJb283QlgXwC3IWufLD/iEQyNydD/aBcVOBEFDVujgS
	kakpeAMQLMf9Ql014b5FsPTl6ApbYvpLdwirwPeuREG84lDeWHQOod+snYzMZUpx1GoFXWcPt/W
	17fg9moNgNTTde9RGMv5Knd8XgWcVc/TQ9j+VqTgdnPHZuNIirCXaT/lNXuhCC4UA7gNEACn2C/
	CrZ1soJiV+K8My4QhKY+UtRVcGc0NlDcEtrsByTAy3x3LCyYJevC
X-Received: by 2002:a05:6402:2421:b0:689:816a:5367 with SMTP id
 4fb4d7f45d1cf-68c8651d431mr852723a12.0.1780090703463; Fri, 29 May 2026
 14:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-fan-mark-cwd-v1-1-cdfb3b5b6d7c@google.com>
In-Reply-To: <20260529-fan-mark-cwd-v1-1-cdfb3b5b6d7c@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 May 2026 23:38:11 +0200
X-Gm-Features: AVHnY4JFsXcZubiMQSUmo9QsFAAHHbp9HPon2aKRoIHyShz9SrjY_eo4bSTU74A
Message-ID: <CAOQ4uxiHU5xK=_FsOBkkB0go9ACBb2fYcdVE6T2o=MYDcxaiaQ@mail.gmail.com>
Subject: Re: [PATCH] man/man2/fanotify_mark.2: AT_FDCWD plus NULL path doesn't work
To: Jann Horn <jannh@google.com>
Cc: Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>, 
	linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 7:27=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> The fanotify_mark.2 manpage claims that AT_FDCWD works with a NULL path,
> but there is no kernel code for that - in fanotify_find_path(), in the
> `if (filename =3D=3D NULL)` block, the fd is only used for a normal FD
> lookup.
>
> This was also already the case when this manpage was written back in
> 2014, so remove the bogus documentation.
>
> Fixes: c200b422d ("fanotify_mark.2: New page documenting fanotify_mark(2)=
")
> Signed-off-by: Jann Horn <jannh@google.com>

Hah,  never noticed this.
Apparently, hallucinations already existed in 2014 :D

Acked-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  man/man2/fanotify_mark.2 | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/man/man2/fanotify_mark.2 b/man/man2/fanotify_mark.2
> index e561ffd21..a3b77537c 100644
> --- a/man/man2/fanotify_mark.2
> +++ b/man/man2/fanotify_mark.2
> @@ -560,14 +560,6 @@ defines the filesystem object to be marked.
>  .IP \[bu]
>  If
>  .I path
> -is NULL, and
> -.I dirfd
> -takes the special value
> -.BR AT_FDCWD ,
> -the current working directory is to be marked.
> -.IP \[bu]
> -If
> -.I path
>  is absolute, it defines the filesystem object to be marked, and
>  .I dirfd
>  is ignored.
>
> ---
> base-commit: 9db8ca91f920b9aba40ed68de6b8da0ca9dbefaa
> change-id: 20260529-fan-mark-cwd-1c760106eff9
>
> Best regards,
> --
> Jann Horn <jannh@google.com>
>
