Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8EB36A367
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410165; cv=none; b=GsLu19rb4JOdKZ9cJQxdYEnCrN+e/OAz06XpOpy4epjXg47+2azXPrj1A330CQCGN/GPSPAcf+JA0BSSizepfExr2o/4uf9D+WxlLXt0DfKQBcU2LqdNC1JIUL1ulpk6zX+uBXXmzVDrbk9NxqGpe8mlXPqIT64nY3lVlVBfUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410165; c=relaxed/simple;
	bh=GWAzilTAhOSPVd0+e7jbvy+xSZIlIlP9/bqFdegHZ74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZRydAeEEdqhvGdILhrG/dGb7RSjtxO/Ihdn31aEYB9r5QdB5aJ+vRSnBM4k0A/XiRzIJPg8S0B7c4JWwr35siQVfekwXDkjyYnIZfl77vm39U9PvEyhQ8f3mBC7Hy9Z9AeU+IiPGlAwb5wYB+o+4djdCV5g82jd26FrtMnzeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPJMwlQL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPJMwlQL"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b77b150aso35103635e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410163; x=1784014963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NBU9KHBd76lsHQEnuxzVifTFhsHCH8TNjYTc1LaiBLE=;
        b=cPJMwlQLPjy0/kbO5DP6RIo3tbBLDc0fANh5wVplfzAiZKmbhJrp5Wxn7z1zN1g6Up
         iMXXP+WFqoalYW1VtHT315jygj6yrkFYI48VMHwANgF6HtAoaYoO0nXMn3xHfJXobgfi
         J4TFlCpQs4YUiVJJEKmizQqkLS2ZuPaPCFxYzXkBr3KFmiiuQHWerj2Ff8GREz/vvtPP
         D/WBL316RSZaZrKNwvHGeGAwGdRIEjyDkpvOPtMGLXMjGc0QP6BG1WA8RIgC9YoqHyID
         rr3etEshtVsz2qHPGqY7u/Nvoa09lfWxHDXzjbV4Ks2HXkPX5qfU39o57zFwjO9mYobA
         yxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410163; x=1784014963;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NBU9KHBd76lsHQEnuxzVifTFhsHCH8TNjYTc1LaiBLE=;
        b=IUcXZ3t6Yd2bN3AxSMg+A/UV47vW1MJ6xyjxP/zJyQcgVR4eTKsXw6XGule5zMYxdk
         8tY0qhgLuouDN7diRkrrefg0UZZ/zjN3R4uO0bVOkPtSagW5I4UtfK6bNj3Wl86/Ajzc
         Bo7pUgkf4bV7UHTMjCFdTEjI3EmKw5kdrimomf22lViILQWUxeVNiX6DYllOaxV1Zt4z
         4k+2h7YE10nX9HgKT8ZzD+WLy97a+7Ztm/rU9zGuNOi/4j1z7HnV9wgCLThMY/3CALov
         QfRT+lSt0QtKb6w+Jtteo4YgF9fqDlv7AnGC1uevia3n8N9eIwO0rcjQv5oRf/GIRgzZ
         xheg==
X-Forwarded-Encrypted: i=1; AHgh+Rqcofyfyen1P5kAeTjDMj+Ao4qirp3s8zIRiA1k1zm1ERbHM/ed064sFeZ3KkBhY7AMiIa5BQgN/C2Tsz9r@vger.kernel.org
X-Gm-Message-State: AOJu0YwUE1YYyj1aDoJ1frHoETn3dxMOAyOHNqKm7CRxho8Gl5XXJeIx
	lhxSWUBf8PwDBEs/fsMP7UwLN2uciXrEOfNOVC82hRAF8mqGpbPfxjzl
