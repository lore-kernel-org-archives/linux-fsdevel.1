Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D94C3A1E80
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539915; cv=pass; b=AHGBWVh8v8oqZzwwtwb4Q4Djxr4SmJp33hzAdXl3rfVN3SolTQVYHu4tb2L86rvWPzg9Wgn2r83RXjiYhkPHwMV7qed7lCm1ZTmPQjwNSWL0VWPYfeyuMhOaklhXYkDZxD3md+W2/a2qszV0ubnaVs9MoPeZeCxp8El0REXkTAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539915; c=relaxed/simple;
	bh=JaB8MKARUyOluTUTKfGfO9Fwrtc8Ku2njk8Dxn08suU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VgWL0fsEDCi/ObISlT68aAqHFywk6m/99gJsYQeh0YHqkyoj3apbVKmyrwQ+HFmBV8HP+J8fj1GfjZrkf2DiXZfTG5zcXDzw+DoLIRJUGr/a8IY1IJ2Ay92SebQT98Dgh17r8QyairQCAgLKML6zwg94UzD+kpnDh5M9UgYidk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LW6ZqAC4; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LW6ZqAC4"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c1372f84dso6681351cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 12:45:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783539912; cv=none;
        d=google.com; s=arc-20260327;
        b=A5jNAF3Af7Eo/rTwiYe5gvTWGqUsdNsPYZyQ6CV8SyvNgaQk1+En1DXlZ4zAO7wBZO
         8lchXt2KFYJxA5VocojOe4T0hPU5Wd5W2yna+BdFYxdxpV4YkYUqu+n3CyqrYouMljIU
         Fs9MRbDin2iSf6sRvqXjMTt1nDMau2w4dJaX/pn+Vz4JwWrCp7wwUpZx+EhKQVjqRU5I
         GT0vX97HCAiNylIaRdexCNOjgSMQCJyHk6Tze4a6KBO2OJ/TOBQ2KdZCznrEOcpqelTD
         dgKzZWubxBHuuZgHlFHxgJi1kCdPqTqInhin3TnSCEczB4SLyzqE5fnz9lSAnT6SFbTB
         /TwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BRAVl1LUxqDgkvoB9BijEMJL+fVxc4zMfLM5kk+MyrU=;
        fh=PTSutLdBezsCLMvu3t3OwccTCc0kzl/a0qhRCqpmLYk=;
        b=SYJCsdSFLM8/8peOI9vOII9ptqJLFOR9b1m3/B/zdAlhTmDVhMS4lUZFbkFZ53AFIy
         2c27eJdJwAnhq/EtRAxx91H0fG4OqPgwSpp6zyDdUc/CBBiqeyZN4Uw1algN6oY8UW+w
         dpB3jDVIJJJQN/dN4aqwUB2fh73124VmoaAniYIfYOr3498Tofy4FYR71RlS4hUT3ucQ
         Eu57YIedzLJfe0sk3aQSc2aZ9H7A1RETXJVJgXkityRYSo/SR5v5UnAsbUd6yFE91eIO
         PCqjcrEhfSLqo1tMxTuAfT4ywCp1xIdFS72HgFN4bV3ca/NSXt72DlwIKMOZIc1DPtsx
         hkgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783539912; x=1784144712; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BRAVl1LUxqDgkvoB9BijEMJL+fVxc4zMfLM5kk+MyrU=;
        b=LW6ZqAC4FbxbBm8HLLrTFWWlXoMUJ9CUp2FdEycrQL1F9NefHq0xM2Dq9eWhVKBmjh
         JHlkEl3qhrEXAXf46hGh6OVto2prj6QX52fAtlIl8quaqYYWRzrpiCxZOloGEaHqXIQR
         G9sgax2w4irmb4tkY2CyHmQKLbv6l+q/VWoL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783539912; x=1784144712;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BRAVl1LUxqDgkvoB9BijEMJL+fVxc4zMfLM5kk+MyrU=;
        b=mVJLmwME/o3oxPj0Y2kaohG/kGuinxc7eM1+ccZNWevXuen2rYBOYsBcyBuYts0/WZ
         OjVMoWWlPFzCeNTdHpt4GRe8rW3uM6vQxKsAN/s8EzJCFReIBOpzwb+Vuc1IwJTkHdh6
         gCEn5pyZPW98Gd20XXlWJUDlP6nAyhJE/zvkafOhB9k+Zxd9ur1k6S9EfL80jEKYH9YV
         Tss9oYSOxlAzbmjTlh9becxLkv79e0qGobHPx8KCQ4GAPZ0y/ujCGEWLpbOjDzMOdGo1
         653n0bRM6RH24p1OqldPYRqud3GhWFxhk967gDxKLsCMxFjsSnk15QvrnsX7xUp8lnUc
         aEFg==
