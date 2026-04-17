Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0772DEA95
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 20:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457987; cv=none; b=dVkYm42zfJ1aCMW2zbJ+te4dcdkUVqceZ8RI2Mi0x4KhL2bUoWdZYf1jgq3GlvM4KxcDCCCoQrcJHATGP6RmpVY1EofAPvisGzC3ONwx/MWg6keFZ5j128vYQFjT2ufGYiAQ1+YieiQJUrdInMp+jW++sVccNMBO4T6YdRHeGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457987; c=relaxed/simple;
	bh=jFrdw+X0q0nEQz1vk2GjktA7ZkOoieLsktKpKwr3zTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zp+IMB+pTFPorWzmwcGcOFmvaCbZk+yhvXvc16HpMCxfWjtFaI6lpyOGeN/lxmD2eXWiRW3Ct53hmk1/WHTtsIl7IXkuE2Q2f9GAdCkDKd12oc1GNOBRCckKvr4ZyAO0PPocwI9TDItiafanPY43peZMoB52WLGaV+ECBVJa+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIEq/xxA; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIEq/xxA"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651d692e833so1154107d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 13:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776457984; x=1777062784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ESaQCO0d6F6EEXsq95L8Y+GOiOFVbRFpB4PjdvQLY8g=;
        b=QIEq/xxAbkZ6O5c/fPXqKyawmbwI4Q6j0S1T0aZ3Uo6WSgE7MvrIsP2BwumApzVRCm
         LSTPuCpA9U9n7vYfGuaEB4o/nWTZEi1u8ueioeyfmAN51YsXCSuhmHkssN86X52AmTIC
         0Nv+LQAAh118nRTrIdo3vFlKv6dUA21g0LqvUuw4Z6yRs7brk5UKph10rKOZfZF9X0eR
         CtCsLy7ktWK0ob19qWxYcFxzYI1wnNGWzlZyDQrQhNIUuLnd8LrrH73KyRt6dMEzjOda
         Z9M+dBsD9XPf1ZRrHHFPQxge0NIFaim6mKxiXZkGlwVZJB9QNnBjuvV/6nscNcEbY1aL
         gzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776457984; x=1777062784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESaQCO0d6F6EEXsq95L8Y+GOiOFVbRFpB4PjdvQLY8g=;
        b=Ad6iVyk7fUzWzbGtXzlIqZ8yDWqcm2xjKORH1Kj8UOK2sL0Dp7tYdJswFRZWhWVdbu
         wHzZ9e+Yv8ovXh0GmAB8NuVyxbEnsKUI5wxdN1Y/NZh95oY2O6GYZdV0xzFtru+Uyco5
         XlPn9qUcC04ySWC+cwnOkcGxCqVJ447jNQpGFJSFbsb8A7M9fkhxara++vZAgn9bGxtc
         Co5dkDuVOk0LXmRSarGp6KQWNI/aZ+D+gsifnOoL40vxli5qwU47hiODr2osRa+hi5HF
         WFdS6wDIFuZP7bKAhHBVf7bPVt+cjCh48pzORB3SEbrATkRt0oNofJBKHGoEA8wqf5Eg
         6Bkw==
X-Forwarded-Encrypted: i=1; AFNElJ8gFN8S9lUu1FybLKzO3pkzeptdtl3w+w8h9JxDVudvHbnwMjYabDRglhsYh3ZdPjGJCrXPfgTZERNCnFQI@vger.kernel.org
X-Gm-Message-State: AOJu0Yye1qpTt4dhs9NZbJxNTZybfA24/ACt/sSyCLgf06YyqDMqN5qG
	1wvc/4MUrRzZoClRcqdeN05z5EiK63ZYuXTGx+Huno+rZs3d/XnEJ6yc
X-Gm-Gg: AeBDievEue+LxsuK+PGCHFmUCr0W8jAN4M4eHtz7yVzJxDNkJZwWxQWYlG0b0RhBZkt
	jApZYgYiSNavdUJnRZqV5/kWe2uo40wbY269eGGV0R9IPIjxhVzD9HeI1leNfj+UO3VHhcLrWSH
	mHWJUKMny7y41/rLA2b/2+hFKenikeovkvqpcnaB5jZBDCPCw8BcW6Sa14gOaf5wo74PlzU8T81
	nf1Mvc7AoN+MZnXty2TmVuR8YR5bIhBQbiGfwMwqyaOG4mkayAbQhMQxpcLJo+LsN2WfR1ShS8/
	McF2LN/uHtO2z+cxV68bXK8V1fuMgmj5Gpkm+ZW0wnn4emQI3UEztc9pNxTu6jAgh/plLFNPli5
	Sqfi/0L+WCzp4x91MZyVUwce790wKSA//Iw42aVw8g6n/0mgeCdrSW11YmhZemP7e6ABRG/Tru1
	BVL5broII0WAh4sgMiBj5fgFmN590pJPQHwOsvRJhbIoHi+hQwjZcV2C/JXjd9vL7n56+gH6CWB
	g==
