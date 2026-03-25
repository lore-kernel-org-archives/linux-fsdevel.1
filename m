Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D63D5670
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774443439; cv=pass; b=kgEJwbjgs70y4I2iU8KSAPd3a3/Dz3aqabXaIMW6pWsg8GMSWPSimhFqHRfo1c9ENHA9Gg7G1F5Yw1Qpllvg+Z6CN6H65Yhm/en0XRbycsQg2j755qNRu+NndAMzgElYfILPPW8/x5qjJcBd39W/pZQWPlijnxQOxINgrN6DJlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774443439; c=relaxed/simple;
	bh=I6nu+W5oQXgoBediHBI1nxFNIoHjXKwmRc/d4+b+Voc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Or0DemWBkoHcJ4si03hCDR5oKWz1Wif9YnosXIHLobeau7iPujN/Y5UckVwPD1KdqG1ECfu6Wy5g+G8z8m9TETtv1585Hyb4fJUP4gSTaThsAW7Znkng7xPu+PrIwL1hR78Sr9xop2dA8pBCJp6O0aNHDVGEficaYSeIRHxnMgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qiomFnkk; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qiomFnkk"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c160308a54so567717eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 05:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774443438; cv=none;
        d=google.com; s=arc-20240605;
        b=BFcc3LZ6zhHchLiqluyvomuXj7J4a3ZDJCiqPdVlbi6duLqf0Br0+8+snZPBnGV27h
         a4yPOXtPSzUmPqU+cKnIvcWxqIGfF9kOVTBmRuBJ7Vw0WfgotBQWNJjRSbalteOPIVmH
         eSW6rrh+lmwEn6Nef/6Ct/OM58Uqbj2QOtmPQSvfaveDh6oa5BR+WTtRwDa+WcvuRd8L
         oFb49/5CP5cMAVeeAtfnf4zr7yOcc3WDBownxJS0jZvx139CfyKq3CtWgL+xDXKo/bj6
         gJkr1g6cKQfIIZoxZhhLoEstBT8ijSZebjzigTHpJ2Sx2BgKL7WpKCh4R8prDJDH5ysS
         jh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f6rECN2hnxCRa03RaIkDSyMoiGlA3vF3EfjC2Pxqcgk=;
        fh=0OTK5pqzQB/IuUAMIWIdqPUfUcljkDj/dMaHGF8xlqE=;
        b=Mq1WAIkGE/9uKKnkQXIpA7nh4WGca0SstF+54jwglGWdaxZ7Z8BKIyHbiWh0yTYclL
         uOjrTftSXcxSCfJl+tGNxBqIqttem5ecZt2lbOSWkKo+spMimGm/gFsnjvRJf2UgBJiE
         0w86lSpkP+B1vDiQtGzzI9rO5/vOYI9PHA4pZsT+G+XrmA7edwO15DXRp5xfaTWwmNYv
         UDABGkVGy6qqYRcMWciBgm3lAEKiaTC7hJR+kUyBr50QNEVWxbVqjJu1DGgGijD5poJy
         rryxnr8+rMF+0ghCAQ/ZXFq6nVqaXwlAPYVt+VcE9KZ18wGDeSf79/++rrQSz+ss2EcW
         ugKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774443438; x=1775048238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6rECN2hnxCRa03RaIkDSyMoiGlA3vF3EfjC2Pxqcgk=;
        b=qiomFnkkr42P2GIKsv5PSCAe7nSPhqCWkaOoyodzniBgXR9b5F/A/7nd1TZ8FG1A4T
         wQyuVmrvAg3hLCVGWNPHISbKfON0KA6RLoKndKmHjx1JEatDr2jOaEZqDWGIBEsKuulS
         NXNyPB4OccZwt2U81BScfz3UMhu4rQn4DarQ+t2K7LLiqT8pBUzq7S4P1NwvpVx8YO/5
         Dw7mbTQZ+Uw2KjrWcR5HYQ41qaguAm5oHAjIeBZnYWZkWZ1Tf/mzyI7a00hA/mBmBvf3
         qam9dmUZ6UNihRecMDmWiA8ox3hLLKLSqphMcs8eOLs8ZBdD+/nTQkze2Xm/KCLxz28B
         bFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774443438; x=1775048238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f6rECN2hnxCRa03RaIkDSyMoiGlA3vF3EfjC2Pxqcgk=;
        b=A2NEbaj5xKc61rdSFettPkhmtJV1iOwoziLBbFIcuoB+iaaBg1Nkkv+yDJ+OfTKoq+
         pcvpXZO9DbgUqkgh3J7moTB26WOIeFYJX0PZslDxdDeEj+WGitr0Yu4f1+cZYrK8Tis7
         oLJB+xP1+amD81hnfwGaQDnOeR222LnmIe6YgJ0ucLe83is5hp67E0+DdQdlnn4JglMn
         Ls3e7MbPtsPiQUCxSpQPOEM7mN3cIyZ8596EoFralZ7+kb8VT/XCKWT1JZoeQceeYbf4
         NnNDwxNN7FNbf/RgAWU0ya/vtPsl8zvJ37Yph4oFP24jB9GXeNmpV+BylB+JTKEQrjCk
         qE5g==
