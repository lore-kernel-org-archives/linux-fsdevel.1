Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1BF40758F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553117; cv=pass; b=s5RfLHgkZB8X11Svq+xdRUDue0CY917pr+djAV9yqjlcdbi+y1AWuASpMYh1RMqQAF8qMazB7knc8yKnwE+SB7ZdcY0RkVX7q/Uvkt6vWgTAbbI2Hsr/3Pj66kqtbO733sUNZbwIVJzlxoUcptCQjCn0QpN2/aIPCRMgKP/FTTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553117; c=relaxed/simple;
	bh=TA+7x/4MagXqD1Is+R4FwfzOqYBftsiGIdMNk4CUjlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZEP4og1KPVn+INIybmu55Mt8sSp/k86e+RnNbVicusWYr/HiqkvgzTjOPsDQJI3YWMFbDVAtHgJQS3pPdZf/fkVVFQTknGh7t2bZcIid22cgX3TmfTRVn0i1ZTZjHGQAe6z1zhdqxI9TQwrWpFrFwRGLwZhKJXjss6U52BTGOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmwQ64xY; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmwQ64xY"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488d2079582so8915305e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 05:45:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777553113; cv=none;
        d=google.com; s=arc-20240605;
        b=F6oe05UiKh/X0z3EC/9aUrW6oAdMEhkvIdAZ+0IpxRjekABgTuoGrI8RD5DcrKG3dO
         PhVRCoM8+IRhgohdThTweus8+BlxsEWQFYbPcI6GwiaVjcB8ecBgVCUG8zk6Sx9BjXhK
         Dk61MepgamLTKw4yafZFAUcVF+wvYU1/P6LrgK9eceO76wc3nDXYmU1tJeEodksCSxf7
         a3vK4jcaBbBXS4fp2ifCb71+4ABV02ULuOY/h17ZQRzZaUwIUt7pjhUk++enYf5Bz+ie
         q/8F1BlpFU2UWkhkWF5QrRrHKiDB88H9tB/qr2tV9OOu9zH13URE1+uIrxPuEIARp1wH
         1K/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0wnVvZM7EaRhNn9ESmvoZ6RDyuRVlpp/asgCw1jcelA=;
        fh=BWJlAIj52J76N3mPKnEfeXwE01D9HAk5rPFXvL1P9HQ=;
        b=KBYVhWPNr4BEOFTrjw3rYnxjzCHXUsBMDbRR3FzoaSLC38xho0b2TB/30JMSwQMAqQ
         bs6w0L1HrBxtzOgB6Mqj5Ipmzh73rP/1NqRa9SQ/MUOd5POKwwpyu3KWqqyj5lxIU0YM
         ZcbsVkCtVeVZbNr8bWbONkMaCVt4nFsZAwM9D74MVaTcoHydWdNai2/xVxzBzyurujfH
         F+890a/kyOFE8c3aW0N/UMTYfsvpnI66KwXE4pGi4ok5AuKMv6QZFcZEfULQW422Lhao
         R9ATl8uViK0zrUZabuxIiby6hAfWOATewnQFwXJaWWsido4UD1B91Ib7G9/f5oDBJRrx
         q7Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777553113; x=1778157913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wnVvZM7EaRhNn9ESmvoZ6RDyuRVlpp/asgCw1jcelA=;
        b=dmwQ64xYVk+1QE+on+sQT1D0L/Bkr3fzy0H9FHqeXiKDlgNrw/jrPHp6HvsgZoSJpw
         wkY5V0xe2vjaWnsDd4J+Xe89SdqRJ5byTLEOb4udcOGY69mTOvVrzHIGKeqCzGezkqC2
         JDsvCE7nEUWUJHTwCXmdohI4Er/nx841/vxC+u0VN2WiBoUtJRTEZZEwFNyalxUC+vqq
         yWXbGm1Xy0L/8O6n3vGzS6NbGT0qENriYmdvDilty52bJQzJQPjG+NdyqR75zNO2V8Ve
         pFhNUUOIOcqWA0aR/awdbQCVuisjNHQ5Msvj4fgrhrr6Z7Nu0pe1rGSDZQSzNe17mUO9
         AeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777553113; x=1778157913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0wnVvZM7EaRhNn9ESmvoZ6RDyuRVlpp/asgCw1jcelA=;
        b=ltDiDRn6MQj0jaq58seakbN8/xZvByVIX4Yu5jZJgVETJcWL/jpQ8NeN+B2492pbju
         8eMsxNBWqWwlUNa0UQgZHwZnT4ix2wDCpe7myv4569+Evq8NpKOrl8v92DDmCufyQTdZ
         q3GC0/XfSmhJHOenh7mPlLNRgLx6o5VZ2oMqdgzTMr6etypb9DY5cfD4YEPyZO922xof
         w9LlAzLgEATy/qHrELDTwbOPl6RxqU66xSBMtDiwaK63Xs7P6wB8xeyct8cLEVLk/Abm
         KsYbqfuYcWIxLAdmnyL7YuUE/Rj+oMDmm8ysIWCjwlnu8jfR1JEa5PUNZRNDhiYJ5u0u
         szrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EtihTpindZ6l/vj5YybzKWWzKFjCpIx0FcpwkuNbPzKYin8n7vbywkB/1beoIMSR97MxRksLOFkfgWEhC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Y3C4cEeeclwGkne4/gLNxfAdIoKhKWu3/CBgIkM9lxrR/Cso
	t7QPrZVHJnwdhCgCO4YITcVjzbkqAyofF8j/VPAEZ+1sCKhGtrD91YuxXO9mzEvOlXjsuK21qut
	xmkZIvgbYFEr3yuhLoFn6shkoksmpnGk=
