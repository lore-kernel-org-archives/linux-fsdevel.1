Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85388371885
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371943; cv=pass; b=l3FIsdKKXGTRByfzwCID3jlL5X8Ffgqm2bDqsdlgXuz0eZr9CG7SJnR8pg6EW0tlhk+qIqgwmyK/jOxw2Y5ME8ca+0hGGyI3eNL0XU03GgAXMP2UDeeu1lFBlcTtrJUGmAbl/cxKFtRXe+aO/iD40dgUiFxo4+atMWwxYzVsv54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371943; c=relaxed/simple;
	bh=ViearuiPilsxj0qUlheDJkzq6zI8wkSwoBrSp5i6Bo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ThWanRgqu7UUqPuWjWL+fXDpn227ICdzuabqJafqGugoz2KX4H/wY6CHLbnxnOxMIx0z4SkaGCYgt0pY3cImmPCJ0H9ychJz3LiZnmk+dnhQciQPaLneqRhQEQHPRT17DJbocx6EQ1eTLJjoWMpeIQlSzgcVKeitmlTM6srJF7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a05+SVMN; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a05+SVMN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1677c91969so143442766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:59:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788371939; cv=none;
        d=google.com; s=arc-20260327;
        b=sSaKTvB46v2Cbkf4E8HpOhT/7kRYS7jTlBV7kLA/yZiEOSpI0+D0owMBXvdQHu+QfT
         IuJfwdlr9818va+1FTTb2LaYvAFPDO3sjccJD0kvkpsNN+ZMm1QD+qT1fl4BLOx/GpBN
         4pok568AhgKVk5EGXuGQWSLpXasWw0QbmN3HV7lm4Wc2SbzWG9DwrnZ7YGfh6aG0sqJO
         xJh1wm8M0UmngOkk3lBYQvyZ+A3GeO/lpz2/TsmxCo1mi/pE/rlUOy5E7jHbF0uDM9on
         a1oO8twpHV8h8SrE+0jVlo8V+7baLNUKqC3UM7ian72gkB7poj+9nvCIAOnHL0V1sGaJ
         Amow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U50dCYd9SB0vI2sTlreE2j0FP/8+9aIS570hJ6Rb+1Y=;
        fh=BG4ul+T0U7wGyyV70fzQcBgGHoMSvbH1lRqg4h6rCDY=;
        b=VN99N3KzGuMcFhb4uUCa9MmgoRDnzIN6O3sG/Xyu3vdN8+AJXpJLmIyYmYYbT21/w9
         fLoWdyd/MTkW3BZplV44TEWHdkvRCcjysPnDUKGjwCrdFbli8zMD9tKkjdDhcaef4/Kp
         lLisQPAkDDK43BUlA5QcJTCz6zk+8RdypKVvBSIwtrJ2mIdSsJs++dYq2DiA+F3wsgNJ
         lr8y9odyzq+Cr1Z1n1Gj5zxmV1q80+R5G5v4vgmPL9Nb0oYDIH+GVW1F75b9UBneHLDh
         c55rmy/PfXWchoXoLORUEuKYYfOGhu4rtjNDbXmhuHMWhURS50eFpXlRG+ljgc1pLMpJ
         TJLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788371939; x=1788976739; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U50dCYd9SB0vI2sTlreE2j0FP/8+9aIS570hJ6Rb+1Y=;
        b=a05+SVMN0U1HEcNSj6rvLgTX7ysQ69Uj1dbL5EL1E3sT6AGRxL9XtuL5md8vDrGCDu
         AmcmxdtuemXOkPcyAT0l/j6w2GISVh84fg6byO2xhlIdD0xaCJXPBla8I7i8fOhu9KHW
         MtS89IgvP1IuhKQaBEvjjPJs/uljvZG5XE0FHvpaE3+yqoQHu+t757SuV3eeEohk0b07
         q2t+w4wZzZYMwzGLiQ4loZcBYSqycUuALB9NyGIg8nWfMdmbofQH5IlEZqzs4fzSFMjB
         CNRLq6HAx2vixdw6nA/vRD3GKxJuZx4RjZ9ji0ZIkOu8BVzHeTpEvAnz0+Du/b3rOmiN
         UecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371939; x=1788976739;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U50dCYd9SB0vI2sTlreE2j0FP/8+9aIS570hJ6Rb+1Y=;
        b=pqbBUhdWRqJHjSC/Vmuzdlu5RyDdTCxzzi9d3wZl2+jTk8eyeYq2Ows/lA4ZaEXqko
         ugi52ba087+AEtIXQ4iavvRifzvlIXo0OjvckiU1I3kMvrn6KhmGdxm7P6cqhgcpkPQg
         EhgpHjDgIRcc/5Ua3Dnul0VS6fJkf2SfWMwpJFDYxXVnRX2fpXT5yiF+072CnXoFks2K
         b/81/v5I0RBeaZLqJl+E0Vxx3jvp24Te6M+O+3Y1Y9vyZUAXVOtU/6I+6V4F0BuCH9YV
         Onul9foeKmJvhjx4sKDNjlnBihMXDB8JYO2QA1PFIOp35ySV0CaqNVY+g5qYBwHkLu//
         P8qA==
