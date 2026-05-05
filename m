Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69379EEBB
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000522; cv=none; b=VFfukEpRuIn7Dd9MO/gjZxZzR/u4M31JrRy1Qsl+/xK8cxDx73UHNiyWKeEwppNfvzJbF1L+YL07kUd1CILvpAyx38+T9SdPb5Ap9W/wjW9/jFwQe13nBZVw1prBXIaR+nO3uW4z/az3lqlmR/+FsdhGLwgMphTsZu92QqqWm4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000522; c=relaxed/simple;
	bh=SdOFl2HPXuOaKsN7rEH3v7+xTVPZdaO3Y+Xy27hTOfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCHVoZ3edECwIi27rYhP5ej3Tpg6iQxVMCP6u0jLUdxsqGVzClARoh7IKqULsRsfKpvlim9rfmCNvpMVNdoMliu9CNN/0eNJ+yR3A/RYATyEt2+sbr7Yk/BMN9EXh91kJIiVyx9dwUB5hRWbXKWxtfucxcLksiZWqV+oF1fNCKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JUfJHNpe; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JUfJHNpe"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bc3582acc23so286086266b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1778000519; x=1778605319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4MQubyrWAM5KPG1uqmFTzkEVdT57CAE+7jB/COvFgM=;
        b=JUfJHNpeo9tL50BDd4jyHCAHAaCzB/weQMb7QNJFHgLJKQWVuIAcdElBg7eZ0u+0LY
         ZhVgArtMogmkLWuFVPiCOWbPisKrvGUsqOVEChpXLbWz6nqKgSCSVR3XIU8aC01ciWd3
         YDNCrZnv9bzEbdUYyUEjUn8ryJsTjeQlrD0OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778000519; x=1778605319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4MQubyrWAM5KPG1uqmFTzkEVdT57CAE+7jB/COvFgM=;
        b=CWu2m6FfF0m8A/I3mFW0HEsBX+0vFe1nYC0WF9AgTGz6RDBKBE3VITDfyHb/epA+Xi
         ZYLxtEggY1umKpDDT9mPx+cNLSV/h4jhQyeszlQt4InOBAiHotY5zpZunp1aYUcy63s8
         nI/ZEwSsZvE3Y5+nWWxq+aoNTZ/TZdb7TZirUls8x7P9WKwt7brXIwBcqzyCxf0JdwUP
         RfZXSGKW5UyUr/h0d4LgwVFPZHjNRsB/UY7bL+wWDanQe1j0u8HXSpIPopPCYEucZL+/
         LZ4guqoPE1Bu0wuVXvKiD9n6a8u1wcFmplwTbL33VF+r2+8X1yu1lLoesXYZ8fGUWawf
         jtEw==
X-Gm-Message-State: AOJu0Yxe4n2XnsXHXYnfbVwRHdNiHRFF0CvaWiEocdJ4GTzCkRAbiu+A
	TaOqeistfStzr24DvPY8b6TVX8WhJ4IYUtZC97Ku2/LL+OVF+XuHWhuDK6IiAVm5pp/JhPGF9aR
	3GRGVXAs=
X-Gm-Gg: AeBDietkiTps22goBqLpR6e4dx/iPA0AGXa1ns/l8YdidvvgeAKuyqgoHxQibp2HxEi
	ZZUbwrJhqAaEdi3pSu5dnFCtmjgAQtTqJ7jWsP86WxR1qxEwDMoWjYCoK/GI94K5GDiOSi+sOAa
	7aXgKeTGlH/VqrwWVW6AkFOu9fRmIsaCL6XinOZNEf1CpSaIajgInnZ8PdTAnIqm/pjUY7CbOZ1
	JQl4B3gKwi6q902HA6WYixUcmjZP0uOnF4CbfsrgPg6qGCRYqsp8Pltdc5R93FcMEJAYuiXzHpn
	qWSD3Q7p3swOWwTaFlf5tJrzcVJ17KJxfPVHI+ZC2Nx0Zhb15NWKMflRbKd6ab1308TvFv0PbLR
	BHgZpPzeuH2GGWCjfQg+kLTVBdZZG9Hde8AgjUVHOWV+ECVXvqfBvtHyjBnEuRtWA/YSw9Iye3N
	2dNOfn+PVlpCE0rN1feb2BsNqVLcgREnVqTc85cuk/DCkg7eCveWw7y515Ij84HhwOqycpMsHPh
	IAiGZ3PcmU=
