Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8533002B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774537600; cv=pass; b=DHANmh6zwH+ttg4MEH1SEOZGX6BEgEESlr6dNlfRlnjgW7/q5I1F4JlVrBIjsE8NIWgpo4bbCaYtmudH3LLGi07UKYO1vB1FB9h/KSPxp7vNp0I7GGOg89/qL1SapbzxPVMCpwKFGofsuXAnOrYK8N6LoINK/WJH9m6Ykldt6tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774537600; c=relaxed/simple;
	bh=UyBKRyoLtT4geH1Muv5tUScdFBcp1tOSfJeu5I+ydIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miq7eUvyzIWaAHz5sGPmTkAMsKFhqArXroohC+qwl7jkwj3ZnAscXFrVcLwCx2ILig1rZz7QDpxyj1WH+4zFd8pYNyu3YDSmqvZmc8KqSV9psXLOlyqiwm/8r0riJk9ucT0CIU7bVriux1Wk6I7f0OnPK55YlsmqoUsniSxaH0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EW+9xUBv; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EW+9xUBv"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50917e02472so12894091cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 08:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774537598; cv=none;
        d=google.com; s=arc-20240605;
        b=DKi3oFzVYhLd/30rG51dBjUSIsm2g5fSe7B/i+V4yUqlxM2rCaJ0sW5ykIRZjM4pZm
         fTqn3nKOkRo5wQ+Y0rkbrWcABy01fzwTHb67KKzl2+25aNdqCXm6vAizeOtsq94yz80S
         ZvNzUbJKSa5U1WQP1JFvynTJwEC/6yotjd/fQ/3hLL+W8OpgFNG/8PmTYzdPQ3tqtKfy
         6KkJGJ8/9V9atZpX7EaV86u6cjh7VsEqo5J4z329oSkCQAvqT2VK02uKIMboiB/j3xfg
         ZoUltsNDCIlXhcKxHnKRowxtftKdE7DJfatD4e1/OCbUjX8zLNo90c4fWxuBT1IRV4NX
         VCHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3aEsl1o8Qb8in703p1nbzb/861+bCHjHi/klFzmyVXk=;
        fh=uMEjdZmu+CBZ1NxqbuL/asegVSSFWCfsmd59bl43JIA=;
        b=UQEOsM0A5ccbUAJi27CB5PtP4tItAGyO4Upylzi4pSaBxmaR0qGTn7ubTcMx6LOxaz
         WAkDacpeSdj/KWzE3VHhD8wDT2WoaC+H1YAJpeScI7+1hnQMdoS+GH3NFEh6ium4cpFg
         X9h+l4/rmiLCjb3PLibu1qSxPfHnp//8K7RD0Fnvma9iU/YsQsPLl9m+3JN91iohACru
         dE79iTzgJ4+B6BqH5wgBcgKZT35MGAalyJZq3K3//PD17eA/ZJvLiBXPcnXIvdSd/u2z
         wmYlZqkHL8sZ1QIfdmhFwDfoqHZuAw6MB350gnLxq673BeZkoNQkK4JErGBnZwJZmM30
         FVaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1774537598; x=1775142398; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3aEsl1o8Qb8in703p1nbzb/861+bCHjHi/klFzmyVXk=;
        b=EW+9xUBvv0qpZ10odkKm3DDwv+28PpD2LAIFkmyTYOE7+czxyKIIyHYDdsm/kuxIJ7
         TeLQEk4az8wnAA8IIG9yHiyCfmEcS0IAi+qYDPiB1IFpc1sn4NJr2fNrxzn4/anb3nZk
         zqRObeZHa8LChedFSEqmxguN0hyRiRlKstDVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774537598; x=1775142398;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aEsl1o8Qb8in703p1nbzb/861+bCHjHi/klFzmyVXk=;
        b=pD7uhsT23IZcH+fFr3sSu77WCpcJLqhSirkrzNLn58LzA0P9aY792+pnjxWxkTBTIC
         VjoRrEy0lRHi7kyR4mbf023hJ6wZFUwizOGhELjSIphBt2HG2qoZbb7imlKnbCHout/2
         qk5u6DsVKhPZ4/HpZHvT13PHzHxYKR2IBrzVgIRIRkscIAjSkx1jFjhtAzJ+Zru8/Gjm
         83e5mj0+B1q17PJ3KuMiI4r8LkmcjgOLcvlaImJKeXmgRWSaqi4+dAVaXvHW+QOKPhaU
         RDR4lY5Dq+svz42AZfCmtWOKB9DBS3ze8vIm1o/O7pnX+pb3tXUf6UirjT8f5dgyVlGa
         kLDw==