X-Forwarded-Encrypted: i=1; AHgh+RqbaLv73bgYygoYUDxWfgYvzUvgRGCB8f641np3iO8zEEOcMUQUvJFkYkqLyhs2YNaI0ryN/F5cqK+U2jPk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2orQNtWmwTkDs0IUrzd/kwHe1dtjOBqkoP9QlvfOc/dwcK/m
	wonlN7ANXMLkc2ZBJA9A5aN/Y1gGi7JL8dur4MAf1ZEObOxNAq5P+E4o5aYEMqK2BLueTFPDrNk
	n0lovriZaDhVFQeOlkGu5Hqu6HRIB9jbB+sh0pdSD0U3NwOMKb2u2xGg=
X-Gm-Gg: AfdE7cmDY+Nh6kiHCjr8IS2iVEcbgXzJCmbOA+Y70i+ha05BSifl+LulBbe1Ln9vBpf
	dKHIpfMChom46EOAg0ZKMakIOGI+CCRtiHDoYVwh2vnP1vbZI/q6HD08tJpf2ZUiypyQCmTE2ti
	7w0a/dB6yyGshlycK6/3lK1+3E92I9DrKupYiDaCicHGdy+c0S2XHHtULpj6dIEiz9BBAXuVP8l
	s3/75hXbTue6hA/GxyJztPkdebHWvX+/XMS3AjruWQ6spY3gAFufU0PlomotDjZE+9J5lVzC25e
	I1QUHYisYilo+n0ciqZr5p6EkWDmZJKR+qN32g==
X-Received: by 2002:a05:622a:2282:b0:51c:4eb:b586 with SMTP id
 d75a77b69052e-51c8b2bcca6mr44081721cf.3.1783539912501; Wed, 08 Jul 2026
 12:45:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com>
In-Reply-To: <87o6gh79yi.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 21:45:01 +0200
X-Gm-Features: AVVi8CfEBqDFsxEsCKynN2toUTD0jqsYUgCkXMmD75nSowC3aB39c38nRzYyz0U
Message-ID: <CAJfpegvUEEbFnCa1N9k3gMXpw46YFpWuta=G6brON1=xU36bgw@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 17:55, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> >
> >> Amir suggested to add that functionality when I've asked for some
> >> feedback before sending the patch here.  I am fine to drop it if this is
> >> the consensus although I see its utility from user space.
> >
> > How about a completely different interface:
> >
> > int get_fd_opt(const char *name, unsigned int index, unsigned int flags);
> >
> > Enumerating layers would be as easy as passing an index stating from
> > zero and stopping when -ERANGE is received.
> >
> > It would work for all filesystems that use files as options.  No more
> > fs specific ioctls.
>
> Is a new syscall really justified for such a narrow use case?

That's the reason I advocate pseudo fs based solutions.  Let's see, we
had a proposal to use openat(), something. like:

openat(base_fd, "mount/options/lowerdir+/0", O_ALT | O_PATH);

Meaning that O_ALT switches to an alternative/meta namespace that is
based on the given fd and in that meta namespace the tree under mount/
represents the attributes of the mount that base_fd is on.

See this post from Linus as well:

  https://lore.kernel.org/all/CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com/

The statmount api took a different route, but for getting an O_PATH
file this would be a very natural interface without added syscalls.

Thanks,
Miklos
