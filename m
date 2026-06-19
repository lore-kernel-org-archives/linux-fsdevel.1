Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055B313E2B;
	Fri, 19 Jun 2026 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781854190; cv=none; b=RkvT/Y8pe8J+7YGlOXucat9PWse4XbiL/Fg8wTAEu2k8GoGjtPhE0TuUHVA7DJlcLbUbMSRWixSlOUAj4A98xsnUdn5p3gLf1M9UJFHw2/dydXVp+ibeqci7MDMooRChX+uZkXF/1jMAe9ZDD4XAm51a1ltuKLUzoIE8DQqBPZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781854190; c=relaxed/simple;
	bh=dPIFenbQNEtTVzVU1Fpx0mLvCZOoSUW3jYgdAQ4d6yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Voy1BAQkHTaZuR1ag2gAn+2a3TMzmZ7ido6t1sBPfHM0n31TvvtG8Z7kf/y5zJBHhm3y5wnQU2egJpC/dU5FTH0y+55gK4ygjZOQNUJArI5M1mKYAsySJy2ejjhPiMkG7cpje5zBSBHcVcXcgiWNNNkW5SfS7aX0pPBMk+A4zto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmzCOGgZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmzCOGgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0A81F00A3D;
	Fri, 19 Jun 2026 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781854188;
	bh=l00GP2OkLJvssMhCRBJTMHBdONgVgoHnuX1vhYkVEi4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HmzCOGgZhrIO0iecFCvSx26M5X5UhBIT8CHNEQ0nhveOWUh/SWY/xua1payvS891m
	 a0RziI6kh3aYikO4j8kcwFkWNz7whB0uFoHomhByt2fZ+KYlX9j9RCD/RDAYWSHPRO
	 BkFA9wlky5SA0wJgOMYWGl+SgQeH/0BrDTrguV9k4nvGI1eKcpJJmRPDgKiKh/OaqH
	 1GvrYKiQndyHSH4rZVXfU6kd+11On+N0Kw/1f6mYrg0l34RMRh4OkP0oC2tIu1YCL+
	 EewZcazb1mbBBgRevWLuWc3DtjTNXKfCSEtfRBzT/EmfGj5BNc55ppDuY5KJRrlQ74
	 H2NeyfW3SDj+g==
Date: Fri, 19 Jun 2026 09:29:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] file: add fd_except cleanup class
Message-ID: <20260619-rangliste-umfunktionieren-missrede-ab77d1551436@brauner>
References: <20260607164136.2948550-1-agruenba@redhat.com>
 <20260617-marge-gelehnt-fernreise-758645450688@brauner>
 <CAHc6FU6QucixT5jkatPpawaCT4O4JO2kXSeSejb-qQEeUTnzVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU6QucixT5jkatPpawaCT4O4JO2kXSeSejb-qQEeUTnzVA@mail.gmail.com>

On Wed, Jun 17, 2026 at 04:50:00PM +0200, Andreas Gruenbacher wrote:
> Christian,
> 
> On Wed, Jun 17, 2026 at 3:41 PM Christian Brauner <brauner@kernel.org> wrote:
> > On Sun, Jun 07, 2026 at 06:41:34PM +0200, Andreas Gruenbacher wrote:
> > > CLASS(fd_except, f)(fd, mask) allows to specify whether to accept or reject
> > > O_PATH file descriptors by passing a mode value of 0 or FMODE_PATH rather than
> > > using a specific cleanup class for each case (CLASS(fd, f)(fd) or CLASS(fd_raw,
> > > f)(fd)).
> >
> > My main objection to such patches continues to be that it keeps watering
> > down the meaning of O_PATH if it continues being usable for performing
> > ever more actions including write-like operations like setting extended
> > attributes.
> 
> I see where you're going, but let me argue that extended attributes
> are different from file data. For example, the
> "system.posix_acl_access" and "system.posix_acl_default" attributes
> are about file permissions. They are an extension of the classical
> file mode permission bits which are accessed via stat*() and chmod*(),
> operations which accept O_PATH file descriptors today.
> 
> The "security.selinux" attribute is in a similar category as
> "system.posix_acl_access" and "system.posix_acl_default".
> 
> The "trusted.*" namespace is proctected by CAP_SYS_ADMIN, so it's
> obviously also not about file data like information.
> 
> The "user.*" namespace may appear different because access is guarded
> by the file permissions. In that sense, you could say that setting
> "user.*" attributes is a bit more like writing to the file. It's still
> only arbitrary information attached to the inode itself, though. For
> example, operations on "user.*" attributes affect the ctime (when
> changing), but never the atime or mtime.
> 
> Also, you're clearly aware that the same operations are possible via
> "/proc/self/fd/<num>" today, just in a messy way. The exception are

Yes, very aware and I hate it. I wish we had upgrade masks but that's
is very very hairy work. :)

> environments that don't make /proc available. It seems fairly bizarre
> to me to make O_PATH file descriptors available to environments
> restricted in that way in the first place. And that's the only case in
> which processes would effectively gain new abilities.
> 
> By the way, I forgot to mention previously that this patch set is
> related to the following change:
> 
> 5daeb41a6fc9 ("fchmodat2: add support for AT_EMPTY_PATH")

Yeah, I did merge that because of fchown*() parity. Let me sit on it for
a few days to mull it over.
