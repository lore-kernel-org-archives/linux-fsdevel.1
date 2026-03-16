Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262F3195EA
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683796; cv=pass; b=gBYTVHf+VAGlqhscwUZJatVFv/iRzdSh+f7GJdVSipAYKbFHAcqNzhwyu51vkCUMZ+mRV/kR3Hp6bOQTQgyrvaMCRCj1mdC+hsJ4xAu0/OAG/1VuTjLNBrGlwYWU5K2swyZZ3OKhP/Ouq1Tw1Q1FCmft1pc/IiMBdPbqon8KXQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683796; c=relaxed/simple;
	bh=I1vbAzFZtc0KG+gZfLVD1SzRI7ZL+EQR3nZxbZkmL9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpQSdpyaXk+IL0Ul1nkDZ/KHJvm4TvZPo6mOZ+bT8DdJc7o1LLkIWuJM1IkPIx9J5st9lNE7DKu2NECIh4x1rTvHOuGHSr77ninXtVppyjdKz9fCtrU66QSDk/PPmxw1c3k3A5N2ja2Cuy0exaf7WprkOnwcrqHdJ0el2Gg6EV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbqNu+T5; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbqNu+T5"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so1477536f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 10:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773683793; cv=none;
        d=google.com; s=arc-20240605;
        b=I6LbjB7/jV8HzwACtgCaZpF/DVtp0T5VqkBrcdbhxy2YoItUh3udZHdny1yBgEuKgB
         ZHssBAln0NliJZpD1qD8WXYkvP04rJeB0TENAmC33hsfBBsZnv81mJ92iU+ilHwWrxtz
         1pFOxX5vtWR/gAxEz7PI0FmU03ZjHBI0QBxkbNBFFgS8req9AF3YT8Lbg25dVPbxMkw9
         5GbZrWFXfxZ5HxI0yrQzvBCx09Rp5EDenDmzRiXfdlFPUJS+sPPM7B++rqKyZKF0WtpD
         /A1J7++DTzV5OPDR5NOXRH0hYRVacs8+kJLkcD5T7MeQPCFE2x+g5iW1CIsKe1TZSpbc
         MLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nLN8x7h3gKI0NxYeYvj5GuYRQATdaCAiSq+73Q3o4Nk=;
        fh=kaJvDsEg6Hfwd6AS1oXlMIUNmP1hApMKRTQD0U/l5Xs=;
        b=cmGLixCRkdeh651hagRlGrp1hOnLvKeEQeinbvuHcd0rhAfs3yW61hE8O+jlCmszGM
         Xi5AUcvZhZKW9QLX4w0n6mC7PXXPjCYBg9VdRr6a9zSEAWLEFSRECo9Cyi5E4ds7MuwR
         2j5N2u6bO1jLGEkWGXgBdWX0BHEvlr8Uh4/1j7GejMgZVPQ5GdVC3oOmUpn2hOLeEgTT
         Jl3Wz6VOIE1Wkso3gYUQj0hqRCYfd0/O+HrEOb+gLGFBGcBo+qXprOUrqekSS2Lz/624
         KK0vJGIXYla0jyd3nnotN7U77VK3AoPQcKY9CIrjnCsAm6fbNIxNUwkbgWY1aea6IrKQ
         j70Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773683793; x=1774288593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLN8x7h3gKI0NxYeYvj5GuYRQATdaCAiSq+73Q3o4Nk=;
        b=VbqNu+T56XiJ5b6lsaCKvhkwWlyWO/maLFnOJHzDC2lyZ1i3OblWQqeaP2TokZTtco
         B2kbxC1MqknfA0jskEMTyn/BudH6NvwOU1WVCbIEt+eHcn/wGfGe5he8OpSlbouIgsP0
         zJHKHfYYbdqxqVj6XNv1ckge+NSwis+kPk3/Itz2KCPROhV97+GBlt01SLLhG41cqb6I
         htah7i1/JVmrHTjQ7m7S95XVbK194A72YT9ts98q4tBiD/ItplDdP9V7Ox28VXW3n94Q
         +JLOg26S7EaP6u9UwCne+Xr9+MShZOw1etgkpFpQYTPSw+D/y8Otsd/+Sw/I4vcAKqoc
         KsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773683793; x=1774288593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLN8x7h3gKI0NxYeYvj5GuYRQATdaCAiSq+73Q3o4Nk=;
        b=BlV9Bg+lA0MCLl9glXUwrCL8zffr3H9GJPz2R3HPpyVv//W9uBhpJyCsYQYD9eeNep
         1/3yoLTnfqUVYMpJQwUFhEDaQEG2K085aVPhPH0gpbzln7rLv7tr99LFV+olh3/ZUwbv
         c3qyuho0TjHyym2PhUEsKgPxZIMnycc0ahhF2563oIp3sMrD/no7x00BoIKkrk2nx1+C
         jh0Cp64UbKiTYgem2yIgGhvCdsdX8Q/mdG66881t0bYehW+rBidIj+gOVj+bdLm708RD
         mmNo5Nsue/SOpKWFTaxiVMAvlFMMMnJR5yLGWJI/SBGixcfzU45t/VfixpZUqYSs12Ba
         YO3Q==
