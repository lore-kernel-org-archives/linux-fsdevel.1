Received: from mx.fmap.me (fmap.me [51.75.121.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E53D45CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.121.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633483; cv=none; b=O3vO9XqB0nuB/vi3FsVQMQ+z543bSzaDWIhAS56momOjfCblwCWH/XuQvPSXrn7wauGYQ88f3+z2qctC1DIQPWK8UMkQm6niQN6dKu6aWVCX2OZASUMmCY3VyB/zUMJmzAOQyroLpit9VTwZDuvrW6pcaaLWgbxadiM27Z56vZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633483; c=relaxed/simple;
	bh=layTl79gbMyLCah9kWZR8v8fN/Q7zatYtwSC0yhKbmY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Q95VaJwMgoRwfbs8wHr1EMK8A9tE17TeNn26i4lja3WfMNx8GFqFyB2g74YK3kQ/U+MLPr2KI2fGnIvF09yOpS2tcHUVSc4TJCLzgQSuFJ9gxRTOjaxkSmF6VdxDBk5oVUoXBx0jYQ4ITCpFFJKvZ4U84+AJlbuRtFyBR151LuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me; spf=pass smtp.mailfrom=fmap.me; dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b=A6ridIjW; arc=none smtp.client-ip=51.75.121.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmap.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b="A6ridIjW"
Message-ID: <7b1d3d69-9459-43e5-8de8-1ecb82c510f8@fmap.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
	t=1781633479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naXgK2kbrMvQJ6JOF3SwWmMVnIMMUt8ZbCvz9MHnDVM=;
	b=A6ridIjWvdJMXL1Ji5wz7fEIDiyV66VJmjfFzyHyfNEkmoQwsp0LGkaXTSuBej6BEuUCXZ
	j+i6zNrFzkHbmZ59YOh5bb6wtwiJk0/MKaMbRyKiGXClhhywRTxLvPtcIsSJot/MoDeCgq
	zj/uhdUVBYP83PRtUAQ0DpA4GBRWZ48=
Date: Wed, 17 Jun 2026 01:11:13 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
From: Nikolay Amiantov <ab@fmap.me>
To: linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
 <aeFuarTL7xBbut0F@casper.infradead.org>
 <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
 <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
 <CAJfpegum=LJTCGqMUfLHehQE19kgdZbE2eXS_002fdpX_sd6jw@mail.gmail.com>
 <D4988E64-C9AB-404C-AA95-E5F4725BB646@fmap.me>
Content-Language: en-US
In-Reply-To: <D4988E64-C9AB-404C-AA95-E5F4725BB646@fmap.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ugh, I sent an HTML email again from another client — resending to the 
lists :(

On 6/17/26 01:00, Nikolay Amiantov wrote:
> On 6/11/26 18:36, Miklos Szeredi wrote:
> > Sorry, this got lost in the noise.
> No worries! I didn't get around to trying other implementations at all.
> > I was thinking of something like the below for fixing the invalidation
> > race (untested, whitespace damaged):
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 4e636647100c..c9ab0eb35afb 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2856,6 +2856,14 @@ ssize_t filemap_read(struct kiocb *iocb, struct
> > iov_iter *iter,
> >
> >                          copied = copy_folio_to_iter(folio, offset, 
> bytes, iter);
> >
> > +                       /*
> > +                        * Has the folio been truncated? In that 
> case we could
> > +                        * have been copying stale info (including 
> zeroes after
> > +                        * EOF) for a distributed fs.
> > +                        */
> > +                       if (folio->mapping != mapping)
> > +                               break;
> > +
> >                          already_read += copied;
> >                          iocb->ki_pos += copied;
> >                          last_pos = iocb->ki_pos;
>
> I may be missing something, but doesn't this still leave a brief race 
> window when i_size is already updated, but the mapping is not yet 
> invalidated? It's invalidated by invalidate_inode_pages2, correct?
>
> Thanks,
> Nikolay.
>
