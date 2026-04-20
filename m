Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CA347FC0
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776693662; cv=none; b=VVF7khppMTHAK87w8lpPPQ7/Szz3o8conBaRCpxVn5HogiTLr5DmqqO9gsWtDQM6ZredjH5nZqm9A5yu2rfem0QuGhGWInkI5N+b/TiFfLmA0+fTdpOkpd18JvZgV1US27rCM5TRqFEJ7qFIj0IC+eBQHKmcBxCuXLIL2+qGpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776693662; c=relaxed/simple;
	bh=GeIwoHKdIt3lRMHRpv38Y59HbZX122pNjvfE2Ot3KkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXE7w7O8ClVuA6wwFo3L28lafnRQYas4P8F0BuQEVOEZPy10oequJsaSheVSd6bXS2l8teJUcWTnPAENT04WmmaPnzGGwYIdrXvmv81A8yP/8w04ar98qlI+vM2VCmNCXDjTW6UNd2gUjMqegN1VHNjXLcODyMmPYC5KvfbfOfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuqIb4/4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuqIb4/4"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso409088666b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 07:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776693658; x=1777298458; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GDU0CUYIgdPj6T6zTg/0YVXUe6jDtdkR+wmRebePUmA=;
        b=IuqIb4/4shVWThfChaK77dU4EFVNLIeFbOUEaZJV1IhLKe41JYWecKadjpMjM1xMOw
         XKz/4nJEFcatEPbFNgEqBEvf9uG87K+V+TT207JcnySJeSbr7s4uosTBl1wotVOHMo13
         QBPnsmDAFlJWFCgJoVJUKH6uwBmYwez0yL4sGn0JkfwRFuHbye98xR+Qfu1IELcRbiLz
         hO2/Nw1Ie1Ay2p9vGc5frNSQgbEpnIdO7Myez2MW7qmih79wnCRGpsb2ZLGsjK65jZ+W
         SFKeQwVJ89+Sk8+DfCJdquiIaG8mZBW3zyHMrO8fFZbUU3S5SDnVjhP+fcyWJjJ3dsnq
         lRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776693658; x=1777298458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GDU0CUYIgdPj6T6zTg/0YVXUe6jDtdkR+wmRebePUmA=;
        b=sQrBgwUnoDOOPZ9j/smxrjcb/qA9HVoxq3k6gHAG3W2Xv4WiSf79eNekasM22ZPWnA
         nSwkWEtiyfH5jDUaprPVwgXQRGxmS+r4h4E6crhhehItK8rJDzwPquakUZ6C5MkpXLRk
         Wxh87lS5myHrvDv4eEE7iGtUKrD569QKaqgA+RB6vVxL6AyD94Y6UQJj1H35PDaGcEQg
         awFdDWFAfojvKyvfLMEGjz/fVRjrNUZKVoRvcHxQnP3zl3H7AbxUiNrIYlZPjrmNfXMM
         qcgGz6M350DQWA3lEz/jfqgnDq1pX5rEZETGY0io7pqq0owRlsJkfKq1M1lK0ANNENNi
         YUzA==
X-Forwarded-Encrypted: i=1; AFNElJ8yjr7Q+f8Yuh90b9E1YuuCbHSlBuueebJE6+15PMexQ6hBoDd5iL7hFSA4h8lpyI9hmVNBMvfHkznNssLJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnSb3DXfyo09wxm4/w7SY9w1cV1TNJCX8UjMX82kMwwv23eb7
	53Wx0kHpHifqahc+AIwwx31aSVUhOBMJ1Xn4y0RBkGKQ7dxiHFugD3DljPmX1+Jy
X-Gm-Gg: AeBDiet7MXTA+81ijtd6DSQbfRG0PF65MXvb9wKWXZtbRBCa23EwHhTwHt/+Of1qF8/
	XmbYYk3gjgVjk4P7g32i2gPeJGYmC/GBZgQ6SmNXF6jMpF953Zv5GI39z4h3qAqyXlDNvuue9Qa
	FU3G4Bwbq/8r25oBl0iR0nS8M//lTmuzsnEHiuhUIfUMF9we+Nu4R151ILJtCLI9TodjFtdpQmw
	4WqafuuMWLylYLwEZNhm8Mj6eakW1f7l7bONJJwSxtf52oLbsAAqiAOoIW6Mobl6ibxJsCPwMtR
	7QKxGpODkPc5P57QOY+di0FirBSrtEyICofAWsyCP6Ah1BDHm/BtADh6px5ykGC20vbgelngvhA
	X7fs4OByupyvFiuCBFqs3qrAS0Bzw7oQmgQOKM10QiA0aFCJyv0NJLH6dVY9BHDINYiM/ypYi0G
	SEskK7YOjpOfBwKgo9SbMfKqHSqgdrd5gNoVd66PrzNMNFVYXlxIIu4ul93qKZwVgDVZdfkTfQ4
	9JtftpgbbwW2cv3mB+atvDSgNH8UI5tTeuoFJA=
