Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E73491D6
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730799; cv=pass; b=YKXDz0hqlN9eRXR7Oy8EL3W+uAKxJmC6H6LagCdRQZHOGx4tYsQrATwY0VIXOVdeoABMW9BjMO0/GR4ug8HhNiyGaqckYEkP+5q/Y06Yw6Rj9Rt9gj3KGwXRdXRhZOy3r7ebVnf7bP9YF8XSO31juVVcNtaDgXJMjyrq4VYmgpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730799; c=relaxed/simple;
	bh=1mR9CqXhEU4CC9cY2n6d7OE544yF5pG2nx/Q1tpIUJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b9f2vwKvE2d3RO9NzhN60U7urSL4wfK5vscDiCJ2B8kt2QeWsvYEHDtp+hLLlbSYkIiKMbIwbdsOr3BsIwB+jM5+YmzjnokAKZkyVUV2I7NVFssmunOi16Q7cHB/5t9iC4FpygdbL2QypWvaBPcwVeLEl56/BhRJW1ModRm7tQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvXC7QTq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXH4HuIw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvXC7QTq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXH4HuIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773730797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OLtsQ+ltehYsFOWqCMFIGDgpl9c0YfxP2xteobrAre8=;
	b=CvXC7QTqreUQ27G7E9Fzwyjyabv/pakD0Q4FQUZOCjBMesnoxPauURYWN0r6hdtPDy926o
	u0wVZstERDNABMIibQQRJ9Pk1mXxa7VIKcclGna1Q6AAxHZjPkd4lSUONRDOuXLUBMYZaf
	orPwVWqGnREIYj6YTTvAFDIA8c446BA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-5JZFjmvdMS6IiVjvGzxv5g-1; Tue, 17 Mar 2026 02:59:56 -0400
X-MC-Unique: 5JZFjmvdMS6IiVjvGzxv5g-1
X-Mimecast-MFC-AGG-ID: 5JZFjmvdMS6IiVjvGzxv5g_1773730795
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b938cb02038so57652966b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 23:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773730795; cv=none;
        d=google.com; s=arc-20240605;
        b=Yb/x/qV5cVsqEsw/FKyDrq2oAhjNg/z1PtP6h/01YPQqXFBLjMYhR4+emSyUxqFBtO
         +078XDKycr/mQhAoZPZYA8XnUUCppfTXhYoynTP+/0Evep3u0h9HCQRfdi63Dun13nsl
         Ffs/4cGXowzfIvbWoYmgIcDZHdwRUrng0zKHV5+FeAl1EFXZRE3gE9YsQi4Izsbr2Iq1
         2iz7gEV52ndBnrDthTFDATXZP7hKTiT+hVLKD6pHrqQHzQ3V8ZMuyqkipUFD5EkviK4b
         Ttphn9aI5yFr2+TgBEv8SI4Q1TQ4d+u4uuqtKORtM97cf7ilVjp8pPCPFeE5F/yDHFiy
         oo9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OLtsQ+ltehYsFOWqCMFIGDgpl9c0YfxP2xteobrAre8=;
        fh=8O/fyrb/ag7GR5NXaJOq2d+hc0sOFkhooU3opYJ/hTo=;
        b=AvADAyjQwKX4a3W2h3qZViK5yWPBZzGDmcfp0lLkaT6bCKv6IXeGoM/J6aU8mTroLn
         BL5ovDyNCOGxReTOvr9srT5x4fSLTY0NVUXWjxuokrLVozwDYbyOrkpWTIreQIvD4Atq
         gPnez3VMuJ4jXKaGjRcw78naDBPZ3EmMUgxGzKft+6MN9FAdTDWrlfRLHyfaM04qx2gA
         Zp6wK4U3d3m1zZh8s2n60uKDPDZmYDmrQU/uq2zQeXUq1AI2yjMLDZxaUzhJcOKfmVz6
         K1Qjl/RjGu3uc6KHWb24dR7miQ+tq2HNoGRRdftvbfhfRBH3Ip/dxfA8cBJjh8aFktsF
         VuAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773730795; x=1774335595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLtsQ+ltehYsFOWqCMFIGDgpl9c0YfxP2xteobrAre8=;
        b=UXH4HuIw0kODKQKERg2ZbUOOYIXNnm39dXOIGvFb33ksR7kfKrWIth+Pj105RqPhkz
         KyaLD6da3KMwr9qAf+UCSLTeE3Fgjp29iaT9Upd3xMASQywVe2hNnA/Y0lzdgsMlG1qH
         ed6AnZr/JlgrN//cD/DWDOwR9JUyexqsB6SsHxxU3LmXls17Bu2fflWHkDUvkvzGWNv5
         YcdlOaawUgHJaugFolQjQUSaxawZ2OX8c9ft1NKNdRNndHE75GmPxhHiLGaYTeHpkwBH
         PPSO/u5CRHNp8K8+IXwZJglGgjmGV4tEK4EKCDqdlzME+psFOd3Bi+ev1FINJW/J9ftj
         69oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730795; x=1774335595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OLtsQ+ltehYsFOWqCMFIGDgpl9c0YfxP2xteobrAre8=;
        b=DaVuOpsph0jqPdRrrY+idAtYHYKOV1jESWOT78NENLz7+5W2Za2XODGx/um4GcWEIh
         +gkLDEw6L0K45k/vQOVIZS0z1kPSp0L3SWU6d2C4oMYoUT/OPu4sLbTULJID4HbSOb3L
         GMcgf7wtjTlJiM5SX3Y3GqH6S4FyDEWOYfdMlj3FvhCY0046mYIhu0wRrgXs1g+UmE8P
         8SAA2L6cQ6O5CyHaUxtzeWxoY6IngnLSppnQcpN/ks2ITMzvlUbgnE3RWgi4LeAGG2Qn
         60B/K4U9MISqojtZnVa6fiZsg/hgi9He9FvkmDmy9JjGLsMDpJ7srV6E1Sq5GwXr9I4t
         8TTg==
