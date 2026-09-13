Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D641A341ABB;
	Sun, 13 Sep 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314588; cv=none; b=CWViRT90b6P8n+OFvKNxmRen+N+WZ4h755ml2DNxKMVsvFpKL2wXA5SMpM6xXYm8OoQ+kqqZX4/0y+Y4AsBhrnm/EjSYfcytM6jSWKHw1VsE2pZ16EPGdfZqzQq32RPv0X/M+jKsroPin8gSo1QFKqCcw/vGtZvcL4tUihSyrLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314588; c=relaxed/simple;
	bh=b575kUcLFx6W86FIDcyoHI6OwWxW++ZDO6mldLyBzFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akIMZ9ekVw45Zuto3JrymR76gdvXAG6z9ohzzPVfKVPigdxzRmCeUmeIMUf/fWRGRwJ9tBJSArpx8UiU9rSsHGvN3yXJ/I2Pi5mc6W/26ERAJx99VWqh7QJ5MzhjZf311y2gI0GWlG6U/A1hsRdOXiCQ4le246mzxzQHETBg1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=nlEWD3Ah; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="nlEWD3Ah"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id B757714C2D6;
	Sun, 13 Sep 2026 17:49:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1789314584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZbYcnwCQHJ/1hYTl1u1L0A3/zi83h13LUtfR6PoX5Ok=;
	b=nlEWD3AhioAbCMcVazifVtxqrCLfphBeoyugxnq3McgZR6SGaqDarsmPTP7iknD6tXmiyU
	vf82KVz34lj5PC29tSjegp8eGGuyVHYFirY+KE7ssDR8E03WDUv2wYanCZ8HtuIayuOCE+
	EuCkX7ZRFv22zG9TLOoQ9S20IgHIeFGjeSStmBLa3c4zgzXu9J83yKHU4Hw+HY/OZ3yet4
	fHD/ysObJVsCG+f5sxQxGHVUXx7UbJ6uw/e5ty+cQNoRzvUYL/VvaIj35jrpC3YemnHgNm
	RHYPZSB2r7wh9UvXC/22PsRit8dSjSZL/nSsveQ76vVdE32zhlG4VicMxJNrqg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id a21989a5;
	Sun, 13 Sep 2026 15:49:40 +0000 (UTC)
Date: Mon, 14 Sep 2026 00:49:24 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>, Barret Rhoden <brho@google.com>
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] 9p: treat read return values of 0 as EOF
Message-ID: <aqbGBMJ6bntYB1t2@codewreck.org>
References: <akfHGcqke9qixd3Q@codewreck.org>
 <20260702090941.1298188-1-brho@google.com>
 <2237820.1783934942@warthog.procyon.org.uk>
 <f7005841-80a9-4c21-a114-6cfd6ee63a58@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f7005841-80a9-4c21-a114-6cfd6ee63a58@google.com>

Sorry for dropping the ball here, I haven't had any time to do 9p stuff
at all recently and the wave of LLM generated patches hasn't helped...

Barret Rhoden wrote on Mon, Jul 27, 2026 at 01:38:16PM -0400:
> On 7/13/26 5:29 AM, David Howells wrote:
> > This is kind of a weird situation.  We're caching locally the content of files
> > aren't really regular files and probably shouldn't be cached.  I'm not sure
> > what the best way to deal with that is.  I wonder if there's some way to
> > detect that and mark then non-cacheable.  (Assuming the server can be told not
> > to even serve them).
> > 
> > Can we detect that the EOF length doesn't match i_size and set a flag to say
> > "don't cache" in netfs_inode::flags?
> Possibly, but could you have false positives from this?  e.g. if a file's
> size is changed concurrently with a read returning EOF?
> 
> As far as detecting EOF in the first place, my patch had the 9p client doing
> it.  Not sure, but Dominique's question might have been whether netfs should
> have done the detecting instead?
>
> From what I can see, the netfs clients were responsible for setting EOF
> (except in netfs_clear_unread()).  Some in response to an ENODATA error,
> others due to the "did we read past the end of the file size."  Not sure
> whose responsibility it is to detect these cases: netfs or the FSes
> themselves.

Right, that was my question; I honestly just don't understand the
requirement/promises of the netfs layer.

In this particular case we have two patterns to address:
- synthetic files with stat size > actual size,
e.g. /sys/devices/system/cpu/online
- synthetic files with stat size = 0 (rarer),
e.g. /sys/devices/virtual/net/br0/brforward

For two at least two modes:
- cache=none
- cache=loose (writeback I guess)

Right now, none of these work, with various degrees of not working;
I'm not sure we can do much about some of them (e.g. stat size=0 with
cache enabled I'm fine getting empty data), but imo
- cache=none should just try reading as userspace request anyway and
stop as soon as the server returns 0, that's not a 9p specific behavior
and I wouldn't have expected having to do any special handling for it.
(but if you tell me it's to be done in 9p case, then sure, we'll do it
here)
- cache=writeback + stat size > read size should also stop when the
server returns 0 and truncate its view of the size to that; the problem
in 9p is that we'll reset the size again to the remote size shortly
afterwards so that will need more thinking (and overlaps with the other
cache size bugs we have in flight), so let's focus on cache=none for now

Thanks,
-- 
Dominique Martinet | Asmadeus
