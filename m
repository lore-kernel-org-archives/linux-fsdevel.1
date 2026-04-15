Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A440DFC9
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 01:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776215416; cv=pass; b=OZp0DJJ1SaA22dOWrtinWhkddU7w67dcZfrOhTtocb2oG4CC2fjEv5SImjVX3O/FtCSXDK/JjXUi5PH16CUqXpGTA08B2X2Nzy5UA5V/AkQCBMh9o9yT6Mr43D9hnxs02jX8ki0abbYDsbjXKLywUEziRn+wBhTXbazQd000F/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776215416; c=relaxed/simple;
	bh=cY8cgTRa1DZsqsE7RCYEtBwElKC6XPGbK65mYX3c4+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag1kqilGlhvib9//fFZT605ycYMyLI6ax9DDnspWCxlg2ZNmSRvqT0WyIi3egGMqYTnaKKQ/lMg8gliT3SBb8qs4CmPinKxLLK3eZPUnETeRCBAMLkDBw0RZhbPKyhaoUiBltC/9QXpF1ZmNRSuOcHLSOx8lxijLJ8SIbb+isvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVuXr6HM; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVuXr6HM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48374014a77so83772455e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 18:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776215413; cv=none;
        d=google.com; s=arc-20240605;
        b=RTZ+h3guihQJrEINs0NgD5UqunIK36/RdkvFOAj8CyMJBxSke0gQjky3fAs1ZqrBdF
         tfV6o8lWtB68Nw23EOMXvckJC0iIgBEd626dhciGCnXb08iXnvggORWso5OWkUT+LK+L
         7WOEZeLjibLz9BX/zxoswESlhUF9tQDgR0HYbIyYwWdIrO/wGDxb0dshNuoBOp+q+NP4
         UJlKCmPHVaRmVRWnlFYkd9k3XUXcnC7HAmXJ5PnkUiVZmXzdTF04LzwcsDJ6x0NVBJhu
         SwH04gPG21lSb6mq6it9yV7mcYSK7PZbVjCwzqm9hc/598NJZhivUEKr8bIJC9PyalLb
         sk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJXb0g/1M8z17Wugtz2qq1lTdAnbqiUmqW3S/Cf/DWk=;
        fh=znXMIfQ+KGuEkQ/pkKqploLnOvLBZUKwM4n0ajFwho0=;
        b=TZXn0eagNbu+mu9QbKe+6fNPNJh0e2phpZ7qw15+6AXpHzG+UwOWuk043grAXmYQS7
         3VX7Y4+X4ujSBZ3RnhdwoGJAIzHSWiLo4KLncqWLf8R3OKwqgqhyXr+lFlBS4ecnbum1
         axXG+gUGTvhDkbtELDZuAg7ajGACOkczXEGf3eQPpFz8xcy4fPoXSt80zdG99fkjiu+O
         /5erE+Lxt2gO4TQsij4YcylbXpsBMlhOLvXoL22LsiA7bOfLNsaD+IohyViaZzS9ApjF
         p47M3K8NyTZthQZWDnEHwWXJl3We8mFtdbCcdOEXx+IbIAvi98xbnJHlyCwmBFCF7qoy
         qwdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776215413; x=1776820213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJXb0g/1M8z17Wugtz2qq1lTdAnbqiUmqW3S/Cf/DWk=;
        b=HVuXr6HMJj4QvAfD/5bBx+HXXXCCw/jIZj1BJkCh7Ppc9EMY3DtVNjv0iolULhHLvR
         PP4W37WzJtop3ObibIuzZ31hqvQYzz5Gnq1nYB7OYYBKETT17xCOSpZTJz0oMWr0/e23
         NcfHSQeEkryEZu8aixFjm2MAjgcconPFvzOu8cdddEEyqfrAtG3QqurBKPOj8GcBmRfD
         d71OoVaDZD8pZFJ/Bowd7uUuVv1jYHzcV2rvxIYXitAy4jj1HD4XFucIH1rZ/L9OH1td
         6J6bOrWRJwQ9O88PEUrdzPgRgIcR0hA7RjjsVYsXJBTt5t9ai5Heu5YRD6yBCfmiQju7
         oKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776215413; x=1776820213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJXb0g/1M8z17Wugtz2qq1lTdAnbqiUmqW3S/Cf/DWk=;
        b=LpnpiKqGZ39MhjqZQmel4lbdAN/lPez5GWlsZ7A3gd/7xWAFd0+61bKl5IkzJZLJV5
         UV6hnJ+3lJaaACIQsSWXzQDdkzhudWbRg3xbZPGPeqlEggyqU/t0FncGt39gkRb9quOO
         jZNSBTMqxSk3ONQxkVRVTtXn+ffn3L+Lab2XS0P9KiXhDeQ2NGwLWcyGnoywvBEda0Ef
         HvHKXDYikYtc/mfbe+FAnuQbYy5tTLnQ7WpznliMEOdOtv/Kkva56QRXr/AazttMvOXG
         4BasUIf/En74BeGbhM+Jbxef3WCe1gWoUH7g1iuZUZ6fmakdUkrveLrsthW2DytmYqFL
         VkSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7AayloTRukqSDonWxWKLaimJhveoqs18kZan0QWs5aSt6t7TRfjAYf5uTLG0ehhzyifl2a2JWhqVWpOuN@vger.kernel.org
