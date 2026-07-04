Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DF81E9B37
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 00:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783125313; cv=pass; b=VyYyj08w2Ye9zRl1L8YyVVkiqlvbdeCyib4ilVKMADgVl8LOnKSDFS9E5SC5aSgZkJecqjwMGRJqrH5ssEoMuwSOyOXTTk64CEiP9c95DAai7LHB04TtkzItnJaEoH7x2CSs+qxCp234BvzhrTRcCo7QN43T3i8nLMV7O4To1vQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783125313; c=relaxed/simple;
	bh=clrDD96YBt5A3a2Rvc28rREplTx9fw9n1eB41uH1mEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDXMvfqgeWRYku0BnSQ8545ZorokXHMSxBT5AmwCfE3wapgEepwScEIWgq6PtvZmNEz0FEiJ5mg6JTIlbbh3sC+FFqKFJTteVffFv5DEETcZ7G9fjohHz05t/e/XXaqw2kv2pdRyhxfhv9ih6hxuYMrvYZuuD5elfmmsLB9qqo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pSnUN7Z1; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pSnUN7Z1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493d28b1930so439135e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 17:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783125311; cv=none;
        d=google.com; s=arc-20260327;
        b=NMV9XTG6tIVAbRy8EiD8NR9F+zMYRVZ+h+efvbIqyPImkbyk/AifeJQ+GaXdEaWISj
         ++D/8FSZDNNn/IhHKDqpXeiakostZZLmKuyaVjWkdZyiN3Yg+AQsdtrq2tfZLGgTf950
         2sESi32FWGfB+GSwAs7HC+3AwoE6HVpd0gZzfTJ9PE9a69McMol+jkVHZaSQMsMvIZtM
         io1OUgzA/x38Db64ItNIKluQE1OPhQhpluHpBTRAYDgz0g8i/vk+Uotot6IQU/nbOEyw
         0SC7GMCVVER1Cjl5UtQfWdtCHhXIZGrsFAB6eA2GzRXGWdg1Y8VJn1uUB2vyUJN2ZK+1
         QLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wW7AlhxqGYiRva1oC552NzvH7YtXs9EvRN6VDKKQkfM=;
        fh=Y6D9WboLwn6utexLTq4p172/liZEfEscCp5PbQ8nybw=;
        b=lm2qR/6nP0AsyXiHO3UalsIiku8MwnXONlP9dpPlWuN4nWO8uoMZr1ZNTwGrktIKRX
         gCSx0wKUl/BiDziHxqUvLizDNielwbM+3CNc7GsMja1D/w4BKbiDRSoMWiziE6+95mNh
         fxa+eAF3eTi57JYxeGFBYzTIvd9jy0MUDWdQylB+HHaF4py/1LRDLOZmv7EwqJpdLxTV
         Jl2l+erDsdgjhAhM1k7b3PqXfc4yLWi/HpcxPUILwV0SADgZSTJc2nnSYUNSw0FeWdod
         iWuqGVIa4z4khg8qRWcCkSTeTRqSZp8qFZmYhKMVHaGZjjsOHu7cYKHR3zJLU3TMXizM
         APEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783125311; x=1783730111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wW7AlhxqGYiRva1oC552NzvH7YtXs9EvRN6VDKKQkfM=;
        b=pSnUN7Z1IPzl1PUejj1ZbBo/KW7cjP/Q3GRVbjj/54TkXCqh4uwm302JQIauMohZYJ
         mUvkfiO6qyBMktjaZ5S6UJJQplzNMgNEdHyJ+QXaBmfHm/b6UEl2ggeU/4s8ijZzbc7r
         asCQw4+mjoUHkjssFZLc5Iw3B00xouaqqStkeNJ71sRQeB+U+WKPB8jo7KX2siGB3yEh
         MzOIRkvZJmisEPi9wPPdoJ2vmw3Tty+hKT5+3bSXaeiivvZyJtvBQs04+8DiXDwgOXDL
         JxshMTB8jXxOe1uLdfz/a7cNGFV1DyfkM0D4mXN0NaarvA3V5YNE7/5XOuU2dql4egiC
         c3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783125311; x=1783730111;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wW7AlhxqGYiRva1oC552NzvH7YtXs9EvRN6VDKKQkfM=;
        b=gy9SMIAaRDcLr50cGFgqWjBQWpz4/c4Crk9tPHxkcjlzGC1seqe76EQkRCRzKgaO1D
         0aBYfZQKPIBZP1G+MbOAJa3Dv8SMDdufCNJQzaqSEC5Lt71XqL4o/Mi/iQQoNVRX+zuo
         fFlyKfiVl5PbpRDZXQQdIIYxECDrQhQWD6ry27Hm7rzQNJAxBDGfRm6R0VueDqY/pKPr
         9V7PVoLRbbOqdJaOF+k3aa/WdlK/+uY8CDaa1cI8cMCIAPS97vrLq09hvY1B3Rco4TkA
         tU9qtkBKZz7l98U+pjML+EoU/10efQb1fxPYoV7SyYe23Ra1x/SgCaU2cofEvXyiqlIZ
         We4A==
