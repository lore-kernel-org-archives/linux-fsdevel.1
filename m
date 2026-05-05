Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3BC2DECB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021412; cv=none; b=ROZsvM3uv774jzNTbVG1BVX7VgX9UVlB8nzyK48+on32QV0WyGYcvB4Ya3ms1LCyrNQfITXEl47q3TQQ46iNl4GCUfp5MRjF/ucSIYBFsXwTkKDdUwP+OuIzYKHdumLCcuqstnDM20zv15o1pcIriSY7xpAqtSUAOA2v4ynFAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021412; c=relaxed/simple;
	bh=P4EH6qtCNKBBenRP/DiTu+2Gl9yidqZ5/dDOk6y3rds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+dx6Pt2YfdalehZVBHXHe5uROm8+6SypD7MY5TjNUXFPJCnplnSHXR0Saifw18oGX1Av7ocgE2xQzxFraSazh07S44+m4dSAT1ccagnVBUKIK8I+w9XUwdNcpdKWHyiDj0oecTXuYjndlKj+JhihFljpy1R3nmDr3RJrndhM7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AILjOW/r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AILjOW/r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ej7FP/rhlrBj6nXJmmG2nawSvIbUH05C7OCxBpfwNpk=; b=AILjOW/rg2xogIhhlbywvC8lhS
	VzzZuiOCuUr/fhEE3Kt/Trxt/2DvVIG/mIqDnrJmcSbs3uFWYpAgy0XcCL4lCCkh4Il7tey70Voyx
	DxAfVR6YU00VuLq0lVKWLEnCLZVKhcn2uyPZE/tckZw49c5GenAEkPYm4S1g6etMEzliniqh4flFY
	7Qya1aM8ysszkZpKRjCLnj6NdxhwodfJ845E5cME/FGRtDhOor8FdfAsmXENlNiIWpbRAbEdsNdSm
	aVzdoWeLvjOZc9M8LO+RN1cumRkrJIu1+7h9o2lKuiJ5uTgFW9xMBmj51hfiot0t7vmJY9zlN+1zV
	e4yWdq5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKOay-00000009Aeb-0y4o;
	Tue, 05 May 2026 22:50:29 +0000
Date: Tue, 5 May 2026 23:50:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <20260505225028.GI3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
 <20260505200501.GF3518998@ZenIV>
 <afpj3FBrvHer0E6Y@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpj3FBrvHer0E6Y@pavilion.home>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 11:40:44PM +0200, Frederic Weisbecker wrote:

> > FWIW, back in 2015 spin_lock() did *not* provide an RCU read-side critical
> > area, according to https://lwn.net/Articles/652156/; would be nice to have
> > the history mentioned in D/RCU/whatisRCU.rst - at least to the level of
> > "once upon a time one *did* need an explicit rcu_read_lock() in addition
> > to spin_lock() - spin_lock() or preempt_disable() alone was not enough;
> > that has changed in <...>".
> > 
> > I'm not familiar enough with that code for that kind of archaeology ;-/
> > Could somebody help with that?  Paul?
> 
> That's quite outdated. Now preempt disabled, IRQs disabled, and spinlocks
> are all implicit RCU read sides. On non RT spinlocks disable preemption and
> on RT they call rcu_read_lock() internally.

Out of curiosity, how much headache do bitlocks cause on RT?  I mean, they
are unconditionally disabling preemption, RT or no RT...
