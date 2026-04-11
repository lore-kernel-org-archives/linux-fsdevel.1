Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5E29D294
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909264; cv=none; b=Up9Z42X8giGHpsL3JrvOOCbbK9jsOTvVKJe6C7E+oSSNLwTfXTFnVvb8/xMxFku4aT8POX0NeMqEKyCh5HEfC6z4Rld6zep84RpOHRi7FeGZveCUcNodLdnwZrqXwsNgHEvd0mO75djFWj3ca4MtjjmFeNy/tKinDzT8KPnOKyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909264; c=relaxed/simple;
	bh=DBR9qGMn2CIiifxsFiPeBCgjCkxAs1y/rjAoTohAAqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGnP0LxJ3CufhprCMX7UK1mJ86JdCl5CXpjMrpapkcyMz5NjAtnl/b53qTIZq+0iLm9HRNNHoKEevAzFvzpGQQv0ybfajLCynBqkkUt4qy79K6UniOYFRVYFGgVxivxj1ANvuyitHlwUt5XGl0iKbqtjPmge2SBsK8mxTowE3JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=GLWqhbiA; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="GLWqhbiA"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c19d23b19so2917836c88.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1775909262; x=1776514062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGgggYeUbSwNCvBaCLtmhDUzMF8iM4jryN8/BPkTNLA=;
        b=GLWqhbiA6JzjK8TyjxyGhv3ql+td31fuQpoTUVvl7s4eKyb57AqS2CmSvKlsI2wZKO
         k8f/HlFeAV8WFCjcE3m6xU6btAKYyUkaCNQugjdpJmQlBtEuiEAiUN3hOzkFo9vltZaT
         mNYQXgpg00oaWqDTE9wtGsWwPPUhgE43iob6/LHTWNyle5xBw3/fTU/8bZrGp5OMiG3Z
         +DqP9viSWaudxj0b54tFyf212tQuonq0QmO4vkVue2dj1tDuCmZIhruME1hb7MSOY5vC
         uhzQ7iU/xJTOteRYCbjSowO4thEivxExB6LkRyqVJWYgqX0wIFe3FGSCcpeD3zU8ZC5x
         Tc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775909262; x=1776514062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGgggYeUbSwNCvBaCLtmhDUzMF8iM4jryN8/BPkTNLA=;
        b=YV+OPHjn0pIR1xLjf/DjYDjFfS8hh9kxoy0Hei9hhffBtQUiqmqApvQ1GUQV/tI+T/
         iHFohm0SiD3UufyJ0XChAcM+YShehrcn7TZh4evu4ZH6DLFWj3y8fyPoeK8AC0uSYHW5
         PiOLHalKh+fAKRZWIQK8K14Wu4evZZ82geBC/5wbrUq7vWTWhr1YsRFRT2/JXDV/leqP
         Q/6KhlTRn2rA9jjJVzRhFKmzYwq6/fSsMGRkosoewAhrV+1xqB0GvMxRqjhsFZ80JiZL
         TEzlZSMPrZ7Od93rbiTHXMUmatHf6M9+GIqMqvr0Lgd4+D9AVIUH6Qn8JaWn9nCh9R1J
         iqmg==
X-Forwarded-Encrypted: i=1; AJvYcCUaHbq12yUAqn+w3U9KqEKsuMFG747hUF+RFNZCJq9N6BoRlBKLww2GzBWhMV0aYlNGi1kjASPG9G2OZY8n@vger.kernel.org
X-Gm-Message-State: AOJu0YwAn0ewrybLPxWVnD5JEdioht9hzvWtHcS7J99MonkMk4R4VxA1
	BF8nrQN7L7UgKYRTCXYwIKo1C80BXf+E5zCOTTmgEewI1HGyjBkhsVz7Tz83lULX/zw=
X-Gm-Gg: AeBDiev46qRP1NdzFjnOKx4dVlVZqnJhKF1qouneYPqZnFaUD+9lVWr+6hdwc0Po/Hb
	u9BsO/ORk0opcs/n1xReMJFn//1Ev5d7V1i1nVUxZbJob99Jkv/KnaK0lRs/teD9OxseEOS7qqs
	ITNBQzEeWhZlTnhI5hZdbaa2w2E2IOrc4Do+hXnbq3nTpTXe6h7my7oDqVbOl1HD5w8TZKtFj+6
	pncJ4goGx1NPH2aWeVLVohtYT61fixPkggoc9TXF1HgHBF99mRs/m4rt63AEtmob72jwMSvBfA2
	bvtqau745g8UikaKW7DcIMmeMATFCGiO/XNZKTUtATOMEn5V1GK8oERpfDj6zY9BjGqadra2O2Y
	kglthtiND1Gch5tM+NyhdVWP+Um166NG/Dhq1D+naZBf8t2zJUt+dT2+XhooAndVe/+t8v5Q+mo
	GZtS8Na9/EsRHdMatFIzIQRvMFPA==
