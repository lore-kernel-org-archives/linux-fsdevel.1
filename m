Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8483806AB
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 20:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776283716; cv=pass; b=XpUOSjW1M3zI2LUjPIC1IRZnZNb2z2j56LzRBA7h4dTAb+mL8HZ7FKnzzeXvNmNN20t5X3rdEg1LOco73WHdoVLyHbjikqzzTfKUyzUDUNNKiPKzU0bYwJs+YUP58SHsNGxZNBsDNZemVlW9X262Q35sFY5iRbwq0ALgA1BFmK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776283716; c=relaxed/simple;
	bh=8O9DUC+x1xbhPY+/2GlgrsCgg33RrtyqBoHTeTqpEFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nA8lBSc1pKROnlVC8W5C1jZH8AqYOhnMwbtGImhLAJkb0u/Qc0mF3WKyPpxpb1ObGB+zHFby2BUBclU7/QhL9VRxaudXGRi7MaH2gK+hgN7IxiqtPmiTunVh04cKsofx4W/eVVBzwLG3Z608pvmcjBheAzcOMSEE5xCwHFa6fZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+yUtCHi; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+yUtCHi"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-671fe205535so3436270a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 13:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776283713; cv=none;
        d=google.com; s=arc-20240605;
        b=VIA6UtJyDvmU8KvfRhptS9ClaMx228E91+TLGtnVRJiU2OlmYTb5rgpFHw9sQ5G/Ck
         qZSVxup74iP1Ic1zEiERYimwBU9GKv6jvZ0apq8yENt6IsttVkESy39j+Mqwq4AWwmCO
         262O4+zjn74g35JRkNBcNZrtiDr18z2sRYqPWKNzp9s5LxbbaS3ao3f9kpJv7PVB/8Ac
         ZK/paN7EwbEl08m+uNTdPWIqg+UQg02RUqw4GbfKwqlOvgqeGYwYgiooJsa3emDkmn0d
         lZnvqPyZpITzuPs1G9DAJm7wll1k7GDFd3CUI0y7b8fjT/xsivg4sMRHaiM5zvkLpzWj
         lljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8O9DUC+x1xbhPY+/2GlgrsCgg33RrtyqBoHTeTqpEFY=;
        fh=dGRhfwRGENnd2BK/FrGFS24INXa8GDAzGsQFuS/P1zk=;
        b=LbURkhQref/OKl65kcGllcnh1COWId1ddW/bmjsjeDyoXTr/o0EhcBwbrGYrx1gBbc
         Hteu5PWBm0jfUFA2DqQI4babT4r85XxZ+6E+0/9FM6r4wkmEmqK5cHl4JbYgXLnpmXJU
         34trQx8OvEuDjdx29g5hHmW8sXWBS2aD1GgVhaFnmxrg6kzhWq3MUIVGIARBywUpW0Yn
         kMqTA2zqnBmoOEBzvmAZe1YlwmAa9HpVqRMlBwoXi/XWfacQrjk6JTDRfAI+7q04i7s0
         Dql1bvxSieVOm8HSsKivdHvmSMbrneG8aCdI3xyA81JHj38lpfs714PVG8GBIl5l5wva
         6KFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776283713; x=1776888513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8O9DUC+x1xbhPY+/2GlgrsCgg33RrtyqBoHTeTqpEFY=;
        b=J+yUtCHiqgRHtn2q5Ixtg0/V9+aixYGF1grMAGd1+qNUdrG3pLfSgaNL6biKVnocPk
         qqynmpZ9/bgnCgoIRguilNhfgLqV/pusUMK+I43wzY1ji9n3tn5g4njD+xQyJH1wpxEO
         HlPbJY7WAXI8sdpcbKapR1BfsbztHTFyF42oIPEMzaTOhzcLgg3dT8JRxh1KwIesP8C6
         /7YlIiSdrrgTgTvz8HAFJMqrcpnQy9nHbY8C6TBfP2JZhkIMeXcN8ufJHHzMImPOw2MN
         ICJ6si9Xl/JJxap+lYGAJq32hedX+aFM0WjVryvrfeYi4AKlVrfzHWpSvbbXLl1WHJ4K
         4XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776283713; x=1776888513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O9DUC+x1xbhPY+/2GlgrsCgg33RrtyqBoHTeTqpEFY=;
        b=EEBRIhc1BcwwztqHleqdPA3wpGOaKQ6c2lxWi7w317f+ykZ9seLukV83HjNDXuDGGu
         yA6HnWK0gnJTsNkb9IcPupgP+emhARjn9trakjQhFWG4t9GBeZJGbefFRwXgdKYUnCDk
         c6+9zKnLnsIgbKAPYe/zG2gRjJESsmKtVdMstS/ZzJCZWfyovWM0FFtye4oUjWv6ZAQh
         5kKOVyoMSGXuBtwVTWuTwiJFa+pSf93Z6FnO4nGkgSze/wgSUn37jceFgJ3vK0G+mj/6
         VnLei+NJ0TxrKLoBbZX8llX7TuFtbxX95mHiJj79lAb3iCJxmTm+MfUDVUWnBi6bYrvL
         u9uw==
