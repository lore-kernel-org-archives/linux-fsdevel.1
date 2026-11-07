Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794077276;
	b=E4R09qN75nfBvoPVCgdP1MQhg1tiCIMkRo/rQw89C92dz06N9P9ed5b3mHaXvJsY8GLM
	 p4qoLOfJeYSjN67yFBfXts/3cvaxDKT8I8irHTUsOWxaR/2CIKK7CnKYRquY9x+UsfQ24
	 Hq8/OzZMTW1D1UX6MyMYYGjfbQUkF03GFp1JsZoSt7jfIcURUBihP6vjD3qp4/Qj0umwy
	 69aHvL2MUDNRrlXKfDzR1vqnCzIyTm0lNyB7tHabiaHJYbGdAl13+lRVh0RK0ETXYD2Jf
	 tnX9hRdsXxLRy98SoBfgjGlC6TCUPBkHaxI4D39Mp437kwjLR6v4dN+V0vQVQNxuKYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794077276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
	b=3OwVsj78sAAWszqwPlSyAJ3oBMbo9NWC8AVGoDB1wco7tSvD/IIHGb+7qIFzlCGIFrqP
	 1WxeQvKl7IS1LuIUPC7WjEHImxpjwLlu+nC1lxxj6jW7dEOr5FTYMZlBLxcSZm8KUKvwQ
	 yKMGbo8pUDPtLb4MDpVUqIqtV9Ltu40qWdUbW4feXlI9ix5+tj2Xrb5JuEIERBzg63sAr
	 Mof5eYuqoHNXndIera4m04rXa1cush4Y+AkXtBaTlJKE92z9vRuGbLe101BTYB2beGzY1
	 MT97TFHqJSjIT4BOytaKJbbr5+VAtBlqDSNveYoD6yw+vi/z8uNuaX0d90nHPRKfIKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jDsWkgNe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3C606A326
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 18:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C3C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jDsWkgNe
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c1479a959aso135875e87.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 10:47:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794077274; cv=none;
        d=google.com; s=arc-20260327;
        b=Kx/0P7XRfsvtJh4ZTtAo3FFxEuIpoy5+LUkdU/iYZOF8gCI/Rjabe2yPhNar7nRq4u
         QkqJi1lwO8pF8/8bQtSe+gIIFBKdNKByUvO65/4OsM9KSkg6Xj5sQo+QRS+Hx4aOQbjm
         lpdx3U2xwxUtv0YtvVvPCynyWQp6ZxMQey2mJcRj5TXJ+GpgtmUWGkj1dqtogTQUfI8M
         4Jiw9x4xCfXc7cOq8bfdwzO4jz0XvBKSAM45TZObxvjBFq28WDdEAep+8Yrd7bNRslZ3
         yTcJDWd0bGhsY0GsXHB4dbs8iQF7JGTfpj/HIKDzXfNx0RW2WpcwCDCFvpJBy/o/r2Bl
         OJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        fh=ll9FK3i/RXGVWeQE6aiZaWKSokDqUSX7zA0ljwZZ/vQ=;
        b=qjuCro3DnkE7p1Pulew/mmMCwIcPRBlJLUlC1a2AUIUukYFkvDZei4FUfkxevF2Y1V
         oVXH4RUkpq+OB3tyNmgV/rf6gXd8+vmPBYOkBCtSTcjGRG/gniPTob96U3bKVz1cxLzY
         aJbICtq+Hq6wEq+ZIwEnzk4cNtxk6FMrxfmhld+hvhusGYnUOiyH5ZIpSsHHKfGpqJBv
         hDunHv3A2CxG6ID+oVF7zPp7NNsSU81aYoNGnO5rykbh/BhulOisviQcrIa4r7Tp4bwp
         dKP/DrXtw2M23CjIAlsTBV9gK0W9EuLxc+ackvTtbP3PANs80HoFqGcQp3M7Tx1lXAKk
         HFQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794077274; x=1794682074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        b=jDsWkgNeFsbdQ7qKqbpHSGOmDkfyI4OzDS2pJc6+Irn0QHpBxG9wPbmRTDmNnDdzS5
         db8t7KSVAGcHE/QtRbNhFDCWnX4uqUr1mEeZuLglr9YUDK4k94+gZZ0e2v5XDqaLBMAu
         GF2mKtLq3tPj9IBZGN3w1gGTAF0jFrsZMFCKcXAmKrirJiOIjEcuysNg1l24IqICP4gV
         r2UQCTmuYiVAi+q/1GU8UDVYE1+IZodom/D3RIz9GtMMMdasHTqHTXmlylMP0IcXnVJO
         5lWPTzglrmuISOXtwRoPqefa1QyXnIQk56sGTTb2Rf1nGsDNJzcZ5BPRF2XDpKcZZ3TD
         g2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794077274; x=1794682074;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DWojXY4nDMT9rtwg6h/b477SwUuLPC3ITyeb/WPBYqc=;
        b=KH0/jDc7SKWB5Fe5Nj5pO8Njfn1buhDUp4pTmFAIkzOO0W92XpFfiNU3aWzWwKyOhv
         e5eotCkV4s9dmg8Zwp3Ff2kB+/o85ALQ2UcNgNDY16uTZyzslvgNb39Rf9rvbQM6WJP4
         rabrBO+F9o8pqjVrYQ0bqgIHucFJDyeio065Xjr2Lm/xvxQDGFmNXrpyppJTiux7EUQd
         PJHlm/nhXc6XJmW6gbMGLBla6aqjj6pAdroGtqC+Hn5xEJiATx7pNmIwO3jEl5WmfQ3a
         n5ofk/M5yedjY1MJLEV1YHa43w9aDDajjXy4oDtdVCAjJa32f5zPEpCHtsXQ7QARtpnJ
         WuWA==
