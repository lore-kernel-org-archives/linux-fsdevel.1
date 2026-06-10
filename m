Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B63738E8A6;
	Wed, 10 Jun 2026 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076688; cv=none; b=leoia5c+xj19dpmph0873dg+7DH1g4eCQCzW7UTl8mPCr3MlcdaX9b6DC7dSMLc3xo8nGuGJep/IgUzAoKkC9W4TuKBlgABII6xS7rZKvngguRuI3Mk4+tEUtTEJkePI5kNrHi9VxBEo3Tw2eqGpShPuH/YeJXyOGAm4N/2Yc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076688; c=relaxed/simple;
	bh=r35Ug3nuzrb1TZlrRlaJ/byMz2jEo4jsEWfD5ZnFmX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwnU4I3mvoFuPkRrlJi7pHP2oOQX5WzPKvjFYUMYEhITuDNJtde2gWhAx937Cu7FstVuztdetVBV0fyo4AOE+JHwcdTPLeSLPMzYudLT8oGvavVvAltAvMzPeq/yGzvOF5h/KgogGSjycZoUD9WtXD2bI5yDOVh1Hw+d1B1oxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbV7VSWk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbV7VSWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A506B1F00893;
	Wed, 10 Jun 2026 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781076687;
	bh=7+ReyeKy6qPFJoiIvw7ddGeZu12JO1u6FzwJci0SAI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lbV7VSWkccI7ZRO9Iv6SYeNXyTkgYAx0xfqQuzdnt4x/S3xkZp3lUChofffGKe+90
	 jBpCu5kPfJ+wz0ZiH/J0mYxpXV4uqpA9cfJmranvi4DnFqgHijQmPTL42Y6nh+Hbn0
	 OQ2hn9KOTnTByytc563kSd+ZZ1bJ5Jrzy9k32MmzQhOgXOH+va89ctmlPwg6MAz0I6
	 CcQCZz4TX5UA49P9SRl83YAmrRIf7+WGXXBUi9X82Nk3mXXmo8JA7vZp2CL4qQ/9bS
	 VFsDpBrjeelefOPZKF84+QoRjQPJziHdWHmMCMARi5s7xdGQNo/oFJwJPfZUWTHnn9
	 UBxVzGWnOLYVw==
Date: Wed, 10 Jun 2026 09:31:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: AnonymeMeow <anonymemeow@gmail.com>, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] fanotify: lift pidfd reporting restrictions
Message-ID: <20260610-umkippen-bauformen-fehlpass-d637b7bc0555@brauner>
References: <20260607003343.425939-1-anonymemeow@gmail.com>
 <hsqpfvobwt3pf5he6hho653wl2tkwjaszfldqk6itch5uoqccy@jkijxqcm2in5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <hsqpfvobwt3pf5he6hho653wl2tkwjaszfldqk6itch5uoqccy@jkijxqcm2in5>

On Tue, Jun 09, 2026 at 12:29:05PM +0200, Jan Kara wrote:
> On Sun 07-06-26 08:33:41, AnonymeMeow wrote:
> > The pidfd API now supports pidfds for tasks that are not thread group leaders,
> > but fanotify has not caught up yet. This patch set lifts that restriction and
> > allows fanotify to report pidfds referring to the event-generating thread.
> > 
> > Additionally, this patch set allows fanotify to hand out pidfds for reaped
> > tasks by registering the event pid with pidfs when pidfd reporting is
> > requested and dropping the pid_has_task() check before the pidfd_prepare()
> > call, as suggested by Christian.
> > 
> > Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
> > Link: https://lore.kernel.org/lkml/20260602-patzt-sturz-segen-f1f305d61b75@brauner/
> > 
> > Changes since v4:
> >  - Add a pidfs_register_pid_gfp() helper function to pass in custom flags.
> > 
> > v4: https://lore.kernel.org/lkml/20260603001516.26234-1-anonymemeow@gmail.com/
> 
> The patches look good to me. Thanks! I'd prefer the change adding gfp
> argument to pidfs_register_pid() was a separate commit but unless Christian
> objects I can live with that. I'll wait for Christian's ack for pidfs

I would also prefer it to be a separate commit but same as you I'm not
gonna insist. :)

> changes before merging this through my tree.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
