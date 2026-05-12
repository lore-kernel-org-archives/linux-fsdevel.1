Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67D379C38
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572053; cv=none; b=DBbl/5ZGOcSq8WRHGSbuyTTQe3p1BrYb3PeQYSURfNlnokSgeP4ImqOQvlikhlknaO9UC209emH/Ar1vgYXv4kVLyg7e/0WmW4HlDfw8/tASqp62skD8pLdSCrE9Q/nWuNPjobmwozQSmlAeXDpEAGATSSV495PxXXspMWCn29U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572053; c=relaxed/simple;
	bh=Sry2EHCbI1c3DF4E7xIqTuleO5X/BOOL8lhFmzR8RA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIHQ7XIP2OXCZlmSTvTz1W4bsHZa0M0JxuFLV1i+H4dQhoR4lvNSaST6wnbBuCzN3H6e3Uhvdp/ylXWjhxJ4rx8Z3X4lYTJk+xO3ONYtzvNzu9HszFGnXULTgep6ddNj728OlqhUE76oB8MPAoH4pEKzFdI/OLPeCk2qMgoAY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOz0OUQl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOz0OUQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC1DC4AF0C
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 07:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778572053;
	bh=Sry2EHCbI1c3DF4E7xIqTuleO5X/BOOL8lhFmzR8RA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aOz0OUQlnq1bQazI898PFdXQIX49edwnTjhffQZPyOQsxL7Znexx1I1jpVK/IswWp
	 iqoqzE4c+/B4mIq41xuJCu8Z0RSZ3bosyvh/EfExyirpZt+zselC6o89VrnT9g6ZrB
	 EqDSDWWncCNcUyHkg1kbtjGZUiptFej1wUr5aOIEaLH6FnhZuFgQUPWi3eCJsQA1FC
	 /N3rtRqPEeM1wtNs4oI4jeriZXPADIQyLWL5c9MyLexTktD6pJ+vWoJnSjIIT0AACI
	 gPmCGiZYSWjoVVFTV1wFPsVZlotIkEP/DG9A4auOZrAUplHSYloZm+ninbd6spRIgH
	 v2hATh3irWgGQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so10699793a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 00:47:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+NNhSuJHFFDAWnZnUwYD5+P4EaOtwfwi9IPqufdqpR2mKanIJ9CY0LvRk3ZXVcOYXi3ouGqsKbisDMcZYe@vger.kernel.org
X-Gm-Message-State: AOJu0YyrMeIFaGJ2zx8I7bnWtgHv/IVeshE/I2ULxAVCGByeJ7zXKERs
	momQ/zjTEScskaQSvGseYG+qopNHzHct7OQ6DxgP6hEyI4pVxZIkVVhcoj+iXTkfDU6Ua6ERGVl
	AJtvbQ1BeBxN38IcX6QwXnPPYGWQWWmI=
X-Received: by 2002:a05:6402:7d0:b0:67b:7e7a:45ed with SMTP id
 4fb4d7f45d1cf-680b2b12646mr1170287a12.6.1778572051867; Tue, 12 May 2026
 00:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-9-linkinjeon@kernel.org>
 <20260512063743.GA31640@lst.de>
In-Reply-To: <20260512063743.GA31640@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 12 May 2026 16:47:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-ShfqpjE2Kq3+DOZqT67pj72XYXN4OZZWWrSs8roT1DQ@mail.gmail.com>
X-Gm-Features: AVHnY4IdjeMPMYrWCE-Gou_4t_NvtukzmnXbTw_QjKvE6MBMnpsyJDb48JTnTJ0
Message-ID: <CAKYAXd-ShfqpjE2Kq3+DOZqT67pj72XYXN4OZZWWrSs8roT1DQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] exfat: add iomap direct I/O support
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, 
	dxdt@dev.snart.me, chizhiling@kylinos.cn, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:37=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > +static int exfat_truncate(struct inode *inode)
> >  {
> >       struct super_block *sb =3D inode->i_sb;
> >       struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> > @@ -315,6 +315,8 @@ void exfat_truncate(struct inode *inode)
> >       inode->i_blocks =3D round_up(i_size_read(inode), sbi->cluster_siz=
e) >> 9;
> >  write_size:
> >       mutex_unlock(&sbi->s_lock);
> > +
> > +     return err;
>
> Allowing error returns here looks unrelated to iomap usage?
Yes, I'll split it out into a separate patch.

>
> > +     if (iov_iter_count(from)) {
> > +             loff_t offset, end;
> > +             ssize_t written;
> > +             int ret2;
>
>
> .. splitting this whole code block into a helper would be nice.
> And eventually it might be worth to lift it to iomap as we have
> a few open coded versions of it.
Okay, I will split it into a helper.
>
> > +out:
> > +     return ret;
> > +}
>
> Usuaully just directly returning instead of jumping to a label that
> returns is easier to follow.
Okay, I will update it.
>
> Otherwise this looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
Thanks for the review!
>