X-Forwarded-Encrypted: i=1; AKwUvBxabO/YEWwCSmmc/lo9qNEXBCFGwil7TNWcuR5dAwvsSZpAJhj8rjTnsCYkmZl7j5+iJ9Iu8bcyVE185I1T@vger.kernel.org
X-Gm-Message-State: AFuF++mEaJbL6QGosLv0+GiL7rpf9C0squZAJkT+aavlfrpqHiqfhElj
	h3imC+poxKQkhFhFImmV07jBCW2FoTokN/WI/cR6rOd8cW+mKXF1KMeCSxgT9K1rDRjzITSHSSe
	QH4ZRx3vY0BI78xONVCsamAG+Gh5dcDw=
X-Gm-Gg: AYBFou3uqTl4NY+smS58MQoJYpV+l6Uki5yW4ezQUbGkeifpd874F+tymNs2szGnW1R
	bf6Slkz1/C2MgHnUH17O/x33AuxQHmWXi8tNvOAhc0eTqKiAbdfpJqhscW8NMutKSUg+VRmt2gX
	4JrALK88v9WW5PhOiBHPTZdiKllwqo09rKKFLEdOmzTdwo6j4ANyUYOwwCym317XPMoSTWuVFN6
	Mf1uWGU+pfGJEIIZ85+TS3BrXJI+A0iadMbQLb+4GGqtDgnizhaqbpUQuOYjjkuFROGCRpb6yv3
	IwVc6Wuuq6we0e1GTHElXk4SwiMUL2STWaUP3b8LEgM9iXIMQ77vd1ngmLVkeyiIXzIgs6JRnNB
	g
X-Received: by 2002:a17:907:c408:b0:c24:6390:decf with SMTP id
 a640c23a62f3a-c25d54bb587mr460332266b.16.1788371939542; Wed, 02 Sep 2026
 10:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
 <20260902-work-coredump-unlock-self-v2-2-1bece368cbb1@kernel.org> <CAGudoHGQ=eTQjzY1cV6ZUa+CmTrTF0=au6r+_98CqEGnY+ZfxA@mail.gmail.com>
In-Reply-To: <CAGudoHGQ=eTQjzY1cV6ZUa+CmTrTF0=au6r+_98CqEGnY+ZfxA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 2 Sep 2026 19:58:46 +0200
X-Gm-Features: AcwNN1WtvBQwpmvwsUGjzkv3j9fFF4NUZ3cVo3MWWlRoe8gK1B9R88BRzMh9ed4
Message-ID: <CAGudoHFEjeLK_neejhQTKTS=YxN8ew5p=8jWW-WYK8XC5tw_ZQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 02/16] fs: add fput_close_list() and fput_list()
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 7:41=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Wed, Sep 2, 2026 at 5:58=E2=80=AFPM Christian Brauner <brauner@kernel.=
org> wrote:
> >
> > Add helpers for paths that close many files in one go. They collect the
> > last references during the walk and drain them right after
> >
> > fput_list() runs the final __fput() for everything on the list.
> > delayed_fput() shares that loop.
>
> nit: I think fput_list is a highly misleading name here, suggesting it
> grabs a list of files to unref.
>
> I don't have a proposal for a name I'm happy with and I'm not going to
> argue about this, but to throw some ideas: filp_close_list,
> fput_finish_list or similar

