Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795038587;
	b=eP8zYfsQ6Cfo7VcEeqrp4nK1Y5/b1+KlfjDgf9aRmg1Zc32GgowFwkKSCHuYlLN2aOKW
	 VgWVoxVRIlj1tPqVfmkoR4/7nwAs/WgcUtKDbt2SvWjYhJfGfqHfDz7kxbrm9Vmqf+/F0
	 evXJdXNJVOwqi/CXAVRvGtmyGmvcadev+nl7iOvbBbruNfPUNXNb1nZxqsXeWIMrPuQ5G
	 pteeE5YqYOG25cp7Rag+7B1ytMaVBsU1kfb/kFCokRLHgkf/fELpjjUL2+O98IcqtQ0r3
	 4rDVPhg/Vcc22xEXP0F2/C+XOpncQ4xl3CSDtWWjzIL8pIdPO7CyrRuyQkpW7WWW5zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CZPHqjEKi2vg5bpASOGDI+kJVhoG5JNXko8FEV4Oxfg=;
	b=IUPMqkWJFF5jjGHbNS5SztWcGhClPA3rf6GqHAt9ne45r4gffSb5EPhY5SvkNr2PE4YM
	 7RDVQy5jA41AyV6BeBE1VTrdRnjXA12vSX3GP2x/h+7Ii/RrDFzTfqLF9761Ps5XawUnf
	 3b2MXoWvOfm4fJ0M6LqQGso0Ax3i0RavxHvxQsRov8t1hDwWps+6eQ22yNsACfymi3jbI
	 XG9c3jXCBRgYha0bDzG6nmyPVPj6WobabzPIKdE/1dGcZ6tQfm+oAmVES1+WAK8n5ULeB
	 6umzrZ38KFpVJdehUv/TpT2aoGLNWGvulvqnfXljIJIf+abAYl9KLI3YFoWhLPlus4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KaciEEIF;
	arc=fail smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A267606A331
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 21:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A267606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KaciEEIF
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c15956ce07so284198e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 13:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795038585; cv=none;
        d=google.com; s=arc-20260327;
        b=pkvDiXetcNjg4SKnnvVuPIdF41BrPOhf7yH0ZnTIzDL8xRBZpgFgqSfTspX5vn8Li8
         apsgUVhp/7YjykI1P1/HybY0+TQFTJJ/qtCKlpe3DRT5UR5HiBFqoRZQQnqxQ+z0crBY
         9PSJOcY2i8fkvuP6R6q8vyR0UzI43D7WidbaCM496TkCsOHdaYTV5NYWnp0TKRtU4rcL
         SszvegUn+r8XWKWzVzPV5/IqYzWsOqTf43SJaLkosJZT+28N/fiaWBUQwBIgOde9VKXF
         Uj4cw9YztHwEM9H02IOawqHUoTl6zyjJwPpsIJCYqW27mIpErOQu4eFbwoi5LO+3Xl3z
         kpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CZPHqjEKi2vg5bpASOGDI+kJVhoG5JNXko8FEV4Oxfg=;
        fh=JpWd7XKC0nfnYklsMotgjgEUUw2ZA3UR8lR6yvgNd98=;
        b=V1IEWNdewEBLLJ5taX1cPKrel1j4RTk0stEiwhLhCT0hqJIE+n4aCz47ocXeQ9yZJ2
         wdRkhZ/KdmXuyu3tTRhc0Fpacq7tbgRh2vHKz8Xn75qyg8aExXzTjjGbLON4fhSx614v
         +JcD11sqzUxK5Xs8+jlrCwde8oAM4pM8QtwOQCQJzNrMFkYHOWO4oNwNr2TZFYPVFODe
         wHDNWCqBC/gORnrIEjSOSt8XS6kMNdc3HIeMJRNmt0EhQmPhuJS78Aoh0p5VBnaazx9L
         EHIsqedle43B+rvgiGcHseuJ5jHevKUTHKxDmzAJC2OPMwRMKgodtGi7rnEL+6aK3Vti
         U6Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795038585; x=1795643385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CZPHqjEKi2vg5bpASOGDI+kJVhoG5JNXko8FEV4Oxfg=;
        b=KaciEEIFbL/YwiIDScNJOJE/ZISkK9Hm5quErzyii+lNT1WfC7kXZg/3FpRZhArF36
         Ad6xuGX4OWHMMcj6Uv+Z0P3xjYKr4xdoCcBZYBSZ40V+hyh+sFba/6f/Byhy6/IHBYV0
         /krtJ2/zrzEeNc29BPoEzTEoutLnweqJEraHWGz4Xdqq1myp231uUNQJfdNikDffJxU0
         OhrtcSpB956rNGC7WaELPyoRadGtF0ROnUwsxD71d4jKhm42p47rbfwAaCyy31Ekzp8c
         eLl8tZDuFmJ51rjZGikkRD11SztUd+7xg3bdsx6y/sDvmlwM86hcs70DaEGgQFzFJe8W
         wh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038585; x=1795643385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZPHqjEKi2vg5bpASOGDI+kJVhoG5JNXko8FEV4Oxfg=;
        b=vr1HBGwf96zEH4QwwE3ZqmL/WswrG+bGM4Y0zcvJNlkhup/Rck4CZ1u1mQeIi4qhXz
         8lQUe+r66w2tEdIUduTkAZYIT5DWtXAj1rjrLxope8pgg7Jfy4VEyG1fgAnKpD2FIOgf
         7rKgCKKwmvhh5a/i44pGbUfqI0L0HGsmkLYiOcZ4S6BGXv2S84D0pbL8WyHn6Wmkl2VJ
         Wu5XI+2sRYfw7OhZEeCeYpM9nhLp9zX/X6DhtB9n1ZIBkRHeit9LjMkkwhG5FqegH+g5
         ZdEz7O0JFSfikx954Sf/IQ/FOEtMs+73cZrHMqBktkX65G1vlzA9hbb3uuIcg5nobnlp
         Sh/w==
