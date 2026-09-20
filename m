Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31577446821
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938853; cv=pass; b=a3abhlNx6sPtQ3zyzOpuG7aGf64DAcyG7OE8YEf7VSlGA0w/nQ+x+0Zf2CPrIlK8VVnwkY4klHjiS22BWqetEksPr2ZJAWqzd0G8WBplQUtIlItsmB26ykFdowwJwGRnty9AIv+ovUNCQNzP7tY6fV5JqFPYwrgv3rBV6B/yCGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938853; c=relaxed/simple;
	bh=ZP2LKBPL0cBLk5dPcCtHOiZGDZ5qkSE7LN4mdOu118g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ya1RSY3wUvsqFQzDrCpGjJrhfWyuzokOckuv1x/75wmrYWKSNIZBs2IpI8nzb0FQSSfU1u22w4BsgTf7kxX4tSNp7ugBe0sCZc5EDzrQSyNcAi/KNqZS1j8G5q3FCj3lJIqR7MwhsCoOl0iHIhOVRc1OZCrOqcYXbGH+r0mnMgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in; spf=pass smtp.mailfrom=thechris.in; dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b=QG6rVRj5; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thechris.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thechris.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thechris.in header.i=@thechris.in header.b="QG6rVRj5"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43f9b119so18579237b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 14:14:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789938851; cv=none;
        d=google.com; s=arc-20260327;
        b=O3NQAMth6UL64AOpRKxegXEfZtXeahaJAlsy6x2NDf7/ts5KxoJsh1b4GQqx0HbBEJ
         slHWEFzMBQ2ZJ+/IWLkQThBXiI/Ev+j/K7Vhkc3+jJQ6igwZ0f3KPVzmSydTkAGd36Fc
         P6G5ncHYYRHzghPLTbEZPn9hHjYkPt0Y9Rcw5sqQGzT28WyEKUAqbhHugi8+iHgS5kTs
         oho7aX6gaKSOvAQRQM66uqJsbeBeRwfN5ID7VWCTiK0UWyuWFjcSmfMdeb2TPppCN3Nc
         YTn6BFBg6sxFn611D9hghu6EIOpcppYSDXkvFUUnYRmRJ5SOshoyWf953q2i4FsftAUM
         XfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MspPu0+DEulTacQxx9QyZ/LDtlKZj0ul+YFa8hoOWcc=;
        fh=5UVqmN5YZ0R604a9ZzevxWn8JDf40QROppN/KkNk97M=;
        b=WtbBwgTKnsVVlNnjblftv3dm6oGkWz+Bsm/nssLYha1JYKwuH4McgrUnpTNJ/YAeAy
         H9Nz83u04ITqfPkdn2qAjuTJfvX30gcql/0aACsbEzZiXVqvfuoeQzTmUP9wZWaZ4dsk
         rNawY7Twr/baDk/602S2jf5DvOHEyJzvti2c+CSWeWjFTiT6WkOuBieMYkkhj85XN5ho
         JnyCcy1CkdIpSeU6H2uNIoqHnEun9ClMK8zpoiWb8iwUF3tlX6q5IRyoO18J7HF41ISf
         hfjNNyn8zll9R4c8on+MPEu8CGmAgwOIu/wFXc9OkBhkUO9vwNautzS+2BUf519FzwA6
         iOUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thechris.in; s=google; t=1789938851; x=1790543651; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MspPu0+DEulTacQxx9QyZ/LDtlKZj0ul+YFa8hoOWcc=;
        b=QG6rVRj56BSZA3UWUho/Jv42gtKpiFNVceNFgMFevj4lvznxXchdl3rTfEj4HEYEuk
         pDc7n+dF81O1ARSPEENuf+ENUTnRryfmLZSkHZmeawaqXwWH6mW/FPwmQd6kxnCIDPRD
         O71dcVG49HLAPVFQHfEPGe4Ev+KQ0KKuQ4aphhzpWkAgVcaVWkO8RNh8DtTQUBJiuOF8
         GyA4N8elHxqZnQ/CPCxoTyUjuPInm0INrbkPSx5X1QnHzjfASUA0G9kNx0hePWCPvwbV
         +qRCjrheVlipmiGXYR5RVdJerHGnw4O5XtmgXAES2PpXmO0bCitP++A4V1fDiN3on/5G
         i2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789938851; x=1790543651;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MspPu0+DEulTacQxx9QyZ/LDtlKZj0ul+YFa8hoOWcc=;
        b=VK6hCuVC3UnpafrsYr7D/JNFy/kp4dKb0G/gbOUW58m1sMJ39j0vaesWabBfCdPj9Q
         4YTFVM+/9ACnVZ8FhPzjTe88fO8sjB97f5lmXV5r7Lu3aNTpver1DXxKrwGS8trdyFU2
         d7eb3y7WfpK9srM0WKuw5olRFMujOV/v2AbnNhOGAy6gPAHJBep1Gpe27aJJ/GLYBwVE
         9WHMiWP2XcTJ8vwBYRdkBQEBlV6mu3K2s+1RcHftrjoqVH2SbXM+wzk46rCqvXech4Jx
         AuxycHWRiv4Px/2wA4PWcTdMT5ou5hyWtIgjaob+SoOOFoRAE/8+ML5o8djJ34E5gr9G
         bMXw==
