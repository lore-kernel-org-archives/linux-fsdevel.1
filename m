Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E7C37B402
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550518; cv=none; b=YpOqS1vCfFS8zPkW6py8eIIP2Ghy2a8xZmIRFpoHafu+ZxDrwCT1dkG/jUOTGBc5gsfMLLqxm0um+Ky/GCY8XHc6bbmNo7uVdbh1p/SwXOyLw1ALqlEzr6EMsMXjeiZNIU0wre8yIJkB8LUWg+XPvTaxVS3Iam+F86aJCo50PAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550518; c=relaxed/simple;
	bh=f0Elc4e1Jj0ktehHdLT9N6W5augEkrYfR2WpKyNS9jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNaSG+s4mXJM8qQlzrjpouh+uni8TP3BHfBw5SYl6cQtVaxiT1xDqsZH+dnZ6dstGF9/OTVNVRCpSwJqBtFWn73KqZGdNQXDT6gc87EWLA95AejNuctO2X9PZTkoV4YTjeK94Eapfx8bM81xy7qP6cIiiSHiZ4d6MBo1z6QaoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzSf0ZP1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzSf0ZP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786550515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z35eFswbmjF9DuGez+uF260Mt350Dyp0791JFJvEIkM=;
	b=YzSf0ZP1XQPIzGG28wfvLN0ay6Dbx6GcER54d2clzO+J1LYdToeDowWw0izkUVCW1Jd6uB
	BBPW72ImmgZSVx1DOAYPLw2HeK8LgHnV/VG4aHbnw7NvdlMhVy4vvT9j8BmcLsulpCyFPb
	JdVgWiknhE815rHMcerL9iwpKccmAbg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-ZbrUaPziMGGIaayA_nFnZQ-1; Wed,
 12 Aug 2026 12:01:22 -0400
X-MC-Unique: ZbrUaPziMGGIaayA_nFnZQ-1
X-Mimecast-MFC-AGG-ID: ZbrUaPziMGGIaayA_nFnZQ_1786550435
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BDB319560AB;
	Wed, 12 Aug 2026 16:00:35 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.81.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2358180034C;
	Wed, 12 Aug 2026 16:00:33 +0000 (UTC)
From: Steve Grubb <sgrubb@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, eparis@redhat.com, viro@zeniv.linux.org.uk,
 brauner@kernel.org, jack@suse.cz
Subject:
 Re: [PATCH] audit: add MOVE_MOUNT auxiliary record to log mount relocation
Date: Wed, 12 Aug 2026 12:00:31 -0400
Message-ID: <P3A-8ZIRRiqomtqZCupr6w@redhat.com>
Organization: Red Hat
In-Reply-To:
 <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
References:
 <20260713170035.4073532-1-rrobaina@redhat.com>
 <CAHC9VhTR-qaU-WFiuWZLfxhNisTtKXahLMHrH7-Ts5o09VMYcw@mail.gmail.com>
 <CAABTaaCTYuwXYcnY22YzN1G=Gs1=YKfNn8Efs2umOUWdnMQZwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wednesday, August 12, 2026 10:39:52=E2=80=AFAM Eastern Daylight Time Ric=
ardo=20
Robaina wrote:
> On Tue, Jul 28, 2026 at 6:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Jul 13, 2026 at 1:00=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com>=20
wrote:
> > > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > > syscall. The generic SYSCALL audit record logs the move_mount syscall
> > > but does not capture the flags argument, creating an audit gap for
> > > mount relocation operations.
> > >=20
> > > Add a MOVE_MOUNT auxiliary record that logs the flags argument passed
> > > to move_mount(2). Pathnames and file descriptors are captured through
> > > existing PATH records and SYSCALL record arguments.
> > >=20
> > >  ----
> > >  type=3DPATH : item=3D0 name=3D/mnt/test_src inode=3D1 dev=3D00:41 ...
> > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > >  ----
> > >  type=3DPATH : item=3D0 name=3D/mnt/test_dst inode=3D27460862 dev=3Df=
c:00 ...
> > >  type=3DSYSCALL : arch=3Dx86_64 syscall=3Dmove_mount ...
> > >  type=3DMOVE_MOUNT : fs_flags=3D0x4
> > >=20
> > > Link: https://github.com/linux-audit/audit-kernel/issues/152
> > > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > > ---
> > >=20
> > >  fs/namespace.c             |  3 +++
> > >  include/linux/audit.h      | 10 ++++++++++
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/auditsc.c           | 13 +++++++++++++
> > >  4 files changed, 27 insertions(+)
>=20
> Thanks for reviewing this patch, Paul!
>=20
> > This is because we only log the first four syscall parameters,
> > correct?  To put this another way, if we logged all six syscall
> > parameters this wouldn't be an issue, yes?
>=20
> Yes, that's correct.

I've been aiming to reply to this and lost the original...in the case of=20
mmap, yes. If we had just 5 of the passed values, we would not need a=20
supplemental record just to record the fd.

However, in many other syscalls, we only have pointers. Sometimes syscalls=
=20
are designed to pass a structure with config items where some are security=
=20
relevant. In those cases having all the args doesn't help and we still need=
=20
the supplemental record.

=2DSteve

> > I'm aware of the argument for only logging the first four parameters,
> > but I've always thought it was a rather foolish decision.  Perhaps now
> > is the time to spend to investigate adding those two missing
> > parameters to the SYSCALL record so we don't have to worry about hacky
> > workarounds like this (to be clear, I know this hacky workaround isn't
> > your fault, you are just trying to make the best of a kludgy thing
> > <g>).
>=20
> I completely agree that's the right thing to do, and I'm happy to hear
> that you'd be open to it.
>=20
> I did a quick check and there are 100+ syscalls (~18% of the total)
> with more than 4 arguments
>  --around 67 of which pass audit-relevant scalars (flags, sizes,
> modes) in the 5th or 6th position
> that are currently lost.
>=20
> I'll look into it. Please disregard this patch in the meantime.
>=20
> > --
> > paul-moore.com
>=20
> -Ricardo