X-Received: by 2002:a05:690c:3181:b0:7b3:5872:694d with SMTP id 00721157ae682-7b9ecef5437mr48642037b3.22.1776457983655;
        Fri, 17 Apr 2026 13:33:03 -0700 (PDT)
Received: from suesslenovo ([2600:1700:18fb:6011:e63d:3ec:f0d3:1523])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bd34sm11026187b3.26.2026.04.17.13.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:33:03 -0700 (PDT)
Date: Fri, 17 Apr 2026 16:33:01 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, kpsingh@kernel.org, paul@paul-moore.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org,
	gnoack@google.com, jack@suse.cz, jmorris@namei.org,
	serge@hallyn.com, yonghong.song@linux.dev, martin.lau@linux.dev,
	m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com,
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Message-ID: <aeKY_QUge4okHjrW@suesslenovo>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com>
 <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo>
 <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo>
 <20260417.ohgoh0Eecome@digikod.net>
 <aeJlHIoSjVPmccDx@suesslenovo>
 <20260417.aPh1ooQu8esh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417.aPh1ooQu8esh@digikod.net>

On Fri, Apr 17, 2026 at 08:03:14PM +0200, Mickaël Salaün wrote:
> On Fri, Apr 17, 2026 at 12:51:40PM -0400, Justin Suess wrote:
> > On Fri, Apr 17, 2026 at 05:18:05PM +0200, Mickaël Salaün wrote:
> > > On Fri, Apr 17, 2026 at 10:09:13AM -0400, Justin Suess wrote:
> > > > On Thu, Apr 16, 2026 at 04:47:40PM -0700, Song Liu wrote:
> > > > > On Thu, Apr 16, 2026 at 2:53 PM Justin Suess <utilityemal77@gmail.com> wrote:
> > [...]
> > > Why not using proper typing with a dedicated map?
> > > 
> > 
> > I may be misunderstanding, but from what I see, a __kptr DOES give
> > proper typing, __kptr is an annotation not a type.
> 
> Ok, good.
> 
> > 
> > This is what it would look like in an BPF_MAP_TYPE_ARRAY.
> > 
> >     struct ruleset_kptr_value {
> > 	    struct bpf_landlock_ruleset __kptr * ruleset;
> >     };
> > 
> >     struct {
> > 	      __uint(type, BPF_MAP_TYPE_ARRAY);
> > 	      __uint(max_entries, 1);
> > 	      __type(key, __u32);
> > 	      __type(value, struct ruleset_kptr_value);
> >     } ruleset_kptr_map SEC(".maps");
> > 
> > So we get proper typing from what I see. (It's not like a __kptr is a
> > special void*, it has a type)
> 
> Looks good.
> 
> [...]
> > 
> > The answer the the lifetime part is yes.
> > 
> > The kptr destructors and the landlock ruleset refcounting give us that
> > abstraction. (along with the KF_ACQUIRE/KF_RELEASE annotations and
> > destructor implementation)
> 
> Good.
> 
> > 
> > > to the caller) and pass them as file descriptor?
> > This "pass them as a file descriptor" is the tricky part. It would be
> > very convenient if we could send the fd to bpf from userspace and have
> > it be implicitly converted (like in the BPF_MAP_TYPE_LANDLOCK_RULESET
> > implementation) in one step, but I just don't see a way to do that with
> > the bpf_landlock_get_ruleset_from_fd kfunc approach.
> 
> Song's idea to have a generic FD map looks promising.
> 

I agree the generic FD map sounds like a good fit.

So this would be three parts like:

1. The new point-of-no-return flags for NNP and staging domain to
execution time in Landlock. Selftests and doc updates.
2. The generic FD map implementation for bpf. Selftests and doc updates.
3. The BPF kfunc implementations for Landlock using the same point-of-no
return staging. Selftests and doc updates.

The scope of which is probably too big for one series.

Luckily part 1 is pretty close to being done as part of my work for v2
of this series, and can standalone as a preparatory series for Landlock,
since it adds flags and features that have utility outside of BPF.

Open for ideas on how to split this up (or even better, for some help in
implementation or prior works).

I'd like to get some feedback and figue out what this generic fd map
should look like and get some more eyes on that idea to avoid wasting
reviewer time on an unsuitable implementation.

Justin
