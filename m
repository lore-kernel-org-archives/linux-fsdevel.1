Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C013264CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776292860; cv=pass; b=QNa5xHbdj2A08/PYi/LFR/3tsKdSdT6O+M2D67Ek7+/v/6riDd81bmVCQQTGL9y9Xw0y16QgM2t+1rQrNLW+p4/Zb8u0cm8NWKWCfgM9VG1dzZyVp9EXi0yivh92G0V6KOX5Y8lWmzGrb8RMq8Ss5J255CI7NVCIjupk0bEuLCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776292860; c=relaxed/simple;
	bh=76EGVB5oWxGfenbDwi1w9hY7gjBZKqPINwO0Y7ZvTRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdCsTJkEYpjoiTpbQXIEU9DzZDYhA2sbWKpzX2duIG1tsoa1LWJ8VuSa+z5kRM+CksRJ+mHht1B/cnuezJK4zhktkwkin2CTNWXPuIV/lUIrZaB5WuNGDzqR5HuKO5QPhzES2odSrZ3vrjnzXr6yORb8nY20gSXeT++OU4bpwAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDavCgek; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDavCgek"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b8efed61so505335e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 15:40:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776292857; cv=none;
        d=google.com; s=arc-20240605;
        b=Y5hqAs1qlsvyJZQwBp3sJHIPE4wllvXETufzTE90GnsWRk0itytHfA4FjQ21VYo2Um
         hHC7S+a1GnaFT/deq1psN2MvAjFCrp0LcAG6HJr0pjyqklqvY9eHtQfE0+CN8iN2H7PE
         VTfVZbbrTxbOjYMMioDiJr2A5EtmdifCnulGkdZdW1FfEoYJD19Pww+8X8WGBHFS+rV5
         xaRJ+jQsK6U2JqNWNiXLKHmHrfrf8ck7G5bYSgpxpva3AzWgG81kQacirnbR4kEiBxlM
         9jnyIz77bLrEkVU994m8oSyKcJAkfFnTpdyoWdNtvxxoJLY0CvHK9me7bGgwL5Wp5nxv
         IBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cWfGw84WBIkcIJa7RtAfsO5pLmp4sTAor8d8qSFGyuw=;
        fh=XNw4byym+TREMdxCMqKBBNxDoU27RyRKdd59zbvU0do=;
        b=HoCkHVhAtT+xa81LgCCv1yd1JBwB6t1K5/Xx0MFshEXLa58enjAKfAoBeK7GpUy4mQ
         0JbjRIwxNcEFSbuS8CQ5QicFOjgzn5NcDdOAwpNfQS6vZUYjWhyiqFHhMUmFum3Kuj8Q
         CYZfo54f4GM2uKvkqs/g83ENnUZ8GXD4m5nicevc8y82hD2Uoc+88lwORACFKqFXW8K6
         mnySabnjdMEyqHxNAyV3aoVH25wsowrL8Ifa3wXWpvHCDPHK9hZ8LyasTh6sFvfG6FTx
         t4GZPO0jR11EnSApUCEkgUd/x/s8vXHb+jrfp3STThoNHRY3y7Z6iJpoSArPOGnqxSCg
         X+GQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776292857; x=1776897657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWfGw84WBIkcIJa7RtAfsO5pLmp4sTAor8d8qSFGyuw=;
        b=MDavCgekgnjfPLqrozLq+YT9BYNRnWr3E6JXgN8NGRLQ/W1PSH45/o9Gle1DnLLiE1
         83onpRlsTCZnetZXapVlbH9KbxNIS91B15w/+KeAW9eBMuc63vPV9sxUnpCUHefuVwZ6
         oAGbFdsct5WbiYytbRf1nNjf0ruXMBfwPAmoBHbLte02o+mVKSJ0AGNOLL8kLzCdMKt8
         eD1p/yFNeKtKsBQo1bG/RxM2WYSJhLx3CiC4Aonn+8bpR5YBVO7ytXP0sEjuKDBPsdEv
         AM8/vWaE703TZ/jmK3eJjYzdoArHu9CLPtu0aZFEN+wMtOtIj2wOAf24iEeJfrAgU5Gp
         xGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776292857; x=1776897657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWfGw84WBIkcIJa7RtAfsO5pLmp4sTAor8d8qSFGyuw=;
        b=hA80yQuTshPHdlLUqjS5Czjn+EXTGKZcYjCJFYy04vHBDKlJcdAETd8Hg5ltITZdCI
         4/Cu91N6oaZFMep480uRJMv6s1c4RVlAG4nC90RtTXDkzKGCM/6f2xBODXaegZGNFozW
         aOy2WwvWyQcgQFBXOjxW2javnfIollm4YzXC44HW/At3dqh5DG1Wa+0UxVozX8NFJzL3
         gZzQFwyRhtoOSi6skShxVZ4noGoj2VRSoSEEc4jKdIVICCmdX++Jr5NEKSnCSQqbQDCU
         ZJaZgWRVHeffAhJ4LppAYtwmEDD4sqL5uvqTvger6ZGRg2gAgcNACSxmozXzbSOKQiLW
         ua6w==