X-Received: by 2002:a17:907:a0d6:b0:b98:595c:a76f with SMTP id a640c23a62f3a-ba418888cfdmr606545166b.16.1776693652814;
        Mon, 20 Apr 2026 07:00:52 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-3beb-8da5-f727-16c5.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:3beb:8da5:f727:16c5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bae2sm355617166b.36.2026.04.20.07.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:00:51 -0700 (PDT)
Date: Mon, 20 Apr 2026 16:00:51 +0200
From: Amir Goldstein <amir73il@gmail.com>
To: Xin Yin <yinxin.x@bytedance.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: fix inode reference leak in
 fsnotify_recalc_mask()
Message-ID: <aeYxkwYXD23PTqMo@amir-ThinkPad-T480>
References: <20260420064727.1760604-1-yinxin.x@bytedance.com>
 <CAOQ4uxiPsbHb0o5voUKyPFMvBsDkG914FYDcs4C5UpBMNm0Vcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiPsbHb0o5voUKyPFMvBsDkG914FYDcs4C5UpBMNm0Vcg@mail.gmail.com>

[fix Jan's cc]

On Mon, Apr 20, 2026 at 03:33:30PM +0200, Amir Goldstein wrote:
> On Mon, Apr 20, 2026 at 8:52 AM Xin Yin <yinxin.x@bytedance.com> wrote:
> >
> > fsnotify_recalc_mask() fails to handle the return value of
> > __fsnotify_recalc_mask(), which may return an inode pointer that needs
> > to be released via fsnotify_drop_object() when the connector's HAS_IREF
> > flag transitions from set to cleared.
> >
> > This manifests as a hung task with the following call trace:
> >
> >   INFO: task umount:1234 blocked for more than 120 seconds.
> >   Call Trace:
> >    __schedule
> >    schedule
> >    fsnotify_sb_delete
> >    generic_shutdown_super
> >    kill_anon_super
> >    cleanup_mnt
> >    task_work_run
> >    do_exit
> >    do_group_exit
> >
> > The race window that triggers the iref leak:
> >
> >   Thread A (adding mark)              Thread B (removing mark)
> >   ──────────────────────              ────────────────────────
> >   fsnotify_add_mark_locked():
> >     fsnotify_add_mark_list():
> >       spin_lock(conn->lock)
> >       add mark_B(evictable) to list
> >       spin_unlock(conn->lock)
> >     return
> >
> >     /* ---- gap: no lock held ---- */
> >
> >                                       fsnotify_detach_mark(mark_A):
> >                                         spin_lock(mark_A->lock)
> >                                         clear ATTACHED flag on mark_A
> >                                         spin_unlock(mark_A->lock)
> >
> >     fsnotify_recalc_mask():
> >       spin_lock(conn->lock)
> >       __fsnotify_recalc_mask():
> >         /* mark_A skipped: ATTACHED cleared */
> >         /* only mark_B(evictable) remains */
> >         want_iref = false
> >         has_iref = true  /* not yet cleared */
> >         -> HAS_IREF transitions true -> false
> >         -> returns inode pointer
> >       spin_unlock(conn->lock)
> >       /* BUG: return value discarded!
> >        * iput() and fsnotify_put_sb_watched_objects()
> >        * are never called */
> >
> 
> Hi Xin!
> 
> Ouch! nasty one.
> Very good analysis.
> Do you also have a reproducer?
> 
> 
> > Fix this by capturing the return value of __fsnotify_recalc_mask() and
> > passing it to fsnotify_drop_object() after releasing the spinlock, which
> > is the same pattern used in fsnotify_put_mark().
> 
> The fix looks correct, but I prefer for my mental model to keep
> fsnotify_drop_object() in one place at the end of fsnotify_put_mark().
> 
> Please see the suggested (only sanity tested) patch.
> 
> Thanks,
> Amir.
> 
> 
> >
> > Fixes: c3638b5b1374 ("fsnotify: allow adding an inode mark without pinning inode")
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
> >  fs/notify/mark.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > index c2ed5b11b0fe6..cc93fcc2c5a9c 100644
> > --- a/fs/notify/mark.c
> > +++ b/fs/notify/mark.c
> > @@ -283,6 +283,8 @@ static void fsnotify_conn_set_children_dentry_flags(
> >         fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
> >  }
> >
> > +static void fsnotify_drop_object(unsigned int type, void *objp);
> > +
> >  /*
> >   * Calculate mask of events for a list of marks. The caller must make sure
> >   * connector and connector->obj cannot disappear under us.  Callers achieve
> > @@ -292,15 +294,19 @@ static void fsnotify_conn_set_children_dentry_flags(
> >  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> >  {
> >         bool update_children;
> > +       unsigned int type;
> > +       void *objp;
> >
> >         if (!conn)
> >                 return;
> >
> >         spin_lock(&conn->lock);
> >         update_children = !fsnotify_conn_watches_children(conn);
> > -       __fsnotify_recalc_mask(conn);
> > +       objp = __fsnotify_recalc_mask(conn);
> > +       type = conn->type;
> >         update_children &= fsnotify_conn_watches_children(conn);
> >         spin_unlock(&conn->lock);
> > +       fsnotify_drop_object(type, objp);
> >         /*
> >          * Set children's PARENT_WATCHED flags only if parent started watching.
> >          * When parent stops watching, we clear false positive PARENT_WATCHED
> > --
> > 2.20.1

> From 8cc3e7e2e75f5c93875bffce6bf8398d94398c33 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Mon, 20 Apr 2026 14:58:00 +0200
> Subject: [PATCH v2] fsnotify: fix inode reference leak in
>  fsnotify_recalc_mask()
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> fsnotify_recalc_mask() fails to handle the return value of
> __fsnotify_recalc_mask(), which may return an inode pointer that needs
> to be released via fsnotify_drop_object() when the connector's HAS_IREF
> flag transitions from set to cleared.
> 
> This manifests as a hung task with the following call trace:
> 
>   INFO: task umount:1234 blocked for more than 120 seconds.
>   Call Trace:
>    __schedule
>    schedule
>    fsnotify_sb_delete
>    generic_shutdown_super
>    kill_anon_super
>    cleanup_mnt
>    task_work_run
>    do_exit
>    do_group_exit
> 
> The race window that triggers the iref leak:
> 
>   Thread A (adding mark)              Thread B (removing mark)
>   ──────────────────────              ────────────────────────
>   fsnotify_add_mark_locked():
>     fsnotify_add_mark_list():
>       spin_lock(conn->lock)
>       add mark_B(evictable) to list
>       spin_unlock(conn->lock)
>     return
> 
>     /* ---- gap: no lock held ---- */
> 
>                                       fsnotify_detach_mark(mark_A):
>                                         spin_lock(mark_A->lock)
>                                         clear ATTACHED flag on mark_A
>                                         spin_unlock(mark_A->lock)
>                                         fsnotify_put_mark(mark_A)
> 
>     fsnotify_recalc_mask():
>       spin_lock(conn->lock)
>       __fsnotify_recalc_mask():
>         /* mark_A skipped: ATTACHED cleared */
>         /* only mark_B(evictable) remains */
>         want_iref = false
>         has_iref = true  /* not yet cleared */
>         -> HAS_IREF transitions true -> false
>         -> returns inode pointer
>       spin_unlock(conn->lock)
>       /* BUG: return value discarded!
>        * iput() and fsnotify_put_sb_watched_objects()
>        * are never called */
> 
> Fix this by deferring the transition true -> false of HAS_IREF flag from
> fsnotify_recalc_mask() (Thread A) to fsnotify_put_mark() (thread B).
> 
> Fixes: c3638b5b1374 ("fsnotify: allow adding an inode mark without pinning inode")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/mark.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 622f05977f86a..e256b420100dc 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -238,7 +238,12 @@ static struct inode *fsnotify_update_iref(struct fsnotify_mark_connector *conn,
>  	return inode;
>  }
>  
> -static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
> +/*
> + * Calculate mask of events for a list of marks.
> + *
> + * Return true if any of the attached marks want to hold an inode reference.
> + */
> +static bool __fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  {
>  	u32 new_mask = 0;
>  	bool want_iref = false;
> @@ -262,6 +267,34 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  	 */
>  	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
>  
> +	return want_iref;
> +}
> +
> +/*
> + * Calculate mask of events for a list of marks after attach/modify mark
> + * and get an inode reference for the connector if needed.
> + *
> + * A concurrent add of evictable mark and detach of non-evictable mark can
> + * lead to __fsnotify_recalc_mask() returning false want_iref, but in this
> + * case we defer clearing iref to fsnotify_recalc_mask_clear_iref() called
> + * from fsnotify_put_mark().
> + */
> +static void fsnotify_recalc_mask_set_iref(struct fsnotify_mark_connector *conn)
> +{
> +	bool has_iref = conn->flags & FSNOTIFY_CONN_FLAG_HAS_IREF;
> +	bool want_iref = __fsnotify_recalc_mask(conn) || has_iref;
> +
> +	(void) fsnotify_update_iref(conn, want_iref);
> +}
> +
> +/*
> + * Calculate mask of events for a list of marks after detach mark
> + * and return the inode object if its reference is no longer needed.
> + */
> +static void *fsnotify_recalc_mask_clear_iref(struct fsnotify_mark_connector *conn)
> +{
> +	bool want_iref = __fsnotify_recalc_mask(conn);
> +
>  	return fsnotify_update_iref(conn, want_iref);
>  }
>  
> @@ -298,7 +331,7 @@ void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  
>  	spin_lock(&conn->lock);
>  	update_children = !fsnotify_conn_watches_children(conn);
> -	__fsnotify_recalc_mask(conn);
> +	fsnotify_recalc_mask_set_iref(conn);
>  	update_children &= fsnotify_conn_watches_children(conn);
>  	spin_unlock(&conn->lock);
>  	/*
> @@ -419,7 +452,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>  		/* Update watched objects after detaching mark */
>  		if (sb)
>  			fsnotify_update_sb_watchers(sb, conn);
> -		objp = __fsnotify_recalc_mask(conn);
> +		objp = fsnotify_recalc_mask_clear_iref(conn);
>  		type = conn->type;
>  	}
>  	WRITE_ONCE(mark->connector, NULL);
> -- 
> 2.53.0
> 

