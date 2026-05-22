Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34603376A00;
	Fri, 22 May 2026 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451848; cv=none; b=A8qVr2xwp/9lIWiq0/Tl5SQNQTibDvHiyTjQc9MjzNW5aag1mg6/GPvN4RTRtjlYsX7EHqB0jCdABZ41BV+IiK+melBzEXS0bpuxKyNis92Erqqvh0giZDVVsabiU0EdLBnP0Y2Mr6uAf1xrDyc/X03ROQzkMUrX1QcqosYNkg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451848; c=relaxed/simple;
	bh=6P8Jlg4l2029b1V02C7uBOwgKbUtHLKhaiFg6hqUIUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UscZMDmIByoWVHY9Hp9Z2M4ge5WtcVGkI+ZVAnu+BqElaJL10vIYveR0PoYlPvACpFSuLPJhOmzv9fD/UAEs6RLDVxyG5HERDmF+iBq+wGTnJFA3cx1bhnUTNmuMaXeGzZw0YoLV7FsoRpKEV52OiVkiupRslAvBWlj5PksikGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=wBZjr/d+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="wBZjr/d+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=bjzkfHAR73gVyHESRaD3e1Go0DB+NgJ32dG4wk2RzRU=; b=wBZjr/d+oDy/t1Xt/t2ZuC6dHv
	+1DoqcruMqlpft9jIatKplxQucQqMZCMNUt3ZUyyjkneZXoe45vKzJeQBMr3P1cUotLqCTT4UP46C
	u74BuAwK+rpUfB9RtQKGh+gMTp4RulcfoTrPI3WZF3vXMSy/Ns+Z62TSjDJfGTwSuQZxWconA8zp5
	EwFu8Z+xdfhNyhXo1qmdVly9zPYEef6jxlzHiBWCwsJzvZFKU/pdeoolSsiRdqxXwT5tOxjtwbvVw
	95TTkfmhKu+ckdcx2DLMp4dcovoh7sq8oUwI6rtYHTSpXH6oZM+yswzch0z45sCchyQjcM74gQYKL
	RYcpDNdg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQOi4-004eZK-1q;
	Fri, 22 May 2026 12:10:36 +0000
Date: Fri, 22 May 2026 05:10:31 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	usama.arif@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 1/2] fs/pipe: bulk pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Message-ID: <ahBGd-VwsZN7BGYm@gmail.com>
References: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
 <20260515-fix_pipe-v1-1-b14c840c7555@debian.org>
 <q37bmptbjr2gysl2g67bqo5axxqor4lsrrnf7ajixxjdrumbup@tgu3kz6kien5>
 <ag3Ty3T24wjn1aFw@gmail.com>
 <CAGudoHGT+8FW9HsN+ymQ2QECVjmwkx=xNQ9=WnjYWirXcA6u4w@mail.gmail.com>
 <ag8lIqhAmJtW4Rtv@gmail.com>
 <CAGudoHGMVQTU-5bh5csvZDgXv_aXun5-eSSGRoONxgSZAcF6Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGMVQTU-5bh5csvZDgXv_aXun5-eSSGRoONxgSZAcF6Rg@mail.gmail.com>
X-Debian-User: leitao

On Thu, May 21, 2026 at 07:26:48PM +0200, Mateusz Guzik wrote:
> On Thu, May 21, 2026 at 5:38 PM Breno Leitao <leitao@debian.org> wrote:
>
> I do suspect the best way forward in the long run is repopulate the
> tmp_page array if you have pages to do so.

Ack!

> > +       struct anon_pipe_prealloc prealloc = {};
> >
> 
> I forgot this bit is going to be a problem with gcc. I verified it
> emits rep stosq in place, which is going to completely unnecessarily
> slow things down especially on older uarchs. This is a known bug with
> gcc doing terrible job optimizing this.
> 
> The problem will be avoided by merely initializing the count to 0.
> which looks kind of ugly if done here, but see below.

Ack, I can do it inside anon_pipe_get_page_prealloc()

	static void anon_pipe_get_page_prealloc(struct anon_pipe_prealloc *prealloc,
						size_t total_len)
	{
		prealloc->count = 0;
		if (total_len <= PAGE_SIZE)
			return;
			...
	}

> > +       /*
> > +        * Bulk pre-allocate pages outside pipe->mutex for writes that span more
> > +        * than one full page. alloc_page() with GFP_HIGHUSER may sleep doing
> > +        * reclaim and runs memcg charging, so doing it under the mutex
> > +        * extends the critical section and stalls the reader. The merge path
> > +        * handles sub-PAGE_SIZE writes without a fresh page; single-page and
> > +        * >PIPE_PREALLOC_MAX-page writes fall back to alloc_page() under the
> > +        * mutex for the remainder.
> > +        */
> > +       if (total_len > PAGE_SIZE)
> > +               anon_pipe_get_page_prealloc(&prealloc, total_len);
> > +
> 
> I don't think this comment belongs here, it should move above the
> prealloc routine.
> 
> How about this: anon_pipe_get_page_prealloc gets called
> unconditionally and expects an uninitialized prealloc struct. For
> total_len > PAGE_SIZE you roll with the current code. Otherwise you
> just set ->count to 0, which prevents the ->pages array from being
> looked at. You can even pre-set to 0 on entry, just don't memset the
> entire obj.

Thanks, let me respin a v2.
--breno
