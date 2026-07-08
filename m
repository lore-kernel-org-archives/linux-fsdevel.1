Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DE040927A;
	Wed,  8 Jul 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526114; cv=none; b=p4DGR8le2fNJ8vue9jt9iq/wqvdSr7B31H7eDAPUdoiSpZK5TZCitZHsC7uE7m1Blik97ms3Pa0A4JQPhKV4ecBAeXpqetjgvE2TmdeoheBDW/tn78Ykrvygzt+e3zDkthFFaKYDcuCKg3Yt85jrZTR3ZNcXcPGQL9YOkCm3MPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526114; c=relaxed/simple;
	bh=oYUkap13H/ljKeh7prqaskPz/1kSTD389KTXQSfGjxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdBHRNwsiIx4h13YWhB8KMoKEUbyoKUMfUVrsFrHOYKpasuzp+3FRwc0Znh4DbaxwZgbyAT8GiwCNC6mgzGLGaX+6ujrqCJRyHTB8+MtIsy298QiyQ9SCTK9C9a3yhqnZ+xOJGlKp0FY5qXbJ97hZi8XX8EHSSot+GioDLgUZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qiOgDbiE; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qiOgDbiE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=9uzo/+ZMsI9AE8BH3oP33g11nkLTRuU3D045+coURXo=; b=qiOgDbiEUagj3suhyQZJYFHimT
	fiJaBOWAPs9dYl6uMoND4iBrSHrp0KWBmTSiRfdSyOxwP1fLmvA8Qf5XBDYRR/TkGjJGr/dsDVXKm
	9hZwaO/KTJ1YvFbVcOx38ewL1fDNHch4sDD4gjDH43QI6JwC8G6hrZno2vMhpOLJeQRCA2t0ZmZPo
	Y5dtBvm0sMKBWmzeENzFoorJ2VCSmaw3g6gpg9A4qis41U8BRhNdgC+g4vHmS1Hd5dGN+OasvmIYw
	NLIOVsLLD0Qwwk6aBW/yehkoJJuurHSvH0GA04DYegBOYiKi6jsB7AAxIlKAntJAzKLnXfrFjSRWC
	PV4KBAnw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whUc2-0033ej-04;
	Wed, 08 Jul 2026 15:55:02 +0000
Date: Wed, 8 Jul 2026 08:54:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, oleg@redhat.com, josh@joshtriplett.org, Jan Kara <jack@suse.cz>, 
	jlayton@kernel.org, axboe@kernel.dk, shakeel.butt@linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
Message-ID: <ak5yfhm1qA2E4ntV@gmail.com>
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
 <CAGudoHFGFJZ_j-osEKnLvGYGai+SKVAJKy8B_PChWms7SN7xoA@mail.gmail.com>
 <ak4rSEAwV-RoG1MO@gmail.com>
 <rac56njg4yorvhc5oyrme6bt7ej2vs64umbqkz2np32wpjbcjj@wohli2ntub4s>
 <ak5nXRnSSXfA2B75@gmail.com>
 <CAGudoHGAg2s37LeJzZTKTyQS4fARSdipcis-76b25x7XnWoZiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGAg2s37LeJzZTKTyQS4fARSdipcis-76b25x7XnWoZiw@mail.gmail.com>
X-Debian-User: leitao

On Wed, Jul 08, 2026 at 05:24:47PM +0200, Mateusz Guzik wrote:
> On Wed, Jul 8, 2026 at 5:11 PM Breno Leitao <leitao@debian.org> wrote:
> > That said, your approach is better than what I had, and I would like to
> > integrate it to this patch set. Os it OK if I give a Co-developed-with:
> > tag?
> 
> imo this is too trivial compared to the entirety of the patchset to
> warrant attribution. Just take it.
> 
> To be clear, I just now verified avoidance of the extra trip resolved
> the regression for me so I have no objections to the patchset.
> 
> For completeness I note I failed to remove the lock acquire in
> anon_pipe_trim_pool_and_unlock, but I presume you noticed (at worst
> while testing).

yes, otherwise it was self deadlocking it self in AA scenario.

> One suggestion I have is to post the entire thing as one patch as I
> don't think the split here buys anything, but I'm not going to insist
> one way or the other.

Ack, I splitted the changes hoping it would make the review easier.

So, I will respin this with your suggestion in a single patch, after
some bake time (probably tomorrow).

