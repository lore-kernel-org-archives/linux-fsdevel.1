Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4912A372075
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786565988; cv=none; b=ah+p5zCBQ0f+pn40KDX/vtv01AFzr6edewcNsj1yZrUuYBppBu3ifGE8ew6t8v/95P/8FJyy86hYfs9iPkFLYzKkzacpZZHj3qgsCzIySIq6utWh6URKkR6/h9StutIlxBRxorkuqUC1NO+1Iwb7I2NaLj1Efi3CoHmHxXmyGBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786565988; c=relaxed/simple;
	bh=OaFEt6PC9bTVtS9wdoto3znMwad8uVlpfNrX0MAuHWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GeVu0uUuTs7GUGo0kOVmqIKRM6NlSTOsOYa1sZslsL8qO7fwPkgDPJdJkWYe9WrNhM5P1jjd7rcWgYnviIHGYl2GqtbT2ejDjwmW35ulH2xBRpYqDIB1TWiUUINnWio4cCdZtQKvBKAfzkb+ht8i6qVNHfV8xGKSrw+9BTWsqFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aec9h8OT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aec9h8OT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786565986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7bhnHnsHZYp6g8JKq1WBkXIo5fDHg0kqiO/tyY3/iuY=;
	b=Aec9h8OT2EZx1UbwFhv9gm11Tfey4hJdkC7pRxCxMy8NU0FBN2hbjGBw15AHO+PdPSNvmG
	EKFsKdzpS6PQ/uVqj+CRkKQTFTeQbBaVu0GXwhJZDC1tTUqxb/f4Addcp1UQXUpqeMeapr
	If3EjRdYcrMpcnUWmD/B2lC5nejfc5o=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-WRlG_rzrOPC_0uLWTUp4Qg-1; Wed,
 12 Aug 2026 16:19:42 -0400
X-MC-Unique: WRlG_rzrOPC_0uLWTUp4Qg-1
X-Mimecast-MFC-AGG-ID: WRlG_rzrOPC_0uLWTUp4Qg_1786565980
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 576641955D42;
	Wed, 12 Aug 2026 20:19:37 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.81.16])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92FE6195DF9D;
	Wed, 12 Aug 2026 20:19:35 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Ricardo Robaina <rrobaina@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz
Subject:
 Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
Date: Wed, 12 Aug 2026 16:19:34 -0400
Message-ID: <gKPBCNAOSa-tEF8t5Pm2xQ@redhat.com>
Organization: Red Hat
In-Reply-To:
 <CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=gqy7dX4Ah11RVhdyCBUQ@mail.gmail.com>
References:
 <20260713170035.4073532-1-rrobaina@redhat.com>
 <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
 <CAHC9VhSjEt_-Bsra4AEqWv+Daw5Ff=gqy7dX4Ah11RVhdyCBUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wednesday, August 12, 2026 12:03:17=E2=80=AFPM Eastern Daylight Time Pau=
l Moore=20
wrote:
> On Wed, Aug 12, 2026 at 10:40=E2=80=AFAM Ricardo Robaina <rrobaina@redhat=
=2Ecom>=20
wrote:
> > On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@red=
hat.com>=20
wrote:
> > > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy
> > > > mount(2)
> > > > syscall. The generic SYSCALL audit record logs the move_mount sysca=
ll
> > > > but does not capture the flags argument, creating an audit gap for
> > > > mount relocation operations.
> > > >=20
> > > > Add a MOVE_MOUNT auxiliary record that logs the flags argument pass=
ed
> > > > to move_mount(2). Pathnames and file descriptors are captured throu=
gh
> > > > existing PATH records and SYSCALL record arguments.
> > > >=20
> > > >  ----
> > > >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 =
=2E..
> > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > >  ----
> > > >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=
=3Dfc:00 ...
> > > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > > >=20
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > > ---
> > > >=20
> > > >  fs/namespace.c             |  3 +++
> > > >  include/linux/audit.h      | 10 ++++++++++
> > > >  include/uapi/linux/audit.h |  1 +
> > > >  kernel/auditsc.c           | 13 +++++++++++++
> > > >  4 files changed, 27 insertions(+)
> >=20
> > Thanks for reviewing this patch, Paul!
> >=20
> > > This is because we only log the first four syscall parameters,
> > > correct?  To put this another way, if we logged all six syscall
> > > parameters this wouldn't be an issue, yes?
> >=20
> > Yes, that's correct.
> >=20
> > > I'm aware of the argument for only logging the first four parameters,
> > > but I've always thought it was a rather foolish decision.  Perhaps now
> > > is the time to spend to investigate adding those two missing
> > > parameters to the SYSCALL record so we don't have to worry about hacky
> > > workarounds like this (to be clear, I know this hacky workaround isn't
> > > your fault, you are just trying to make the best of a kludgy thing
> > > <g>).
> >=20
> > I completely agree that's the right thing to do, and I'm happy to hear
> > that you'd be open to it.
> >=20
> > I did a quick check and there are 100+ syscalls (~18% of the total)
> > with more than 4 arguments
> >=20
> >  --around 67 of which pass audit-relevant scalars (flags, sizes,
> >=20
> > modes) in the 5th or 6th position
> > that are currently lost.
> >=20
> > I'll look into it. Please disregard this patch in the meantime.
>=20
> Thanks Ricardo, I think this would be a great improvement!
>=20
> I'm particularly curious to see what old/existing userspace tooling
> will do if we add the last two syscall arguments immediately after the
> first four.

It would ignore them. During search, it grabs a0 and a1, then skips to ppid=
=2E=20
In the output phase, it should also ignore them since there's no code to=20
interpret them.

> If we have to we can add them to the end, but if it
> doesn't break anything it would be preferable to add them inline with
> the other parameters.

I'd also prefer inline. That's the most natural view.

=2DSteve