X-Gm-Message-State: AOJu0YwZpWgPUWwlVtPEHIfErNrUPJTDbUns90ej6RgVgPSjglEucjzr
	utFHKPDyyYyOmIt18j2qmdPVR+qtXHFS0EI4ggP6hYmP71RiPjld3zk+mhufN3NlernVE0bwagS
	aL8wnKNxyKM4dKv2T70vARdRlSDnAwRw=
X-Gm-Gg: AeBDieu0prjd5HOI5LMiDA8N05u6umkzSmLhKnPX3C+TQiRHYNwruLT6Z4wP8+abeOy
	Z254wN+MO+J+9FGgCFB3bEDb/h7AmTFxLw7VkENL1dqPAtaGFY0+RNnJZmgqzY0PNLxd/CAK9ej
	p9F/K+EbKCn6+il8cKqJzNGvOO06SPQVev4SnLZIWHRZMVf/2zbQp4tieHxdo9EPJtCk24/pcJp
	ktzHX4eFPL/qWjrokIyDu9pHf9DL7yifOrlE/RPGvr5EGKahCGzEIDDFlUUYVQBsRGjAg3o00Zw
	6I0idlNcEFXR7rNm
X-Received: by 2002:a05:600c:a11c:b0:485:303b:c50a with SMTP id
 5b1f17b1804b1-488d6804721mr201462735e9.13.1776215413430; Tue, 14 Apr 2026
 18:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-15-joannelkoong@gmail.com> <0f2b87c5-2c98-4463-9a9c-bfca91e83cfc@bsbernd.com>
In-Reply-To: <0f2b87c5-2c98-4463-9a9c-bfca91e83cfc@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Apr 2026 18:10:01 -0700
X-Gm-Features: AQROBzC6nH-PRX3zi6u4ymmkOu7XdP8C4KEYAgDLShVZx_OAg0NBvvVDPD8I21k
Message-ID: <CAJnrk1ZAcbYkewWz=CbxgzkvXnk2-QKLjSk-oA0hywbnVUSM9A@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] docs: fuse: add io-uring bufring and zero-copy documentation
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 2:05=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 4/2/26 18:28, Joanne Koong wrote:
> > Add documentation for fuse over io-uring usage of buffer rings and
> > zero-copy.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  .../filesystems/fuse/fuse-io-uring.rst        | 189 ++++++++++++++++++
> >  1 file changed, 189 insertions(+)
> >
> > diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documen=
tation/filesystems/fuse/fuse-io-uring.rst
> > index d73dd0dbd238..bc47686c023f 100644
> > --- a/Documentation/filesystems/fuse/fuse-io-uring.rst
> > +++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
> > @@ -95,5 +95,194 @@ Sending requests with CQEs
> >   |    <fuse_unlink()                         |
> >   |  <sys_unlink()                            |
> >
> > +Buffer rings
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +Buffer rings have two main advantages:
> >
> > +* Reduced memory usage: payload buffers are pooled and selected on dem=
and
> > +  rather than dedicated per-entry, allowing fewer buffers than entries=
. This
> > +  infrastructure also allows for future optimizations like incremental=
 buffer
> > +  consumption where non-overlapping parts of a buffer may be used acro=
ss
> > +  concurrent requests.
> > +* Foundation for pinned buffers: contiguous buffer allocations allow t=
he
> > +  kernel to pin and vmap the entire region, avoiding per-request page
> > +  resolution overhead
> > +
> > +At a high-level, this is how fuse uses buffer rings:
> > +
> > +* The first REGISTER SQE for a queue creates the queue and sets up the
> > +  buffer ring. The server provides two iovecs: one for headers and one=
 for
> > +  payload buffers. Each entry gets a fixed ID (sqe->buf_index) that ma=
ps
> > +  to a specific header slot.
>
> Hi Joanne,
>
> thanks a lot for this document! Could we discuss if we could just hook
> in here and allow SQEs with different iovecs for the payload buffer?
> Let's say fuse-server wants multiple IO sizes - it could easily do that
> via different pBufs and just needs to specify the dedicated IO size per
> pBuf. Those buffers could then get sorted into an array - we could
> define either via FUSE init the number of buf sizes or use a fixed size
> array. Fuse requests then would just need to pick the right array.
> This is basically what I'm currently working on for ublk.
>
> I think it would be good to agree on the design before it gets merged so
> that uapi doesn't change.

Hi Bernd,

I'm not certain I fully see the use case for a fuse server preferring
a static preallocation of multiple IO sizes over using incremental
buffer consumption, but in my mind to support multiple IO size
payloads, I was thinking something like this might work best:

* iov[0] for the headers stays the same. no matter how many IO size
payloads there are, the ent always maps to a header and the headers
are a fixed size
* iov[1...x] are the payload buffers. From the uapi perspective, in
the fues_uring_cmd_req init struct, there would need to be an array of
uint32_t buf_sizes. Each index in the array would correspond to index
+ 1 in the iov[] payloads passed
* on the fuse side, each of the buffer pools has its own ring. I think
this makes managing the different buffers a lot easier and gets rid of
having to do any array sorting, and makes buffer selection/recycling
O(1).

From the uapi perspective, right now this patchset adds this to the
struct fuse_uring_cmd_req [1]:

union {
    struct {
        /* size of the bufring's backing buffers */
        uint32_t buf_size;
        /* number of entries in the queue */
        uint16_t queue_depth;
        uint16_t padding;
      } init;
};

To accommodate multiple io size payloads, the buf_size should probably
be the last field in the struct so it can be extended. How many
different payload sizes do you envision needing?

Does this align with what you had in mind?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260402162840.2989717-11-joannel=
koong@gmail.com/

>
> Thanks,
> Bernd
>
