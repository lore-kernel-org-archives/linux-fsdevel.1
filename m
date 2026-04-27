Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524A3BB9FD;
	Mon, 27 Apr 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777301463; cv=none; b=TqFz/1kiuihzYiNozxMqREDdEhCjAi5r8CHQY6EyDEjr9G2eWhMItU4qRDulxDwKeqwr8EpwMgEQdjLME32Zdxj78dmsdORKb6AEulJp6gPuM7rsnqTKOkXC15i14o3NuGTbvJvYYBwu3WyzFfQJSCRKj9SZ31c4xZwIuI+2nEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777301463; c=relaxed/simple;
	bh=2T6S+4TWa48LESOUHSb2tjdOhvJqnrda3WWp6MYczF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cANBeUhbpOPU6Ghycs8MgsB03diFAwVUbMIirROUchuWmzLstIPl7E/jZdnnDejCpBV0lDi/MGDzfdNWrng0TblMlEUegkH3iNqdDGf1QJbHfJYfp9en+W4Mf002YrmMEttNpUHF0eS9vsrX2VG31g6d5Tw6hD2NLb5qZPJqVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiJWe9RE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiJWe9RE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6444C19425;
	Mon, 27 Apr 2026 14:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777301462;
	bh=2T6S+4TWa48LESOUHSb2tjdOhvJqnrda3WWp6MYczF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jiJWe9REmolUDjcep/yiG64BN1SY+s9uWzY6hXIsmst9qLA3wZ2ZxzCfREhdjWL90
	 P2GrP8sc/5VzwtlgRXvsoIVK4dCkmQJbGAK3Ow14WTltFCgvTITjw6KkfP97xmMElp
	 yG7iZ8pRcyX1Kw/5i+SOpLI2xGJRD4VwNtkBRDoA92XKb4EO1ZryA6oJRp+Ix+k6q1
	 ao2grgTDqKi+Ysn/+XfPvMUbtweRRtNPCDju742ckoqKqMqWBDQGv8XHNNDyE0qIuh
	 KkfKDm4thH2V2VDcgYn0PC/TzBKLF1QwFF73gQ1ia91pbPC7IrpJgvyOucJLoJT+ax
	 6xJ84ZEze4CVQ==
Date: Mon, 27 Apr 2026 07:51:02 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
	miklos@szeredi.hu, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 11/13] example/service_ll: create a sample systemd
 service fuse server
Message-ID: <20260427145102.GL7739@frogsfrogsfrogs>
References: <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
 <177689988738.3820166.3563042250723069297.stgit@frogsfrogsfrogs>
 <18844024-34a4-4e72-831f-04effc8e1418@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18844024-34a4-4e72-831f-04effc8e1418@bsbernd.com>

On Sun, Apr 26, 2026 at 11:28:11PM +0200, Bernd Schubert wrote:
> 
> 
> On 4/23/26 01:22, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Create a simple fuse server that can be run as a systemd service.
> > I plan to create some more single-file fuse server examples, so most of
> > the boilerplate code goes in a separate file.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  example/single_file.h        |  153 +++++++++
> >  lib/util.h                   |   35 ++
> >  example/meson.build          |   14 +
> >  example/service_ll.c         |  312 ++++++++++++++++++
> >  example/service_ll.socket.in |   15 +
> >  example/service_ll@.service  |  102 ++++++
> >  example/single_file.c        |  733 ++++++++++++++++++++++++++++++++++++++++++
> >  meson.build                  |    1 
> >  8 files changed, 1365 insertions(+)
> >  create mode 100644 example/single_file.h
> >  create mode 100644 example/service_ll.c
> >  create mode 100644 example/service_ll.socket.in
> >  create mode 100644 example/service_ll@.service
> >  create mode 100644 example/single_file.c
> > 
> > 
> > diff --git a/example/single_file.h b/example/single_file.h
> > new file mode 100644
> > index 00000000000000..d8a91adbf875ef
> > --- /dev/null
> > +++ b/example/single_file.h
> > @@ -0,0 +1,153 @@
> > +/*
> > + * FUSE: Filesystem in Userspace
> > + * Copyright (C) 2026 Oracle.
> > + *
> > + * This program can be distributed under the terms of the GNU GPLv2.
> > + * See the file GPL2.txt.
> > + */
> > +#ifndef FUSE_SINGLE_FILE_H_
> > +#define FUSE_SINGLE_FILE_H_
> 
> From the name it is kind of impossible to figure out what it is for -
> requires to go through the code. Could you add something like
> 
> This is not a standalone file system, but a helper for other file
> systems to expose a single file backed by a physical file or block device.
> 
> For both the .h and .c file? Please feel free to make it more verbose.

Ok, I have written:

"This file is shared library code for example fuse servers that want to
expose a single regular file that wraps another file in a manner that
goes beyond simple passthrough.  It is not itself a fuse server."

How does that sound?

--D
