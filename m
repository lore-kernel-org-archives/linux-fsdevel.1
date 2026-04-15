Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54A38A727
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776289218; cv=pass; b=MgnKsJOSKVg6XJ+KylezNy3TawIbMuxp33O+f6AIRnDVsBqViQ4S/IZPLJOzFzjnO4l62lKu4yIc8V4wgIFUUjnRvwlTcpNXX2sgMyI6shp/1GqgfWUW6Uib4r/+4ggUftznSTybmwuXuUNVNv8N68uzZ0m9UWEFhxH41SmMHe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776289218; c=relaxed/simple;
	bh=BfxWaS03QavzR6RQOsGUS7baFHXQLvUh1CH1oKeY8GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sF6Hq0CvUZ45SgY2qVlq5mlRKvo1IhJFlNkJQlNX8xue47lq2nhhs47nhUbI2fzkLSpGjNBgN+LltbrleLu49tI7b3R7sCOlt5fIdX/OJtTFLX5c+7q/J3f2gUXFxJkxSqDV7k5A6RNBaL4ZVOu3hsZwV2oY/Gi8EYnnaLbzhvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eixzv1x9; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eixzv1x9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so7372767f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 14:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776289215; cv=none;
        d=google.com; s=arc-20240605;
        b=IYFEMeKyhQRquX2f3GQJ8jEKhj4286ZxjS+/oPVXgb+774glXtdFjXtF2DRqzVBr+Q
         nKtW3umGojaeV/nFCNaKN/K17rIgkSNCH6PXFrRp4ma/g4PAYUDeuy+dhEYSDHihy1vD
         oNS8jcmAe8e5ohc+6h7mQFtzhUHtNNwqP/kB0a82pR5S1zqIdEgS7Xnls5oVEEmuUC6W
         godZHOa93iRgozHUnxShY8+ltiJ3vcwAQpLOAIOHDGPVpc/6oLe5eeB1j1ldqSs0jPim
         Rg1PS8VHI/NCsTao5G5YbWfuYdVfR5/hNAMhEFWoh5h1L0oM7pZASVqs3nfOC5L68w7k
         zbjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6/sbgt3goJpXeAIdY+603XnfW9J92SkHyWjPdUU2Hoo=;
        fh=uI/TRr0VVHuiRFDcFwUis5XVDmpc3ob7G+3FdioRhbM=;
        b=Vn+avbF98sxJfdw0gDwBt0lsVd9yprd2eTxwzSX5w4eRLch6dBpGFNjBdxbh7fjZj+
         r0p8YR5XfcRXTbTqKbWameEDL+T3MKNO46VDKQQkdKFuGfg8baVhtzw6XspFFmYnhSyV
         LopZh0h88YMAJ2QZDJoNiOm54ExRG8gGcGLfCVL7ba/dq7PxwIs8V4eMgZ6bcloDrRel
         xxj3m8u0m1IcHj0FhM5RyqUX2IjqD76RMS68yoB62pKGPNkrcLbiZ89vT4Kli1Z/qdCM
         34mTIFBQp6cz/39gR5o7ktoScgPQ1CgbVjQ3IBcwV9/vued7yfY1dMpPWKm5FURN5+iO
         /nfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776289215; x=1776894015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/sbgt3goJpXeAIdY+603XnfW9J92SkHyWjPdUU2Hoo=;
        b=Eixzv1x9dKXleWw035nb+0/2h7PlzOcv9eDKHaqbHoSGRDKuBfZ0CCvN1EhlT9rUWd
         BvANwEsoNro4RHiTGpYt/b5tI88yJR/P+ObBcBHxRDSd5U2e/3UvV7cLSp4i46ufccHH
         Z2PukSmLpLQXzy7xvDKlxYgAU3SFhicViwf7lTl/zCWBFIA/kqfJBnlRCXNrLTyrWek2
         T0+l0vzwMx7A2BfDyFYHCpd60qD3fizQFoqIMlkZ3BId/xDSvVvro4hzW5u6H/j+Jzip
         KRpVPsX/uXotbwZtzs1Ej7J9vzaAR+nTxUnXVVXxi8lLxoWjBTEPi2orFVTkL/nSwzZb
         LKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776289215; x=1776894015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6/sbgt3goJpXeAIdY+603XnfW9J92SkHyWjPdUU2Hoo=;
        b=W/7TTKOJm1T5tHx/pGDwWln3vPmUn75aKmFzPgmQR2wNP7/P89XFciR56UzBiV2X8w
         gqsaos9iPxN6PSUATjboScv4+Bgqgz+DiyImoxHVHsdopKT6GcyoAkhZOCbZU4UvTsQ3
         7IQ5zcBg0ctCh5c5KCMvOBdpLke9WXUjdG6PteDxL8zVGZRFJQD5T7wszMG/I26JMOur
         WpqzpqAA/dy9svzW/wG/2hsPWXVpfYt4cC6WVRdVDWfKuD00/OlCNjs07//UgtmeF88Z
         riCXIRboE59A1LyF3noe4e0F+YILyTlNxlGCbOPeGc1OVeFnZKp0viZc+3P8rwyRwGNK
         VlHg==
