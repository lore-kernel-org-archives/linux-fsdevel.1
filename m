Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499403BB48
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774912806; cv=pass; b=OsklVE1L/0LlAYqcnDfVINBQXwIGJ39/9KD1pcyTTn+vM/6jPh4kG5xxMkXukt/nll5ZzPQweQADCthHA5swU81BIXCQuIwKWWrHpkQAEhlYf6qvTyWRaOai6Q8QyZor7CcFW5uB5l7RtwiCdm80yYmdyeI1jjniWjrX5uKnM/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774912806; c=relaxed/simple;
	bh=WbOv22VRnLbpqp5AlrIBLVScP0nbTr5MT0k4b22JuB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHf8/Ll6mQUVvbWNxALjSOfDe9V4Cw8tnnIDreRNp4y7CLkhcuKG+9RYDcYMDPViQUY7b3w81BsqPrsfHXSAvKhFgSPK1rmOHUgweO7rjTDZvE4IuHToWcSYzNt2S3DoM53is/O/fBpu5ZKUHXgWMvJlrNwrdvBDbeMs4o3Nd7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK7KCiQP; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK7KCiQP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso2881011f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 16:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774912804; cv=none;
        d=google.com; s=arc-20240605;
        b=YFdSkzhOeDXUI+Mat5o9Qs6ttdSLWxO1vl9OmSZsn7lAA7xHGhKthBXhGYSP2+mATp
         alXSuOX1PTcdVIRde4HgCZ7FaFKcdi8wb3YDhdWTDY2FENVLDbA6tGrUdpolCaj8TfAN
         LLqRhfvUESmRoRNeCCIyMREtjscKl+M1CRjT0lfGbGp8w9c1Nx5mD3sVVdLCdHaOMFqv
         sf5Py8lIVybva2VTDSdFOMiGTOhjmZQoDYLMnkQ83x616bNi8yD4IkeUKsrd5g110knn
         oCxgTbdblmR2+goxxpfaKl564gHGjj54olcTQ5DxtvtmyDwwEEOuNZG3zHrsXNJDI8L+
         +RNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7nVm/haVDLplgMTbOsS8tMMdmmzBvf/nT8hehniaBnU=;
        fh=ZiAyBwQHtRi31w6i3drkg749oalgcKl/sweg+n8cS+w=;
        b=MnU3rWqFb014+VjsuiX+ZQIYFRGhyQM+MF+8d5gW2aXZsn7AQ89e9R0x2kQ2M9dqjp
         ebCYyGCtBhmcFRdArBa+h+uTmPi77VLTHNa0+TuVB9gMI4lbMSeEg8h5ijtqTmC/cl65
         sxkxZbEd4p9GWdRShxNfSwnd4clKpvSkF3AQkkyP+wMG1b7p8CSUaKmGA1eQcAgpwKWG
         6rk0Y7k81qWYUHGF0VDXy9A7/zXkzI82lqsco32VNZ1uZjMs7l6nTUYgnxvy68vVog+I
         wgX4D3BhiyI8E9u07IcO3DWLQ0L/1t+x0qQM0rWg14CXTcxFZsS21OG52vmaC9MlAlzq
         pYaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774912804; x=1775517604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nVm/haVDLplgMTbOsS8tMMdmmzBvf/nT8hehniaBnU=;
        b=DK7KCiQPPp9BoiLNI5maVl71iJ4aSbUJOgaQy/KDkafeKYAeLye6sgFHpPFI2s8vus
         f/IBMLN55KTdRbNDEhs5Xb+xolf1lI2ILyi5aO3oXjpcTutoicrXggBp+ND5li+fYepw
         0GHHBl+Je2RvoRsm+tqT0FJe+K3vN/GDNNa1OO1YhBkmo7y2mMPIBCtUkoFJ7lr0a+qT
         dV4IUAHIu+lxWGWou8hfP/bBJKxkV+lCOyf+zsjpaLof4UbCBHTWFvkW/st6PgMfSgc7
         3NVTQnMWo6wNrvzhrOVzXFRaipAIxG5Yrirg1hKFkxCZBij/QW/M0+9+fvUUpnT5SB+u
         JYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774912804; x=1775517604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7nVm/haVDLplgMTbOsS8tMMdmmzBvf/nT8hehniaBnU=;
        b=mEqTXE5ANwqwxh6Kjxv0goGf9+0o83scp9mm9W9RklejgKsP+J1OM53Xgo+QiudpwZ
         DQCmhNCygs9YNTsu1xpkfAiT2yYZ3veDriwnkNAiXH1fZ5JqkIgbPGDw1wZozDPidBSr
         N/QruEQ4gdJeQlDRqKTc1IUGlatlRKJY0aewICL7sLxJaWAI1vJpVfRug+NlrloaJmYG
         bAOeSHDSjID6NjJW7/NGuhvcpdwAuT+SHfcX5bANmKbjeYMQC68+JXvImiCvWjhSyfrn
         JvKxtOPz8tO04gyVFwWntI1VR+vkGvD9QVlE9xkVFJ1OjwDpJN5cjK5SQ6ZuhrxBWNGB
         CXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqiadQQfJYC7L9Krz2Gkjh+piBl33uxzsCvkdR2sWl3xrZMUiGC/+S6+2oqtQ8QgIbpAfAFldedBvRwtI6@vger.kernel.org