X-Forwarded-Encrypted: i=1; AJvYcCWM8Ce+gX6rYozUItEKexgQrTqT/Dv9asO+vezyjtekRrSSOhyzQuSZIrwmdPnehs3JL9Pb7gtN2WUhPwR9@vger.kernel.org
X-Gm-Message-State: AOJu0YyqOGpBuE/VwXxFEtSefu7DgYGjDO9VdEDFJDIzyzcepW/harQg
	6c5DBYTBQ1jkYTjXkMv9U7GdKM5BtjuBsZxv04z8jYLZeNiaT9ni7x8OtpZJ+TovjFGRY0eaWEx
	m2t1153n9hz/gFLf5gyj75hM7tH8TI4cGQgiUqfHENQ==
X-Gm-Gg: ATEYQzx0ofjzHqxJpJonVuvnWzAVA2GvT/0whOp4Q1KBQg4YPv6HWtGV+6NnIb3wT/n
	NRZORLnbxEF2tZU13weuYdmal0f+gM1iFcNZiALv36TPzR53l45NwHsYu3sgfV9Urmq9m5Hh5XN
	q6pBKZeZrKo/6wHbxZnSu1822hxjzns1S/yzhqXpv4iLWVbCOdtO/J21KHl9SYhilyQGUBt+/UA
	tVBAZ36eO+OHGn9Y31pe3nFjdnx1WF0fBYdPTKMm60IGMFwMqlCQTbE7hWLh+2WTE1pxK1TGQLt
	xWY8
X-Received: by 2002:a05:7301:4446:b0:2be:8216:57db with SMTP id
 5a478bee46e88-2c15d26fb14mr2019315eec.3.1774443437531; Wed, 25 Mar 2026
 05:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4001609.1774391729@warthog.procyon.org.uk> <4002225.1774392603@warthog.procyon.org.uk>
In-Reply-To: <4002225.1774392603@warthog.procyon.org.uk>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Wed, 25 Mar 2026 09:57:06 -0300
X-Gm-Features: AQROBzCCntXGzWRv1Zw1UxwJFz_M34nFofbkb9RgsykrtknfvGumglgDUw89JVs
Message-ID: <CAB9dFdvs4=ZbqHeoMFXj39tPxCxKsApHXdyCxvjT8aAAbRCf6Q@mail.gmail.com>
Subject: Re: [PATCH] cachefiles: Fix excess dput() after end_removing()
To: David Howells <dhowells@redhat.com>
Cc: NeilBrown <neil@brown.name>, Paulo Alcantara <pc@manguebit.org>, 
	Christian Brauner <brauner@kernel.org>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:50=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> David Howells <dhowells@redhat.com> wrote:
>
> > Fixes: 7bb1eb45e43c ("VFS: introduce start_removing_dentry()")
>
> Actually, this should probably be:
>
> Fixes: bd6ede8a06e8 ("VFS/nfsd/cachefiles/ovl: introduce start_removing()=
 and end_removing()")

I think it is the correct Fixes tag, but I'm not sure that this is
actually the right fix.  7bb1eb45e43c switched other callers of
cachefiles_bury_object to use start_removing_dentry, which gets an
additional ref, and removed the extra dget from
cachefiles_bury_object.  In the cachefiles_cull case however, the
dentry is from start_removing and has a single ref on entry to
cachefiles_bury_object, which is an issue as "rep" may be used there
after end_removing may have put the last ref.  So the correct is
probably for cachefiles_cull to add a dget() before the call to
cachefiles_bury_object.

Marc