X-Received: by 2002:a17:907:7f90:b0:bc1:1716:2e9c with SMTP id a640c23a62f3a-bc40df71064mr238607566b.16.1778000518423;
        Tue, 05 May 2026 10:01:58 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bbe6d06e23asm508708066b.36.2026.05.05.10.01.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 10:01:56 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67c1e0229acso4702753a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 10:01:56 -0700 (PDT)
X-Received: by 2002:a05:6402:46c7:b0:67c:4e1b:9131 with SMTP id
 4fb4d7f45d1cf-67ccc1822camr1757589a12.21.1778000516012; Tue, 05 May 2026
 10:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk> <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
In-Reply-To: <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 May 2026 10:01:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
X-Gm-Features: AVHnY4LngHfLimL-fj7KF3U3phHZM_pJec2XoWLeEkJi5bJXS4eaNto-rsn65iA
Message-ID: <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
To: Al Viro <viro@zeniv.linux.org.uk>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"

[ Adding Pail and Frederic explicitly not because they care about this
code, but because it's - again - about spinlock vs rcu_read_lock() ]

On Mon, 4 May 2026 at 22:54, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> @@ -1477,14 +1477,15 @@ static void d_walk(struct dentry *parent, void *data,
>         /*
>          * All done at this level ... ascend and resume the search.
>          */
> -       rcu_read_lock();
>  ascend:
>         if (this_parent != parent) {
>                 dentry = this_parent;
>                 this_parent = dentry->d_parent;
>
> +               rcu_read_lock();
>                 spin_unlock(&dentry->d_lock);
>                 spin_lock(&this_parent->d_lock);
> +               rcu_read_unlock();

Ugh. This also triggers my "this is ugly". It makes no sense to me.

It's documented as "shrink rcu_read_lock() scope", but again, it's not
clear why that matters, and more importantly it's not really *true*.

The code clearly still depends on RCU reader locking - it's just that
it mixes explicit rcu_read_lock() sections with "we hold a spinlock,
so we're rcu read-locked", and then it goes "oh, now we drop the
spinlock so we need to explicitly take the RCU read lock".

Which I don't think is an improvement. I think it was actually clearer
to just do rcu_read_lock() over the whole thing, and then essentially
ignoring that spinlocks *also* act as a RCU lock.

Now, with all that said...

If we had a function that was "transfer spinlock without dropping RCU
read lock", and we'd use that as an _optimization_ (maybe we could
avoid all the preemption count games and testing for whether there are
active RCU events etc), that would make sense to me.

At that point it would *all* become "we rely on the spinlock to hold
RCU read locking", and it wouldn't mix locking models. So I think such
an operation might make sense on its own.

And no, I doubt the "optimization" part of it matters hugely, but I
think it might actually clarify what is going on just due to the added
abstraction. IOW, even *without* actively optimizing the code
sequence, maybe a

  static void transfer_spinlock_with_rcu(spinlock_t *a, spinlock_t *b)
  {
        rcu_read_lock();
        spin_unlock(a);
        spin_lock(b);
        rcu_read_unlock();
  }

would I think be a better thing than have this ugly sequence written
out. It would make it very explicit what we're doing (and it would
_allow_ for code generation improvements if we care about it).

I dunno. Maybe I'm just crazy, and irrational in my reaction to that
pattern. Which is partly why I added Paila nd Frederic to the cc to
see what others think.

              Linus