X-Gm-Message-State: AOJu0YxQF1dPq/ZqqDsYZY+J++uGBhkmLmpP0J3Qo1jaEAvbHteApQX0
	7DRKgipsBvrzux2rkbTL3soiDsXD7Vz+41CSfW+JaurB6FxcTF4rMWPGGgnFDsd1iXfhC/83y/3
	+7DVNIUSEJUvz9vFtkZcGJkqD2U+52p71Px9O
X-Gm-Gg: ATEYQzwE7R4aLzuM8c5DPzTYyJ2ldfw8n85evokbQJ05IKDRRbVArw1W/+MvIQ2N0od
	F5vu0T/Zi1Ht2b+v7iNUslb6mZ3fXVRwZdYAxP+gGNfUUpF3XeQW8mwhRDjt35d6YTRJ5u189JF
	uBkEJtvtRZpG46LKpmUUCpB6DYg7/XaQXCE0wD6wY2YsQ36ojN24G5SAio9F3zMVqxAgANEUCDy
	ynbki2PIEoe488ELeRJ1tDxcGIRRcBaG+xu1QhcoHPFVpsFAS77Cid9gSUCLAOF+UQhnrIxZS7b
	zFrk6Q==
X-Received: by 2002:a5d:5888:0:b0:43d:184:8a92 with SMTP id
 ffacd0b85a97d-43d01848d3fmr7741072f8f.6.1774912803402; Mon, 30 Mar 2026
 16:20:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324224532.3733468-1-joannelkoong@gmail.com>
 <20260324224532.3733468-8-joannelkoong@gmail.com> <6b066b75-e77e-4b4a-8280-199d547c2e94@bsbernd.com>
