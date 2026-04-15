Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560D1AB6F1
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 00:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776214113; cv=pass; b=O+JDvF32tPVJ7M+HQ9jTHpimNhTFGuLhWo4SOOW6/rpqwGyD+A1Mp9OrQp1PQw8skcs+V5zZByM2VbOG4YaY8/X7elIqJvjqlwVOeH22VuDUy9NNNAxjs6wVply9MUEgnL9GaQf8kCDWgRYxsn4KCFz8CVjsZilXntoKC6b7RIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776214113; c=relaxed/simple;
	bh=sZe/g577bm9MRlLA8DY2OXlBYp7yYlBjKvWRHF5WXsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8rN0ufF0lzW1Y6xEYUw/8axy3lMMXYyjlAPJu5VjXJy7k3/lpNAcj6HMVUKFfVwj/Ngf6rXyfY78z/eiC15ft5lHsOziTbSOdT0LNhC+Gc+ban4CNR1DyST0hqe4OOhSouGq1bchPsiDVLfWj863dydnKSQcjFOuPXywmtrWV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXvO2v2v; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXvO2v2v"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so6220939f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 17:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776214110; cv=none;
        d=google.com; s=arc-20240605;
        b=aRknoiG4Y/dIWnjNi6DPGQvWqPqMZinrDAwXIriMXM0Yh8i7tsyTTqe8ksfoaiDYgr
         UiBlzZv5rO9eOiH88Eh6X9rt5V2D74asOhVCHHR8b9hbHSZFuvY/zG09so9bFY7pkEv6
         +MYcTBQPj8gyxL/KKXsyC1I8Eld9PGtx8Lk60Py6ozS8itj5RDjUGsHQaek4s913vsAj
         muLaauczFPBZFK12CpQrivCgvOXdwSzXGKwcu2PsUjRkhe7SOTEZEGosKhS1jhyYRyLg
         PbByA1iL0hix3eMzHhZx34RmUQCr2NVwB3XQ9LRhW/iQfNmBkjGANlnLkrShk1JqYKd2
         ajGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=InDBjGNkCwCEmS0XXFKkIgswrokKUpV4YQmuF6nvZAY=;
        fh=FNP899pOMq0fdFbBzk700MVitZNQyomCiYLgmmHRkfE=;
        b=DVmHfpE1UjzB+z5W6J65Ql9whfgFSVcLnP5ZeUJHdNMw+VKM1DWaMNSgaFxAldvZ/E
         UIDjnaIK53RUzSAZSSCmdBc4zceEJvuveAO/aRPlWmwXoq6qiV8Q0dS2gaSTPDt3HPif
         LZ3dp11CoNyoS2tvpKBikpIEsLEtQ1uk0MMhksdyvjtKmoYvreXWkAs5q6OyXDkblat5
         z4+lOjC+SFk1OaZ57UyiotCc/FBlHeXxdcq4XztkukZn9m9l3/YbEGf6UVFiNWyUaLu0
         u7VTfYPci8ShCZiOt9rqqIIbWH84FHg0BXKEuELtg0Gtx+yjye6vyumlsY3KKZ8ALwK0
         BEsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776214110; x=1776818910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InDBjGNkCwCEmS0XXFKkIgswrokKUpV4YQmuF6nvZAY=;
        b=NXvO2v2vcu9akstWuWp2FJ+ra+5yV6VVD9inloSON+ndBmNfRv3OTkAd4nXhS2ou5f
         ILyN+R4RL2OUL8OstW+hkLf86E1UXnBw0y3+ufC+ou+bYFTZPW8rfmuvzpaf8WeSsiQz
         IjLqO1sHeWg1w+fB2HcYrovrkikuA9M2Tr8fr1/RB1OLDHE+KtGdj1db6DsN3XmrRj5H
         UQKtEop76OO7mBh1T5Zo/qqyPyBJg8SrW62SA6JEs6NFDXddKcSHlf+74eJHOc+FiZ3T
         wNWKOzeZxLZvHa1NBnHgMe7KKlsVoL9WMwr8U9fLUhGGgT8QvI1rvijTdpeFHwA216ZO
         DC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776214110; x=1776818910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=InDBjGNkCwCEmS0XXFKkIgswrokKUpV4YQmuF6nvZAY=;
        b=YGmLvJsI3XFUHJ6rWCbHtt0nrZWgYpCO49viGTqRUhHByzwtlRDgTxeLbc27Hkvi/E
         XAPRasbAadtNk49FcT0qumQNYjO6rsN0/h+7DBw3sv5WNn1dXWkhVfSnDp5Vt05hVADM
         ZIdDHUe49XJXk3O9/u+BPznonGGTxpoMKuJ12I9t9X4NDjOaBEyB07pgDMIUx8aIyWmD
         zBxcOyNDPWHyN6ila5JkJcSmvOHbJFCr+iNObNL+ZJet3VsheAEkPjIQLy41sC6R4ccN
         p6AWbQHKxRQnKd4LgiNagvvY56X5hJwOUtln+JHCO1aYkTTXaVcF1anlERXWISIhveBq
         e3hw==
