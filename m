Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C44627FB37;
	Sat, 21 Feb 2026 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771657838; cv=none; b=n8WQ0ay/m0A+J2sH4Dd2IfiLR8CyIIHivFlADqia9v3Du5NPk/a6s7Xj9/GevXWap+hR0iwOPTKQ6PKOq4u9/2zInQgk4gbIzYRbfrBZd1yFqjlteKT4Puyieaxg/nlo8qeh4l8q0YfFHjJXIMBoTX+zyvd0ese6GPTgy72WoFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771657838; c=relaxed/simple;
	bh=siDGq+cYqbd1HY6mDkkTonfR447tYvlLU9pKjuMAAT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9ZS4pcD5p/b+5vG1Kh9IDgZLUIeDRE3FP4HUnEc6m1E9fyFcOVNB/8bBbX4kfQD2yLe41SbZA3wiemlumr81KDJGywmuovgfCDW5L6tUho0gx6vnpakfAmMpIIEl24mwAPSggiGvlypH1sv+o6Mf5gBowjgaDjlNGAXME8EjfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRrb+af4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRrb+af4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756D2C4CEF7;
	Sat, 21 Feb 2026 07:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771657838;
	bh=siDGq+cYqbd1HY6mDkkTonfR447tYvlLU9pKjuMAAT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRrb+af4gR2bGlPtV3umAkV6UKd+qijvzKtTI1pgbliAvetwH54LStp9lDKt2JqN3
	 sK5Ntp5sp5L/cw4cEwkc0VwNJ7wxe8ISDoPtqLFE8iT2mHfCtMMigtNyWSa3Zxia+l
	 46WE0kkfezOr+Lz8yUzKZPXRCuu0OcVzhvQPdntajVCIzifFWSeTWZ4T4XcEGRmLJg
	 NX4aJUZyk2xDgsfs2MmN84fUIshoFW8TuA9CbJ8A8/QFq//8QavLH9ZDdmJ6zLlnvJ
	 QBxGMu3PrcSb3yMFnfy4b/V7b4wbiFaV0aRFwOzxPQzTYGY0/Twu27kNuE34Xg+Nms
	 /C0yXxjJU0Fxw==
Date: Fri, 20 Feb 2026 23:10:37 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: David Timber <dxdt@dev.snart.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 02/17] fs: add generic FS_IOC_SHUTDOWN definitions
Message-ID: <20260221071037.GF11076@frogsfrogsfrogs>
References: <20260213081804.13351-1-linkinjeon@kernel.org>
 <20260213081804.13351-3-linkinjeon@kernel.org>
 <144a192d-1298-4aa4-891d-cf5e2ad6b8e6@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <144a192d-1298-4aa4-891d-cf5e2ad6b8e6@dev.snart.me>

On Sat, Feb 21, 2026 at 03:17:30PM +0900, David Timber wrote:
> > +/*
> > + * Shutdown the filesystem.
> > + */
> > +#define FS_IOC_SHUTDOWN _IOR('X', 125, __u32)
> Should've been _IOW, not _IOR. This is rather unfortunate.

Yep, it's too bad that this has been encoded in XFS like this for
decades. :/

You /could/ send patches to add an _IOW definition and make
fstests/xfsprogs prefer the new ioctl number over the old one.

--D

> Documentation/userspace-api/ioctl/ioctl-number.rst:
> >     ====== ===========================
> >     macro  parameters
> >     ====== ===========================
> >     _IO    none
> >     _IOW   write (read from userspace)
> >     _IOR   read (write to userspace)
> >     _IOWR  write and read
> >     ====== ===========================
> >
> > 'Write' and 'read' are from the user's point of view, just like the
> > system calls 'write' and 'read'.  For example, a SET_FOO ioctl would
> > be _IOW, although the kernel would actually read data from user space;
> > a GET_FOO ioctl would be _IOR, although the kernel would actually write
> > data to user space.
> All the *_ioctl_shutdown() do get_user(..., arg).
> 