X-Gm-Gg: AeBDies9TiHNflJWiMRUteq22xXsTXVOIoaerpsfojx57Rw+Igpz/UxGkxlKk7anW6i
	dZeBjv1AsHpLURyx9c5QG1ovHp8/lCmOGqtfjhvLyyT/Ozh/pIwj1dqlAzvwS2lQUa9JAOvBxwb
	BoLWhF4H52OYTBhPhhEzcn/b8Dh+7UcxDw062sHoknUAaQNKfiQVNmx7BVhB4n5TUkdeDXkxy9y
	tNy1389khLnVcr5rDwN7MWNpPipNyfaMg2XiwAsa78Z9gVsnMWKPRoOl1kJ4aTic8QE7Hx+GBCW
	Gu5OyS11rtWes7MFcLMNPoGPY74b4MeXxQ==
X-Received: by 2002:a05:600c:a310:b0:488:78f2:6b0 with SMTP id
 5b1f17b1804b1-48a84460fcbmr37498625e9.29.1777553113054; Thu, 30 Apr 2026
 05:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-11-joannelkoong@gmail.com> <c6977f02cd8c341b80ec5e7cc1bf67e0e455d859.camel@kernel.org>
In-Reply-To: <c6977f02cd8c341b80ec5e7cc1bf67e0e455d859.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 30 Apr 2026 13:44:58 +0100
X-Gm-Features: AVHnY4I1MoXwmr4V7xrTDMMh3oYlEpp-L8pttCgTxM8u9oB39PZt8cKqTdCx-bo
Message-ID: <CAJnrk1Y__-nmLsaNL36jATEsotSdHJE1oeEgekuywtCH-dB-fg@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] fuse: add io-uring buffer rings
To: Jeff Layton <jlayton@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, axboe@kernel.dk, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 12:08=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Thu, 2026-04-02 at 09:28 -0700, Joanne Koong wrote:
> > Add fuse buffer rings for servers communicating through the io-uring
> > interface. To use this, the server must set the FUSE_URING_BUFRING
> > flag and provide header and payload buffers via an iovec array in the
> > sqe during registration. The payload buffers are used to back the buffe=
r
> > ring. The kernel manages buffer selection and recycling through a simpl=
e
> > internal ring.
> >
> > This has the following advantages over the non-bufring (iovec) path:
> > - Reduced memory usage: in the iovec path, each entry has its own
> >   dedicated payload buffer, requiring N buffers for N entries where eac=
h
> >   buffer must be large enough to accommodate the maximum possible
> >   payload size. With buffer rings, payload buffers are pooled and
> >   selected on demand. Entries only hold a buffer while actively
> >   processing a request with payload data. When incremental buffer
> >   consumption is added, this will allow non-overlapping regions of a
> >   single buffer to be used simultaneously across multiple requests,
> >   further reducing memory requirements.
> > - Foundation for pinned buffers: the buffer ring headers and payloads
> >   are now each passed in as a contiguous memory allocation, which allow=
s
> >   fuse to easily pin and vmap the entire region in one operation during
> >   queue setup. This will eliminate the per-request overhead of having t=
o
> >   pin/unpin user pages and translate virtual addresses and is a
> >   prerequisite for future optimizations like performing data copies
> >   outside of the server's task context.
> >
> > Each ring entry gets a fixed ID (sqe->buf_index) that maps to a specifi=
c
> > header slot in the headers buffer. Payload buffers are selected from
> > the ring on demand and recycled after each request. Buffer ring usage i=
s
> > set on a per-queue basis. All subsequent registration SQEs for the same
> > queue must use consistent flags.
> >
> > The headers are laid out contiguously and provided via iov[0]. Each slo=
t
> > maps to ent->id:
> >
> > > <- headers_size (>=3D queue_depth * sizeof(fuse_uring_req_header)) ->=
|
> > +------------------------------+------------------------------+-----+
> > > struct fuse_uring_req_header | struct fuse_uring_req_header | ... |
> > >        [ent id=3D0]            |        [ent id=3D1]            |    =
 |