X-Gm-Gg: AfdE7cnjr/E31fjByGGneHfff9Iaf8mD1HULCkZ8OpLuZIxrdaJ/uiJIg+JJNOVqjHn
	c36hBOA8ClBdz/OQakes/WvMyY38KTILtsWL484slPlQYqRP5k2jfjG/6JW1NXeQVYHbYETCoRK
	dSg54drc/v8CrT6FVbHnXtSVmQzMAgO80R69pq1VGbYCQHoXtbuUO+vJZGP/0My6GHcCx30dqLt
	qnE6+tq3Ah+2iW5VjyrGe9DJmNcRkl4eLQ76r20xNyVRhhUycKcXBPWHi47yYXcHPXbwBWXzRlr
	cCuuPNutfLzN6UxWJehmuzdr1aXqkHHJmXecNzDKjFCA3ow8NRj3yBihLo+zRksdodLdCL1pNSB
	pAl/xmzHZdPuxXwP8RfO/o+7fJSO+vp1LyU85mZ2CJnWVgUkKtSxQV8c1NZ5kz79mu2Xkl/IKqo
	kR2eq9eXB+/Z64cY3rccav91IG3bIfJyLRaO007/OiP8YgXA==
X-Received: by 2002:a05:600c:6990:b0:493:915b:dc4a with SMTP id 5b1f17b1804b1-493df055999mr42892705e9.8.1783410162564;
        Tue, 07 Jul 2026 00:42:42 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f41014sm32544825e9.6.2026.07.07.00.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:42:42 -0700 (PDT)
Date: Tue, 7 Jul 2026 08:42:37 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: NeilBrown <neilb@ownmail.net>, NeilBrown <neil@brown.name>, Jeff Layton
 <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Aleksa Sarai <aleksa@amutable.com>, Amir
 Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/14] fs/namei.c: use trailing_slashes()
Message-ID: <20260707084237.3d445b19@pumpkin>
In-Reply-To: <202595709.128794.1783371348230@kpc.webmail.kpnmail.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
	<20260704164149.3480051-2-jkoolstra@xs4all.nl>
	<178331016004.27465.14624469599238469373@noble.neil.brown.name>
	<20260706082947.248bcd17@pumpkin>
	<202595709.128794.1783371348230@kpc.webmail.kpnmail.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 22:55:48 +0200 (CEST)
Jori Koolstra <jkoolstra@xs4all.nl> wrote:

> > Op 06-07-2026 09:29 CEST schreef David Laight <david.laight.linux@gmail.com>:
> > 
> >  
> > On Mon, 06 Jul 2026 13:56:00 +1000
> > NeilBrown <neilb@ownmail.net> wrote:
> >   
> > > On Sun, 05 Jul 2026, Jori Koolstra wrote:  
> > > > There are several places in fs/namei.c that can use the
> > > > trailing_slashes() function to improve intent.    
> > > 
> > > I think it would help to state here that trailing_slashes() is changed
> > > to take a qstr instead of a nameidata as that is useful in more places.  
> 
> Yes, thanks.
> 
> > 
> > It is also taking the struct 'by value' so should really be always_inline
> > before something makes a compiler decide it should be a real function.
> > 
> > (Or make it take a pointer)
> > 
> > 	David  
> 
> You know more about this compiler optimization stuff than I do, David. So:
> is there any chance this does not get inlined? I am fine with always_inline,
> but I don't see it often in these scenarios (just inline usually). Is there
> a reason for that?

There is a view that you should just let the compiler decide whether to
inline something unless there are technical reasons why it must be inlined.
But I've seen gcc fail to inline static functions that are only called once
even when they are marked 'inline' (that mattered in some embedded code where
any spills to stack would make it too slow).

It is normally the KASAN (etc) options that cause functions not to be inlined
(as well as causing massive stack use when there are lots of calls to functions
that get inlined).

It has been suggested that the kernel be built with inline implying
always_inline - but there are a few quite large functions that are marked
inline and they really don't want to be inlined. 

> 
> Pointer is also OK, but this is just two register copies (even if it does not get
> inlined) on 64-bit. Is that really less fast than one copy and a pointer deref?
> Genuine question, I am no expert on this.

It isn't obvious from the code that the structure is that short (I didn't look
further than the patch and it appears to contain an array).
But passing structures by value is usually either not intended or inefficient.
Any longer than (I think) two registers are passed by taking a copy on stack
and passing that by reference.
(In the pre-ANSI C days you could do that by mistake and spends days trying
to work out why one code path failed to update some members.)

On 32bit I'm pretty sure the three values will be copied and passed
by reference.

This function does have a strange name and implementation.
There is the hidden assumption that if the name isn't '\0' terminated
the extra characters must be '/', and the (bool) cast was probably
added to silence a compiler warning, but '!= 0' would read better.

	David


> 
> Thanks,
> Jori.