X-Forwarded-Encrypted: i=1; AFNElJ/GoLQCJMeX9z31DjZQsmllCNc6pK9BSxfA8xteuybOjyNQGSvXUZadKzEvhPPpdhKd1rexVfDdItY1x6n5@vger.kernel.org
X-Gm-Message-State: AOJu0YxU22Pk41+n+z9r4ln4iyVEJmZ82VebMyd0OLDWipJ75VQTJFgx
	X0cttjY7kVAWkN1zIKTDKOCvQd5cmQigm+n0oxXfNGjlNgXOLlYJePjxO6TEqtgyOay/HF0ELGE
	xLbCPYbmKJ2jNc4XGcnfhRbwPYZ04KBk=
X-Gm-Gg: AeBDiesIBlQ0uN806TzEzkoPLSiSP1WEBLEEFTlDBiT++XuycLZr90xZVh58KKDT2wJ
	Sx+j4V9/1XKc9ruRPu5NSWZuhg5/p/VyvHJIFHBGXiC2xWgVr5+7gp/4FUcmknJZxr0y95WITzM
	6Jfdpjn4lg65OcP9OeE2VFotJp+86AEyJVn2T0AHW39w43tgngXfzZE5dQkTRXvslKkfleakvWs
	zSCoNslh+eNQWNucwSeEbRvHiPduhGdoWuvrJsBOMmJZQKae/wv4xp2urY1DkpzXjnM9gQEz8mE
	2/LchN3VukP1U4/ggBRucfueMJo=
X-Received: by 2002:a05:6000:2586:b0:43c:f925:8fc0 with SMTP id
 ffacd0b85a97d-43d642dd84fmr29487281f8f.50.1776214109913; Tue, 14 Apr 2026
 17:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-12-joannelkoong@gmail.com> <81b7ce30-50c3-4148-b0dc-fbf0a870f76e@bsbernd.com>