X-Gm-Message-State: AOJu0YxW/rELksxPmdN+Snghl+4OyZEi1z7nMM2E1q06WuVwRZGakHzc
	1vc6xD8t7N2eiowVHoQr7Sym/w+jIW0yju7rokpo14BrE8m1fzvwB63Xk2bOxIBdgag3l8lHGOb
	uIFEpzPx9bJ40nbpq7frWEZ6jndGLR6o=
X-Gm-Gg: ATEYQzxCkyicNvo5xOHU8J+FL05Y2H8OTJKGxVPDjwlA6F+bHc9i+cHAkVzNcU/vRWL
	Zmg9W5ySIhA0MfrimJjpd6GEP+gfQi6wX5hB5rBNpxcCmMV3oeKrTzIqgQMVwolCuObAjxkOVnJ
	bKGgJgYj6HwRHW+Y3j8jGTogeiga+CsQKBkttFZEYzbQEgc2FOlIpRsJKx/+wttoohHP/GUluQH
	2589yy8zwDsdZoG67TL12uv10ThZRshWRLbcgnOEzkTipuTdNPvSYe6gRe9EVP1waxO1Nc+L1eo
	mAl8QQ==
X-Received: by 2002:a05:6000:1787:b0:439:c6d9:7fc with SMTP id
 ffacd0b85a97d-43a04d95261mr25316775f8f.25.1773683793152; Mon, 16 Mar 2026
 10:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223224617.GA2390314@frogsfrogsfrogs>
In-Reply-To: <20260223224617.GA2390314@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 10:56:21 -0700
X-Gm-Features: AaiRm511WAGRtITI8RxyWj-xfdb_uS3eh6Gi0osoQrCb5u55mxyV9n1ZU3-bjXI
Message-ID: <CAJnrk1Yd1J60-Ek=O7jzZQg454pbr3O=b71yZHzYbrWfqJr__w@mail.gmail.com>
Subject: Re: [PATCHBLIZZARD v7] fuse/libfuse/e2fsprogs: containerize ext4 for
 safer operation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-ext4 <linux-ext4@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, "Theodore Ts'o" <tytso@mit.edu>, Neal Gompa <neal@gompa.dev>, 
	Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, John@groves.net, demiobenour@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:46=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> There are some warts remaining:
>
> a. I would like to continue the discussion about how the design review
>    of this code should be structured, and how might I go about creating
>    new userspace filesystem servers -- lightweight new ones based off
>    the existing userspace tools?  Or by merging lklfuse?

What do you mean by "merging lklfuse"?

Could you explain what the limitations of lklfuse are compared to the
fuse iomap approach in this patchset?

Thanks,
Joanne

>
> b. ext4 doesn't support out of place writes so I don't know if that
>    actually works correctly.
>
> c. fuse2fs doesn't support the ext4 journal.  Urk.
>
> d. There's a VERY large quantity of fuse2fs improvements that need to be
>    applied before we get to the fuse-iomap parts.  I'm not sending these
>    (or the fstests changes) to keep the size of the patchbomb at
>    "unreasonably large". :P  As a result, the fstests and e2fsprogs
>    postings are very targeted.
>
> e. I've dropped the fstests part of the patchbomb because v6 was just
>    way too long.
>
> I would like to get the main parts of this submission reviewed for 7.1
> now that this has been collecting comments and tweaks in non-rfc status
> for 3.5 months.
>
> Kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/=
?h=3Dfuse-iomap-bpf
>
> libfuse:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git/log/?h=
=3Dfuse-iomap-bpf
>
> e2fsprogs:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/e2fsprogs.git/log/=
?h=3Dfuse-iomap-bpf
>
> fstests:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfstests-dev.git/l=
og/?h=3Dfuse2fs
>
> --Darrick