X-Gm-Message-State: AOJu0YzVlKo9Xm5VtRDPk5AGqHpeh6LSz3LtbWKLBNV/osjVV8UW5d8L
	kTbmy+2dQ/HX1pin61b/NusAliKLCjOVmuMSJXeUFio+uXpf+OyhvHf7/uxd6BVC6IEDvEsjRgW
	uwi+CvJrA4A586idDfwKpKBOlPKX3IMY=
X-Gm-Gg: AeBDietleNCexXmGzf//lG6xSx2QNFeCVovYT6Po8xVHkAkl+Pg1Z8kyMbSjwS/AxMI
	yv9F1Z36QA/mx+p3sBcBZtIWmJPwSVNkMpSoSb6IdejXG2cMbefSyh/8zFGhb0Zb7SKcoZJHZsl
	02lW7DOETl7f+iO7IZNHSZvlHgmXLbVN+2I2lL7QxI+io3yTwqtMaJIAZgY+8Qe+krLv3KgCEso
	q2iApe3Ffde7V64wvFrSHkmi0d7+4619famrSc5gvO9MIEcQf9SOvrJF8Vrg+TjGVU59jbCAfIL
	U4xvBvC67viv82R7w0uKQ5tzwT+ti9DYKNYnLr3qoO6JVB1krh0LnhQLrF0r9tQEoOjNBBGV1gk
	tOSnRYgwlZnc=
X-Received: by 2002:a05:6402:4306:b0:670:a278:8993 with SMTP id
 4fb4d7f45d1cf-670a2788cc1mr11009479a12.19.1776283712785; Wed, 15 Apr 2026
 13:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411151155.321214-1-adrianmcmenamin@gmail.com> <uamj3cggfd4fdvah6jjfbyqmffxaib7yj4upbnkxzudaos6ig6@xz4rhorxkufp>
In-Reply-To: <uamj3cggfd4fdvah6jjfbyqmffxaib7yj4upbnkxzudaos6ig6@xz4rhorxkufp>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Wed, 15 Apr 2026 21:08:21 +0100
X-Gm-Features: AQROBzBRRCjsQRZgqIGyabzSlOZsTdNR4owARY3w66rILxYg3XzmzRYcbGUYa-E
Message-ID: <CACwZE5QpR-ZSk=cinLBuuPtLUMnEiEx7UArtZxpbPmGFccOEkw@mail.gmail.com>
Subject: Re: [PATCH 0/5 -v2] Add support for VMUFAT filesystem
To: Pedro Falcato <pfalcato@suse.de>
Cc: Linux FS development <linux-fsdevel@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Apr 2026 at 16:09, Pedro Falcato <pfalcato@suse.de> wrote:
>
> On Sat, Apr 11, 2026 at 04:11:34PM +0100, Adrian McMenamin wrote:
> > SEGA Dreamcasts come with a "visual memory unit" (VMU) which contains a slab
> > of flash memory to save games playable on the VMU or data from Dreamcast games.
> >
...
> >
> > These patches implement VMUFAT as a Linux filesystem independent of hardware.
>
> Isn't this filesystem a great target for FUSE? You definitely don't need
> super high performance here.
>
> Also, you're missing the fs maintainers. Adding them.
>

Apologies for the long delay in replying - I was hoping that maybe
someone else would have a view rather than my rather inevitable "can
this go in mainline, please?".

I'm not saying you've done this, but in some online fora, this patch
has been discussed solely as a Dreamcast add-on - when the key point
is it is hardware independent. Dreamcast users who really want to can
already get what's on their VMU via the VMU mtd layer code and then,
again if they really wanted to, manipulate that at the byte level.
Having a file system is about people on other platforms being able to
access and manipulate VMU contents (easily) too.

It's not a complex piece of code so the maintenance requirement is low
and if it were to break in future it wouldn't drag anything else down,
and nor is it an impediment to general kernel development (so the
other comparison I've seen, with the i486 code) also seems misplaced
to me.

My contribution to Linux is small - this is the first patch from me
for over a decade but I'd hope the pioneering spirit of "because its
there" still lives on.

> Pedro


Adrian