In-Reply-To: <81b7ce30-50c3-4148-b0dc-fbf0a870f76e@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Apr 2026 17:48:18 -0700
X-Gm-Features: AQROBzBeRsSGk_mDMRutxCEEtwpb_O9o1CjHSEYy97JU4o8ioDtqefhQ_LpppbM
Message-ID: <CAJnrk1bTdqEGdNkJ1tod62ovRXjam3GDj_g_M23YtxwYv_srqg@mail.gmail.com>
Subject: Re: [PATCH v2 11/14] fuse: add pinned headers capability for io-uring
 buffer rings
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 5:47=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 4/2/26 18:28, Joanne Koong wrote:
> > Allow fuse servers to pin their header buffers by setting the
> > FUSE_URING_PINNED_HEADERS flag alongside FUSE_URING_BUFRING on REGISTER
> > sqes. When set, the kernel pins the header pages, vmaps them for a
> > kernel virtual address, and uses direct memcpy for copying. This avoids
> > the per-request overhead of having to pin/unpin user pages and translat=
e
> > virtual addresses.
> >
> > Buffers must be page-aligned. The kernel accounts pinned pages against
> > RLIMIT_MEMLOCK (bypassed with CAP_IPC_LOCK) and tracks mm->pinned_vm.
> > Unpinning is done in process context during connection abort, since vma=
p
> > cannot run in softirq (where final destruction occurs via RCU).
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c       | 228 ++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/dev_uring_i.h     |  23 +++-
> >  include/uapi/linux/fuse.h |   2 +
> >  3 files changed, 243 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 9f14a2bcde3f..79736b02cf9f 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -11,6 +11,7 @@
> >
> >  #include <linux/fs.h>
> >  #include <linux/io_uring/cmd.h>
> > +#include <linux/vmalloc.h>
> >
> >  static bool __read_mostly enable_uring;
> >  module_param(enable_uring, bool, 0644);
> > @@ -46,6 +47,11 @@ static inline bool bufring_enabled(struct fuse_ring_=
queue *queue)
> >       return queue->bufring !=3D NULL;
> >  }
> >
> > +static inline bool bufring_pinned_headers(struct fuse_ring_queue *queu=
e)
> > +{
> > +     return queue->bufring->use_pinned_headers;
> > +}
> > +
> >  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
> >                                  struct fuse_ring_ent *ring_ent)
> >  {
> > @@ -200,6 +206,37 @@ bool fuse_uring_request_expired(struct fuse_conn *=
fc)
> >       return false;
> >  }
> >
> > +static void fuse_bufring_unpin_mem(struct fuse_bufring_pinned *mem)
> > +{
> > +     struct page **pages =3D mem->pages;
> > +     unsigned int nr_pages =3D mem->nr_pages;
> > +     struct user_struct *user =3D mem->user;
> > +     struct mm_struct *mm_account =3D mem->mm_account;
> > +
> > +     vunmap(mem->addr);
> > +     unpin_user_pages(pages, nr_pages);
> > +
> > +     if (user) {
> > +             atomic_long_sub(nr_pages, &user->locked_vm);
> > +             free_uid(user);
> > +     }
> > +
> > +     atomic64_sub(nr_pages, &mm_account->pinned_vm);
> > +     mmdrop(mm_account);
> > +
> > +     kvfree(mem->pages);
> > +}
> > +
> > +static void fuse_uring_bufring_unpin(struct fuse_ring_queue *queue)
> > +{
> > +     struct fuse_bufring *br =3D queue->bufring;
> > +
> > +     if (bufring_pinned_headers(queue)) {
> > +             fuse_bufring_unpin_mem(&br->pinned_headers);
> > +             br->use_pinned_headers =3D false;
> > +     }
> > +}
> > +
> >  void fuse_uring_destruct(struct fuse_conn *fc)
> >  {
> >       struct fuse_ring *ring =3D fc->ring;
> > @@ -227,7 +264,10 @@ void fuse_uring_destruct(struct fuse_conn *fc)
> >               }
> >
> >               kfree(queue->fpq.processing);
> > -             kfree(queue->bufring);
> > +             if (bufring_enabled(queue)) {
> > +                     fuse_uring_bufring_unpin(queue);
> > +                     kfree(queue->bufring);
> > +             }
> >               kfree(queue);
> >               ring->queues[qid] =3D NULL;
> >       }
> > @@ -309,14 +349,131 @@ static int fuse_uring_get_iovec_from_sqe(const s=
truct io_uring_sqe *sqe,
> >       return 0;
> >  }
> >
> > +static struct page **fuse_uring_pin_user_pages(void __user *uaddr,
> > +                                            unsigned long len, int *np=
ages)
>
> I think this is a duplicate of io_pin_pages(), can we just export that
> and use here? I'm basically going to propose to use the same technique
> in ublk - would be another duplicate.
>

Tbh I think this is generic logic that makes more sense to live in the
mm layer instead of fuse calling this as an exported io-uring
function. The memory it's passing in is not related to io-uring, so
that was my hesitation. For your ublk use case, is the memory you're
passing into this user-allocated memory that's not part of io-uring?
If so, then maybe it's best to move io_pin_pages() out of io-uring and
into generic mm.

Thanks,
Joanne
>
> (Not a complete a review yet, just something I just noticed).
>
>
> Thanks,
> Bernd
