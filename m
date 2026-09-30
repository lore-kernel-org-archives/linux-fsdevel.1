Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54BD420480
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798007; cv=pass; b=jHrb9nWoxFv0IsCQMpulvbWxgYONZCDMd/0hw/0J7SRC9R93/G7r/WYI7uGcwpiHqCM/kuor5FW17UdYCbhQzYa4wzAJEwKchzH4Vs29JJ7xLp4MGzdi52Odtjwta3DoXykZaLZpcNj5+bzwzdWq4x5LbxbKMXNld+fNV6Qe/dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798007; c=relaxed/simple;
	bh=jEjOJJgnQ8TLl1NXrjU0PSvQC15w6bG/fD+IpOaPESg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0zAN4CnGJ2UgCWR1IxOi5bIE5dfjo7tuxXtJoUoMtv3v9Fg94c9lAeLYTiqFU+SiyFPiziagA2aijWYpWNdiPh6tD1E9EQ/dl9O7RSCfhWLvqvBcIJ+88Wz9aUstPgNrdmSGbAbYHyIIVDKRxvPnl4I7pDFIYD4aj76f1YcUgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9XlL1tc; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9XlL1tc"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5337c7b9937so63601cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 12:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790798004; cv=none;
        d=google.com; s=arc-20260327;
        b=mXgDCbSIMZJElD81HcCnlBUNlpqfKcdU2vUIbhLvldTNKJU2tPJp/Gno/qYr6MSjDp
         2a7xqrH4rrZten/vMipRJoPPjsza13Mbss5v6xXoqgn1VphAP2TYRoOMKZDr7xHqS32Y
         J3Ck2fpXrblxqQ/vov9w//eiCS4E/2ZyEAi1jcSwp5e9XxlezKyIcB7cXX6J7ufZHfh1
         VZ24tBxOMfXxs757IJE8RCICkoHS0xZYN1/bYhPlweM7z3Jkbg/gf8gQt7X3S8egJXyz
         iLbIpMmlCy+cLQFCUhTc79SUtdoImsVRQAae7wKEhH1PaIQAo0jbGvStM5Ak6E4ml/qB
         qYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0eIq1qnomZnnsUKsF5xFhZ0yFWtEcE3Qo/pF8vzCbBI=;
        fh=+plY0we3ASG0vKBcb8cPkSbVjHPr64DLNDvsRC8N4JM=;
        b=X2iNlybevYsPtY0qHTtCj0HVAu88zuqypx7RWLp/IiWYP3vyymzelvG/hnctm3EGi/
         FiMViaAKmYR8yUZrHdJmK4yMJ2Ouk2NXgJ0migAyV6Zzc49Z1PRbuDt4JdUCYeJMWNyw
         iByRLktgtRPeBj2uzX+aDQmXicQ/6zP7zlFmdQhnv56zlvx2LEwdIrRODTAqY6PA69lQ
         tWLo9VQ3oPV+ac2vT08WnhFqMyv0Ifc7mfYOVH6/6FCY1ttaNfGbKa7ije1YeOXUJ50v
         2X3SS20H2pGlLM4W3dJyAyG/zgtlOG+afUooDN9RPqHDplRiLUsyJjtLfbn/nQY/sVSh
         GwMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798004; x=1791402804; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0eIq1qnomZnnsUKsF5xFhZ0yFWtEcE3Qo/pF8vzCbBI=;
        b=K9XlL1tcG8DKGkWNRbdLWBNuxxr+uWaFO0+496dnJ6qoNsZN1uwmYn1kOv4k+hTB5Z
         SlY9v/+LoqJW2+r17VCttG98omyn6awZQLqhyFIt5YgKHXDkM3/jVPxAXChh4VqbD9d/
         7hX8cFCFRaooxoEGBjpkZ6VpZnabul7viaXH+Vny1gU7yZvfkzPiDq3cILN9BbhCbalC
         aAeLZ/FGLTCqfvu0LNWlZhlCFJ6hEcxmOCiR1GqRrbTdYdgsxx+zDqi83+UmyeAsej6Q
         Bxh7BWP9svQiPqKjb4USBGNMn2cwyIR0LKVM2h/47S6sZ4/0TEozOT58vEIbBncFcxst
         R58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798004; x=1791402804;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0eIq1qnomZnnsUKsF5xFhZ0yFWtEcE3Qo/pF8vzCbBI=;
        b=y4FHDO+deCDeZkWlTJQ48Wnj7X/WjB7loH0TOFRLPZaeiECSiYQZOiZ5hIis9MK9lO
         I8ny7eJVrGyshYlsfzaHqPIDK0DLuN07vAB578wfShNXz4OsbigXKbKDa/2Atcvc3T17
         CcsHMxSaWX59As1orUmc4yYnHreIqfWivCb1uZCgdQSyHlDvjCIdHLLjKzQTrZ7FDdSa
         KDhhE22wKipqxP2mvYm69zBDlrMSoN6bjpdThwRhLHhX9hJv/UtkbsSlqQIj9CBEm35G
         cG0JM2GbVmuBIZKf465y96vHyu2bZRibvk0PqRBEgZE0FKLxO2F/ZhVH8qKymwDrFhea
         FXdA==