The more I'm looking at this, the more I'm convinced I'm whatever name
it should follow the convention of ending with _sync.

>
> Regardless of what happens with the above:
> Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>
>
> >
> > We'll use that in the next patches.
> >
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  fs/file_table.c | 25 +++++++++++++++++++++----
> >  fs/internal.h   |  3 +++
> >  fs/open.c       |  2 +-
> >  3 files changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index c68b8c0a4097..617912ca4e0a 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -528,11 +528,10 @@ static void __fput(struct file *file)
> >  static LLIST_HEAD(delayed_fput_list);
> >  static void delayed_fput(struct work_struct *unused)
> >  {
> > -       struct llist_node *node =3D llist_del_all(&delayed_fput_list);
> > -       struct file *f, *t;
> > +       /* Detach the shared list once, then drain it like a private on=
e. */
> > +       struct llist_head list =3D { .first =3D llist_del_all(&delayed_=
fput_list) };
> >
> > -       llist_for_each_entry_safe(f, t, node, f_llist)
> > -               __fput(f);
> > +       fput_list(&list);
> >  }
> >
> >  static void ____fput(struct callback_head *work)
> > @@ -629,6 +628,24 @@ void fput_close(struct file *file)
> >                 __fput_deferred(file);
> >  }
> >
> > +/* Like fput_close(), but the last reference goes on the caller's @lis=
t. */
> > +void fput_close_list(struct file *file, struct llist_head *list)
> > +{
> > +       if (file_ref_put_close(&file->f_ref))
> > +               __llist_add(&file->f_llist, list);
> > +}
> > +
> > +/* Run the final __fput() for everything on the private @list, right h=
ere. */
> > +void fput_list(struct llist_head *list)
> > +{
> > +       struct file *f, *t;
> > +
> > +       llist_for_each_entry_safe(f, t, __llist_del_all(list), f_llist)=
 {
> > +               __fput(f);
> > +               cond_resched();
> > +       }
> > +}
> > +
> >  void __init files_init(void)
> >  {
> >         struct kmem_cache_args args =3D {
> > diff --git a/fs/internal.h b/fs/internal.h
> > index c658c8a5ebd5..619eaeb23fd9 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -129,6 +129,8 @@ static inline void put_file_access(struct file *fil=
e)
> >
> >  void fput_close_sync(struct file *);
> >  void fput_close(struct file *);
> > +void fput_close_list(struct file *file, struct llist_head *list);
> > +void fput_list(struct llist_head *list);
> >
> >  /*
> >   * super.c
> > @@ -198,6 +200,7 @@ extern struct file *do_file_open_root(const struct =
path *,
> >  extern struct open_how build_open_how(int flags, umode_t mode);
> >  extern int build_open_flags(const struct open_how *how, struct open_fl=
ags *op);
> >  struct file *file_close_fd_locked(struct files_struct *files, unsigned=
 fd);
> > +int filp_flush(struct file *filp, fl_owner_t id);
> >
> >  int do_ftruncate(struct file *file, loff_t length, unsigned int flags)=
;
> >  int chmod_common(const struct path *path, umode_t mode);
> > diff --git a/fs/open.c b/fs/open.c
> > index 6b1c14e684a9..7181665c3af5 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1506,7 +1506,7 @@ SYSCALL_DEFINE2(creat, const char __user *, pathn=
ame, umode_t, mode)
> >   * "id" is the POSIX thread ID. We use the
> >   * files pointer for this..
> >   */
> > -static int filp_flush(struct file *filp, fl_owner_t id)
> > +int filp_flush(struct file *filp, fl_owner_t id)
> >  {
> >         int retval =3D 0;
> >
> >
> > --
> > 2.53.0
> >