X-Received: by 2002:a05:7022:6b8d:b0:122:2f4:b285 with SMTP id a92af1059eb24-12c34edd852mr3702091c88.25.1775909262256;
        Sat, 11 Apr 2026 05:07:42 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:8b67:f5fb:a7a8:83c6])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346fb26dsm6511536c88.14.2026.04.11.05.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:07:41 -0700 (PDT)
Date: Sat, 11 Apr 2026 05:07:39 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Boqun Feng <boqun@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC][PATCH] make sure that lock_for_kill() callers drop the
 locks in safe order
Message-ID: <ado5iygp3MR1p8Dc@mozart.vkv.me>
References: <CAHk-=wjuOm+AGHtjF15Zx8cxJwYwbzJgi28EQ6KW=Ze-4YjN+g@mail.gmail.com>
 <4305138de599923591df7403aefc4d663f50324a.camel@kernel.org>
 <20260410191907.GV3836593@ZenIV>
 <30ac5108ada614560326636d4da353d6304c3f91.camel@kernel.org>
 <adln5vp9HFbX-oz0@mozart.vkv.me>
 <20260410212403.GY3836593@ZenIV>
 <adl2dMjN2hmVvORh@mozart.vkv.me>
 <20260410230553.GZ3836593@ZenIV>
 <admIGCR-xGfKgIQ-@mozart.vkv.me>
 <20260411005126.GA3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260411005126.GA3836593@ZenIV>

On Saturday 04/11 at 01:51 +0100, Al Viro wrote:
> On Fri, Apr 10, 2026 at 04:30:32PM -0700, Calvin Owens wrote:
> > I'm sure I can narrow down the reproducer more, I'll try a bit.
> 
> No need...  Just have parent and child share descriptor table, then let parent
> wait for child and child do
> 	char buf[128], buf2[128];
> 	int fd = 0, n;
> 	do {
> 		n = fd;
> 		sprintf(buf, "/proc/self/fdinfo/%d", fd);
> 		fd = open(buf, 0);
> 	} while (fd >= 0);
> 	for (int i = 0; i <= n; i++) {
> 		sprintf(buf, "/proc/self/fd/%d", i);
> 		readlink(buf, buf2, sizeof(buf2));
> 	}
> and that's it.
> 
> That's a nice demonstration of how nasty conditions can be arranged for
> d_invalidate(); *plenty* of busy dentries in the tree (to the tune of
> several millions), with some evictables scattered here and there.
> If you get enough busy stuff to wade through until you find an eviction
> candidate, you'll get select_collect() return D_WALK_QUIT as soon as you
> get a single evictable sucker.  Of course, then you need to restart
> the whole thing - with the same pile of busy ones to get through.  Repeat
> for every single evictable left in there.
> 
> No memory corruption involved, just a fuckton of rescans ;-/
> It *is* recoverable - you just need to flush caches hard enough and that'll
> unwedge the sucker.

Ah, sorry for missing that, I see now it is making very slow progress
exactly the way you're describing:

    20:24:34.493233954: d_walk(dentry=0xffff888f3effbc80)
    20:24:34.601228789: __dentry_kill(dentry=0xffff8881b3dbb200)
    20:24:34.601232747: d_walk(dentry=0xffff888f3effbc80)
    20:24:34.709533603: __dentry_kill(dentry=0xffff8881b3dbafc0)
    ...
    04:41:27.450293144: d_walk(dentry=0xffff888f3effbc80)
    04:41:27.559336564: __dentry_kill(dentry=0xffff8883fea30d80)
    04:41:27.559340982: d_walk(dentry=0xffff888f3effbc80)
    04:41:27.668177811: __dentry_kill(dentry=0xffff8883fea30e40)

I guess my d_weak_revalidate() patch causes strictly fewer dentries to
be considered valid than before, and that somehow misses the
pathological case here? I'm very happy to believe that patch is wrong,
but I just can't explain for myself why it makes such an enormous
night-and-day improvement in the reproducer's behavior.

I'm curious if you can see why... but I'm not meaning to challenge your
explanation, it makes perfect sense to me.

> IMO that's a very convincing argument for not using shrink_dcache_parent()
> in d_invalidate().
> 
> That goes back to 2.1.65 - very early in dcache history.  Back then (and
> until about 2014, IIRC) it had been "try to evict the subtree, unhash
> if they are all gone, fail otherwise"; these days it's worse, since
> d_invalidate() is not allowed to fail.
> 
> "Rescan if we have found something and ran out of timeslice" is there since
> 2005 mingo's 116194f29f13 "[PATCH] sched: vfs: fix scheduling latencies in
> prune_dcache() and select_parent()" - latency problems prior to that got
> traded for this "rescan the same pile of busy stuff for each evictable"
> pathological behaviour.
> 
> FWIW, it doesn't have to be on procfs - you can arrange for something similar
> with fuse.
> 
> Joy...

Well, I was hoping to help fix the existing bug, not discover another
pathological workload! But I'm glad this ended up being interesting
despite my misunderstanding what was happening :)

Thanks,
Calvin
