Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36A3E1233
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786370713; cv=pass; b=ER9vvvV1JkxkCVmibg3GP2zGy0zwqD4+JNjW3rN9OgTN23+nc+Sx+OitvqgZmoNBDh+ER61cClG9wZY5vogZhmVzKtw5PaJ7R744SbrRCoKZAtDag6v7LZTV0o4MBD6CXDDA1h3i9zd4AaWB8gWEc8glbgmEsZba5WvacAkCVzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786370713; c=relaxed/simple;
	bh=wQK4iC+iVboZVQ0TbBvuUd5c8pU8uXP8R69wO9Cbm1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q12wFt6TLku69jXxYpaTaqaZGGFd+V2ejZ8/DhRKtGH/lbr0WqZMnuT113fGjyR6ohLKD6tjRtv5pIk0PJK2SysC/WUlcH/jfOH6XoutRvxK7bf1C2WNJl+kBXNkg5+F4mELJ7mWp74cGP2654l7ocezK0w5cOytqCwxusJBk38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=myhmKgHT; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="myhmKgHT"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8eeadbc5e21so11757076d6.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786370710; cv=none;
        d=google.com; s=arc-20260327;
        b=ZzxOsysGRW3L168RmkDYdtulHMBsEWtjf73t0fhNi6GyUBaxN5WqQY6EBr582LdjB4
         rg9wtcXRzXwuuBIEpPWMNpwmaHgWMVk55wRR2aAVeJJp9WCmcC1Ryav5jwZ7yN8moSik
         w808eiEXUDGnYhkipxWPqCQDfsahuPwHjIW+ZYN/8PbXgCuckyXhshQ3yvpN8Cyz0wnZ
         U0M1RWWtEVGDjmIMRQ7WDg+PnW/cFQ9CPo7h/C+eVqYcYJwSryk/o1psMFVTB6K85phw
         Y5kmE5JGfgaWaklGrMBw6Y+Dhx6AdNp8459Q52FxE3kO7Ul+J5+dpyNC2Ee27ndAVJFi
         rc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        fh=0hGDlFNGRmZQsIWmWAuBSbtOA9RbZT7hD1USEdUNzh8=;
        b=RURgJMNCwgtmqpz7Lh3HQpVKQYotOsSrsX6QHvM+LoxGbcC2gh2XKQrNa0sAC3y/hX
         rJ0dKAY3iqRXa7bWhBebzy0cuuOv+g66m9FQ3uZNrFxsI54ZVUnpDFlZsw1bEow0YSBO
         eStIjn6ltG+zicTlO3tO8RlUSWB/2p9aep5rTDmjmH3NDHL5sm7rTZJ0kJWOzrmu3NPD
         5rw10MI+SPvHrxGdOvbhos+VNa+iOWCdChfFQCIyIhVLC3feYvjqBng+nQ5zauS4ZuQQ
         2ABN0IB7zKKKXoa6J4swErcRURgAAlkkeY62yxkPoObVhu8ZPxVhOYkr6/6Oeh+A0fVZ
         QXQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786370710; x=1786975510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        b=myhmKgHTG1hXWp+ZWdXS/rOTTX/n2t2qUF8gwZnkEQrZniSCmin6lDe/80YepezVa6
         121u1I/avdUEU9WLXbOvUTKTDZnRMENu9eDMm34cdrmTSuVA63UMoNjjk1PYE/pAvemd
         YBbtcfpvyQ4CvlD5YmCvZn51m6vllAzMISc9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786370710; x=1786975510;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NV+45oOv6d8nxP4iat2b7fdyPFUDUzYrSvuxe5NbF8Q=;
        b=UcxG8GDKc2jeKFAfGVX4S+YMivS1uhUNyvj2xEvnWXkHjNC8M4Yj+2aS5yVwHOo8ab
         Y+/jXPUaYIeMAS3Kww5FmQ2+pBjMYYtieNOGxZQsWGJijrMF/Tp8jgLietXO0IxksYLq
         PwXpwxFkLVKWg+wM4WX5gqYiuqZpYaCJDQrvfYlKFaPFZUlnecJOUKKtBmEYwrZ/IdEk
         vOMeEymzb9Kq1o7mLeVdN2p2STsXrx1UU4+g3VtWqvxi82u39lHHltemFJVzgteUW+K7
         FxKrbiYlDks0RGIUr8+f1IBHQN9H/IsTggQuCgTChu3aBEEGJztEUixhaVg+4ntsbwYk
         FoJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rozz8z4wgIDzBHrRNCIuj9nFj13FRJ8vAFCCRCZKeVQYf6siYGEn4oRQPXkLNrumixZkHbZaqTt70LAYaJt@vger.kernel.org