X-Forwarded-Encrypted: i=1; AKwUvBzAOsy3igWt4P0UCs8itpRS8H0pXCTLvJUAKoo9Dynng9OoV/PBzUMlN3cf4YpNqT7kza4va3P5VSYwboMk@vger.kernel.org
X-Gm-Message-State: AFuF++lr249mhawcxBDwjcOZbAoEfDxXQXc6hVC3rZqPHO9Bjtjv9XrO
	FPcfJhqihGWzf63TCcWFhM8G27OYW3AMRVYSw0QYxmW/XBKMp/d8Ij/VfjZ9sL4lsLk/xdvqgcB
	F0UcdMZjmGb5PSOkjYCbhungGi02pFPshMUK78uaWMn0=
X-Gm-Gg: AYBFou0zZRxt/9XjOvYCgAFU8X91wW7OtbbcKQhOBm607GnJJYquXjy3PvLpd+XQHhq
	TnJReduyRqhVKzIz/3q8ZMjOnrFBD/nTGP57XBok8YCgeOH9lwBeFw8qg2YUxafb3jwDiIoU2Yw
	k4nRFMUDqZ4KJ/xwN2m9hQ5ofIYsx1rDRIekGZ5IQXZoybeeDokQd+4pVT3nM4H31nd6MUn7cf0
	30OjWDFirPxb98qiCs2dASvoz1w8igQay2LYmSpwKqupQSS1NQSRIZ+jw0RAeejq9e+wPXx0LEh
	KA2BVWCP2HAPrrL0tc4396okCfYGgRIHn0BDRLmkIHtloyjyWGpzKs0kaVIudSsAaLB67Zd438j
	/Y4JvLKEvcoZuCA4d3TXHF2uM265JUI456iZ3xMMyWhSnvo6XoVWce8RHlNpicziPhNcUP8DrVg
	Ib6kpjVS41tXjsZw==
X-Received: by 2002:a05:690c:e681:10b0:863:e8cb:7773 with SMTP id
 00721157ae682-897346e315dmr20106047b3.32.1789938851178; Sun, 20 Sep 2026
 14:14:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2Bdm3NuEHshrG6K2boKAnCQUvT5SX79cP9nPgS2s1afzY1hg@mail.gmail.com>
 <6aab0f82.e91c2013.3bdb06.0009.GAE@google.com> <CAE2Bdm2wzxj-J0TM8F+3SVnu0W3HeiROW97U4qvBeyHKdHJFmg@mail.gmail.com>
 <2026091753-broadness-bootie-b683@gregkh> <CAE2Bdm14hif17B8RTAE+PhWEps5Fzh=WPurZeSNp9C6TqCKumg@mail.gmail.com>
 <aqwuWWMwdIcx3704@cashel.logfs.org> <mu82xsi6.76ee613a-07fb-48b1-9336-99e8780e8b6e@nod.at>
 <aq6afmdN5DYpuUa2@cashel.logfs.org> <mu8hfoxj.7ce5e90c-076c-4b73-813b-f9c60310ddab@nod.at>
 <CAE2Bdm2UA2UTkYY-w2qxLaXWjnujTkOoC2mS+WXu7McZV2MyeA@mail.gmail.com> <muab72x3.7c175620-35e4-4686-b377-487e6c270ea9@nod.at>
In-Reply-To: <muab72x3.7c175620-35e4-4686-b377-487e6c270ea9@nod.at>
From: Chris Roy <iam@thechris.in>
Date: Mon, 21 Sep 2026 02:43:56 +0530
X-Gm-Features: AcwNN1WbQLG4glywQGVIDhxD1uJUtzAMcMfTWSPukcrARUaPtDIjPzyQr6Yayyo
Message-ID: <CAE2Bdm1zFXr7UErCUR5KR-aGj=baCh--gaiDzZhjepF-_6H6ZA@mail.gmail.com>
Subject: Re: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
To: Richard Weinberger <richard@nod.at>
Cc: =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@barelysecure.org>, 
	Greg KH <gregkh@linuxfoundation.org>, 
	syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>, dakr@kernel.org, 
	driver-core@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-mtd@lists.infradead.org, 
	miquel.raynal@bootlin.com, vigneshr@ti.com, 
	Adarsh Das <adarshdas950@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Richard

> Keeping the module parameters is not a hard requirement but would be nice.
> Ideally, the module parameters prove an initial configfs setting.
> ...
> Yes. See how nvmet uses configfs. A similar, but simpler, approach
> will do it for block2mtd too.

I have encountered some bugs with the sashiko bot. So, this gives me
the perfect opportunity to
re-design with your inputs and propose an RFC-style doc including a
bigger patch within the next
day.

Regards,
- Chris

"But how could you live and have no story to tell?"

On Mon, 21 Sept 2026 at 02:39, Richard Weinberger <richard@nod.at> wrote:
>
> Am Sat, Sep 19, 2026, 16:44 schrieb Chris Roy <iam@thechris.in>:
>
> > On Sat, Sep 19, 2026, Richard Weinberger wrote:
> > > While we're here, maybe it's time to add a decent configfs interface to
> > > this driver instead of configuring through module parameters.
> > > That way also multiple instances are possible.
> > >
> > > IMHO testing is the only use case. I use it regularly.
> >
> > I would love to look at this if you think it's worth the added
> > complexity. A couple of design questions before I start
> > on anything:
> >
> > - Does configfs coexist with the existing block2mtd= module param
> >   (for early-boot/cmdline compatibility), or replace it outright?
>
> Keeping the module parameters is not a hard requirement but would be nice.
> Ideally, the module parameters prove an initial configfs setting.
>
> > - For multiple instances, would a configfs group per device (backing
> >   path, erase size, label) match what you had in mind?
> >
>
> Yes. See how nvmet uses configfs. A similar, but simpler, approach
> will do it for block2mtd too.
>
> > Can sketch an RFC-style doc once I have a sense of the above.
>
> Sounds good.
>
> Thanks,
> //richard
