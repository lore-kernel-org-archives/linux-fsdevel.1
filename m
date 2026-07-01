Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B36A47F2F4;
	Wed,  1 Jul 2026 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909777; cv=none; b=ZcZrlZ8lSrUWyRW+C11o5SnkWRc8H/CKEiBRkEWbC0LvbbNt0mWlqdGAWoz9xavRoV/Rzx2hXBoCaEO3ecWnZ5oF+qNXbZBo40SPIo2j5Nh2t1TzhnHBLY2PFHUfCs9mIVS/BLMwgiQX53zRhWQHMdO9DJQ7wTt/IwBU/sqP/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909777; c=relaxed/simple;
	bh=la2d6Fo3yEaA2Kdk91C9AiHckAv1HLTK8INPR3EEhoY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=BtigfCVMRVyEqm5s+pOp5efsFyFAWDTkOll80FcWfAhG7TzQg+BRelIimdbM9PjgHnk4pmS6z7cz8DGaVWytNMT6+m4gFOw64CUBgg4XHKgU4Yjo14oGZQRx+Lsgnga48vhkW4JxqIpZsl7p8MNsT/JFVkh72jvGJ8NgJ9jie20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAt9LD2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAt9LD2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00F21F000E9;
	Wed,  1 Jul 2026 12:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782909776;
	bh=ZB9HUxrtqxv21ro1rgfH3vCk1a5ng3S1KNn7Gi7FpeI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=HAt9LD2HqE7hXzmOL3BIA7WgHQFyNOy7T9YorwUW6V61HjB3Vt6KcthSFwVqgJx0a
	 JYu3i6aY8PVZuyn5S3qh8yJ3e2Dv7uyCRmsigY7Pk4rY4ts0TkyTl0XoGU/3se+QfX
	 v4AHw90DStD5f2faoat5gVTxFmZNxatvA9RdCfNLZfWH2cL2uv/R/pvPdmhZe/f1hX
	 8KPGdoUbCEgM65dbKldzM3biJhofGajbodKg5CJpdSsWBQKVDGiqehniKqiBSBC4Rz
	 xzuJj0a68JEgdasNQa5xSaJG7TV8aLbSyLtyPEynZ9+iq9hUSSzKqx275VxgfKNCbe
	 ZV7QMVExN/lRw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 00/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1904623668.3623657.1782904060400@kpc.webmail.kpnmail.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260701-vorspannen-zutreffen-unbeeindruckt-29ea949f9d5c@brauner>
 <1904623668.3623657.1782904060400@kpc.webmail.kpnmail.nl>
Date: Wed, 01 Jul 2026 14:42:52 +0200
Message-Id: <20260701-ablehnen-zupfen-endziel-bf3f905ddf20@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; i=brauner@kernel.org;
 h=from:subject:message-id; bh=la2d6Fo3yEaA2Kdk91C9AiHckAv1HLTK8INPR3EEhoY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5cvt92el8W/x3zoPjBpxLnh4+oSBV+nv9wo1s+iVee
 2dqBLvf7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIPheG/8nt0fFJVtWlV9/r
 L3l4v+nERt+JBTs/XZzucaZ14tJG/wqGv3IfpMoz+g9/nPJlwtq9Xo+CY/fU3LTYsOIU581Fs/3
 NHzABAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-01 13:07 +0200, Jori Koolstra wrote:
> 
> > Op 01-07-2026 12:51 CEST schreef Christian Brauner <brauner@kernel.org>:
> > 
> >  
> > On Tue, 30 Jun 2026 12:53:29 +0200, Jori Koolstra wrote:
> > > vfs: pass S_IFDIR mode to vfs_prepare_mode()
> > > 
> > > There is a comment in vfs_prepare_mode() that says:
> > > 
> > > Note that it's currently valid for @type to be 0 if a directory is
> > > created. Filesystems raise that flag individually and we need to check
> > > whether each filesystem can deal with receiving S_IFDIR from the vfs
> > > before we enforce a non-zero type.
> > > 
> > > [...]
> > 
> > People are of course free to annotate their patches with Assisted-by
> > tags to point out that they are using an LLM. But I'm refusing to do
> > free in-kernel advertising for specific companies. So I've changed all
> > tags to read:
> > 
> > Assisted-by: LLM
> > 
> > which is good enough for all purposes. Nobody cares what specific sed or
> > coccinelle version or whatever else was used.
> > 
> 
> Oh, I actually much prefer that. Thanks for changing it. I was just following
> https://docs.kernel.org/process/coding-assistants.html. Maybe that should be
> updated...?

I have no appetite for reviving this endless discussion...

