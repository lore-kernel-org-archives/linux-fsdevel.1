Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545A24293C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 23:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773791025; cv=pass; b=PzuCRxmFAmW6NkKW5EaZT2Hy9Z++TH26VDtF/cNlIvcuQ8GKCttTqNQlzzNiQv0PdRMwCkD5Y5SRj2GhDEB99WKyeP2qhqTFIvOAmOfrvl9xyuWTCU7D3TtVk4Tnda3hOj4DE7QVd3I6i6E/sogUPZG/c2cEEi263omJY8/tWoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773791025; c=relaxed/simple;
	bh=zKWPwRYfmnxgeQEuXiHBNCz0l0RwNmQhCQ2sOU0mXRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NycKTrCVaJ9azFRAh6p1KVRYDnTYihNSUBCPizsv9ncexZcOlL3EGBGlTjifbQB3AjZqffqldOlZS/GbYHZRaRmtllS5US3lN/AiD35LppKgHmGWs3e77LG7ujsv+odQxsIGZR6bu4QTuYLnIxwXF0+9oZFlaxeQVj4iDRL2VZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud2O2bTY; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud2O2bTY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48532925a4bso33472975e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 16:43:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773791023; cv=none;
        d=google.com; s=arc-20240605;
        b=MadjVyBjd1ZqO6xOS8gtLUltL7NPNsrYpTr4QDhm6gXLV7P6fuoVSO2Epn6WNgUb+S
         zuBM0iU5zUbxhn+hg6gpycv9wXJxdb1XaU6MqK3V7nDi0foMzulg0TzaN3zgfP5dRCWf
         4Z7D1Hrmq93Au/Gwv33VlBQsmt9tG7Dq7fP2BlgasyMPEdG6thdfjiwZsRLutfVwpDtP
         EgGGGQp+utjhx7b1Pzzn66vLuuxN3RZHDCKI3tjaxInMYddm/7urOp6W8rY9OX+tnLmY
         nHRrYKHDdpGsXivnR8WYmtkPT6EoN/jA1lJqUF1YYA7d4/05EoZ13mfKVe1NRnFzEc1F
         Ky5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=autMmFQ+U6b3hhWji1XOjZewDxPP3G+PG9ALz/dtmZI=;
        fh=PNWzqmm9ceSoaPUBFRYd8WZLTzkfzk4/wF2R9/cYXbE=;
        b=Jt/J0oZMpUoqkfFPgUgg4WB6emNxoej0ojVmEMvS0ePCEiIS9GOPbQpnOS+sDJeZWv
         lfbV/4ddQNIG9SrBQaeiWcnSUBpCv62pWW587t48tq0jho/mw5AOP85+8A0p8dU2E1Zq
         5oCS2rGKhy7UZOt/uQ5kq5PdyQnu5yNzdIETkrlOpExVKnjHi5E8waLfhvhudMlrSgmR
         h1DTmTDgVNk6vO0oCoZJP0pe0ftzpKsW7eFLFsGvJXd2t68UWO2JDjk5Be2Hel/S1V9b
         3xrEJOkIksIFBLLSWX13QiwTPWr45+Ah5eGOXC3RThikZPDrcl2MZ3VBL8KI4E7h+tr8
         QOxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773791023; x=1774395823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=autMmFQ+U6b3hhWji1XOjZewDxPP3G+PG9ALz/dtmZI=;
        b=Ud2O2bTYO6QBgNhpewoeIwjy5sm3IvHPvdjYiG80ltWvK1lb64wG9Ad/hbMj4n4D8H
         vI5sXIbq1rhEd9eVARSCU0FtENmwzWT78KXqH7WCM3QVHqPnt3RoZLEaxiY6PzgqG6X4
         pUg+/3fl8u8hGJLILOPipjOkN6SypCC6PCf+G2sy4hBtA6j3ejQP6fdG6F+MnRaSHd8w
         tR+mqfksvFMgK3kDIztyenTn5Dp4Kvdx9hJO+i4HMM9VsQXiUXvwX+4uqGDlZKoaIoNz
         kqZbfMIjG42w0y7ITcuokoWRGRyrRRVHKgBKGkM0DMX58y55wUOHz/vf/kx5dycGYWHk
         +2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773791023; x=1774395823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=autMmFQ+U6b3hhWji1XOjZewDxPP3G+PG9ALz/dtmZI=;
        b=ZbZsvsv1nw7gJ23Gu2l36o1bx9YNoEBsq03lMY6ib2DzZo3RXvPCBeU2SrdZwnDSRm
         CafiNvHBnc2/MTFkmduqEe8rhH5o5YagV3ifJh45jirWpu55CZqg/4sx9NafckkPuYQK
         6DR4JMs1UkZhjayPI4dRzdVWXXpwmdKCuna5tNE2MyJCrwqTpsSOR8wcvWL+6BxzgvgW
         hNwXO5pdYpt/7F886ZF2GZTNIusBm0M5QrGCi7R/Jo20JtzEOBvwwuAKrXwngW+P3xuA
         89wnNPhTE5TeL5xHiNd95+em9fJCedyu1Eyqx8X3cojtnv1OCi3WSXBR/vCKn2t7tPmt
         246w==