X-Forwarded-Encrypted: i=1; AFNElJ+OI1pTrYvKXCOogKC5a79M19UsBtrXtZvcBL0S3UEktLKiIg5UnwwCg8CzDR4NMeUyLMuzgwXXbUf7O5jD@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtNq2hYthDPzx9LQGGxDImrUrkSV8R726KLAr+e0bOwAN8dUk
	1C7zhg2p0fH4wcgxrj79N2mxN8bUsaWJYodHljmVyEFB4goKx25MEyGFGwtoLkwiSiYX1XaM+g1
	1P4UZaJJOk2ZXtbT3NtaxWGdiJa7BSOI=
X-Gm-Gg: AeBDietFaO5k6T6mXVF8vfZ67QhbxLBptR8UMI73jn7WBV0CnbpKv9motLm1+Yn0XV6
	ItU/WaTqDn5rGh5dYbrBKA9i95Wv29CkbbE46Gg6AFMNWtuIUZohM9nEtCw6rEDbbTlor1a+TIh
	c5XBUn9TEc64cpdLx834ZQgaLW8lkvWB8fJRuD/TNQyrq9rx51Ay6ovC1Xrc6zS7bX5BQxrZLDU
	2VbrUakeU82Abb30xel4QGvs5VXIaKHqI2fsNYH5xQF+1P3TxjJrne6hm5gcNtH5QuYcwput+wx
	1kZNPClrnlx6J0AV
X-Received: by 2002:a05:600c:3e0a:b0:488:c6e9:1e0c with SMTP id
 5b1f17b1804b1-488f47c90ddmr15353295e9.5.1776292857262; Wed, 15 Apr 2026
 15:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-15-joannelkoong@gmail.com> <0f2b87c5-2c98-4463-9a9c-bfca91e83cfc@bsbernd.com>
 <CAJnrk1ZAcbYkewWz=CbxgzkvXnk2-QKLjSk-oA0hywbnVUSM9A@mail.gmail.com> <ff596299-38c1-4c5a-8f1d-14931dd84ef0@bsbernd.com>
