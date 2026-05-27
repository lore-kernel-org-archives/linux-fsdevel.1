Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E23F5BC4
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884727; cv=pass; b=C9CP2qzHR+8N5CGupko0qZYH//dgiNuiA85yY2zhVWC15QpNb0mSK75hQjh7E0aHZmfS3NkIX90A3nSymkRQgmFKiftkTkedTJ9Ax4Xl52dcZrVfxTCZtRkTIgKE0KT+oePYvS3MbvJ6kGmyiEqKsAIKFp7q+K0ecxDzvIiP/sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884727; c=relaxed/simple;
	bh=QH7X6mMUgwH11C8C0NwSvhdxKEnW0MUqm6E18WiMtpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OEJprEYCMhD6Utm3pmbuSjRD/AcDeVFJZaSKVhEMWBqhZLQKCKsRMFDtV4fLpJAU93WH0+6xws9zfRUsXhgFg4xQXQlvc94d5jgg6bZnvsfdjVaYVv3gDIr0I12E6eZ2g8Ardubh3SHqmQKkw+VxeSFOQZ38PJpEwz09NV9izik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=h0pG7avg; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="h0pG7avg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-516df7b256bso22986891cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 05:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779884724; cv=none;
        d=google.com; s=arc-20240605;
        b=EFv+f1HuKn5kTE/VM9X+EiPLXZh3de+7Ena4QHHeeXv2DU7W3hlHwp0yVVM7xfrO80
         IA0sWLMVXHkMijeQJsqcKmaNcQlO2QHxVU8WOTk2l66vuMkrtPgyydoZktHXUnS3muP/
         6uvG1RY2cTyTPStnd50s2kv5GjVjo3NKnHjWUz96KqCVRkBEIHHpLbuINPCA6dQXCVg7
         60Rx5hKYTpE66gb/oZqNJPl8cyxpN2jb5zPHI1v/jH7ua0Ebsq64XRyNqVF9kMKDTsk4
         PK5ut+FCKHjZo6b8nh6FWnfVcnrz5CQ2N2gij6comhxJ/pWxCzJxfP4cHhMb6ZnV99Oe
         PJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w7pZrxFJNQerIMty8B6smj8HjW+76z4MVN8D/42e9J8=;
        fh=1AomG3r/fXvV/nwwz9C9HLOQPHatrWUs5ADW+26l8Jc=;
        b=dh4aPG71izHFDaMKXdcL/d+7S0eMCDyVLcKVYQDsuzrxXy8khWUKxCrxxWpa4I9S6i
         /wKFAUbXYLhAJetk8ZjTD/JQiaCfNsJF7BRhrANFRHvUP7Biqx5SmuCQodoiSLH78Qbv
         q0YrdvFe/WyXXTVwjSD327FnjoqchJAJFyg6TTxQzpasW2FFuCIR4z30KbHHkDUNNAXj
         Me0vaaY/VAhIQ8UyTWV+7kKB1QA8f09n8ZoAyXjH5oywUWSFAF4TqijmA5Ne0axW+qbM
         olHinDJHFdaQt6JvKPr31aRSajLmLspmbqzedawTtqAo7SM0ouTqrNFzIrHWZCXnG5Y1
         kXWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779884724; x=1780489524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w7pZrxFJNQerIMty8B6smj8HjW+76z4MVN8D/42e9J8=;
        b=h0pG7avgcTO/FV2zNnQZPzg/c8h+OvpvZtlXGl7ls6s34x+ySL5Q+7yWdj8Qs0zZpF
         rWCv0fNKYIGUYgAPLbqJ/mPt+wuKF7Gmr5FKOjc6g1O+ICA9XsOqJCZxq0ThpAf93h8z
         /TZHQbgMz4ZvZUrbS22UmbccPTkrtQcZiKuTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884724; x=1780489524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w7pZrxFJNQerIMty8B6smj8HjW+76z4MVN8D/42e9J8=;
        b=VW7F7bDaMniQQ3oOcJgwD/8IrDDYAZn7tDxTL7A55EdZ+PfCpf0/HcJL8l1jlq+hWc
         X6g3RYriDN3ZiYcYJ0TEpZbv8hqIBhGI97UtFTYQSSGTNpo6mpSX6lRCtd2IG6FgUuyP
         +G0YlzTFd/SW8B3Lp8YrdwGxa47uvA8MmWx9Vo8ncaohpdRFm7tG2RoD15H9SvIGbGFs
         s1Hs7OwUDnfI0e4PLX2NVgpcv+f53/6vGlIfsW4/EqF8gkzhRD77tTfdIDQfKVo1plij
         sBMSzey6Fb6UaweKZVdJWksHC+yGX7ckEY6TVetpqFUtkJfOYqFj//4LU9YBAdylfrWD
         kiqA==