X-Forwarded-Encrypted: i=1; AJvYcCWeVKZvVSTanIi+oubg0bZCv+pOURX6k9cv07YSGG1T862eT3grRpjphJYNYbguJ37mPoVhEG01qBMENMeC@vger.kernel.org
X-Gm-Message-State: AOJu0YzXrJtI+i2EYDS4iOERJEOiKf8cJV34fRn/7k1tndAdMo4fHWJ4
	kIaBYlPc4ojjs7MrjI8bDdGnXVQMHUwt+YEqcKzaTmFgZqaZAIvqg+mv9WU60d598Q4IDGaZjmX
	z7+o3kCkfVABk67Rj0AtLJWq+8MeJV4vZLHcf0aCdV/tioDLZX84ixXOKQbD7ATCR3BDSZh4lmI
	Qk++0Dy/nVqhYswQ9JruUb/jNpRzjn8zeo0cR1iItyEQ==
X-Gm-Gg: ATEYQzxh7qF73BOqLrw7m6xduLfCQbYEp07khqcFYmmtNCrAMcesY0ZPhwA/Zf3507C
	Z1SbiHtMvGSjzyck6iaUu4OANkffXRgcP1o0u6RqwYBVHHHO8+XdxTBT1652oT/pAx44tTjaThc
	Ac74evUwRUS70deZ8w1gLsExtq95a4yKFWP5pDU5ucheEAu757NuE6XfPxPBfKNMI0iFBe8qYje
	ewZVCxe
X-Received: by 2002:a17:907:948d:b0:b97:b03d:d262 with SMTP id a640c23a62f3a-b97d6d2f926mr160752566b.19.1773730794677;
        Mon, 16 Mar 2026 23:59:54 -0700 (PDT)