X-Gm-Message-State: AOJu0YydQtfWnD/622Vq0GeIeypgyTkA4Wossth5Cy/LCo0UA7pznK0H
	IsIDXDJREremximS3wCs7qNTH40lNSoA1XnzSKFlW5B280uQeTZ1cfu0TL7KS4FoSPksPggQN3K
	4ARO97Ygl/oMzHMqWdglcfqRH8JfVMJb0dA/c1iIeZQ==
X-Gm-Gg: AR+sD10KvpI1Eon4872We3ihJvCaHuZoj7Sw5joaQSHeW/ZJzfAjT/HempJTSZCwcHw
	EkHg/mTtB3dLb1vtFeNj1UxHc7gL0h4ljgB/fZpTUa/CnCgKxb1EwgCdg0JCdV1weLkhVD9rzep
	28HgpBAW3VqSu/5J1NcQTVynwqHdztUX/kETQcWtCsEFYzTGQ4d+2S3Z/dK4YUZYD0kx4eFx1Du
	bxVf00A+gDS/BAPwKeTGwxwH5fBAmupt6IgK6GasMpKMbWOmZVZYliT608PoVO1DVPAmZEb9pOV
	xUJXR6mv5YgeVOkeu+YolVRItsIx9weU+qHUu/vyfEaaWaOirkR3SCIJ22u0mPiESMstbAQ+Ixw
	=
X-Received: by 2002:ac8:5cc5:0:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-52d1919e59dmr254953691cf.37.1786370709751; Mon, 10 Aug 2026
 07:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-3-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-3-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:04:56 +0200
X-Gm-Features: AUfX_mwOr6H9OqGZCernhbLrr_tuorcVZn-K7EOk-lg62vULXKmdHLNqnvpAUNY
Message-ID: <CAJfpegvTXG_kJHyFB115zdQvbyvDNtfqA_Mv9UKiEf9BE5qXwQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/12] Add and use d_for_each_positive_child family of iterators
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:38, NeilBrown <neilb@ownmail.net> wrote:

> coda_flag_children() doesn't need rcu_read_lock() as holding any
> spinlock prevents an RCU critical section from finishing.

I think prep changes should go in separate patches.

The conversion should be an equivalent transformation.

> nfs_clear_verifier_directory() is changed slightly so the parent lock is
> dropped and retaken between clearing the verifier on the parent and on
> all the children.  I think this is safe.

This can also be a prep patch.

> get_next_postive_dentry() in autofs now holds the parent lock a bit
> less.  The only non-trivial code that is no locked any more is
>    parent = p->d_parent
> This cannot need the lock as autofs doesn't support rename and
> a ref is held on a descendent of parent, so ->d_parent cannot
> change.  And if it could, the lock wouldn't help.

And this too.

> diff --git a/fs/autofs/expire.c b/fs/autofs/expire.c
> index 5c2d459e1e48..7b0a22629415 100644
> --- a/fs/autofs/expire.c
> +++ b/fs/autofs/expire.c
> @@ -70,12 +70,9 @@ static int autofs_mount_busy(struct vfsmount *mnt,
>         return status;
>  }
>
> -/* p->d_lock held */
>  static struct dentry *positive_after(struct dentry *p, struct dentry *child)

Move this primitive to libfs.c?

> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2182,14 +2182,10 @@ static bool drop_negative_children(struct dentry *dentry)
>         if (!d_is_dir(dentry))
>                 goto out;
>
> -       spin_lock(&dentry->d_lock);
> -       hlist_for_each_entry(child, &dentry->d_children, d_sib) {
> -               if (d_really_is_positive(child)) {
> -                       all_negative = false;
> -                       break;
> -               }
> +       d_for_each_positive_child(child, dentry) {
> +               all_negative = false;
> +               break;
>         }
> -       spin_unlock(&dentry->d_lock);

simple_empty()?

Thanks,
Miklos