X-Gm-Message-State: AOJu0YwIeJIFWY1Yp8UmQlwVXRj3TBHYwOtHdAGKxUqoAu0uV61sMbOY
	Zm9DejCYIU3Sj/ws4U6Mf7vo8Z/J5DR+LRH8c2O4nzVHp7U8iBAWcfBA2cIplMF98Q5giy658ZC
	+45jCerp5fWB6xSJxCgDU2TuyFCqFhu0YmFOGI0yNzw==
X-Gm-Gg: Acq92OG4hPS5MJ54VjauAFuaj7b5ac6V9sldnalyUlfc9tOfOc/aI0f8ZtLeILT6/Xu
	j1r+QPBcO72VyXJByUQtM1tIdSf5jHbpLDIYFumfpa3P7g9QQmcH/s2m5TafrcB7oBXPFgJpv8u
	AsQdil+bLkd4YR3ygeq7OA2cZ/gkX/59UoMtqSgtAYokAnq1HBaE8PYFrPsKxRkRM0dTFFUcANB
	yIuDHSn7ZSFhPXOw16FJlRGgytYWfb3SJ6uFA+JydEuQEB987PS79N38XUA9myn0p0+wbfUAVzr
	4gsOWO5vBWgKe6najTS5f9R+0H6BuOcC9pFpzxA=
X-Received: by 2002:a05:622a:4019:b0:516:dd65:21af with SMTP id
 d75a77b69052e-516dd652495mr249087861cf.45.1779884724159; Wed, 27 May 2026
 05:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com> <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 May 2026 14:25:12 +0200
X-Gm-Features: AVHnY4KwHDouTYGOUbTjVfFUD291DFYrxTCujWiChCCBfK7Jp0CgOE__pmRUeLY
Message-ID: <CAJfpeguAvw=GTkWhMsjSAyDx5oXXfMLNOPGDUg8HuPRxjppxkA@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jan Kara <jack@suse.cz>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 May 2026 at 03:42, Joanne Koong <joannelkoong@gmail.com> wrote:

> On a 8GB machine (with assuming vm.dirty_ratio=20% and
> vm.dirty_background_ratio=10%), we get 12 MB of freerun, 4 MB of
> proportional throttling, and then full throtttling starts at 16 MB.
> With 2MB folios, the 4MB zone between freerun and f ull throttling
> doesn't leave that much room for the balance_dirty_pages() logic to
> adjust the dirtier's speed, which I think causes the writes to
> oscillate between freerunning and then being fully (overly) throttled.

Some handwaving: would it be possible for the folio alloc logic to
modulate the folio size based on how close are we to the dirty
threshold?

E.g. if the number of folios to reach the dirty limit is less than 10,
then start allocating smaller folios.

> I think this problem gets untenable for random writes with large
> folios, since dirtying just a few bytes will charge the whole folio
> size to the dirty budget. I have a patchset from last year for adding
> more granular dirty/writeback tracking [3], I'm going to pick this
> series back up. I think it will be useful generically, not just for
> fuse.

Tracking partial dirty is not going to help free up those large
folios, unless the dirty part is migrated to a smaller folio.  Not
sure if it's worth the added complexity, maybe...

> For getting this to work on fuse servers with strictlimiting, I think
> the next steps are to
> a) as Jan had suggested in [1], come up with some heuristic to
> constrain the max order supported for large folios for these fuse
> servers if they're running with the writeback cache enabled
> b) benchmark ^ and if there are still regressions, then we should
> probably just turn large folios off for these servers

Definitely worth exploring the characteristics of the current system.

> c) add the granular writeback/dirty accounting for large folios
> d) look into improving the balance_dirty_pages() throttling logic to
> handle narrow gaps between the freerun and full throttling zones
> better and reduce over-throttling
>
> Does this sound like a reasonable way forward?

Yeah, makes sense.

> For privileged servers, I still think it makes sense to remove the
> strictlimiting requirement or at the least, let admins opt out of that
> if they are confident their server is well-behaved.

This is already possible via the /sys/class/bdi interface.

I'm fine with introducing a config option / module option to turn it
off by default.

Thanks,
Miklos