In-Reply-To: <ff596299-38c1-4c5a-8f1d-14931dd84ef0@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Apr 2026 15:40:45 -0700
X-Gm-Features: AQROBzDigbvwD_rvz1gtTPtt4_JNchLz1er0cxfqTpS9yV371eFv1h0vOImkydk
Message-ID: <CAJnrk1bmxYzZEV46-uG3XXaVEu2hciyEWf9K5QNXaXuz0qUWcg@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] docs: fuse: add io-uring bufring and zero-copy documentation
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 3:55=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> On 4/15/26 03:10, Joanne Koong wrote:
> > On Tue, Apr 14, 2026 at 2:05=E2=80=AFPM Bernd Schubert <bernd@bsbernd.c=
om> wrote:
> >>
> >> On 4/2/26 18:28, Joanne Koong wrote:
> >>> Add documentation for fuse over io-uring usage of buffer rings and
> >>> zero-copy.
> >>>
> >>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>> ---
> >>>  .../filesystems/fuse/fuse-io-uring.rst        | 189 ++++++++++++++++=
++
> >>>  1 file changed, 189 insertions(+)
> >>>
> >>> diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Docum=
entation/filesystems/fuse/fuse-io-uring.rst
> >>> index d73dd0dbd238..bc47686c023f 100644
> >>> --- a/Documentation/filesystems/fuse/fuse-io-uring.rst
> >>> +++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
> >>> @@ -95,5 +95,194 @@ Sending requests with CQEs
> >>>   |    <fuse_unlink()                         |
> >>>   |  <sys_unlink()                            |
> >>>
> >>> +Buffer rings
> >>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>
> >>> +Buffer rings have two main advantages:
> >>>
> >>> +* Reduced memory usage: payload buffers are pooled and selected on d=
emand
> >>> +  rather than dedicated per-entry, allowing fewer buffers than entri=
es. This
>
> Then don't register that many entries? An entry is useless if it cannot
> carry data - why do you need to register that many entries then?

Registering more entries gives higher concurrency (since the number of
entries determines the max number of in-flight requests). Since not
all fuse operations require large payload buffers simultaneously,
buffer rings with incremental buffer consumption will allow servers to
support higher concurrency with a lot less memory than dedicating a
buffer per entry especially for metadata-heavy workloads.

>
> >>> +  infrastructure also allows for future optimizations like increment=
al buffer
> >>> +  consumption where non-overlapping parts of a buffer may be used ac=
ross
> >>> +  concurrent requests.
> >>> +* Foundation for pinned buffers: contiguous buffer allocations allow=
 the
> >>> +  kernel to pin and vmap the entire region, avoiding per-request pag=
e
> >>> +  resolution overhead
>
> Pinning can be done per buffer as well. The part that is harder is

Yes it could be done per buffer but imo it is much cleaner to do it
contiguously.

> pinning of the headers - this is why libfuse currently allocates 4K for
> every header - prepares the pinning. From my point of view, we _should_
> make use of that and set at registration time that the header is
> allocated as 4K and then small requests can be inlined into the
> remaining part of those 4K. With that ring bufs become useful, because
> most metadata do not need a new payload buffer anymore.
> However, I think in your current design headers are mapped into a large
> region and there is no way to use extra space. I think that is fine, as
> long as we have the capability to have multi size buf pools.

I'm not sure if you are trying to make this point or just describing
the non-ringbuf "legacy" path, but I strongly disagree that pinning
should be done per-header. Each struct fuse_uring_req_header is 288
bytes, and rounding that up to 4K per header is not ideal and I don't
see any benefit from doing that. In the original (eg non-ringbuf) path
where each header is allocated at 4k, that can't be used with ringbufs
as using ringbufs mandates that the headers are allocated
contiguously.

>
>
> Contiguous buffer allocation can be done for entries as well - userspace
> just needs to assign it to buffers that way. It becomes it a bit harder
> with dynamic entry registration - entries buffers should then allocat in
> sizes of system huge pages.
>
>
> In fact I initially had that in libfuse and had allocated all userspace
> buffers as one big memory. Then 'temporarily' removed it because I had
> development stability issues - the single buffer needs to be marked with
> ASAN areas in order to catch issues. For initial development that was
> just overkill, but could be added now, in combination with ASAN buf marki=
ng.
> For pools it would be good think about ASAN as well.
>
> >>> +
> >>> +At a high-level, this is how fuse uses buffer rings:
> >>> +
> >>> +* The first REGISTER SQE for a queue creates the queue and sets up t=
he
> >>> +  buffer ring. The server provides two iovecs: one for headers and o=
ne for
> >>> +  payload buffers. Each entry gets a fixed ID (sqe->buf_index) that =
maps
> >>> +  to a specific header slot.
> >>
> >> Hi Joanne,
> >>
> >> thanks a lot for this document! Could we discuss if we could just hook
> >> in here and allow SQEs with different iovecs for the payload buffer?
> >> Let's say fuse-server wants multiple IO sizes - it could easily do tha=
t
> >> via different pBufs and just needs to specify the dedicated IO size pe=
r
> >> pBuf. Those buffers could then get sorted into an array - we could
> >> define either via FUSE init the number of buf sizes or use a fixed siz=
e
> >> array. Fuse requests then would just need to pick the right array.
> >> This is basically what I'm currently working on for ublk.
> >>
> >> I think it would be good to agree on the design before it gets merged =
so
> >> that uapi doesn't change.
> >
> > Hi Bernd,
> >
> > I'm not certain I fully see the use case for a fuse server preferring
> > a static preallocation of multiple IO sizes over using incremental
> > buffer consumption, but in my mind to support multiple IO size
>
> I have to admit that I don't see why we need pbuf for dynamic
> allocation. While the io-uring ring has a fixed number of SQEs/CQEs and

