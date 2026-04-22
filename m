Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFE036F437
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776886243; cv=pass; b=hWjXu3T5lCiCnMoVndLZXRVHjGxNLBXwfIj6NYg8xaT2rN1gAhpW6klf5uVAK7SNl+eUSRZz2Kc18jbghc5xHTh2Qs202LrzWbb8t7yZO/BZvEBJmIQWiSFTG3TVfFvT8W0wl9G4MSUkDsLMzX/5jzpxrFRtWx5ri+RfpumlSLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776886243; c=relaxed/simple;
	bh=fhuwujzJsQ1txOxmh/iVbjDo+gW3V7o1wpkYVb2eB2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PD7+AdWYJ+GZ+KK777JQ+D3jIo7Il+/KKB65fs2Ja0aWpnU4RlLOwxgkzU4WuYdspSCpK2WoyBImZaMV711F5mwQy8WyGHm1uwImx3BKeTCTeBoGdJP1dqHh4cw4JNZH+VXdaU32+yQswLfRCWZ3idVmSfboEVYh6J6zPBqAnrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F38/XNJW; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F38/XNJW"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d03db7f87so4005321f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:30:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776886239; cv=none;
        d=google.com; s=arc-20240605;
        b=PBdNBYkSG2sSVMAuh20iklART80PPxCNe0GgjT+MA9ewZTT+IeTxPj0PbiHrjN11nd
         1CpW4595+frXZ9V00pjAR6R60l03YGVYlo5vvXjEFq+Jv0GK61/JFmqOQAoKy6RBTDHx
         GUK4jiagT38Efx4EpAATFY0VVlREA0HT0dtcak8iM5iLsDyS5/Fe4Ivf2yYHD9GqZMti
         dCHZ/tpqdPw+/KR+U5Ruw1lOwz74968bCWGfTNtKHhkm7Zx/y+dxkTaTMjmeCjzHxBR/
         33cBsP+uGt8u1X+Y96MCZ1bxWXS7mQiI9yEz5Uu/E46Lg6wlfGRQaep0EN+dhNwa+bH6
         S1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aw3yaK4icnRFqcoPcDXx3ykLe9iB5O1jMvtRXhuzNFo=;
        fh=cyIqqUUg5binJ2W8WDDokVxsYGMm3t60pzmXyRXp7j8=;
        b=SHj+K0w+JfYtlocWacmqkKA26jjXxxegHl+wFWukCYJmXdorZ+F8b7zML2p31vGrzY
         kR9KjlgqDn5suWdA8RjZ1wafRglUMvzEhJYRw3+szCmE1vaMtIsxrB0Bd+5JdJKh3GdF
         XtAoxZLfYjRp89ycnOmVf16Hdxm9j3zDbm9qRGmmVx87tlBfv1Uk6K3hiyKoiw93/z32
         r3Napo6oDLj7FV2Odt2H0izON8Fl2/WCVUB1+PCzjKNOwPCloqJ9P52vDXBd5TB3oGzx
         u6pBk0kRSnvWt2y56WJTS8slHKv4Kz0wpXKSyWndHphxlBmJEyyLAYpNs/gjRsIqse+T
         E7cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776886239; x=1777491039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw3yaK4icnRFqcoPcDXx3ykLe9iB5O1jMvtRXhuzNFo=;
        b=F38/XNJWowHgiphsHG3lUFg6QgJr7r4hZ6lNFsCzzDQxaG5K5YRRbmNItUB0DHqPu8
         CliyqOcOKfGJC8CMmnUqLA4bNz+SUBdsyxyrI2s1twmcMrwDNyUuVPHAZyYPGvtYQfDd
         Bp4SLsOYz52i6H3umpUhcC0JbWdrY/zi/52JchA0ds9pS5dSlXzDx/ENJAmZKZx4ObGo
         SpVvPGRgifj7J9x9+Shtw6vupe2hNpx4dwswdffsw3F0AbuGU2JcvimHmL1+Y7zIPQrF
         w8QUip5uS2VHUxHhjCBehomYBPhgCFWM/aoJEej1iqrXGPVAXQNb28xAzu6rjwfNdTef
         NGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776886239; x=1777491039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aw3yaK4icnRFqcoPcDXx3ykLe9iB5O1jMvtRXhuzNFo=;
        b=AoEo3tnFzrRfbBPqiJp+yvHg7cVwtWwUkGbf7k/EDXgdfZ09VclN+Sa2u5NywE71/s
         x2abwPedMmuZIUDhFx5CWUXAnhyXO1nknx5XAAYPlLUFmKe6cT6FZv5JsdAtIAtQXPz3
         myWUbLVKnW/aEa1NDQ8QWO4gQEALYJ+4ZDzEHGvHLXdh6z3HNEwJXoCVy/l1wwwEQB2N
         sN/5uXUDxVCXPwVKpLqejkjnDdGitUznwBIgN+YxNY7XcwiN1XTcQ7dfRbjPyhI6r7yq
         Cnewr7M8JwvSkUIMBq/wbztYluFgphrjM1OuV0Wjju4z841+L6G/d+S4Un0DlRiJm79x
         8alA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ht+4a0N+o1pdD0n2liirOHk3XFjsVIc2ASQx0R12vWT43IDVm4rOY0hZoL33jSCjRqX1eiDZeJ4er38V4@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrwTiDXkOZ0wWSZG9ePsvZ6g/Xs+FXfgBIOPll8+mFEF7XY/g
	8kAqoaDf50VadEYwmzibPctTsiF5UhbUx6PwlA3qY9HdSJsiYDQD3YAhN4F054sB7ZVVnzlxXHZ
	xJtbK1ZeaPDqeY3QoMnQW10HAAkPdqgI=