In-Reply-To: <6b066b75-e77e-4b4a-8280-199d547c2e94@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 30 Mar 2026 16:19:52 -0700
X-Gm-Features: AQROBzAvnr4EC6m_HBfOJaUk6Rh25_1LvkSRCI04gfJwjvEOaL_LAyNXR9zTU9w
Message-ID: <CAJnrk1aTOzsQgh4DfT=6h+n7=OZx0xfHGbV_H5VcvZZF0bp6Bw@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] fuse: add io-uring kernel-managed buffer ring
To: Bernd Schubert <bernd@bsbernd.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 2:28=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 3/24/26 23:45, Joanne Koong wrote:
> > Add io-uring kernel-managed buffer ring capability for fuse servers
> > communicating through the io-uring interface.
> >
> > This has two benefits:
> > a) eliminates the overhead of pinning/unpinning user pages and
> > translating virtual addresses for every server-kernel interaction
> >
> > b) reduces the amount of memory needed for the buffers per queue.
> > Incremental buffer consumption, when added, will allow non-overlapping
> > regions of a buffer to be used simultaneously across multiple requests.
> >
> > Buffer ring usage is set on a per-queue basis. In order to use this, th=
e
> > server needs to have preregistered a kernel-managed buffer ring and a
> > memory region big enough to hold the headers. This should be done befor=
e
> > queue creation is initiated. The kernel-managed buffer ring will be
> > pinned for the lifetime of the io-ring.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c       | 384 +++++++++++++++++++++++++++++++-------
> >  fs/fuse/dev_uring_i.h     |  46 ++++-
> >  include/uapi/linux/fuse.h |  19 +-
> >  3 files changed, 376 insertions(+), 73 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 81cd20e0d50b..cd45b6a8e6c6 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -10,6 +10,7 @@
> >  #include "fuse_trace.h"
> >
> >  #include <linux/fs.h>
> > +#include <linux/io_uring.h>
> >  #include <linux/io_uring/cmd.h>
> >
> >  static bool __read_mostly enable_uring;
> > @@ -19,6 +20,7 @@ MODULE_PARM_DESC(enable_uring,
> >
> > -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_rin=
g *ring,
> > -                                                    int qid)
> > +static void *fuse_uring_get_buf_ring_headers(struct io_uring_cmd *cmd,
> > +                                          u64 headers_offset,
> > +                                          unsigned int queue_depth,
> > +                                          unsigned int issue_flags)
> > +{
> > +     void *mem_reg_addr;
> > +     u64 mem_reg_size, headers_size;
> > +     unsigned nr_pages;
> > +
> > +     /* find the headers in the registered memory region */
> > +     mem_reg_addr =3D io_uring_registered_mem_region_get(cmd, &nr_page=
s,
> > +                                                       issue_flags);
> > +
> > +     /* server does not have a registered memory region set up */
> > +     if (!mem_reg_addr)
> > +             return NULL;
> > +
> > +     mem_reg_size =3D (u64)nr_pages * PAGE_SIZE;
> > +     if (headers_offset > mem_reg_size)
> > +             return NULL;
> > +
> > +     /* verify headers fit within memory region bounds */
> > +     headers_size =3D (u64)queue_depth * sizeof(struct fuse_uring_req_=
header);
> > +     if (mem_reg_size - headers_offset < headers_size)
> > +             return NULL;
>
>
> Could you add to the commit message how the buffer layout is? I think
> this deserves some explanation.

I will add a visual diagram for this. The headers buffer is laid out
contiguously in memory. On the server side the server is able to map
from ent id to where in the headers buffer the data for that ent
resides by calculating ent_id * sizeof(struct fuse_uring_req_header).
I'll also add a diagram for the buffer ring as well. I am going to be
sending out a v2 that has some updates. The bulk of the fuse logic is
pretty much the same but the buffer rings and memory accounting
infrastructure will be moved to fuse instead of going through the
io-uring uapi.

>
> The appraoch kinds of reminds me to my initial patches where I
> configured the ring with an additional ioctl. Until Miklos asked to make
> it dynamic and to avoid the ioctls (and config SQEs as well). Basically
> here every FUSE_IO_URING_CMD_REGISTER gets the the queue depth? Wouldn't

I don't think an additional ioctl or config setup cmd op is needed
because this can go through the registration flow we currently have
without a problem. Every registration sqe will pass the queue_depth in
the fuse_uring_cmd_req data. There is logic to ensure that all ents
for a given queue set the same queue depth. For the code logic, only
the first registration sqe needs to set queue depth, but I think it
makes the interface simpler to just have all the registration sqes
pass in the queue depth, since in the dev_uring code we also account
for edge cases where the same queue gets registered concurrently on
multiple threads. I don't think a separate setup cmd op is necessary
here.

> make sense to have a setup SQE per queue then? Or one global
> CREATE_RINGS config sqe? With the reduced queue series things would be
> definitely easier if we would know the number of queues that are
> supposed to get created (right now the it has to re-calculate the the
> static mapping for every queue).

Do you have a link to the reduced queue series version you're
referencing? I'm not sure without looking at that code whether that
could use the current registration flow in the same way or whether
that needs a new config sqe.

Thanks,
Joanne
>
>
> Thanks,
> Bernd
>
>
> > +