X-Forwarded-Encrypted: i=1; AJvYcCVVLjfLdBamrQP6qULtUopjVXXgoAp2q9tmE/0knsZTQoLrlXe7WSaNz9DDKlksPyHf70ldiTijS2iNCUz2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LF1A7JzysCgjTJlPterElDCFmbtna74yPinLhuuNW9Ouqv4A
	z2RpJBLEjC/WnQmuB8RvXfa1p6qJ8uXBLC0IPA1VJ4yQgVJHwAWs1IcAf1P9MmwOlozJN2MFZea
	I1jQrMtUvUedehQsxGvXCTQZh2FVqArw=
X-Gm-Gg: ATEYQzxLoCQLSKJJYhv7ypI28H7urESknO1UcmOltvpxGLtEHBHu2MzKviNPoiVud+x
	BExgM+EP5gNAV5224V8VU+GELZLduljsE8+nmDfqaHm2xWNpy9PsiQbBgRgAK4jn2A6RmErMnfc
	oBIT+6SIT1CffKDAjbP9qzbMTSMAONwet4UdOQVl7lfcDydaDmcr/NkZ9uaVE1xDhdkj/6q52Sq
	a/jd1QV8stf78Y7vjMyI5fXLgoTVw0oQ9qb9+QubPlO7SN6yRHB8DvTrWgZbA93OHHcjMN6Okch
	OPRZgg==
X-Received: by 2002:a05:600c:c491:b0:485:2fc5:39e with SMTP id
 5b1f17b1804b1-486f44635e2mr23243895e9.27.1773791022670; Tue, 17 Mar 2026
 16:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316165320.3245526-1-mszeredi@redhat.com> <20260316165320.3245526-6-mszeredi@redhat.com>
 <5448457d-4687-4f33-a8f4-fe0da0a2b24a@bsbernd.com>