If the ents are dynamically allocated, bufrings are still useful
because incremental buffer consumption still helps with memory
efficiency

> while libfuse currently strongly couples these to fuse buffers, there is
> no technical reason. Initially it was, because I had taken the 'tags'
> from ublk design, but then Miklos asked to make it lists that just get
> appended whenever a FUSE_IO_URING_CMD_REGISTER is send. Which means
> libfuse _could_ add new entries any time. You could start with 1 entry
> per queue, additionally with the reduce-nr-queue patches you could even
> start with a single queue and a single entry - and then extend that at
> any time to what libfuse or the application believes is needed.
> I.e. except of io-uring setup, adding or even removing ring entries and
> their buffers is mainly a missing userspace issue. In order to remove
> idle entries, we could add another notification type like
> FUSE_NOTIFY_WAKE_RING_ENTRIES and it would then wake a given amount per
> queue and maybe send via a new op code like FUSE_NOOP. All of that seems
> to be easy.
>
> > payloads, I was thinking something like this might work best:
> >
> > * iov[0] for the headers stays the same. no matter how many IO size
> > payloads there are, the ent always maps to a header and the headers
> > are a fixed size
> > * iov[1...x] are the payload buffers. From the uapi perspective, in
> > the fues_uring_cmd_req init struct, there would need to be an array of
> > uint32_t buf_sizes. Each index in the array would correspond to index
> > + 1 in the iov[] payloads passed
> > * on the fuse side, each of the buffer pools has its own ring. I think
> > this makes managing the different buffers a lot easier and gets rid of
> > having to do any array sorting, and makes buffer selection/recycling
> > O(1).
>
>
> Let's say we would have per queue
>
>     struct fuse_bufring {
>         bool use_pinned_headers: 1;
>         bool use_zero_copy: 1;
>         unsigned int max_queue_depth; /* headers buffer capacity; frozen
> at first REGISTER */
>
>         union {
>             void __user *headers;
>             struct fuse_bufring_pinned pinned_headers;
>         };
>
>         unsigned int nr_pools;
>         struct fuse_bufring_pool *pools[FUSE_URING_MAX_POOLS];
>
>         /* lookup: order (req size) pool */
>         struct fuse_bufring_pool *order_map[FUSE_URING_NR_ORDERS];
>     };
>
>
> Order map is then dynamically created at buf pool registration time, and
> then we would eventually get to
>
> struct fuse_bufring_pool *pool =3D order_map[get_order(fuse_len_args())];
>
> (obviously the final code needs to get a check that we don't exceed max
> payload size.)
>
> The looked up pool can be stored into ring_ent for buf recycling.
>

Yes, this aligns with what I had in mind.

>
>
> And then
>
>   struct fuse_uring_cmd_req {
>
>       ...
>       union {
>           struct {
>               __u32 max_queue_depth;      /* (renamed from queue_depth) *=
/
>               __u32 buf_size;
>
>               __u8  pool_idx;
>               __u8  _pad[3];
>
>           } init;
>           ...
>
>       };
>
>   };

This makes sense to me.

>
>
>
> I think pool_idx is needed one way or the other, because the io-uring
> ring owner might have other pools for its own purposes.
>
>
> Thanks,
> Bernd

Thanks,
Joanne