X-Forwarded-Encrypted: i=1; AJvYcCWAV9AAr79h4Z4l79ayD6FHkwjmJW+yFS+sGIKBGDs4SaAMHBLzfq4VB9OKVPxWKNuv+42dIvjnykMhB5tp@vger.kernel.org
X-Gm-Message-State: AOJu0Yyns/6MoZh9Tdb6Tpp5ej7M+aDHcVhPl/O12uvxwS1Juv2YJoDj
	jlazB3BFCi90CtbxJZMB9wqUNLJCPIp2fLdwRLySf9e93528znrn7IhjhLnZI6tXEU1j+NBzxCi
	D4/5f+TPylEdRAS2no8opUGbSecXKbhWBb9Vxw6ha5g==
X-Gm-Gg: ATEYQzzEQ9cwpFbsjcYSiDhJnZ931jggx+9rM5NtgQDzBVRxQM7osUmAKRXiNJdCPuq
	h3Skd87BUR5YFxK/hQyAF1fAPCrNnJ8CfCss6JGU+lzXqifiZMhnmP+aSjaWsRZpO3+ZPfhpCoD
	RteorieFFVc7QTjASiGKe0eKQouOVweZDDALJJzySsp/eBb4+HYccj21G4uESGsL6rYlhJ9VR6M
	kTiaLKSMAXOW0jBHPp2uOA6P3xHLm1wmaAyxt6+MTSjGcNTew/JJ7/3bD4RkNLNPxfSNxZK3MdI
	qMPm66Gs3Q==
X-Received: by 2002:a05:622a:14d0:b0:509:2b02:c1bd with SMTP id
 d75a77b69052e-50b80c9b240mr114327621cf.12.1774537597906; Thu, 26 Mar 2026
 08:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318-fix-inode-init-race-v1-1-a7e58b2ddb9a@ddn.com>
 <CAJfpegu9hjgwmCtM3xF6rjhY6jSvLnH+8wkr6a++RMPNDUpgWw@mail.gmail.com> <acVIc0fXasKIptC8@fedora>
In-Reply-To: <acVIc0fXasKIptC8@fedora>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 26 Mar 2026 16:06:27 +0100
X-Gm-Features: AQROBzBUc28NamLChg36Tfad_hHXf7KtQMnwLCCb3ZOXwuOEcNhvlx2AXwWp20o
Message-ID: <CAJfpegswtxB1DcTOkRs7TT=WXRGbOWSe10AvfGKfuCYQtOXjNg@mail.gmail.com>
Subject: Re: Re: [PATCH] fuse: fix inode initialization race
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Bernd Schubert <bernd@bsbernd.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 15:57, Horst Birthelmer <horst@birthelmer.de> wrote:
>
> On Thu, Mar 26, 2026 at 03:51:18PM +0100, Miklos Szeredi wrote:
> > On Wed, 18 Mar 2026 at 14:45, Horst Birthelmer <horst@birthelmer.com> wrote:
> > >
> > > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > >
> > > Fix a race between fuse_iget() and fuse_reverse_inval_inode() where
> > > invalidation can arrive while an inode is being initialized, causing
> > > the invalidation to be lost.
> > >
> > > Add a waitqueue to make fuse_reverse_inval_inode() wait when it
> > > encounters an inode with attr_version == 0 (still initializing).
> > > When fuse_change_attributes_common() completes initialization, it
> > > wakes waiting threads.
> >
> > This should be relatively rare, right?  In that case a single global
> > waitq and wake_up_all() would be better, imo.
>
> Well it depends on the use case. We send relatively many notifications
> since they are bound to the DLM system and thus to changes done by a lot
> of clients and so it happens that you get an invalidation while still
> creating the inode.
>
> What is wrong with one per connection?

It seemed to be something that would be very rarely used, hence having
a waitq_head per fc is not space efficient.

If two such events are likely to collide multiple times per second,
then I have nothing against a per-fc waitq, otherwise a global one
will be just as good.

Thanks,
Miklos
