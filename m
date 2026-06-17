Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1A3F6C2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781704631; cv=pass; b=l5kpwBf0/37i/M+vsAnlbK7HoRoPKGEC5M4U+dvbQOJOqqJqP3FLWJ3E7p3LyyJDEtkS6dTjw0XGRtGi3+Xk7FDnjAsKJmRBXfwk9KUpq/wdoIkYVyVn1O2Ztpr//glQ0t2EmWqyyNFzF+gI9mlLCUAmlneYzx0eFu+J25fIgeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781704631; c=relaxed/simple;
	bh=dE5QCB49gSg1E/RqRTQMAXzDMVbNpSI9Wu25lRSuKrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQNZp2J/K3+h/zXRa+Ewy/dqB4X63v/7+uMDxbbAEYBh8c/daL9lmG7/+O/IW9/9FReqJRafrgKtu9XDjAcl/tNyqHB6EjscBj7PrE42Xmk0PDuAm+WwMBrg9KpX9XW1tP6IP0T9K1WQQz5HPtzT0qRO7FmLeRAELZf+UYh1Zdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUelxZlk; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUelxZlk"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so11282828a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 06:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781704629; cv=none;
        d=google.com; s=arc-20240605;
        b=OO1QYcvc5A4B/zp8ziDpLmvxqLFO415cqDZVNX0UwdjTn11wEuVc9dP6L8VEdgcT82
         O6UPl5C6GJ1MDGFCrup2HjhoRL2MFjPk5CGlgCEFzYkaULlPGtx1z0ShejgJsVhuw3eh
         1F8SfL4hHAQQdfvMV3/pfQiTaN3S8opzLeeOWvtX3TfN6K2fFclGrBJJ8BZiG8NSUZDN
         8va8qxZeFnjlRcyvSVxK0DeYpJZkACi1DANFT+Wff3PUIXJNR7OLiqRvAUoFOmSDJ9n2
         YAFWtb9BwGCapBCC0HOxr40Syi9JUXWLx9xvYg4sl4YyFglTwqELYcZknBDxHtd7COQm
         RzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+wp0SeU5SONpnRADKEmw1FslXvGN/FM0f3dCvuAH5VU=;
        fh=j+4cwR1HH58gYl6ag2dpu0N1NeemJDgOM8GtFsS7KwY=;
        b=JnneesX0My1ubU18AdQEpB4cVEzfLPAR9knFodo5/gqnXy88Yz/+JOp2TAhvC1U+3F
         NDaFr0TZCJyxlcdlpm04tXMvPxw+FpXDBqKtgrxByHy5NmUHiuycimzhSdf+iskkyPAb
         92sMCV466ZSFppw+bEZVJxy3VbnogJabz3xf2DED+vKiFLiHiZMh679fh/xyB1LwQEvJ
         eQOozquqJ6pGk43BJ2UK0B+dtNam986rjuAObtzj95s2BxBVupfyRUBQk38F6OWcDZKE
         k2UXUbmhaLuLHYrMsocuOEONgUGacEdFaCMPlYW05SBe5rtAXjBp9C///FC+mZ9Qz34r
         xhaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781704629; x=1782309429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wp0SeU5SONpnRADKEmw1FslXvGN/FM0f3dCvuAH5VU=;
        b=kUelxZlkwIHbfz5fnhT976luhMbfUekPLZOAEFTci1N8RM2ZW71hOvNJ9CVzugTqVZ
         6C+GlEhDYA16Xq3byQpwCMcXCPwpm1aNRoADRrFPvXW8uvEfOsG8cQnoUWJzcWQEZlL9
         g/Ni7HUJ/PSQUyB/Htpc/1kCCNi888W15VAFrIaDz/N2BL7Y+5zY0puqN7awKX2jZ6xl
         j2Ee3OVS9O0WlpA3WuZ7JrQ1uB6YCdNVHixDDy8jYOJu8mwc/PZ9LDu8lAEwHQmuNzP3
         fx6+yyW+wlk1/hiCNByCjiWyTfpKDO5LRXwu1wTArC3LjVFvQ7ifYc7S13cgcSZ1CwFO
         anzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781704629; x=1782309429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+wp0SeU5SONpnRADKEmw1FslXvGN/FM0f3dCvuAH5VU=;
        b=Z6o6WHrW49TUedyI/Nt0myFymPLIx7OleqidBb6FDZ28UYTLxwfwTih4yDvRP+shZ4
         DitwjIHGdj7tktCfITJr6cwwlOsECZPAvk3QAyFpzZdAq8QQZqUPWZ27H5aFrbWkUQPO
         cdvgt7KmLUaqnr4QGESZBpRUdvGI+4aDrrGooXMRvLES4fPU2Mto787UM8WWAGTzdUC0
         /BMD2TYxC/8L+8yhBQX75gQ8BTmul4S9zPWeLAonOaLygfRTB9FBW8cxAfcvGXasmSTd
         /A+iA2a+QVVmjpIsHJ+5MHWYkJZk6Dx/BWBTV5dTqjXvWYQxOvjf9OtKcTotjdwQ3r8n
         wUtA==