X-Received: by 2002:a17:907:948d:b0:b97:b03d:d262 with SMTP id
 a640c23a62f3a-b97d6d2f926mr160750366b.19.1773730794141; Mon, 16 Mar 2026
 23:59:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312090810.1145908-1-ravising@redhat.com> <F061AB76-E500-4F78-A6E3-E71A32B04077@dilger.ca>
In-Reply-To: <F061AB76-E500-4F78-A6E3-E71A32B04077@dilger.ca>
From: Ravi Singh <ravising@redhat.com>
Date: Tue, 17 Mar 2026 12:29:41 +0530
X-Gm-Features: AaiRm52D_vdOj5buLxfVNtvwEPZqxIHth_yudypzMHQN3FKNJkJbJVq4ycCg-sI
Message-ID: <CAF-d4Ov2F1FzANH3_MZ5E86u-6ygVh4ZaVcJKyiXe5Tz=5W5Pg@mail.gmail.com>
Subject: Re: [RFC PATCH] quota: allow unprivileged users to query ID 0 default limits
To: Andreas Dilger <adilger@dilger.ca>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.com, 
	cem@kernel.org, dgc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 3:15=E2=80=AFPM Andreas Dilger <adilger@dilger.ca> =
wrote:
>
> On Mar 12, 2026, at 03:08, Ravi Singh <ravising@redhat.com> wrote:
> >
> > Default quota limits are stored on the ID 0 dquot record and are
> > applied by the kernel to all users who have no explicit limits set.
> > However, check_quotactl_permission() only allows unprivileged users to
> > query their own user or group quota via Q_GETQUOTA/Q_XGETQUOTA.  This
> > means unprivileged users cannot discover what default limits apply to
> > them.
> >
> > Allow any user to query ID 0's quota via Q_GETQUOTA/Q_XGETQUOTA.
> > Note that this does expose ID 0's usage counters and timers in
> > addition to the default limits. This enables userspace tools like
> > xfs_quota to fetch default limits and display them to unprivileged
> > users.
>
> Showing the root user's quota usage may be confusing for the regular
> user.  It seems better to filter out the quota usage in this case and
> only expose the limits?

Agreed, exposing root's usage data is unnecessary.

> Alternately, should users without an explicit quota limit have the
> default limits merged into their returned values, rather than them
> needing to query id=3D0 separately for the limits?

Yes, this is the better approach. I've reworked the patch to handle
this in xfs_qm_scall_getquota(), when xfs_qm_dqget() returns
-ENOENT for a non-zero ID, we now return zero usage with default
limits from xfs_get_defquota() instead of propagating the error.

This avoids any VFS permission changes and keeps root's usage data
private. The user queries their own ID through the existing
permission check, and the kernel returns the effective limits directly.

v2 posted as a separate thread.

Thanks,
Ravi

> Cheers, Andreas
> >
> > This change does not affect Q_XGETNEXTQUOTA, Q_SETQLIM, or any other
> > quota command -- those still require CAP_SYS_ADMIN.
> >
> > Signed-off-by: Ravi Singh <ravising@redhat.com>
> > ---
> > fs/quota/quota.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> > diff --git a/fs/quota/quota.c b/fs/quota/quota.c
> > index 33bacd707..8b21f3c1b 100644
> > --- a/fs/quota/quota.c
> > +++ b/fs/quota/quota.c
> > @@ -42,6 +42,9 @@ static int check_quotactl_permission(struct super_blo=
ck *sb, int type, int cmd,
> > if ((type =3D=3D USRQUOTA && uid_eq(current_euid(), make_kuid(current_u=
ser_ns(), id))) ||
> >    (type =3D=3D GRPQUOTA && in_egroup_p(make_kgid(current_user_ns(), id=
))))
> > break;
> > + /* Allow unprivileged read of ID 0 (default quota limits) */
> > + if (id =3D=3D 0)
> > + break;
> > fallthrough;
> > default:
> > if (!capable(CAP_SYS_ADMIN))
> > --
> > 2.49.0
> >
> >
>

