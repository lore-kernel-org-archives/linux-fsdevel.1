Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81C2F5A12
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331289; cv=pass; b=K72wRLY7fMFL5V0ekvGVOR8k3zLgiBao2AWoOqFQ2AJ9oa4NwnW6RwMpWxtDuWHgZ3nJHhKmRByXg7pGkb8toF3ubPe8VfujQ5b4p25rvQ9xhuO5yeq7wopTvzxIsn2Setkd2Pzpuzj/A/OfvY6x5tuWsrXG6E0TTAD2j4AdB68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331289; c=relaxed/simple;
	bh=qi0bNA92wLl2nMk/hIYTXnmjk9Bfbm5qhtK/24nDsrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdVGs97q6Y/JBqpG7hmSd3gOIEtf7+fCFUZZWkrwmm/L+7/HSDj9Sr1V2lPCiWRsB0t2oDHHIsASDlARiu/uMGfC76lYoyfDZKBgVYfF+ktFI1bDERThzCYrQnMCdjc763hqKpexv51+A6RFyVuuabpIOkE+hT3IX3mXyRUwL9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dUXjSj+g; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dUXjSj+g"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c856db4fcacso3024862a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 09:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780331285; cv=none;
        d=google.com; s=arc-20240605;
        b=b67UEwddRh/Vl93JGnhq75qH7EftufxriAwF9m1q2SwsN8RgGD/UcH0inkz20Y7soy
         +FawnQofy+i7+aG9pEGXP0UYWNSi5z49zQlqXxrD6QGxE/X1T1RVd0rOf71sTtZVhPsF
         qN5vv/wB6P1NVG7jVieAh8f2PYkklEf5Nv3IF8ouCcCSFihbaAoW63YetKqDPoVU5IBH
         JV5+sryZR1w0QOKrOrZbo/SH3Ho57YH95T7JBnX7LK0vVnZ1DFOXjmlpRTOpWGOjTi6z
         +U9MwyRF7LfdoqDn7ohhR76+dkd1JmHPcjW5twK68tUVsSlV7b9TKUFL1GCgNAI5gWAp
         1YRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGlM2E9AAqaBi+x0e0uF9maYBNYnyD+734d/pzzcsto=;
        fh=mfqZ/xo9irS8JHbARwU5FzNv9a8AulFK4Kea1lksFms=;
        b=caqMMtTaP3yCxCacqHkj2ndTa2qKEyrISydjuzzmMovy811cEEqFRtJ9/yIkU5yr+s
         wHrAXnmP3g6dKS7MARod2Dv7LLGhFtvuskjUvIGZiofV53sAxOnUGEAYsLQJyf0/DjTQ
         gplKuhrCsINEe24ub2fd2gkHOFkJ6OhBAoqMzzaRXNRHUZbSCIH7gxLGuTN931U2BiXL
         8sHUke47rXfHNIAxWkjE9XWlQ/B0XegkKALRl/7kUeFn021nUtJo/o/P6ounNwULBDYs
         FeOzpxjivuygty/q+wmc5fkLvcDTine1FR0G+GA4TC9W7d9v7qBU/oICpGgeCoqlLw2o
         eyng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780331285; x=1780936085; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGlM2E9AAqaBi+x0e0uF9maYBNYnyD+734d/pzzcsto=;
        b=dUXjSj+gZhEJ1wkBA3Hx1JpYmkvAvUSX7ehbjhMY8bdJnMF9RArJQMFYfB+bjrQHAe
         SVbCQGt3bTri37mM1s4mF1Nb5snzD107h3zbt2VlHRlH/FbVX+y/6rJ2EJruX/gK7C1m
         dRu6usG75kxEqOsojY43Ytgymj6zmkO4zL6BrscU6NK6P1bnNgcBLWdSWjLfH/zR3nTH
         H+sy/BYXTdaM4ICVqQFdftmCVTZMWQmIZy3NsKDg89ATRjTXPqkPWyxBPBxkmPFHBFeV
         9E1F7W9l22SX+u4/u9ihYgwATE8vyUc4DV5UOuugSjUCz8HE8M3ePwoSWv/dOd1gfAIP
         A2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780331285; x=1780936085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGlM2E9AAqaBi+x0e0uF9maYBNYnyD+734d/pzzcsto=;
        b=EsxaillBxuiT4HfFK+opCOM5kWfNyAqD38Yehar1b0mo6Ls/uFZivb0jiqD4Xz8era
         A4naEFAfKJ7iB+Oc/K52N7LSz7+g/UyMUtj0fWd+Hhegco6QtOMe4/Mfr+FyszPth8Sc
         HYyAEOOrFtlvO3gx7XButk+GOgchxv+JuX2IfMOryc0M1Wz5mbpXUmpEqjsIi7S/Ugrq
         dFa2SLYYW5WXD82UK+hZma+gnw8uQsuO4Ztd/GUktqhO2UVGcULwj8Fm8fbu9l4himpb
         HUDQUhf3YPKxqrS1x5VyqKNhXVMniZkOgDwnqnEv3F6M3r2Mu/E/P/rhiwcYabxb50BO
         vaCA==
X-Forwarded-Encrypted: i=1; AFNElJ+wXGYlgIa0/UN0Xv3QLJ4EoPhrQiX4jSRgNq0QtfxBBhOUpQ8D6uY7gWIqsu8KsUw52iyRK0cKh7ML+1hL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4aSKRyHByh/YBhg9TXlOINh08F0ybtBXtbImo7dk01hMSWSo8
	kSCgJDTginIvdvC+F5I3+dPP5pxqWqIptUnStMUMNwKkLsE6XWNp1ShGDKXXiHxTpzRDL12O0qm
	sijhuDC9iDR+k6IizE3kZKxhoe/G4Jrb+UzsWgs2V
