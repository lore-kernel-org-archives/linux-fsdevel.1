Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322796;
	b=5RrQcqtlsQq6zWElVNAvfhwHeDJOJ28ff4qlYy8vR6haeQY0XpBEdbVSGRqvTWjx4jEb
	 lvTcWHgynQtqHV3wN36GTpktk/BESybKwbL5/nlAVqj+1tuT132/NLWHnbz6lf/pflP6l
	 MkxglowqPNsvezMuzK179HZtrfs8gZzeBFkOc9TH9RLUa1/yBZgqw+XzGcef/X/Yho6ge
	 fAc0R1P0dWc/Nzs73FvdqbV9sy16Xkyk/EcvbxmS+Ba3x5+GmoWuZ1gEIL6evZUAPczWF
	 X2E4Qm9H3lV0UNkTTuVerYgzqwet820SnN3hhhnjaKEkh1rmxRE/1Juw/JFRCcDqYVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322796;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Debian-User;
	bh=nk5n+KGNUb4vC/tI/kwaF+NJ3eYzXA4Qv23194hGaG8=;
	b=naNJyieyFnbP5VZGTWJ4oD0I/jAIrFBFUhidkqVvTf5cwzQH+yrSEYXNYdQkUNleclmU
	 jelGktTZVEnqj1vrFkMIrKynGFikAElsR0lmMBq2X5fjp8j0kDTeVUPxdlEXrVedDlU22
	 /Qh0GdbB6TV0BNzmT2gd4/0uGJPExD2QHQhnhqO8T03MHHNFKJPCumbKTZ2WlFNL3YrM3
	 WShTfolETgsc1SVcgsht+skHI1CsIDnOCViOtnDbH8DRUTWkgVEPS/tH72GiDag600/tb
	 rMUPvwKSNM1iWbsO+utGvGhqXwgdkrPsKlLY+hzlXh8ut2eiMAilI7o3A561PeOZT6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=B1RNKiIN;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AF606A332;
	Tue, 10 Nov 2026 14:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F8AF606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=B1RNKiIN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=nk5n+KGNUb4vC/tI/kwaF+NJ3eYzXA4Qv23194hGaG8=; b=B1RNKiINUFSEj+uDwF9/8AKB/c
	jf+zU0SbRDz1P9XyW0wk/aC7Z9ziZ5KxBgVqy4PKNUcfuOMxcTv3kyaddNzyj3R4KS/bFtEE0zNIP
	cBWlGNn7NAiVTs6THBwh7GqAC2UL8NHyO3kwsZAzCXVJHyMb63Pw8hlUYr6Q6lLDUn2AHJ2J/ApMX
	fEF5x8HmRaLKSyUYsWdgS/8ZvW3aKXEg4SEfYB8j0weDtT7bx+CGTnXM7A+gLQzBNMHcDGJXOFKqN
	Sit2N+oUeC7reMR5vNZlhtChDamSWIIz1gIZGJnCB88EdPz8RncU4F4y8kDOCgsk0V4U0U24TYHXO
	wIf7Tg0Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQnK8-00CU9c-2S;
	Tue, 10 Nov 2026 14:59:48 +0000
Date: Tue, 10 Nov 2026 06:59:43 -0800
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [fs/pipe] f7f4665dc5:
 lmbench3.PIPE.bandwidth.MB/sec 18.5% regression
Message-ID: <avMxCN0yayzLh2p1@gmail.com>
References: <202611041404.befe64cd-lkp@intel.com>
 <20261105-trommeln-einspannen-radius-ccb4e174e407@brauner>
 <auygOHcuBba_o132@gmail.com>
 <CAGudoHFpNbxL13ZOWiyyLSPpmzXcB=e=RBZ8ZGk+Oc58Aad9pA@mail.gmail.com>
 <au2vjpu_yqNa83pN@gmail.com>
 <CAGudoHF3de_55YvdztPs7QiYs25u6nPEV=uMOzfr=bWmwof69g@mail.gmail.com>
 <avMQxhpHhIPM_6HP@gmail.com>
 <CAGudoHFe8XgtKZohfn0Q=EH0EeXozTZq+UPJKN0BEmLnEG2s=Q@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFe8XgtKZohfn0Q=EH0EeXozTZq+UPJKN0BEmLnEG2s=Q@mail.gmail.com>
X-Debian-User: leitao

On Tue, Nov 10, 2026 at 03:44:36PM +0100, Mateusz Guzik wrote:
> On Tue, Nov 10, 2026 at 1:46 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > On Fri, Nov 06, 2026 at 02:44:54PM +0100, Mateusz Guzik wrote:
> > > > 6) Any other idea?
> > >
> > > The SMAP stuff is the primary problem right now. To reiterate: every
> > > single buffer read/write takes a SMAP trip, which is very expensive
> > > even on modern uarchs. Refactoring this into i/o under one SMAP round
> > > would provide a visible speed up. It also happens to not pose a
> > > tradeoff in terms of memory usage and would be my first avenue of
> > > attack if I was working on this.
> > >
> > > All that said, one reader vs one writer scenario definitely makes
> > > sense to optimize.
> >
> > I've spent some tokens on it, and it seems to give ~5% improvement on
> > the pipe bench. Is this what you had in mind (in a single patch format)?
> >
> 
> The resulting behavior matches.
> 
> A clean implementation escapes me and that's part of a reason I did
> not do the work myself.
> 
> The proposed patch is on the uglier side, but AFAICS that was never a
> blocker in Linux.

Agree, the implementation is not beatiful. Another approach is to open
code and have a single function to do the whole copying, and simplify it
a bit, but, that makes the code even harder to digest.

Let me try to come up with something a bit more digestible and see where
I will end up.

thanks,
--breno