X-Forwarded-Encrypted: i=1; AKwUvByHOF8L16WigxENpHZxvWuxTNYKE8WAwOyxS/F2GNV1scBrWAJRtGEt9kAGPks2jUzeVljg6pgg1qTucPbX@vger.kernel.org
X-Gm-Message-State: AFuF++nwNTlMuUNYNnf5cxUexKsKEX8CealSrWGkC7ork3s7LqRyx40Q
	oR3tn81xXD7LUjJgOhHO8nf4F7qOh6z8i9thPjO5dAMJxoKFVKo09Q8DBI+pOUxpzClhBH3Fo0N
	Vn4bcHzOR99z0/vxcopOktAOyddJ/UyRKSWRtrXkE
X-Gm-Gg: AYBFou3GVOqYnYKxsyPX1m3HB5i8HXBn/KUx8ZnVXCWQb8HBbM1pz+2uUIMUejPd0f+
	vlZiv2RFsU4i//7xJABpzMLtS4gpGOwg5aUcIsh8e9FHUIGqIMrK8tuPEvsddMP/324wduseC60
	oBj5P3JEA45QUTsWR7La6/VQUL+lFjHK1hve8ps04xbcqmY+/zJ/PkrrxhlAqSTMDP0mznr5x5L
	Cu6u8O9bG+X8shOF171vQjdVdUn/+clcGxG3FAuAe8Pwwl3c9n0lTLwY8PoPecBZx5sIUiiVtWy
	753DoSzeRgSU6HZTqhAJGVY0oyqDNHwFoV6YZ+7il8qZv4MTvwXg+A==
X-Received: by 2002:a05:622a:610:b0:531:6de:6028 with SMTP id
 d75a77b69052e-53386815ca8mr222861cf.13.1790798002634; Wed, 30 Sep 2026
 12:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926-nsfs-prune-rfc-v2-0-53509260e4e7@gmail.com>
 <20260926-nsfs-prune-rfc-v2-1-53509260e4e7@gmail.com> <CANaxB-yj2QV183nk3UC-2PD6qh6hh-_iLRuryTdUsebd+RqxdA@mail.gmail.com>
 <CAGmPdrwOnNRHJqk1mZVB+tFCnJBr3ZTaSZqbiGu54kXPkMtRoQ@mail.gmail.com>
In-Reply-To: <CAGmPdrwOnNRHJqk1mZVB+tFCnJBr3ZTaSZqbiGu54kXPkMtRoQ@mail.gmail.com>
From: Andrei Vagin <avagin@google.com>
Date: Wed, 30 Sep 2026 12:53:11 -0700
X-Gm-Features: AclHuK9MG__TVWG37WqPhPUQdYK5bsOXfsAt-eoCDlcKjWQdQUjwS0-jBycCRa0
Message-ID: <CAEWA0a5OjmjE-CVhiUcLXqrpE4xSd3-L5OszDd41DFDqUgcp1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mount: add OPEN_TREE_DROP_MNTNS_MOUNTS
To: Kirill Kolyshkin <kolyshkin@gmail.com>
Cc: Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, "Eric W . Biederman" <ebiederm@xmission.com>, 
	David Howells <dhowells@redhat.com>, Amir Goldstein <amir73il@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Giuseppe Scrivano <giuseppe@scrivano.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	containers@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 12:49=E2=80=AFPM Kirill Kolyshkin <kolyshkin@gmail.=