X-Gm-Gg: Acq92OGWEV88k0JZQwCLr21w/rLBhVNWq65SMOtcXELVzpxTTQiFQCwp/2TFGvn2TF/
	Bmd9g9p7TAfwt+GPYZlRegq5OqehGupRiIKcN0UJa9eLHXGbGpvjUrJP4Rg3qRZQAW1a5iFwI+z
	iCqUiLGAsbQy6UiZ44g7nd2GK5M+nCfR9uB88iHJ97ezvw8J8kJPjUqLbK2TfT8V+bzowqAfqO3
	UV5CTS7htPDcpWA4mcg4zr0jOUPVluGzF7z0y4K1YGk6m77cOiobS6M7C3kp4ofbDXQbTK79ZxG
	2kRA+gDFYy8ZfmZcpQ==
X-Received: by 2002:a05:6a21:8ccc:b0:3b3:2703:11c with SMTP id
 adf61e73a8af0-3b427f517f8mr12921664637.37.1780331285033; Mon, 01 Jun 2026
 09:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531182045.171711-1-jkoolstra@xs4all.nl> <20260531182045.171711-6-jkoolstra@xs4all.nl>
 <178028260358.2923901.6788358930458921830@noble.neil.brown.name>
In-Reply-To: <178028260358.2923901.6788358930458921830@noble.neil.brown.name>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 12:27:53 -0400
X-Gm-Features: AVHnY4KEv6aJtI3iBUrB4HglIpuGYPQAhy-iIOr2F3ZJYmOy5UkiR3sfOv1CiDw
Message-ID: <CAHC9VhSN1j36Mo0tCOD2EQi0w5dXg_2sOcBw9vEqb1wRdsPh5g@mail.gmail.com>
Subject: Re: [RFC PATCH v6 5/9] vfs: lookup_open(): move audit_inode_child()
 and i_op->create check to before try_break_deleg()
To: NeilBrown <neil@brown.name>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Eric Paris <eparis@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Charles Mirabile <cmirabil@redhat.com>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 10:56=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrot=
e:
>
> [Paul and Eric - question for you towards the end)
>
> On Mon, 01 Jun 2026, Jori Koolstra wrote:
> > Calling audit_inode_child() and the i_op->create check in lookup_open()
> > take place after the try_break_deleg() call. This does not match the
> > order when doing a regular file create via mknod(2). There the call
> > order is:
> >
> >       filename_mknodat()
> >       vfs_create()
> >       may_create_dentry()
> >       audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE)
> >       i_op->create check
> >       try_break_deleg()
> >
> > In particular, audit_inode_child() is called regardless of whether
> > try_break_deleg() fails.
> >
> > Move move audit_inode_child() and the i_op->create check to before
> > try_break_deleg() in lookup_open().

Adding the audit mailing list to the CC line.  It's almost always
better to CC the list than ping folks directly as we now have the
exchange in the audit archive which makes it easier for audit folks to
find this in the future.

> I don't think this is sufficient.
> I think (and we should confirm we people who know about auditing) that
> the audit call should come before the permission check so that there is
> an audit record on failed attempts.  In that case the
> audit_inode_child() all needs to be much earlier.

As you likely already know, audit_inode_child() exists simply to
record information about the file/inode access, the audit record is
generated later (and can is dependent on other things/config).  For
that reason, yes, it's generally a good idea to call
audit_inode_child() as soon as we have the file/inode information.
Auditors want to know what the user/system attempted to do, even if
the operation failed; in some cases the log of the failed operations
are more useful than the successful ones.

> Alternately if we don't need an audit record for failed attempts - maybe
> the audit_inode(..., AUDIT_INODE_PARENT) is enough?  - then the
> audit_inde_child(..., AUDIT_TYPE_CHILD_CREATE) in may_create_dentry()
> should be after the permission check.
>
> I think you are trying to make the two paths consistent.  I think that
> is a good thing.  I don't think you have achieved it.
>
> I notice that fsnotify_create() ALSO calls audit_inode_child(...
> AUDIT_TYPE_CHILD_CREATE).  Surely we don't need both?
>
> Paul, Eric: can you comment on whether AUDIT_TYPE_CHILD_CREATE() should
> come before permission checks, after checks but before create, or after
> the create?  Or maybe several of those?
> We seem to do it both before in may_create_dentry(), and after in
> fsnotify_create().
>
>
> Thanks,
> NeilBrown
>
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 16dcf537db87..293592a4d011 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4526,17 +4526,18 @@ static struct dentry *lookup_open(struct nameid=
ata *nd, struct file *file,
> >
> >       /* Negative dentry, just create the file */
> >       if (!dentry->d_inode && (open_flag & O_CREAT)) {
> > -             /* but break the directory lease first! */
> > -             error =3D try_break_deleg(dir_inode, delegated_inode);
> > -             if (error)
> > -                     goto out_dput;
> > -
> >               audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CRE=
ATE);
> > +
> >               if (!dir_inode->i_op->create) {
> >                       error =3D -EACCES;
> >                       goto out_dput;
> >               }
> >
> > +             /* but break the directory lease first! */
> > +             error =3D try_break_deleg(dir_inode, delegated_inode);
> > +             if (error)
> > +                     goto out_dput;
> > +
> >               error =3D dir_inode->i_op->create(idmap, dir_inode, dentr=
y,
> >                                               mode, open_flag & O_EXCL)=
;
> >               if (error)
> > --
> > 2.54.0

--=20
paul-moore.com