X-Gm-Gg: AeBDiescMx3Ku98MzZOMMfL4WVMnRtJS8hMsAlSCwZrQ+rT5PNyqfeE47iii8A9aUWv
	BvZWiqU74ZUVE6Jkb8USgo/tV+JJyzCUqeiIr3NSt4OO8ninVknsNYPo7cLVBgE/2uRnMoK19bt
	QdTQdLjYVyVio987Z9lR2eOtFiDoc97IdCuXNyewV3rOo5mC50/VQeS1wLJxPoTbGPU7yKbrtgA
	Bpg18VwZfVMkzqNjdJPF5Ni4VLJlnGaoMwoXaDL8GQhpwAU1W5EQV3gzbizlx8hIAsyfYYvsz1M
	2roXkjNber5WPB9FaBvavifP2ks3QgyXig==
X-Received: by 2002:a5d:6751:0:b0:43e:a69b:d805 with SMTP id
 ffacd0b85a97d-43fe3dfbd18mr23709448f8f.27.1776886238591; Wed, 22 Apr 2026
 12:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091658.462783-1-mszeredi@redhat.com> <20260416091658.462783-32-mszeredi@redhat.com>
In-Reply-To: <20260416091658.462783-32-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Apr 2026 12:30:26 -0700
X-Gm-Features: AQROBzC4T0OXo8eu49n2bjtCoR4nay2xnC6t3bxqb1p-jTESdmvWeXfGntCMeHY
Message-ID: <CAJnrk1br9Vc_zRgqoBuO-meyPW2=n6p9PKizEiba2oT=+YX+zw@mail.gmail.com>
Subject: Re: [PATCH 31/32] fuse: alloc pqueue before installing fch in fuse_dev
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	Li Wang <liwang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 2:21=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Prior to this patchset, fuse_dev (containing fuse_pqueue) was allocated o=
n
> mount.  But now fuse_dev is allocated when opening /dev/fuse, even though
> the queues are not needed at that time.
>
> Delay allocation of the pqueue (4k worth of list_head) just before mounti=
ng
> or cloning a device.
>
> Various distributions (e.g. Debian/Fedora) configure /dev/fuse as world
> writable, so the pqueue allocation should be deferred to a privileged
> operation (mount) to prevent unprivileged userspace from consuming pinned
> kernel memory.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c        | 75 +++++++++++++++++++++++++++++++++-----------
>  fs/fuse/fuse_dev_i.h |  3 ++
>  2 files changed, 59 insertions(+), 19 deletions(-)
>

Li reported [1] some missing uring side changes

Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/20260422103603.4554-1-liwang@kylinos=
.cn/T/#u