com> wrote:
>
> On Wed, Sep 30, 2026 at 10:22=E2=80=AFAM Andrei Vagin <avagin@gmail.com> =
wrote:
> >
> > On Sat, Sep 26, 2026 at 12:01=E2=80=AFAM Kir Kolyshkin <kolyshkin@gmail=
.com> wrote:
> > >
> > > A recursive open_tree(OPEN_TREE_CLONE) copies the nsfs mounts of any
> > > mount namespaces pinned below the source.  When the clone is attached
> > > inside a mount namespace younger than a pinned one, move_mount(2) fai=
ls
> > > with ELOOP from check_for_nsfs_mounts(), per the rule from commit
> > > 8823c079ba71 ("vfs: Add setns support for the mount namespace") that
> > > prevents mount namespace reference loops.
> > >
> > > This breaks container runtimes that use OPEN_TREE_NAMESPACE, such as
> > > crun [1].  The new namespace is younger than everything else, so bind
> > > mounting e.g. the host root fails on any host that pins a mount names=
pace
> > > (snapd does, under /run/snapd/ns).  By the time it fails, setns() has
> > > already run and userspace cannot recover: the host tree is out of rea=
ch,
> > > and the offending mounts cannot be unmounted from the detached copy.
> > >
> > > copy_mnt_ns() and create_new_namespace() already leave these mounts
> > > behind; only get_detached_copy() copies them.  Add an open_tree() fla=
g to
> > > drop them from the clone, as suggested by Aleksa [2].  Locked nsfs mo=
unts
> > > are dropped the same way copy_mnt_ns() does it, so nothing new is exp=
osed.
> > >
> > > Keep it opt-in: open_tree(OPEN_TREE_CLONE) plus move_mount(2) is how
> > > mount --rbind works through a file descriptor, and in the caller's ow=
n
> > > or an older namespace such mounts remain usable.
> > >
> > > The flag requires OPEN_TREE_CLONE or OPEN_TREE_NAMESPACE.  With the
> > > latter it is a no-op, so a runtime can pass it unconditionally.
> > >
> > > Link: https://github.com/containers/crun/issues/2262 [1]
> > > Link: https://lore.kernel.org/all/2026-01-07-oldest-grim-captions-spi=
lls-ywC2O3@cyphar.com/ [2]
> > > Assisted-by: Claude:claude-opus-5
> > > Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
> > > ---
> > >  fs/namespace.c             | 14 ++++++++++++--
> > >  include/uapi/linux/mount.h |  1 +
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index ae5dc64f8b45..a95173996a8f 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -3062,7 +3062,8 @@ static struct mnt_namespace *get_detached_copy(=
const struct path *path, unsigned
> > >                         ns->seq_origin =3D src_mnt_ns->ns.ns_id;
> > >         }
> > >
> > > -       mnt =3D __do_loopback(path, (flags & AT_RECURSIVE), CL_COPY_M=
NT_NS_FILE);
> > > +       mnt =3D __do_loopback(path, (flags & AT_RECURSIVE),
> > > +                           (flags & OPEN_TREE_DROP_MNTNS_MOUNTS) ? 0=
 : CL_COPY_MNT_NS_FILE);
> >
> > Overall, the patch looks good. One small thing is that open_tree() with
> > OPEN_TREE_DROP_MNTNS_MOUNTS doesn't fail on a mntns file if AT_RECURSIV=
E
> > isn't set:
> >
> >   open_tree(AT_FDCWD, "/proc/self/ns/mnt",
> >             OPEN_TREE_CLONE|OPEN_TREE_CLOEXEC|0x4) =3D 3
> >
> > With AT_RECURSIVE, __do_loopback() calls copy_tree(), which checks
> > !(flag & CL_COPY_MNT_NS_FILE) && is_mnt_ns_file(dentry) and returns
> > -EINVAL, but without AT_RECURSIVE it calls clone_mnt(), which doesn't
> > have such check.
>
> Thanks! A call with arguments like this does not make any sense*, as you'=
re
> asking to clone a pinned mount namespace while skipping it.
>
> * except maybe to check if the path is indeed a pinned mount namespace,
> but there are cheaper ways to do it.
>
> That said, we can either keep things as is, or
> 1. require AT_RECURSIVE with OPEN_TREE_DROP_MNTNS_MOUNTS
>     when checking valid flags; probably the easiest thing to do;
> 2. add a check to a non-recursive path in __do_loopback, something like:
>     if (!(copy_flags & CL_COPY_MNT_NS_FILE) && is_mnt_ns_file(old_path->d=
entry))
>        return ERR_PTR(-EINVAL);
>
> I'm going to implement either one in the next iteration (v3); do you have
> a preference?

I prefer the first option.

Thanks,
Andrei