In-Reply-To: <5448457d-4687-4f33-a8f4-fe0da0a2b24a@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 16:43:31 -0700
X-Gm-Features: AaiRm52cNW4e1TOyCh-HmY41zMjWWSSKCeSGnNco5OEZrJSd1Cfrv172zUIdJJo
Message-ID: <CAJnrk1brsU+v=OF3Q2y3=GTJjuAO0khJB-gVcEDK3QZpMMF=FQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] fuse: clean up device cloning
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 3:51=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
> On 3/16/26 17:53, Miklos Szeredi wrote:
> >  - fuse_mutex is not needed for device cloning, because fuse_dev_instal=
l()
> >    uses cmpxcg() to set fud->fc, which prevents races between clone/mou=
nt
> >    or clone/clone.  This makes the logic simpler
> >
> >  - Drop fc->dev_count.  This is only used to check in release if the de=
vice
> >    is the last clone, but checking list_empty(&fc->devices) is equivale=
nt
> >    after removing the released device from the list.  Removing the fuse=
_dev
> >    before calling fuse_abort_conn() is okay, since the processing and i=
o
> >    lists are now empty for this device.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/dev.c    | 46 ++++++++++++++++++----------------------------
> >  fs/fuse/fuse_i.h |  3 ---
> >  fs/fuse/inode.c  |  1 -
> >  3 files changed, 18 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 4c926c9c4f39..3d6578fcb386 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -2538,6 +2538,7 @@ int fuse_dev_release(struct inode *inode, struct =
file *file)
> >               struct fuse_pqueue *fpq =3D &fud->pq;
> >               LIST_HEAD(to_end);
> >               unsigned int i;
> > +             bool last;
> >
> >               spin_lock(&fpq->lock);
> >               WARN_ON(!list_empty(&fpq->io));
> > @@ -2547,14 +2548,16 @@ int fuse_dev_release(struct inode *inode, struc=
t file *file)
> >
> >               fuse_dev_end_requests(&to_end);
> >
> > +             spin_lock(&fc->lock);
> > +             list_del(&fud->entry);
> >               /* Are we the last open device? */
> > -             if (atomic_dec_and_test(&fc->dev_count)) {
> > +             last =3D list_empty(&fc->devices);
> > +             spin_unlock(&fc->lock);
> > +
> > +             if (last) {
> >                       WARN_ON(fc->iq.fasync !=3D NULL);
> >                       fuse_abort_conn(fc);
> >               }
> > -             spin_lock(&fc->lock);
> > -             list_del(&fud->entry);
> > -             spin_unlock(&fc->lock);
> >               fuse_conn_put(fc);
> >       }
> >       fuse_dev_put(fud);
> > @@ -2573,24 +2576,10 @@ static int fuse_dev_fasync(int fd, struct file =
*file, int on)
> >       return fasync_helper(fd, file, on, &fud->fc->iq.fasync);
> >  }
> >
> > -static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
> > -{
> > -     struct fuse_dev *new_fud =3D fuse_file_to_fud(new);
> > -
> > -     if (fuse_dev_fc_get(new_fud))
> > -             return -EINVAL;
> > -
> > -     fuse_dev_install(new_fud, fc);
> > -     atomic_inc(&fc->dev_count);
> > -
> > -     return 0;
> > -}
> > -
> >  static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp=
)
> >  {
> > -     int res;
> >       int oldfd;
> > -     struct fuse_dev *fud =3D NULL;
> > +     struct fuse_dev *fud, *new_fud;
> >
> >       if (get_user(oldfd, argp))
> >               return -EFAULT;
> > @@ -2603,17 +2592,18 @@ static long fuse_dev_ioctl_clone(struct file *f=
ile, __u32 __user *argp)
> >        * Check against file->f_op because CUSE
> >        * uses the same ioctl handler.
> >        */
> > -     if (fd_file(f)->f_op =3D=3D file->f_op)
> > -             fud =3D __fuse_get_dev(fd_file(f));
>
> Let's say there is crazy daemon with
>
> thread-A tries to mount
> thread-B closes the fd during the mount
> thread-C does clone in parallel
>
>
>
> > +     if (fd_file(f)->f_op !=3D file->f_op)
> > +             return -EINVAL;
> >
> > -     res =3D -EINVAL;
> > -     if (fud) {
> > -             mutex_lock(&fuse_mutex);
> > -             res =3D fuse_device_clone(fud->fc, file);
>
> Won't this acceess an invalid fc?
>

if I'm understanding it correctly, the  CLASS(fd, f)(oldfd); line a
few lines above does a fdget(oldfd) which holds a refcount on the
file, which means even after thread B closes the fd, the
fuse_dev_release() (and the fud->fc invalidation) doesn't get
triggered.

Thanks,
Joanne
