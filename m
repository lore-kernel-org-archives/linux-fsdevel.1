Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EB82F7EED
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781462365; cv=none; b=SpJkoB2kt5GmtjK+NiwmfMBxKYe/MPeuMa9++xW/M4ECerUDpH5j4PJR0ioXbAzcU9Toq/rwy/i205AQqsM8arRzeQ2DjAkkBv4jUAIHzEMalQMo84sKIrFk2wPjKSOI9AbnfY5pPb3VwlwFzmSMiwaHfqJTkqoJ0H62vuoVMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781462365; c=relaxed/simple;
	bh=iHnfaD3B5eFnB9Rrw40uJEp8jTOhj7iyQs2g3fk+Uag=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DAneBqgUdee3qGdiOagymKYkEJSChYghAppME9Swo0+Ufl3LLbhSwJaxMFKFHuhBI58f4DMPyb+gMeuWVwyiW7DajP+H3wBrjG76GdTY9E08NdwINJxYzmPiMPEc+USf6CLYK1BWlDmn3NAd0eKu05NhvxmA7VbemINOk8M1BaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=VbDZpVxa; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="VbDZpVxa"
X-KPN-MessageId: 5c303b41-6820-11f1-afe8-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5c303b41-6820-11f1-afe8-005056994fde;
	Sun, 14 Jun 2026 20:39:22 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 5c2b2ca5-6820-11f1-83df-00505699891e;
	Sun, 14 Jun 2026 20:39:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=aKlN3sgFW4NFdRpshb9Z0T+iA9paucE3PsjplpvvWc8=;
	b=VbDZpVxanilMox86wpPYT6+TqQs0h4QnZUro2smfTzj7yUKLsMEghRISEYBFSsB9SlAzBfwpJUEAM
	 uV48XTv5Gztfrv3os0rQwLNfLv6lPvXRG0Be2p+XjFkaTQ3n8NXp3u03wWrs6+5szW5WiVOZxK/myU
	 wWho+q/F0sSAv/f8h/OgwOa1VOSNqWJcl3C9xb4kFZL07w0V/aWURkxp1sePgUobC5xKVkG/ieooje
	 n5S8S3BgBv/TEX4UrpB4VMPHcSQvK4zTseLg+pVSG0hxggR1h3bpU38yLJq0o5N+/x7MRvQHMvyP5P
	 wDRq2E6I/DI4JMbO80QKdF1Q+wqCnvg==
X-KPN-MID: 33|txK/9yZRIHT/G3Zu3H7h7Xq+wAANRyoHg1/KaaNgrhPDTLdMq4n8lyuBSOrpGaj
 oBA0lI6dBYoR0vbbq8nV7g2K00TLbaLgHwrU/Qwdj3g4=
X-CMASSUN: 33|UUGO+YGoABa+mbdy0kpz+UOC1K5yhBJWW6cb1y+uEaIPiY8Erqj7KLiYtURQF2A
 3Y9IEwtuB87ORbGNaNonmcA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh01 (cpxoxapps-mh01.personalcloud.so.kpn.org [10.128.135.207])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 5c12c94e-6820-11f1-94b1-00505699eff2;
	Sun, 14 Jun 2026 20:39:21 +0200 (CEST)
Date: Sun, 14 Jun 2026 20:39:21 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Message-ID: <430695106.1691908.1781462361803@kpc.webmail.kpnmail.nl>
In-Reply-To: <178044120271.2082204.8038449401223306061@noble.neil.brown.name>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
 <20260531182045.171711-4-jkoolstra@xs4all.nl>
 <178044120271.2082204.8038449401223306061@noble.neil.brown.name>
Subject: Re: [RFC PATCH v6 3/9] vfs: prepare vfs_creat|mkdir_no_perm for
 reuse in lookup_open()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 03-06-2026 01:00 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Mon, 01 Jun 2026, Jori Koolstra wrote:
> > To implement O_CREAT|O_DIRECTORY we will have to repeat some of the
> > logic that is now in vfs_mkdir() (e.g. do error checks in the same
> > order). Separate this out in vfs_mkdir_no_perm(), which does all the
> > non-permission related work of vfs_mkdir(). Permission checking for the
> > lookup_open() path is timed differently because we may just be doing an
> > open and no create. Similar considerations give rise to
> > vfs_create_no_perm().
> > 
> > Moving the fsnotify_* calls also allows us to deal with this in one
> > place for each type of operation. This does mean that we also need
> > to move the fsnotify_* calls into atomic_open() for the atomic open
> > case, but this actually reduces duplicate code in open_last_lookups()
> > and dentry_create().
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 105 ++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 68 insertions(+), 37 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 4cd132fe3981..2a35dd72ee96 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4171,6 +4171,24 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
> >  	return mode;
> >  }
> >  
> > +static inline
> > +int vfs_create_no_perm(struct mnt_idmap *idmap, struct dentry *dentry,
> > +		       umode_t mode, struct delegated_inode *di, bool excl)
> >
> 
> I meant to mention this on my first review but got distracted.
> 
> I would rather this function didn't have the "bool excl" arg, not
> because it is "bool", but because it is not needed.
> The 'excl' flag to ->create is not needed and I would like to get rid of
> it.  We don't have to do that immediately, but I'd rather not perpetuate
> it.
> 
> There are two sort of fileystems - local and cluster.
> cluster filesystems support ->atomic_open and so ->create is *never*
> called with 'excl' false.  All vfs_create() calls (which are either mknod or
> internal) are exclusive.
> 
> local filesystems do not support ->atomic_open but *always* ignore the
> excl flag.  The only time ->create is called with 'excl' being false is
> after VFS has already checked that the file doesn't exist, and is
> holding a lock so that the there cannot be a concurrent create.
> 
> So we can change all filesystems that currently notice 'excl' to assume
> that it is always 'true' and we can deprecate the flag.
> 

Ah, yes, I see. I have changed this now.

> Maybe I should post some patches, but for you could leave the 'bool
> excl' out of this patch, that would be great.
> 

I can do that as well if you want, crediting you. I am busy on these
things now anyway.

> Thanks,
> NeilBrown

All the best,
Jori.
