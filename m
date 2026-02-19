Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F7F241695
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771501042; cv=none; b=YlGPAs/olf7WqA4UaGMr26NeNhTJ+H6O+RI+tst6eTD0PRlkC1zsSOWBMc3NAFrfnOun1NvTb6q7/v7b4Du7JrDWqvpm2JILCA1ax+voyQx/W6YRUtRXXOZ7cCWX6TuCUnsM5FGEuht1OYlAd4VSiiVTEGfAeitXVy1aeS7KD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771501042; c=relaxed/simple;
	bh=9ssU5WZrgVG4IgiqFopoE8/6agi06eDPJNl7cL7/qIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ftAuhj+INrOYuljym4RgDz22nkpgzmpmmHeQ5uIZ7jLYl2fWbkdoldrLexAI1PC/k84SDJkJ5wdbU4c1YLX2vR52AsEXu10PiB5ii3WeBlo1fKNmpk7oxhTpjMnPgMe12ESgzapSAZGVPYAMUvm2j5vUtNp8AjPuB265yMhUR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHQp1Oux; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHQp1Oux"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A08C19424
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 11:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771501041;
	bh=9ssU5WZrgVG4IgiqFopoE8/6agi06eDPJNl7cL7/qIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VHQp1OuxzKA2ahAP9/UArahr7tryjpbk6xYqcB7IrQr6PwQoV0+qD/dL5x49nyCau
	 yYVKitGdKC2yfgDiMWmpfpZyxWgLIl7BFp+cWmO8Ij0zUnKAyRGm7jTY3q7iPfG+Qj
	 wcJvzWf83XjrLjc+HgbuG4DPUU3LGQwDTjjmk6uGJ0HOPVXyt7xsQPlXvNChOBPImk
	 aKVrZyLzCQ9TECFP5vFlzg0u0owzzUQbxEtje/SlyXKuwUaSS1lqva+EOTbbBWWHQv
	 x+AFJWZXFVLQAqck33wwgmRwP6r5pM1yoERd3j9pJWKTjyaBWxx+s+pEWKZDkR66Hh
	 trIG3DJzCZKmQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8fbe5719ceso177687666b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 03:37:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yxea2vhIwAfjWqRCkhPq7JwGV6aLKd1Ui0V6O7NiZA31dwv8tcI
	hiON6Nm8DVLssnvsOb7K/YsVaKJtqxgs/BPDr/Bb1b+1Qk5+LEtf8pnKzpYkkDPbU6mYu3cgqLv
	R27xsWtFmm4pt8gdrWAQP1jtrPriFbc4=
X-Received: by 2002:a17:906:7305:b0:b8f:f74:d601 with SMTP id
 a640c23a62f3a-b904dea50acmr141894166b.50.1771501040066; Thu, 19 Feb 2026
 03:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0e5da23-90ed-4529-b919-11ae551611f3@dev.snart.me>
 <CAKYAXd-oj5Aa4rccp4iESFgoVUyPq2v+u=2m1AM8KQPpaZOOGg@mail.gmail.com> <8709a255-0c8e-40d8-ab75-b3ea974f5823@dev.snart.me>
In-Reply-To: <8709a255-0c8e-40d8-ab75-b3ea974f5823@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Feb 2026 20:37:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd98fz=evAudpa8-GFhTfGbcLVioXFsO30pCKu_Q_ek8mg@mail.gmail.com>
X-Gm-Features: AaiRm50v_MOcQ9s7fjODSoP3Wxe9pdTgd8tjitF4Cygb952UDKYLHvtRs7Tc6F8
Message-ID: <CAKYAXd98fz=evAudpa8-GFhTfGbcLVioXFsO30pCKu_Q_ek8mg@mail.gmail.com>
Subject: Re: [PATCH] exfat: add fallocate support
To: David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 5:43=E2=80=AFPM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> > Unlike before, I am no longer in favor of adding this logic to
> > evict_inode. One major concern is the potential for cluster leaks if a
> > device is unplugged while a file is still open. Instead, We can
> > sufficiently minimize fragmentation in applications like camera apps
> > by utilizing fallocate with mode 0. If there is any unused
> > pre-allocated space after the recording or write operation is
> > finished, the application can simply call ftruncate() to reclaim it.
> I agree, as stated in the doc change. Not a good look.
>
> Would you meet the half way by dropping KEEP_SIZE support, then? The
> regular fallocate op can be treated as ftruncate which has already been
> the behaviour for a long time - just call exfat_cont_expand() in
> exfat_fallocate().
It is not that simple. In FAT, mode 0 seems to be hardly practical;
the need to zero out preallocated clusters leads to significant
latency. So the fallocate operation itself would be unnecessary
without the keep size flag. Furthermore, I doubt we can easily remove
it since there may already be applications relying on this. Unlike
FAT, exFAT provides both data_size and valid_size, so there is no need
to zero-out preallocated clusters in mode 0.
>
> exfatprogs still needs to be able to reclaim the orphaned clusters,
> though. That's still a very likely scenario, especially on the devices
> that run on batteries.
Okay, We will answer it in ISSUE of exfatprogs after checking it more.
