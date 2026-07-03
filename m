Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E082417362;
	Fri,  3 Jul 2026 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783092489; cv=none; b=Qp4FGeOm+z/38m/OxxgV2d/JSr8SMToZfSdN1klgybCikIceJ7FkNGMytb7FGCJgkS++K7dizM4NcymEisAvc7jQ1bFcxcYfYv075z9vA6s0zIzqfuSPDUMSGN0AwoGdXIEMpx/61DE+B61y+gv8fsfohb4F2m4l6qj24JuSkkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783092489; c=relaxed/simple;
	bh=lJs+X8K4Cg4WT85592ug9GjWBI+cC7fnH1XJ4xBucWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvMu96YxE4IH/1ydeKDKbJISLzVBRVzCYtC/bYJi61vRVacXZC4tTmb0bW2b3z7qA534vzi6C1gRvgT3nJaYDcGz34aLpjSt1gtbxkQvgAYsiJ92RieewdrvMAD86x0//lPQb9tFxGbIucO6CmrpNxarO/7U3/E76guKJ+MGjC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CLGEWLJ2; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CLGEWLJ2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=qn6Y0intizxOglKqDr5Ezl5KVx+GFNtYQ6t8bLYOToE=; b=CLGEWLJ2jPJtYSfK+ByNl0XqSb
	UR1usI+X5v24b5Vyd0XiVyVwpX55Z5GqMeo9RzneOM8C0i15L+bVHBETIXWhFeIqBGdWKlJMNT5SJ
	hG5L7+1d7VsdsU77ZYaCFFSrQauOnPrZPNHYIbetxFtAO5DKS4o4u+dBiCROCipFn3O+61+R8XIVe
	QgBWbHqwFsuimb0DfSDQkUCGYSjm6F7/t8hmg5PmGW92xJnfvPfcRDr9wCMlQCXkmHLjTUjAjrv4f
	fbV6FHBUDQdJ1+KX7dyOpBp8IT1hWA3S8O1weeQIZGGEFYtcejsUwFKREkZUEe12BiiLoFl1Wt+iP
	53nmzXBA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wffo3-009UgM-2E;
	Fri, 03 Jul 2026 15:27:56 +0000
Date: Fri, 3 Jul 2026 08:27:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, oleg@redhat.com, 
	mjguzik@gmail.com, josh@joshtriplett.org, Jan Kara <jack@suse.cz>, 
	jlayton@kernel.org, axboe@kernel.dk, shakeel.butt@linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
Message-ID: <akfO2bPFWLBLuqwG@gmail.com>
References: <20260626-b4-pipe-unification-v1-0-d23fa6b1ee27@debian.org>
 <20260703-dutzend-endabrechnung-mensaessen-1e020014ecba@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703-dutzend-endabrechnung-mensaessen-1e020014ecba@brauner>
X-Debian-User: leitao

Hello Christian,

On Fri, Jul 03, 2026 at 12:19:50PM +0200, Christian Brauner wrote:
> On 2026-06-26 03:26 -0700, Breno Leitao wrote:
> > TL;DR: This simplifies the pipe code, unify the page pools, reduce the
> > code by 11 lines, and improves the microbenchmark by up to 23% — so it's
> > probably wrong (!?).
> > 
> > Summary:
> > =======
> > 
> > I've spent some time converging tmp_page[] and the on-stack
> > anon_pipe_prealloc pool of pages into a single per-pipe pool, as
> > discussed previously in a few places, most recently at:
> > 
> > https://lore.kernel.org/all/ajLA_zxsYyKISkwp@redhat.com/
> 
> I think this makes sense. Sashiko has some comments on missing trim for
> readers you might want to consider.

Thanks for looking at it.

Agreed, we want to trim on the reader side as well, otherwise we might
end up with more than 2 (current default) pages in the pipe structure.

I will update this RFC and resend as a v2.

--breno