> > +------------------------------+------------------------------+-----+
> >
> > On the server side, the ent id is used to determine where in the header=
s
> > buffer the headers data for the ent resides. This is done by
> > calculating ent_id * sizeof(struct fuse_uring_req_header) as the offset
> > into the headers buffer.
> >
> > The buffer ring is backed by the payload buffer, which is contiguous bu=
t
> > partitioned into individual bufs according to the buf_size passed in at
> > registration.
> >
> >   PAYLOAD BUFFER POOL (contiguous, provided via iov[1]):
> >     |<-------------- payload_size ------------>|
> >     +--------- --+-----------+-----------+-----+
> >     |  buf [0]   |  buf [1]  |  buf [2]  | ... |
> >     |  buf_size  |  buf_size |  buf_size | ... |
> >     +--------- --+-----------+-----------+-----+
> >
> > buffer ring state (struct fuse_bufring, kernel-internal):
> > bufs[]: [ used | used | FREE | FREE | FREE ]
> >                       ^^^^^^^^^^^^^^^^^^^
> >                       available for selection
> >
> > The buffer ring logic is as follows:
> > select:  buf =3D bufs[head % nbufs]; head++
> > recycle: bufs[tail % nbufs] =3D buf; tail++
> > empty:   tail =3D=3D head (no buffers available)
> > full:    tail - head >=3D nbufs
> >
> > Buffer ring request flow
> > ------------------------
> > >  Kernel                                  |  FUSE daemon
> > >                                          |
> > >  [client request arrives]                |
> > >  >fuse_uring_send()                      |
> > >    [select payload buf from ring]        |
> > >    >fuse_uring_select_buffer()           |
> > >    [copy headers to ent's header slot]   |
> > >    >copy_header_to_ring()                |
> > >    [copy payload to selected buf]        |
> > >    >fuse_uring_copy_to_ring()            |
> > >    [set buf_id in ent_in_out header]     |
> > >    >io_uring_cmd_done()                  |
> > >                                          |  [CQE received]
> > >                                          |  [read headers from header
> > >                                          |    slot]
> > >                                          |  [read payload from buf_id=
]
> > >                                          |  [process request]
> > >                                          |  [write reply to header
> > >                                          |    slot]
> > >                                          |  [write reply payload to
> > >                                          |    buf]
> > >                                          |  >io_uring_submit()
> > >                                          |   COMMIT_AND_FETCH
> > >  >fuse_uring_commit_fetch()              |
> > >    >fuse_uring_commit()                  |
> > >     [copy reply from ring]               |
> > >     >fuse_uring_recycle_buffer()         |
> > >    >fuse_uring_get_next_fuse_req()       |
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c       | 363 +++++++++++++++++++++++++++++++++-----
> >  fs/fuse/dev_uring_i.h     |  45 ++++-
> >  include/uapi/linux/fuse.h |  27 ++-
> >  3 files changed, 381 insertions(+), 54 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index a061f175b3fd..9f14a2bcde3f 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -41,6 +41,11 @@ enum fuse_uring_header_type {
> >       FUSE_URING_HEADER_RING_ENT,
> >  };
> >
> > +static inline bool bufring_enabled(struct fuse_ring_queue *queue)
> > +{
> > +     return queue->bufring !=3D NULL;
> > +}
> > +
> >  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
> >                                  struct fuse_ring_ent *ring_ent)
> >  {
> > @@ -222,6 +227,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
> >               }
> >
> >               kfree(queue->fpq.processing);
> > +             kfree(queue->bufring);
> >               kfree(queue);
> >               ring->queues[qid] =3D NULL;
> >       }
> > @@ -303,20 +309,102 @@ static int fuse_uring_get_iovec_from_sqe(const s=
truct io_uring_sqe *sqe,
> >       return 0;
> >  }
> >
> > -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_rin=
g *ring,
> > -                                                    int qid)
> > +static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
> > +                                  struct fuse_ring_queue *queue)
> > +{
> > +     const struct fuse_uring_cmd_req *cmd_req =3D
> > +             io_uring_sqe128_cmd(cmd->sqe, struct fuse_uring_cmd_req);
> > +     u16 queue_depth =3D READ_ONCE(cmd_req->init.queue_depth);
> > +     unsigned int buf_size =3D READ_ONCE(cmd_req->init.buf_size);
> > +     struct iovec iov[FUSE_URING_IOV_SEGS];
> > +     void __user *payload, *headers;
> > +     size_t headers_size, payload_size, ring_size;
> > +     struct fuse_bufring *br;
> > +     unsigned int nr_bufs, i;
> > +     uintptr_t payload_addr;
> > +     int err;
> > +
> > +     if (!queue_depth || !buf_size)
> > +             return -EINVAL;
> > +
> > +     err =3D fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> > +     if (err)
> > +             return err;
> > +
> > +     headers =3D iov[FUSE_URING_IOV_HEADERS].iov_base;
> > +     headers_size =3D iov[FUSE_URING_IOV_HEADERS].iov_len;
> > +     payload =3D iov[FUSE_URING_IOV_PAYLOAD].iov_base;
> > +     payload_size =3D iov[FUSE_URING_IOV_PAYLOAD].iov_len;
> > +
> > +     /* check if there's enough space for all the headers */
> > +     if (headers_size < queue_depth * sizeof(struct fuse_uring_req_hea=
der))
> > +             return -EINVAL;
> > +
> > +     if (buf_size < queue->ring->max_payload_sz)
> > +             return -EINVAL;
> > +
> > +     nr_bufs =3D payload_size / buf_size;
> > +     if (!nr_bufs || nr_bufs > U16_MAX)
>
> What's the significance of U16_MAX here? It looks like the br->nbufs
> field is an unsigned int. Is it because struct fuse_uring_ent_in_out
> has buf_id as a u16?

Yes, this is because in the uapi, struct fuse_uring_ent_in_out's
buf_id field is set to a uint16_t.

>
> Not that I think you'll ever need more than 2^16 buffers, just curious
> about the limitation.
>
> > +             return -EINVAL;
> > +
> > +     /* create the ring buffer */
> > +     ring_size =3D struct_size(br, bufs, nr_bufs);
> > +     br =3D kzalloc(ring_size, GFP_KERNEL_ACCOUNT);
> > +     if (!br)
> > +             return -ENOMEM;
> > +
> > +     br->queue_depth =3D queue_depth;
> > +     br->headers =3D headers;
> > +
> > +     payload_addr =3D (uintptr_t)payload;
> > +
> > +     /* populate the ring buffer */
> > +     for (i =3D 0; i < nr_bufs; i++, payload_addr +=3D buf_size) {
> > +             struct fuse_bufring_buf *buf =3D &br->bufs[i];
> > +
> > +             buf->addr =3D payload_addr;
> > +             buf->len =3D buf_size;
> > +             buf->id =3D i;
> > +     }
> > +
> > +     br->nbufs =3D nr_bufs;
> > +     br->tail =3D nr_bufs;
> > +
> > +     queue->bufring =3D br;
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * if the queue is already registered, check that the queue was initia=
lized with
> > + * the same init flags set for this FUSE_IO_URING_CMD_REGISTER cmd. al=
l
> > + * FUSE_IO_URING_CMD_REGISTER cmds should have the same init fields se=
t on a
> > + * per-queue basis.
> > + */
> > +static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
> > +                                     u64 init_flags)
> >  {
> > +     bool bufring =3D init_flags & FUSE_URING_BUFRING;
> > +
> > +     return bufring_enabled(queue) =3D=3D bufring;
> > +}
> > +
> > +static struct fuse_ring_queue *
> > +fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ri=
ng,
> > +                     int qid, u64 init_flags)
> > +{
> > +     bool use_bufring =3D init_flags & FUSE_URING_BUFRING;
> >       struct fuse_conn *fc =3D ring->fc;
> >       struct fuse_ring_queue *queue;
> >       struct list_head *pq;
> >
> >       queue =3D kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
> >       if (!queue)
> > -             return NULL;
> > +             return ERR_PTR(-ENOMEM);
> >       pq =3D kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
> >       if (!pq) {
> >               kfree(queue);
> > -             return NULL;
> > +             return ERR_PTR(-ENOMEM);
> >       }
> >
> >       queue->qid =3D qid;
> > @@ -334,12 +422,29 @@ static struct fuse_ring_queue *fuse_uring_create_=
queue(struct fuse_ring *ring,
> >       queue->fpq.processing =3D pq;
> >       fuse_pqueue_init(&queue->fpq);
> >
> > +     if (use_bufring) {
> > +             int err =3D fuse_uring_bufring_setup(cmd, queue);
> > +
> > +             if (err) {
> > +                     kfree(pq);
> > +                     kfree(queue);
> > +                     return ERR_PTR(err);
> > +             }
> > +     }
> > +
> >       spin_lock(&fc->lock);
> > +     /* check if the queue creation raced with another thread */
> >       if (ring->queues[qid]) {
> >               spin_unlock(&fc->lock);
> >               kfree(queue->fpq.processing);
> > +             if (use_bufring)
> > +                     kfree(queue->bufring);
>
> nit: presumably you could skip the if here. If use_bufring is false,
> then queue->bufring _should_ be NULL.

I will drop this if check in the next version.

Thank you for taking the time to review this series.

Thanks,
Joanne
>
> >               kfree(queue);
> > -             return ring->queues[qid];
> > +
> > +             queue =3D ring->queues[qid];
> > +             if (!queue_init_flags_consistent(queue, init_flags))
> > +                     return ERR_PTR(-EINVAL);
> > +             return queue;
> >       }
> >
> >       /*
> > @@ -649,7 +754,14 @@ static int copy_header_to_ring(struct fuse_ring_en=
t *ent,
> >       if (offset < 0)
> >               return offset;
> >
> > -     ring =3D (void __user *)ent->headers + offset;
> > +     if (bufring_enabled(ent->queue)) {
> > +             int buf_offset =3D offset +
> > +                     sizeof(struct fuse_uring_req_header) * ent->id;
> > +
> > +             ring =3D ent->queue->bufring->headers + buf_offset;
> > +     } else {
> > +             ring =3D (void __user *)ent->headers + offset;
> > +     }
> >
> >       if (copy_to_user(ring, header, header_size)) {
> >               pr_info_ratelimited("Copying header to ring failed.\n");
> > @@ -669,7 +781,14 @@ static int copy_header_from_ring(struct fuse_ring_=
ent *ent,
> >       if (offset < 0)
> >               return offset;
> >
> > -     ring =3D (void __user *)ent->headers + offset;
> > +     if (bufring_enabled(ent->queue)) {
> > +             int buf_offset =3D offset +
> > +                     sizeof(struct fuse_uring_req_header) * ent->id;
> > +
> > +             ring =3D ent->queue->bufring->headers + buf_offset;
> > +     } else {
> > +             ring =3D (void __user *)ent->headers + offset;
> > +     }
> >
> >       if (copy_from_user(header, ring, header_size)) {
> >               pr_info_ratelimited("Copying header from ring failed.\n")=
;
> > @@ -684,12 +803,20 @@ static int setup_fuse_copy_state(struct fuse_copy=
_state *cs,
> >                                struct fuse_ring_ent *ent, int dir,
> >                                struct iov_iter *iter)
> >  {
> > +     void __user *payload;
> >       int err;
> >
> > -     err =3D import_ubuf(dir, ent->payload, ring->max_payload_sz, iter=
);
> > -     if (err) {
> > -             pr_info_ratelimited("fuse: Import of user buffer failed\n=
");
> > -             return err;
> > +     if (bufring_enabled(ent->queue))
> > +             payload =3D (void __user *)ent->payload_buf.addr;
> > +     else
> > +             payload =3D ent->payload;
> > +
> > +     if (payload) {
> > +             err =3D import_ubuf(dir, payload, ring->max_payload_sz, i=
ter);
> > +             if (err) {
> > +                     pr_info_ratelimited("fuse: Import of user buffer =
failed\n");
> > +                     return err;
> > +             }
> >       }
> >
> >       fuse_copy_init(cs, dir =3D=3D ITER_DEST, iter);
> > @@ -741,6 +868,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring=
 *ring, struct fuse_req *req,
> >               .commit_id =3D req->in.h.unique,
> >       };
> >
> > +     if (bufring_enabled(ent->queue))
> > +             ent_in_out.buf_id =3D ent->payload_buf.id;
> > +
> >       err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &it=
er);
> >       if (err)
> >               return err;
> > @@ -805,6 +935,96 @@ static int fuse_uring_copy_to_ring(struct fuse_rin=
g_ent *ent,
> >                                  sizeof(req->in.h));
> >  }
> >
> > +static bool fuse_uring_req_has_payload(struct fuse_req *req)
> > +{
> > +     struct fuse_args *args =3D req->args;
> > +
> > +     return args->in_numargs > 1 || args->out_numargs;
> > +}
> > +
> > +static int fuse_uring_select_buffer(struct fuse_ring_ent *ent)
> > +     __must_hold(&ent->queue->lock)
> > +{
> > +     struct fuse_ring_queue *queue =3D ent->queue;
> > +     struct fuse_bufring *br =3D queue->bufring;
> > +     struct fuse_bufring_buf *buf;
> > +     unsigned int tail =3D br->tail, head =3D br->head;
> > +
> > +     lockdep_assert_held(&queue->lock);
> > +
> > +     /* Get a buffer to use for the payload */
> > +     if (tail =3D=3D head)
> > +             return -ENOBUFS;
> > +
> > +     buf =3D &br->bufs[head % br->nbufs];
> > +     br->head++;
> > +
> > +     ent->payload_buf =3D *buf;
> > +
> > +     return 0;
> > +}
> > +
> > +static void fuse_uring_recycle_buffer(struct fuse_ring_ent *ent)
> > +     __must_hold(&ent->queue->lock)
> > +{
> > +     struct fuse_bufring_buf *ent_payload =3D &ent->payload_buf;
> > +     struct fuse_ring_queue *queue =3D ent->queue;
> > +     struct fuse_bufring_buf *buf;
> > +     struct fuse_bufring *br;
> > +
> > +     lockdep_assert_held(&queue->lock);
> > +
> > +     if (!bufring_enabled(queue) || !ent_payload->addr)
> > +             return;
> > +
> > +     br =3D queue->bufring;
> > +
> > +     /* ring should never be full */
> > +     WARN_ON_ONCE(br->tail - br->head >=3D br->nbufs);
> > +
> > +     buf =3D &br->bufs[(br->tail) % br->nbufs];
> > +
> > +     *buf =3D *ent_payload;
> > +
> > +     br->tail++;
> > +
> > +     memset(ent_payload, 0, sizeof(*ent_payload));
> > +}
> > +
> > +static int fuse_uring_next_req_update_buffer(struct fuse_ring_ent *ent=
,
> > +                                          struct fuse_req *req)
> > +{
> > +     bool buffer_selected;
> > +     bool has_payload;
> > +
> > +     if (!bufring_enabled(ent->queue))
> > +             return 0;
> > +
> > +     buffer_selected =3D !!ent->payload_buf.addr;
> > +     has_payload =3D fuse_uring_req_has_payload(req);
> > +
> > +     if (has_payload && !buffer_selected)
> > +             return fuse_uring_select_buffer(ent);
> > +
> > +     if (!has_payload && buffer_selected)
> > +             fuse_uring_recycle_buffer(ent);
> > +
> > +     return 0;
> > +}
> > +
> > +static int fuse_uring_prep_buffer(struct fuse_ring_ent *ent,
> > +                               struct fuse_req *req)
> > +{
> > +     if (!bufring_enabled(ent->queue))
> > +             return 0;
> > +
> > +     /* no payload to copy, can skip selecting a buffer */
> > +     if (!fuse_uring_req_has_payload(req))
> > +             return 0;
> > +
> > +     return fuse_uring_select_buffer(ent);
> > +}
> > +
> >  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
> >                                  struct fuse_req *req)
> >  {
> > @@ -878,10 +1098,21 @@ static struct fuse_req *fuse_uring_ent_assign_re=
q(struct fuse_ring_ent *ent)
> >
> >       /* get and assign the next entry while it is still holding the lo=
ck */
> >       req =3D list_first_entry_or_null(req_queue, struct fuse_req, list=
);
> > -     if (req)
> > -             fuse_uring_add_req_to_ring_ent(ent, req);
> > +     if (req) {
> > +             int err =3D fuse_uring_next_req_update_buffer(ent, req);
> >
> > -     return req;
> > +             if (!err) {
> > +                     fuse_uring_add_req_to_ring_ent(ent, req);
> > +                     return req;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * Buffer selection may fail if all the buffers are currently sat=
urated.
> > +      * The request will be serviced when a buffer is freed up.
> > +      */
> > +     fuse_uring_recycle_buffer(ent);
> > +     return NULL;
> >  }
> >
> >  /*
> > @@ -1041,6 +1272,12 @@ static int fuse_uring_commit_fetch(struct io_uri=
ng_cmd *cmd, int issue_flags,
> >        * fuse requests would otherwise not get processed - committing
> >        * and fetching is done in one step vs legacy fuse, which has sep=
arated
> >        * read (fetch request) and write (commit result).
> > +      *
> > +      * If the server is using bufrings and has populated the ring wit=
h less
> > +      * payload buffers than ents, it is possible that there may not b=
e an
> > +      * available buffer for the next request. If so, then the fetch i=
s a
> > +      * no-op and the next request will be serviced when a buffer beco=
mes
> > +      * available.
> >        */
> >       if (fuse_uring_get_next_fuse_req(ent, queue))
> >               fuse_uring_send(ent, cmd, 0, issue_flags);
> > @@ -1120,30 +1357,38 @@ fuse_uring_create_ring_ent(struct io_uring_cmd =
*cmd,
> >
> >       ent->queue =3D queue;
> >
> > -     err =3D fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> > -     if (err) {
> > -             pr_info_ratelimited("Failed to get iovec from sqe, err=3D=
%d\n",
> > -                                 err);
> > -             goto error;
> > -     }
> > +     if (bufring_enabled(queue)) {
> > +             ent->id =3D READ_ONCE(cmd->sqe->buf_index);
> > +             if (ent->id >=3D queue->bufring->queue_depth) {
> > +                     err =3D -EINVAL;
> > +                     goto error;
> > +             }
> > +     } else {
> > +             err =3D fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> > +             if (err) {
> > +                     pr_info_ratelimited("Failed to get iovec from sqe=
, err=3D%d\n",
> > +                                         err);
> > +                     goto error;
> > +             }
> >
> > -     err =3D -EINVAL;
> > -     headers =3D &iov[FUSE_URING_IOV_HEADERS];
> > -     if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
> > -             pr_info_ratelimited("Invalid header len %zu\n", headers->=
iov_len);
> > -             goto error;
> > -     }
> > +             err =3D -EINVAL;
> > +             headers =3D &iov[FUSE_URING_IOV_HEADERS];
> > +             if (headers->iov_len < sizeof(struct fuse_uring_req_heade=
r)) {
> > +                     pr_info_ratelimited("Invalid header len %zu\n",
> > +                                         headers->iov_len);
> > +                     goto error;
> > +             }
> >
> > -     payload =3D &iov[FUSE_URING_IOV_PAYLOAD];
> > -     if (payload->iov_len < ring->max_payload_sz) {
> > -             pr_info_ratelimited("Invalid req payload len %zu\n",
> > -                                 payload->iov_len);
> > -             goto error;
> > +             payload =3D &iov[FUSE_URING_IOV_PAYLOAD];
> > +             if (payload->iov_len < ring->max_payload_sz) {
> > +                     pr_info_ratelimited("Invalid req payload len %zu\=
n",
> > +                                         payload->iov_len);
> > +                     goto error;
> > +             }
> > +             ent->headers =3D headers->iov_base;
> > +             ent->payload =3D payload->iov_base;
> >       }
> >
> > -     ent->headers =3D headers->iov_base;
> > -     ent->payload =3D payload->iov_base;
> > -
> >       atomic_inc(&ring->queue_refs);
> >       return ent;
> >
> > @@ -1152,6 +1397,13 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *=
cmd,
> >       return ERR_PTR(err);
> >  }
> >
> > +static bool init_flags_valid(u64 init_flags)
> > +{
> > +     u64 valid_flags =3D FUSE_URING_BUFRING;
> > +
> > +     return !(init_flags & ~valid_flags);
> > +}
> > +
> >  /*
> >   * Register header and payload buffer with the kernel and puts the
> >   * entry as "ready to get fuse requests" on the queue
> > @@ -1161,6 +1413,7 @@ static int fuse_uring_register(struct io_uring_cm=
d *cmd,
> >  {
> >       const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sqe128_cmd(=
cmd->sqe,
> >                                                                      st=
ruct fuse_uring_cmd_req);
> > +     u64 init_flags =3D READ_ONCE(cmd_req->flags);
> >       struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
> >       struct fuse_ring_queue *queue;
> >       struct fuse_ring_ent *ent;
> > @@ -1179,11 +1432,16 @@ static int fuse_uring_register(struct io_uring_=
cmd *cmd,
> >               return -EINVAL;
> >       }
> >
> > +     if (!init_flags_valid(init_flags))
> > +             return -EINVAL;
> > +
> >       queue =3D ring->queues[qid];
> >       if (!queue) {
> > -             queue =3D fuse_uring_create_queue(ring, qid);
> > -             if (!queue)
> > -                     return err;
> > +             queue =3D fuse_uring_create_queue(cmd, ring, qid, init_fl=
ags);
> > +             if (IS_ERR(queue))
> > +                     return PTR_ERR(queue);
> > +     } else if (!queue_init_flags_consistent(queue, init_flags)) {
> > +             return -EINVAL;
> >       }
> >
> >       /*
> > @@ -1349,14 +1607,18 @@ void fuse_uring_queue_fuse_req(struct fuse_ique=
ue *fiq, struct fuse_req *req)
> >       req->ring_queue =3D queue;
> >       ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
> >                                      struct fuse_ring_ent, list);
> > -     if (ent)
> > -             fuse_uring_add_req_to_ring_ent(ent, req);
> > -     else
> > -             list_add_tail(&req->list, &queue->fuse_req_queue);
> > -     spin_unlock(&queue->lock);
> > +     if (ent) {
> > +             err =3D fuse_uring_prep_buffer(ent, req);
> > +             if (!err) {
> > +                     fuse_uring_add_req_to_ring_ent(ent, req);
> > +                     spin_unlock(&queue->lock);
> > +                     fuse_uring_dispatch_ent(ent);
> > +                     return;
> > +             }
> > +     }
> >
> > -     if (ent)
> > -             fuse_uring_dispatch_ent(ent);
> > +     list_add_tail(&req->list, &queue->fuse_req_queue);
> > +     spin_unlock(&queue->lock);
> >
> >       return;
> >
> > @@ -1406,14 +1668,17 @@ bool fuse_uring_queue_bq_req(struct fuse_req *r=
eq)
> >       req =3D list_first_entry_or_null(&queue->fuse_req_queue, struct f=
use_req,
> >                                      list);
> >       if (ent && req) {
> > -             fuse_uring_add_req_to_ring_ent(ent, req);
> > -             spin_unlock(&queue->lock);
> > +             int err =3D fuse_uring_prep_buffer(ent, req);
> >
> > -             fuse_uring_dispatch_ent(ent);
> > -     } else {
> > -             spin_unlock(&queue->lock);
> > +             if (!err) {
> > +                     fuse_uring_add_req_to_ring_ent(ent, req);
> > +                     spin_unlock(&queue->lock);
> > +                     fuse_uring_dispatch_ent(ent);
> > +                     return true;
> > +             }
> >       }
> >
> > +     spin_unlock(&queue->lock);
> >       return true;
> >  }
> >
> > diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> > index 349418db3374..66d5d5f8dc3f 100644
> > --- a/fs/fuse/dev_uring_i.h
> > +++ b/fs/fuse/dev_uring_i.h
> > @@ -36,11 +36,47 @@ enum fuse_ring_req_state {
> >       FRRS_RELEASED,
> >  };
> >
> > +struct fuse_bufring_buf {
> > +     uintptr_t addr;
> > +     unsigned int len;
> > +     unsigned int id;
> > +};
> > +
> > +struct fuse_bufring {
> > +     /* pointer to the headers buffer */
> > +     void __user *headers;
> > +
> > +     unsigned int queue_depth;
> > +
> > +     /* metadata tracking state of the bufring */
> > +     unsigned int nbufs;
> > +     unsigned int head;
> > +     unsigned int tail;
> > +
> > +     /* the buffers backing the ring */
> > +     __DECLARE_FLEX_ARRAY(struct fuse_bufring_buf, bufs);
> > +};
> > +
> >  /** A fuse ring entry, part of the ring queue */
> >  struct fuse_ring_ent {
> > -     /* userspace buffer */
> > -     struct fuse_uring_req_header __user *headers;
> > -     void __user *payload;
> > +     union {
> > +             /* if bufrings are not used */
> > +             struct {
> > +                     /* userspace buffers */
> > +                     struct fuse_uring_req_header __user *headers;
> > +                     void __user *payload;
> > +             };
> > +             /* if bufrings are used */
> > +             struct {
> > +                     /*
> > +                      * unique fixed id for the ent. used by kernel/se=
rver to
> > +                      * locate where in the headers buffer the data fo=
r this
> > +                      * ent resides
> > +                      */
> > +                     unsigned int id;
> > +                     struct fuse_bufring_buf payload_buf;
> > +             };
> > +     };
> >
> >       /* the ring queue that owns the request */
> >       struct fuse_ring_queue *queue;
> > @@ -99,6 +135,9 @@ struct fuse_ring_queue {
> >       unsigned int active_background;
> >
> >       bool stopped;
> > +
> > +     /* only allocated if the server uses bufrings */
> > +     struct fuse_bufring *bufring;
> >  };
> >
> >  /**
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index c13e1f9a2f12..8753de7eb189 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -240,6 +240,10 @@
> >   *  - add FUSE_COPY_FILE_RANGE_64
> >   *  - add struct fuse_copy_file_range_out
> >   *  - add FUSE_NOTIFY_PRUNE
> > + *
> > + *  7.46
> > + *  - add FUSE_URING_BUFRING flag
> > + *  - add fuse_uring_cmd_req init struct
> >   */
> >
> >  #ifndef _LINUX_FUSE_H
> > @@ -1263,7 +1267,13 @@ struct fuse_uring_ent_in_out {
> >
> >       /* size of user payload buffer */
> >       uint32_t payload_sz;
> > -     uint32_t padding;
> > +
> > +     /*
> > +      * if using bufrings, this is the id of the selected buffer.
> > +      * the selected buffer holds the request payload
> > +      */
> > +     uint16_t buf_id;
> > +     uint16_t padding;
> >
> >       uint64_t reserved;
> >  };
> > @@ -1294,6 +1304,9 @@ enum fuse_uring_cmd {
> >       FUSE_IO_URING_CMD_COMMIT_AND_FETCH =3D 2,
> >  };
> >
> > +/* fuse_uring_cmd_req flags */
> > +#define FUSE_URING_BUFRING           (1 << 0)
> > +
> >  /**
> >   * In the 80B command area of the SQE.
> >   */
> > @@ -1305,7 +1318,17 @@ struct fuse_uring_cmd_req {
> >
> >       /* queue the command is for (queue index) */
> >       uint16_t qid;
> > -     uint8_t padding[6];
> > +     uint16_t padding;
> > +
> > +     union {
> > +             struct {
> > +                     /* size of the bufring's backing buffers */
> > +                     uint32_t buf_size;
> > +                     /* number of entries in the queue */
> > +                     uint16_t queue_depth;
> > +                     uint16_t padding;
> > +             } init;
> > +     };
> >  };
> >
> >  #endif /* _LINUX_FUSE_H */
>
> Overall, this looks good though.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
