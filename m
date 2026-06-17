Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E934EF04;
	Wed, 17 Jun 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707687; cv=none; b=qvdPhm8zBluuSD32gkjNzulCyRlX7JfMYycwAlnkqDOns0pWyT5ORyRlB9WKms1ovZJaqKKqcxNPJj+qdNio7yxWmjsevdy/qW9bUDCHZ8Mds5vHARFB8SqYi0KClCzvA+8s0OVfhTOy9192HclWgdXa0f9I5q29R2YOAlCB0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707687; c=relaxed/simple;
	bh=fraDCFpCNdnLQ7SLiZ8SABAXtFxLKG3+ETxK8/+uCpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeKYyW+FWfXFA4iaAmPM1hD7xHq/N6lVrPY6n1QIc/XraWSWUIQx9QvlP2gBm4WYBOCqnCpRVYRBOyuGo7Sfsg6AoSqccmpv5a4aWlv55dmOR4Hte3CgqvOtI4uvo05C1Izg/bio+sGB1VP3Zur868a4Z9eH7kOMgCDy7k4wNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=I9njDkJL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="I9njDkJL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eX7KkuDxepjmifdV31o/TN/TiveAkb0W5UKYG7tQpHA=; b=I9njDkJL1ME3e/LbnV//CsWmZA
	LGVmoak6Q/3IaCKXSwEd0vMfvm+p+jaSIB3ytnoPLPPtK6Vqfp6nxDuFvMzEanUpRevpTzOkBD/2F
	sULiEUFIvhSA/tWOAYA3GG3zrwZgs0a9lZ8FHNREBvH0r5Q7IQbAh1kgFLMwjD653LJqEsFfIjjwS
	9AINfku0nCwkHJPpyGL/XrkjZW9TF6nbOqOJAc7BVgwyV8X+dPhFiJu734ybdt24HPCMcGEsWNWCD
	mAi2hRf3hRJPNXV9/iJpaPtFMFn20mBhzl2p6VOMiTcy6wgOTKrc21ucSsebtJq1Y9gfceUjlj5ht
	TdcVHQEA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZrYW-00Eh02-1r;
	Wed, 17 Jun 2026 14:47:52 +0000
Date: Wed, 17 Jun 2026 07:47:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Josh Triplett <josh@joshtriplett.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajKy5ghjlgyN4tFv@gmail.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
 <ajJ1Xi1p9UhQvILi@gmail.com>
 <CAGudoHEyDz-Tbj=CZFK5XMLuLyE8B17NumdFVLf6MTTekFgRRA@mail.gmail.com>
 <ajKxJM5k9U5L05AF@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajKxJM5k9U5L05AF@redhat.com>
X-Debian-User: leitao

Hello Mateusz,

On Wed, Jun 17, 2026 at 04:37:24PM +0200, Oleg Nesterov wrote:
> On 06/17, Mateusz Guzik wrote:
> >
> > There are trivial touch ups which can be done by adding a bunch of
> > predicts and inlining kill_fasync if someone can be bothered.
> 
> I was thinking about another change, see below. It assumes that in the
> likely case another writer won't steal the pages from ->tmp_page[]
> before we take pipe->mutex.

Do you think we could eventually eliminate the tmp_page[] array and
consolidate everything into the prealloc pages? That would unify the two
page pools currently used in the pipe write path.

When I examined this previously, it appeared non-trivial but potentially
feasible.

What is your view on it?

Thanks,
--breno