X-Forwarded-Encrypted: i=1; AL+hErHH6GIsDNt0tsbpTZjL/R5ZtXgKe/v91+OFfiOo4k66uZROLepYW734izMRpbh4AUSlTtGHag6TY61DLlWb@vger.kernel.org
X-Gm-Message-State: APuU4Z/mw1kBUBKgPz+d2ixK2naaMKNrLsVWWXjXLCyrYQH4mPBjAQ3U
	0AE5z5yX6XMl83hPjj5pUZ7QnHdXcodv/R9ocP0XQu+EbUOg7g83z4Qvz0TDEeLGUidg/kmxrFs
	W5Y1ULfpLEcEiPjl5Y1rFkKCXmrvqs03ay5xh9d9x
X-Gm-Gg: AYBFou1R6mFXv+GGbDnkbAaKpZHJBpdc1DDzt43K16NUyS6ZmJA1X1NLACN0PFnrv4l
	vkhZr8z9cVrcYi4stwoMJRv0DwDUNiDM+24qpvyEpwDTL/+iLn8T+n/Y4T1FmpaZYQQXy/7wIM7
	q/vMmYxcZuAS+ciGCpLhilINwGYvgv9plf+s1FdH0Q15KXfq+iupnFbmCJ/u88DuU3koyyM9LSi
	JVJ9YAbMMtODKUiJ8h9y3g+bck1vDmmNKwmc47mvrXMc0W95YP9Ufzn3t2DLHzutmjLjD/qFyY3
	y/8lf1vWkgGbBx1HZEeKOX/3WLHAVP1oJ1ADq53XB6kzSQ7O8rOPZQeru2gUM/Gl3gtaCejS+lN
	clQe8cDZgxppQanuHPGCpT2bZRkszuRZdsA==
