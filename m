Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC380373BEE;
	Wed, 10 Jun 2026 07:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077083; cv=none; b=oaPcTdTP3FRUNuR5C3Xdaye7DenF5VzfxPh2mTwUrze9yP9mpMSz6ML4YyqoXR2e+B5M6P8/FxpMVvvaLfQ/g62eYd0T9yvOJCfM9WHgANIyVHxZvihKPyqzwg7/gDv+OjYhwEcmOWoklDEtYcG4SNjnvFgtCp3P7SXiVolwI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077083; c=relaxed/simple;
	bh=TlRLDcTDRPStFRt9/iCf7DZCSybmwsEe/5NaeCSAXWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bam94Xa9nQTbNCZUbrg7uHz7NK1Z3GDZEBnMJ1HpWENUzM6qsgZQvssTmW5d2/vmDiqaZiGF3Xd7oVBc0h1SevME2fBiv5pqgQlsXrhx3KSOZJZHvU5+s48QFqGlYsiD4SnqleTtAsrB/5XTre+jm8V3bricW8ZMD+HE9IRIxrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FenL8P82; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FenL8P82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780071F00893;
	Wed, 10 Jun 2026 07:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781077082;
	bh=yYOkV1NVdljOgSjg3gJvnV9hoKNUStf4FTfQfk+Gzkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FenL8P823NPIsZBREpHqEK6DNVuVC8p3x/eZuM5Ss7cn2Dyp3DLc4yEX+X6zudTen
	 AEdpy5nResncDbsUSfKmn5JbYMQCJ5rlEUN9jw5jya5rA+HJ5CwKJr7FHeRbTc5H42
	 Lm9dIbtBjJ9IP/cSBogcdDajFPunyB54/tMF4C/HblQWzel54Sy8MZD5lFsdDSGzYs
	 UzXOAGFqJLaf33yIRHq29tWrgKt0fVeAkSGnPIZayrytHWmjPft28xuyBcJPuSYsOO
	 4ZWo2+wqgxzPdCMae/MX7h4QxCMdAAdfnVPq6s6M4/THXyAv9gZbETkrb+TYlNsR+G
	 8hcyEMF+CaW2A==
Date: Wed, 10 Jun 2026 09:37:57 +0200
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Maxwell Doose <m32285159@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC] Maintainership of the EFS filesystem
Message-ID: <20260610-chaoten-ringen-bauer-516e17aff523@brauner>
References: <CAKqfh0HhN4zzV2=WJwC4ejRQup7Q3L6MkUegC9Bc0xFmzK+Msg@mail.gmail.com>
 <aiOXiumEOIPOQm93@casper.infradead.org>
 <CAKqfh0GNMAnNVvTu-aydHWywR4w-+E+FBtHEV_TCXxzvh6F4uA@mail.gmail.com>
 <20260606042112.GA6060@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260606042112.GA6060@frogsfrogsfrogs>

On Fri, Jun 05, 2026 at 09:21:12PM -0700, Darrick J. Wong wrote:
> On Fri, Jun 05, 2026 at 11:02:44PM -0500, Maxwell Doose wrote:
> > On Fri, Jun 5, 2026 at 10:44 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > As I said, I don't see the point.  Do you have any EFS filesystems?
> > 
> > I don't personally have any EFS filesystems but that doesn't mean that
> > others don't.
> > 
> > > Are you volunteering to do any major development on it?
> > 
> > Like I said, we've already found some problems, and like I said I'd
> > like to fix those before it becomes a FUSE as you suggested. So I
> > guess I'll volunteer to do some major development for it as well.
> > 
> > > Why shouldn't we just delete it?
> > 
> > Because in my eyes it's an awful practice to just delete something
> > overnight (probably not your plan but still), I think we need to have
> > some maintenance for some time before this gets removed.
> 
> How do you plan to do QA with the EFS driver?  Is there a mkfs or fsck
> program for it?  I don't see one in Debian, though I didn't search that
> hard.

If we can delete it, I would prefer to delete it. Less code is almost
always better. I also don't think the maintenance burden is minor. We
really only get away with that stance because we continue refusing to
allow block-based fsed to be mounted in users namespaces. It's so
trivial to find on-disk image bugs for non-actively maintained fses
that I don't see the point in keeping them around unless there's an
actual future for them.
