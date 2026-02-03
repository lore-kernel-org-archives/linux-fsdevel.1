Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88D2EC08C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770110374; cv=none; b=oz3hJM45cboYs+tUOfMWdN+Wbh1P4phqWVJkUk5BEdsEybk/C/Rp2WzAJzcRP0ufI7e5GFDqzBOgU1+qm+zeQfrYSr3hWXeWI+DsUHMD+e4uSHAnT1iJ2eFNiSgMoqRU9bFVcHdSF6FfAWRC//lrLGRCa9Dh3VRuPegYnoVD+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770110374; c=relaxed/simple;
	bh=3Or78jMj5Xlk/VTh3hSCWrSDHyPu3DJXz0lWNpB2qL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0T34xGUQpZcf+9pufpw/DOBuSY8InRzeSHWiIsCt8raOm30WRPQC9yVcKLSOSFmteXyVfQVaogNupftoc8Lr/86HkihBjvfJYx4O6Smixw+6lIXky23QbUlhPW7RMVn43RWWKUEGlkgskS6RA0IvkXpDCesptma5hpcVR5DUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbry8uo1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VTZ97+wf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rbry8uo1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VTZ97+wf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbry8uo1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VTZ97+wf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rbry8uo1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VTZ97+wf"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA613E6C3;
	Tue,  3 Feb 2026 09:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770110371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jaxu/aq7gvWt3kARxgGaAWQwBGrkn5SfTbbQgcomQxo=;
	b=rbry8uo1Yj2v/I/EhivsTo25Y0Wv/V47CvTRLlwObItc9nKk86j1fvh/+eKw4weeAm6ye8
	/B56BzDNnpcSZTL0Ynb5U48j9SMatKs9FR3CxFU+x9Pduj/pcHtKUNduEbcpR3BgbTJzWk
	dZ2mHMmXCYpS7nmRdhcTVbeVwfx4WLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770110371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jaxu/aq7gvWt3kARxgGaAWQwBGrkn5SfTbbQgcomQxo=;
	b=VTZ97+wf2g1jq6uGx3O3w/Y6N4fk4elkhP1k/3DHec8bobiy1h5s2UdzSTY1ffXje91wx6
	yRAdH9HZjVmqYoDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770110371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jaxu/aq7gvWt3kARxgGaAWQwBGrkn5SfTbbQgcomQxo=;
	b=rbry8uo1Yj2v/I/EhivsTo25Y0Wv/V47CvTRLlwObItc9nKk86j1fvh/+eKw4weeAm6ye8
	/B56BzDNnpcSZTL0Ynb5U48j9SMatKs9FR3CxFU+x9Pduj/pcHtKUNduEbcpR3BgbTJzWk
	dZ2mHMmXCYpS7nmRdhcTVbeVwfx4WLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770110371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jaxu/aq7gvWt3kARxgGaAWQwBGrkn5SfTbbQgcomQxo=;
	b=VTZ97+wf2g1jq6uGx3O3w/Y6N4fk4elkhP1k/3DHec8bobiy1h5s2UdzSTY1ffXje91wx6
	yRAdH9HZjVmqYoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 352833EA62;
	Tue,  3 Feb 2026 09:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QZ/zDKO9gWmTLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Feb 2026 09:19:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E9D78A08F8; Tue,  3 Feb 2026 10:19:30 +0100 (CET)
Date: Tue, 3 Feb 2026 10:19:30 +0100
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
	Luis Henriques <luis@igalia.com>, Horst Birthelmer <horst@birthelmer.de>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
Message-ID: <janl2lzct3nz5zlbhlzaasfi7juy3qvajd2jd53qdcb23dbprd@hignhm2ig7s4>
References: <CAJfpegtzYdy3fGGO5E1MU8n+u1j8WVc2eCoOQD_1qq0UV92wRw@mail.gmail.com>
 <CAOQ4uxjEdJHjbfCFM364V=tBrEyczYvzo-b-Xo0UPOCA2cnPGQ@mail.gmail.com>
 <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvg=hqM1vMCyrb61VT6uA+4gdGwvqHe5Djg2RF+DTUMiw@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,groves.net,bsbernd.com,igalia.com,birthelmer.de,lists.linux-foundation.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

On Tue 03-02-26 08:55:26, Miklos Szeredi via Lsf-pc wrote:
> On Mon, 2 Feb 2026 at 17:14, Amir Goldstein <amir73il@gmail.com> wrote:
> > I think that at least one question of interest to the wider fs audience is
> >
> > Can any of the above improvements be used to help phase out some
> > of the old under maintained fs and reduce the burden on vfs maintainers?
> 
> I think the major show stopper is that nobody is going to put a major
> effort into porting unmaintained kernel filesystems to a different
> framework.

There's some interest from people doing vfs maintenance work (as it has
potential to save their work) and it is actually a reasonable task for
someone wanting to get acquainted with filesystem development work. So I
think there are chances of some progress. For example there was some
interest in doing this for minix. Of course we'll be sure only when it
happens :)

> Alternatively someone could implement a "VFS emulator" library.  But
> keeping that in sync with the kernel, together with all the old fs
> would be an even greater burden...

Full VFS emulator would be too much I think. Maybe some helper library to
ease some tasks would be useful but I think time for comming up with
libraries is when someone commits to actually doing some conversion.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