X-Forwarded-Encrypted: i=1; AFNElJ/wEZaIgYAdA/F0Q0YBjfi+7j5rRloHXUZaj+cm4iW93NTz8Y8BNGfibzvoCdXn/JkptT+OWX+rEMfHiGgB@vger.kernel.org
X-Gm-Message-State: AOJu0YxZQoj92EHbmBH1p7YfdlSSz9uAD/0oaCj4NEfMx2fd7/5bTL6+
	cwnqtOdUuxEuZRZW6kA+UgzHb/I9qPyDC/EblE2ygGezNLUh+bXe6vl8UFapwTARwaJjapKUbk1
	qZy5iOG5zE+wb+1KgsxNMfH8iDA1ziHE=
X-Gm-Gg: AfdE7cn2CoyGqK2S63oyzwoFRJTCibPa8XGXQ0r/OrLMqau/dJ8nWTf8FIs+CTq2H3Q
	aIKq9ykB8LZfY7OQNJgKr01XCC2wjkO64wXIQyOHRpX3OFC5bqyXiXL9fKYTcdUSnS7CS1gC2ZG
	Hk5kU8mlic+n22JBTmZwxDvzT/ZuGnRX31Pkl7Drp3JRnlI2UneD2K380gL5zkdr60jK8Ds12LX
	SFwx6vwULEe1HCrH4dcLc7PA1DRZEV7ufHCVJ6hspkea9/ctQQ/SM+MEn02cFcHRbgTa4nNdrKH
	XmlBBrLxnnOFfbvCgsCl/dD/EfBsJ7o5FP4AEzbagh9+Pi89Ji9W
X-Received: by 2002:a05:600c:5250:b0:493:bb0:3b43 with SMTP id
 5b1f17b1804b1-493d11cefc8mr15023595e9.2.1783125311110; Fri, 03 Jul 2026
 17:35:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com>
 <20260701000949.1666714-19-joannelkoong@gmail.com> <20260702192658.GN9392@frogsfrogsfrogs>
 <CAJnrk1YZQOQ0D6p6qYx1BPvKQaDgZsrKzLbGZzaH8tUkj_OoOQ@mail.gmail.com>
 <20260703020020.GS9392@frogsfrogsfrogs> <20260703124331.GA26440@lst.de> <20260703161147.GB9407@frogsfrogsfrogs>
In-Reply-To: <20260703161147.GB9407@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 3 Jul 2026 17:34:59 -0700
X-Gm-Features: AVVi8Cc9z61uFW2rqHr93JegF3VWx93elWcFHjnHavv8xxM4AtcZoZcVqoAB6DI
Message-ID: <CAJnrk1Zv8FEAD+T=1+ZLi6q8ztHVY1zray019QNdeLpYjTNQAQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] Documentation: iomap: update docs to reflect
 iomap_next model
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 9:11=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, Jul 03, 2026 at 02:43:31PM +0200, Christoph Hellwig wrote:
> > On Thu, Jul 02, 2026 at 07:00:20PM -0700, Darrick J. Wong wrote:
> > > The ->begin method can still set iomap::private and the ->end method =
can
> > > dispose of it, right?  Oh, wait, no, that doesn't work because you're
> > > talking about ->begin/->end passing something to the next ->begin.
> >
> > Should we move ->private from struct iomap to struct iomap_iter?
> > That'll deal with the constness and the fact that private data
> > really is a per-operation thing.

I'm not sure I understand. Doesn't struct iomap_iter already have a
private field that holds caller-supplied per-operation context?
afaics, the users of iomap->private (gfs2, ntfs3, fuse-dax) do use it
for per-mapping data and release it in the same iteration.

>
> I dunno -- towards the end of the fuse-iomap development work I actually
> had started using iomap.private to store per-mapping private data.  But
> that work is dead now, so that's not a strong argument.
>
> > That also reminds me that now that we actually still keep the low-level
> > begin/end ops we need to switch them to a calling convention that
> > passes the iter instead of the ugly container_of.  This is something
> > I wanted deferred until we get the iter conversion, but it turns out
> > that now leaves them untouched..

That's a good point. Do you think it'd be better to include those
changes as part of this series or do that as a separate follow-up
series that targets the same merge window timeline as this one?

>
> Oh, you mean changing the signature to:
>
> typedef int (iomap_begin_fn)(struct iomap_iter *iter...);
>
> instead of passing parts of the iter as separate arguments?
> Yeah, that would be nice.

Agreed.

Thanks,
Joanne