X-Forwarded-Encrypted: i=1; AFNElJ8qpPD7IZRQKFMohvbckavbn1cnFRNceBwaqZqwO+k9pASbMsNrq37O3H9rCJU81hph4FagkmEgYs6+FtwE@vger.kernel.org
X-Gm-Message-State: AOJu0YxPS/IdRwBCKnGihkkH/sizjLclCSt0TxugoVsT+X3OdDfJdx2e
	l6qKsFNKWJg955fZFS8QK6rCl/uQswl0GdseSvezI3Oh+sTMSmFmcsciMvYvBzvvn1etts1N9Y1
	gPeK2tmskjb+dVB9jpnREBl23A5AiKOY=
X-Gm-Gg: AfdE7ckpVLoTybm75NyCEvoXaTQjL6PTlohGOU8fii5sk5Zj0fyzvQ8uh1fvXZoL6lk
	CY0JWU/XRlZo5ePq/Werp8YSJslTJ4OJA4E9wVKYGVpQKE/OJEmrhwbwUOI/x1sXRztjKn7OqJm
	zDn9v7XsYz7UYuUQhhNZ3q5mZr8Tx+D4dI15V6mJo/iZOKXvQqVnIR0rP+P/aAiq4n6QNtGLVFc
	KobBrONEOCaTOkUi6zQ6Fqp6thvJrlkt3MYr79HFMsYhQUW68LEj5ofgJ1DvVyCiYnLXVsUWrd3
	OU/4Km8h78xwR/6ERXXyGwGtQ0ID+dA=
X-Received: by 2002:a05:6402:43c6:b0:691:6fc9:da9b with SMTP id
 4fb4d7f45d1cf-695476f12f9mr2346333a12.23.1781704628533; Wed, 17 Jun 2026
 06:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615-work-idmapped-overlayfs-v1-0-7381632aa402@kernel.org>
In-Reply-To: <20260615-work-idmapped-overlayfs-v1-0-7381632aa402@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 17 Jun 2026 15:56:57 +0200
X-Gm-Features: AVVi8Cc91CYxE7YUj4wWZdM6y9_jyZ_C5AaQRG7SM4wSoRtc5uIGg_0FUc1ceTc
Message-ID: <CAOQ4uxin8B4SbPjnNL-hUWX4EP3V=8jCO=ENt8SQ2D7wcCsdLg@mail.gmail.com>
Subject: Re: [PATCH 00/10] ovl: support idmapped overlay mounts
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 3:20=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I've been asked about this feature multiple times and had actually
> implemented it right when I did the initial idmapped layer support.
> So here's a new version of this series.
>
> This series lets the merged overlayfs mount itself be idmapped via
> mount_setattr(MOUNT_ATTR_IDMAP), in addition to the already supported
> idmapped lower and upper layers.  It allows the same overlay tree to
> be exposed under a different ownership view, e.g. a container seeing
> the merged tree as 0:0 regardless of the on-disk or per-layer ids.
>
> Overlayfs already normalizes every underlying id through the relevant
> layer idmap when it copies attributes into the overlay inode
> (ovl_copyattr()), so the overlay inode's i_{u,g}id are "overlay-final"
> ids.  The overlay mount idmap O composes on top of that pivot:
>
>     caller view  <--O-->  overlay-final id  <--layer idmap-->  on-disk
>
> O is applied at the overlay-inode boundary only - permission, getattr,
> setattr, the ACL owner checks and inode_init_owner() - while the
> underlying layers keep being accessed with the mounter's credentials
> through their own, possibly idmapped, mounts.  The mount idmap thus
> only changes how the caller sees the overlay inode and never widens
> the mounter's access to the layers: the second, mounter-credential
> check in ovl_permission() against the real inode stays on the layer
> idmap.
>
> Most paths need no change because the VFS applies O to the overlay
> inode before overlayfs runs (sticky/rename/unlink/create gating) or
> after it returns at the syscall boundary (the POSIX ACL get/set
> translation).  Overlayfs only acts where it bypasses the generic path:
> getattr (it stats the real path), the setattr forward to the upper
> (the requested id is rebased from O into overlay-final space before
> being handed down), inode_init_owner() on create/tmpfile, and its own
> owner checks in ovl_set_acl().
>
> FS_ALLOW_IDMAP is set last, once every operation honors O, so there is
> no bisection point where the mount is idmappable but an operation
> still ignores the idmapping.
>
> Note that fstests will be broken by this temporarily as they rely on the
> ability to create whiteouts for unprivileged device node creation. That
> can be adjusted.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---

Apart from the minor comments on the test, the entire series looks good to =
me,
so you may add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

The problem is that my review can only assert that your changes make sense.

I am not even close to being able to prove that this is risk free.

This is the first time that we will have a combination of
FS_ALLOW_IDMAP | FS_USERNS_MOUNT with fs which is a proxy to
another fs, which to me sounds like Vulnerability Scanners heaven.

Could we maybe ask our friends in Anthropic to unleash Claude Mythos
on this work to try to beat the AI kiddies to it before we merge this work?

Sorry for my lack of faith in human kind ;)

Amir.