X-Forwarded-Encrypted: i=1; AFNElJ8sx3gGChZHAhYvMukb74ETwC9GXRZJaJ1XmjNEAHbjdimGtiHV3Kuc7ZGsFU8bnDgltlOIOUbFcZYXz0km@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzny3EzLnReDyNJoSmd0rnewrA6/6Km2HvhaD7IgDY4TdD8hG
	QPoI0BK4ALvfvZ2/iP0fvpJ/XGJ92OeOwkUqb8FMljQPdFnPWZ0AI+zIFWA05GUIRJCAeIygOtU
	LEPoIOS3FL3sZnvTR89FlAXyrGSdDeuosgotF
X-Gm-Gg: AeBDieuB3dNvNwPqZEvEpL4tQ7e4Wz1tG9cESvAj3uByEVzeWADEaLM4XiY5uM9jHPj
	w3JjrSpWaK8V0M1s/IRpb7TN2p7Xs0bGuLDvzametNI9cAKBY2EVunFPB6VVuifiluQT4SUDIGY
	AlwOZP0bu3SHAQ6mZHa6zeP6RbILPso0eUb0yjM76zp2R6BJXj7D1IlZT7KpM0qElzlVivcJwKU
	A68R/e60EYeLPNpjdejGw8cIMtijsJn+VzaoJyUlyRR5XL5JMtEklIcf19q1pBJsy0AMmKAeMHw
	nE/gf/pkZiP76yuD
X-Received: by 2002:a05:6000:24c2:b0:43d:303f:f358 with SMTP id
 ffacd0b85a97d-43d64286bbemr34104492f8f.2.1776289215067; Wed, 15 Apr 2026
 14:40:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-11-joannelkoong@gmail.com> <e49aab72-4ac0-499f-ba84-b64601cd9b2f@bsbernd.com>
In-Reply-To: <e49aab72-4ac0-499f-ba84-b64601cd9b2f@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Apr 2026 14:40:02 -0700
X-Gm-Features: AQROBzD5ezRxz1E7KfsRyGG2iwNlCuWm64bFl9SyDKVbntp1L-ZM6IQYeN3XyOo
Message-ID: <CAJnrk1bRYivZfHou81dFzdbe2L47d71c+Wdy8O7bHLbkQD57GA@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] fuse: add io-uring buffer rings
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 2:48=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
> On 4/2/26 18:28, Joanne Koong wrote:
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
> > |<- headers_size (>=3D queue_depth * sizeof(fuse_uring_req_header)) ->|
> > +------------------------------+------------------------------+-----+
> > | struct fuse_uring_req_header | struct fuse_uring_req_header | ... |
> > |        [ent id=3D0]            |        [ent id=3D1]            |    =
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
> > |  Kernel                                  |  FUSE daemon
> > |                                          |
> > |  [client request arrives]                |
> > |  >fuse_uring_send()                      |
> > |    [select payload buf from ring]        |
> > |    >fuse_uring_select_buffer()           |
> > |    [copy headers to ent's header slot]   |
> > |    >copy_header_to_ring()                |
> > |    [copy payload to selected buf]        |
> > |    >fuse_uring_copy_to_ring()            |
> > |    [set buf_id in ent_in_out header]     |
> > |    >io_uring_cmd_done()                  |
> > |                                          |  [CQE received]
> > |                                          |  [read headers from header
> > |                                          |    slot]
> > |                                          |  [read payload from buf_id=
]
> > |                                          |  [process request]
> > |                                          |  [write reply to header
> > |                                          |    slot]
> > |                                          |  [write reply payload to
> > |                                          |    buf]
> > |                                          |  >io_uring_submit()
> > |                                          |   COMMIT_AND_FETCH
> > |  >fuse_uring_commit_fetch()              |
> > |    >fuse_uring_commit()                  |
> > |     [copy reply from ring]               |
> > |     >fuse_uring_recycle_buffer()         |
> > |    >fuse_uring_get_next_fuse_req()       |
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
>
> Could we call this 'max_queue_depth'? I still think that it might be
> useful to register ring entries dynamically when needed at some point.
> And then this would become a 'max' value and not the actual value.

Sounds good, I will rename this (and the one below) to
max_queue_depth. Thanks for taking a look at the patches.

Thanks,
Joanne
>
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
>
> If you agree to change, also needs to be changed here
>
> > +                     uint16_t padding;
> > +             } init;
> > +     };
> >  };
> >
> >  #endif /* _LINUX_FUSE_H */
>
>
> Thanks,
> Bernd