X-Forwarded-Encrypted: i=1; AL+hErE5tUgr0UU5niUcYnx8MS54PAu/wmLt3B/G7kHdQ5Huzn5Kcbmf+piPsU7OwCUahknFKlScqgAvQfTQj5fZ@vger.kernel.org
X-Gm-Message-State: APuU4Z8ENsDnYc+ZkghAl0GKpC3+IiDzwy/sZsa/8pnhmr4wpgnz8R1w
	WhBsx7ksE2h/3mNyobZaOpKc9TqDhqS8D3ECiZZrYjJ0FMO4pT/CZhFwnmra/AsHKV9+W/B7ENo
	XoyknMT3loIwQ+X7suoeMfMd1Rqa/hF/mbBO5p6tt
X-Gm-Gg: AYBFou2JS/9ZKkbrlJXUNC1de1MZFC1JLFxa/46YfgkMFkGJhax32E+El20Rozi4a7v
	L5bMkwaw74zyin8TcABXpa7pN4PubC55laMW3+WJv5rCOHLfk1pY0H+dL7AYnlsJcBYnnBFM9rT
	p1PSJDERX49GJz3fl6V1gZ4RNGcq9brDQb7DlGArHMkVkv/kgR7kwpqGWZP9nzaI7VAVMbvjS/q
	vyvqrX6UUiYotaNyomWV2aGMpTVK2wBhkIMr9oaSsFROWkZy9T9OsRNfGQXbzp4XKatcMsr26D4
	ygjZkBcfy5RXFg5eKynbmZ+5lyqwSFJWR8F+q4sSoG3CaDXHl8/va1EK40kAlyk91AdS+0VqtPk
	xQ4TX2SiIj0dz3Fj2BEgGwFUcrfxnZCVFHA==
X-Received: by 2002:a05:6512:291a:b0:5c0:ca1:9dd7 with SMTP id
 2adb3069b0e04-5c00ca19f2bmr594320e87.35.1794077274068; Sat, 07 Nov 2026
 10:47:54 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <CALCETrW9ygriu54gxiHFLEd5+hJminQo0r8Jwd63wR69Dj4W7w@mail.gmail.com>
 <20261106-befreien-addieren-eislauf-e09212803534@brauner>
In-Reply-To: <20261106-befreien-addieren-eislauf-e09212803534@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sat, 7 Nov 2026 10:47:41 -0800
X-Gm-Features: AclHuK9s0dgg3FDVqp4WbjYQnA0hebDpEpxOAgz_VjLjRP_HfRjeTpRH9DX274k
Message-ID: <CALCETrWa1SBLcb5oWjqjgzZvKvCoHjmYFk=Lf5ytEM9uqm5jYA@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: Christian Brauner <brauner@kernel.org>
Cc: "Hallgrimur H. Gunnarsson" <halg@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:13=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Oct 28, 2026 at 03:56:11PM -0700, Andy Lutomirski wrote:
> > The whole unshare/clone flag situation is getting out of hand, IMO.
> > And this new thing makes logical sense but is really about reducing
> > exposure.
> >
> > Perhaps we should instead have a small list associated with a userns
> > (extensible in the future) of things that the ns's admin (i.e. whoever
> > has CAP_SYS_ADMIN relative to the ns) may do.  That list could
> > include:
> >
> > - Create loopback with sensible defaults for ipv4 and/or ipv6 (i see
> > no obvious reason to separate them)
> > - Create tun/tap interfaces in that ns (and attach them, etc)
> >
> > And add a very simple new API to do these things.  Actually, the
>
> We've had this idea in the past and I think it is reasonable. I had
> always thought that we should expose a system call to create empty
> namespaces ot any type. Usually I'd be excited about that but I think
> that point is a bit moot and I'd really like see whether we can turn
> cells (or whatever other name) into a first class api.
>
> The problem I have with the patchset as written is that adds a lot of
> moving parts. And yes, I find the CLONE_* and UNSHARE_* flags plus
> sysctl to be suboptimal as well.
>
> So the TL;DR is that CAP_NET_ADMIN + userns =3D
> CAP_NET_PRIVILEGE_ESCALATION 10+ years later. And this patchset wants to
> put it back on a leash.
>
> So why isn't an aggressively stupid solution to this problem to split a
> new capability out of CAP_NET_ADMIN so it covers the absolute minimal
> set of things that should be allowed instead of doing effectively the
> same thing but split over multiple apis?

Because we don't actually have a clean way to make a list of
privileges that are, in theory, harmless but are hazardous from an
attack surface perspective and assign them only to tasks that ought to
have them.

But maybe we should invent such a thing.  It would be very, very nice.

Other than that, I agree with you.

>
> Anything that is reasonably advanced should not be the kernel's
> responsibility to delegate. I really think the old privilege model where
> the kernel grants control over a whole subsystem is inherently flawed
> and is much better replaced if you have the means to let userspace
> services grant and delegate resources.



--=20
Andy Lutomirski
AMA Capital Management, LLC