X-Received: by 2002:a05:6512:3c8e:b0:5c1:ac5f:e596 with SMTP id
 2adb3069b0e04-5c1b40e9b72mr9362e87.23.1795038584801; Wed, 18 Nov 2026
 13:49:44 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-befreien-addieren-eislauf-e09212803534@brauner>
 <CALCETrWa1SBLcb5oWjqjgzZvKvCoHjmYFk=Lf5ytEM9uqm5jYA@mail.gmail.com>
 <avM41a80aig2de-R@google.com> <20261111-behagen-faktisch-entgegen-e2e714373895@brauner>
 <CALCETrUjW=kXxyggDUvEN+Pxc-pE98eVbdW8XBU8JzfqXj_voA@mail.gmail.com>
 <20261117-rational-ohnehin-unbeugsam-e5c04759a156@brauner>
 <CALCETrWhuOnBy0N0KznmczD4S2XEK0fbr0C=1KFQqTnoTJbQbg@mail.gmail.com>
 <20261118-stapeln-eckpunkte-lesbar-ee73537f474d@brauner> <20261118-zufahrt-baubeginn-gutsbetrieb-c09004227e8f@brauner>
 <CALCETrUMNr=32ENT6VBKPzoyJDfaX6nzZsjMVxuz9O3z+6LRhw@mail.gmail.com> <20261118-professionell-kondition-kerzen-5dd23c1ee490@brauner>
In-Reply-To: <20261118-professionell-kondition-kerzen-5dd23c1ee490@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Nov 2026 13:49:32 -0800
X-Gm-Features: Aa3M54rEY9J5hVHcO1DPxjhsi7Vv-UveBjN-XrYjaJlUs9gt6QOZEnzJ-89YhLo
Message-ID: <CALCETrXAGpb=OZyGQ2=VfKmA6xeizAsusGZ_HmRtp_s99RpRJA@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: Christian Brauner <brauner@kernel.org>
Cc: lennart@poettering.net, Jann Horn <jannh@google.com>, 
	"Hallgrimur H. Gunnarsson" <halg@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:37=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Nov 18, 2026 at 01:12:45PM -0800, Andy Lutomirski wrote:

> > > > * deny privilege gain on exec in the initial user namespace and all=
ow it
> > > >   in nested ones. I mused about this in
> > > >   https://github.com/uapi-group/kernel-features/pull/38
> > > >
> > > > Also, since v7.1 there's CLONE_NNP to spawn a child without no_new_=
privs
> > > > set.
> > >
> > > Forgot:
> > >
> > > https://www.thkukuk.de/blog/no_new_privs/
> > >
> > > has an overview of where we're currently at.
> >
> > Nice!
> >
> > I commented in the uapi-group issue:
> >
> > I think there may be a rather more direct solution to this problem. I
> > seem to recall advocating for clearing no_new_privs when entering a
> > userns way back when, and IIRC I dropped this as part of the extensive
> > negotiation to get NNP into the kernel in the first place. (I think
> > dropping it was probably the right decision to keep the final patch
> > simple.)
> >
> > But I think I would still advocate for an option to let clone, unshare
> > and setns callers turn no_new_privs off. The logic is that, if you own
> > a userns, you already have all capabilities in it. If you enter it,
> > you get to keep those by having them raised in cap_permitted. Being
> > able to clear NNP and thus drop and subsequently regain them does not
> > let you do anything you couldn=E2=80=99t already do.
> >
> > An LSM hook for this would be needed because this argument does not
> > apply to non-namespace-scoped LSM-based privileges. But the LSM hook
> > would just be a "may this caller enter this userns and clear
> > no_new_privs while doing so" query. In the absence of LSMs, the
> > operation would be allowed.
> >
> > This would allow a fully no_new_privs host to run an ordinary
> > container that runs, in the ordinary way, without no_new_privs, and
> > without hitting any new LSM calls after it's started.
> >
> > The API could be as simple as a CLONE_CLEAR_NNP bit.
>
> I think that sounds ok. I worry a little it since it would somewhat
> alter the promise that NNP gives. What model do you envision?
> It seems that CLONE_CLEAR_NNP would only be allowed with CLONE_NEWUSER.
> I _think_ this safe even for privileged users that create a user
> namespace and map uid 0 to uid 0. So I think this could work.

Whoops.  I thought that and didn't type that.  Yes, I think you should
only be able to clear NNP with CLONE_NEWUSER.

(And if something like cells ever lands, presumably a task with NNP
set should be allowed to create a cell without NNP in the init task as
long as the same LSM hook says it's okay.)
