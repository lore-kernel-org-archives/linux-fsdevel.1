Received: from mx.fmap.me (fmap.me [51.75.121.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13222D5436
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.121.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753305; cv=none; b=q+RaxXpSCJH8XGVpP6VevGKw5c9LXTDL6Vs+12b56p46g7YC0tCYnu0qfx0DGuVJND73+npHgoBTl1SrL3LMXcTizHY+AcZBXPUjoqcAn4CyGWKOOrX8o/dPhb+44MpC7vN7PSqnkYVsiLAqfU/ysXCpT3tG7gBzOaXtipnXGmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753305; c=relaxed/simple;
	bh=CoJTMqJ1onnTxeIF9I81G704t2pBej9f21Ok6utvyto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qqUBjVEjclG7bOdEfasYle1GHE3gyaGgmcGhDtDvMWfKUb4xr00szEOfp90e2d8DxYceVRRMt9USlz3jMwAFg84pZL/Ad3+4nxelbkLhYfL+13P/SRiaes0+sJsmnTgDpsJ5pw1wXW0e2W+G3z5m6PSclYGP24OC94wvfrDZ6es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me; spf=pass smtp.mailfrom=fmap.me; dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b=FxD3oW3y; arc=none smtp.client-ip=51.75.121.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmap.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b="FxD3oW3y"
Message-ID: <08666fa4-e69f-4dad-8ac7-910102ecaeb7@fmap.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
	t=1781753297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mIiAFCuiRW46V4lACRjPX/dUTjf+yOIPTAWDGiXm6fo=;
	b=FxD3oW3yHOmyA3WftFJ+9nRMlbyRgRUmB7EXT6kPQuxSSpY9gVIZ43KAtUvYNqNxQitkNb
	iToAnRYz50uSXnEOrzZ+IeaOiqi6BkRplH5Nbqg7nklZp6DRGP/iEYh0QzqOUgUkcc917X
	wn74p0XFKKNPWTj0mLb7tGMWPzSDVbo=
Date: Thu, 18 Jun 2026 10:28:10 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.sourceforge.net,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
 <aeFuarTL7xBbut0F@casper.infradead.org>
 <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
 <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
 <CAJfpegum=LJTCGqMUfLHehQE19kgdZbE2eXS_002fdpX_sd6jw@mail.gmail.com>
 <D4988E64-C9AB-404C-AA95-E5F4725BB646@fmap.me>
 <ajGabryrn7A2VUAq@casper.infradead.org>
Content-Language: en-US
From: Nikolay Amiantov <ab@fmap.me>
In-Reply-To: <ajGabryrn7A2VUAq@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/26 01:48, Matthew Wilcox wrote:
> The patches you posted earlier in the thread invalidated the page cache
> before setting i_size?

Ah right, you meant combined with the invalidate-then-grow patch!

As far as I can see, this covers the `read()` race.

I'm not exactly sure what happens with `mmap`; can one catch a moment 
when `fstat` shows a larger size, but the mapped page is still partially 
zeroed out? I'll try making a test.

Nikolay.

