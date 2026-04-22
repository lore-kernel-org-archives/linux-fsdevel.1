Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920243F0AA1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885509; cv=pass; b=I7/h8nmNpl87EqEr4NmGY6SAwxkE3S13ORMLzuD/8NPV7MM85GapGJR7XOxZRaszaT0WPBPTV4DnC2/2t5BieSByyH85liXFcvn7mBqHbYXR1wYguiVOQVVT8W651m/QckkTeAkN2lpO4OhQoiHM9HBW2TXLqzXmRM9nmTeUU44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885509; c=relaxed/simple;
	bh=eLTy6oaaj50lZLpuUrUrH8HqYBykJM1lQsw4SpqXqOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FpBDFz5ImuIRjeXN95UX526ovQUpySLmmkP6VzevrCmxON1MesGySgNA4Lq8RFNq9HkF3PU1uGs35lnq0e1mZn00ZYtkIY6eX6Ou4MlOSvKMYH+HwA9nnoOK0qdtaMajQNsV/vGAzXLIj1pMuFejnbjS0h5eG7kD/1aZOLSIw6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVQugiWQ; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVQugiWQ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so6010591f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 12:18:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776885497; cv=none;
        d=google.com; s=arc-20240605;
        b=g0Tp2bVCijTnuHl6mQMz8DCex4YMFSOOYUj80rUNFU8g8lTmwUKNhpeA0BW1Y9vhA0
         t9HWYBUWaGDsuHR+Ntx98NbpKlN21CrU17pb2ID+yEAJACDxapUiENnHDbmx1zZxS/4D
         69EIfGvGg4CvinvxANMEn6S271AwHB0RU8zgzfJeIvktbNkjSMfH3cvjo9m6CBfOegzN
         nWXTfT9nui0OWHsC9jzZ2OxrKGODt5wrNccucTteTQKEjfMwIDI3r70FIolgJ5ofAxKC
         SmADTrDRoDt8DaKzTpFpvhqIdRreAX/8oEiOja6BMC5Gx2NhPMtDweZsZvzcoH+9Tumk
         +fgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KL1J7XDwa+fXiRxbzmsV9G9cuoOI0uGFuRHKY3kS6Ys=;
        fh=I9U+e13taVslCSQcHHpYbnji6uKjlQOcGRNZ7875d2g=;
        b=OCG1RlINsXEmf9qh6yYa9yNW7jzm/Q866LMYd/SRVL/dJ1ShdVTLq070WcR6a6ceWI
         brfhO4cdpkKH4f8X8hf+C6uOsorUB9NZg/hHS3ut2Th2kLrf81CbqZC2AAOWg4hrUEG0
         QV92paFJ7SCGe83iHqJlkrJriNacCh5tRDHs5subbvPrXttEFsBWDtIC4prL5+GelUiU
         7GugWF7UNxeK0PrEwF4noyzFGaWn0O3SQrt0nrRu0ciXLjIzRSmZzHghJwxt/onbMTzY
         FiUjX2ih2tZrroq39TR+sZ6u5Aq1lbi3VoaQJw9F5EJtcF8dWTZ+Pt0Jf/At3AepJE0g
         igCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776885497; x=1777490297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL1J7XDwa+fXiRxbzmsV9G9cuoOI0uGFuRHKY3kS6Ys=;
        b=GVQugiWQq0/PABtrZOVVMtrYVZuSDiFlg80AD9Zdg7rgbYxQHjAcdAvod8ROPy8Q7c
         jncMepL6Mk5MiC4V/LIt0PAh8V7NTdpcibYRLJ/tQm9fynCGtZ8ywdcxD/AhESDGr2Yk
         BVSsTuIuWpDbO97DJ58tqj2JnvLC112Eknl5icJ9aqUIya35pTs2ITTGJkN/ygh/ReEj
         RsJP6EPOIVksvPlHgbqGQgCW04HzIsRHBVFfWcY18V7ZTXx51J7ElNfO80NrEK8In6My
         U8V8TQNf/bw3ivdUdbrjEwqsOAu5rgrhaBCtS+9qACz/Rbav08WHaaqzrsU92fpgZMIP
         LNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776885497; x=1777490297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KL1J7XDwa+fXiRxbzmsV9G9cuoOI0uGFuRHKY3kS6Ys=;
        b=Ef7iuhItdsjeUFkhlQX/7vIiEsSVxrN7GD8JLIXjHT0v3LLxPNM+rlJYdhOs3kAGz3
         wynBNzs0PEoqs/HTV/aIEJXGICsZL/6O9zKcFRzA+kOYk5ATvnbJEiHNqnCh4/DQjruk
         7Yc2qTKQE+tC3uN43ZZAqNCZzoOEfxMYmDkjmvRD7DubeXkFgFOT9ZBjolu6wRD8z6La
         ZgfWlbhD0YAezZ0K7DDDc9uSYavF2yIlEztcKQi98XRWcoE4EPVV/PyPMuSzoHMZF0p3
         WmX8PCKPGWc0bYMg7LYGMW30Rw9gK2BKTd8xJM739F10Jr1m/r5J42Ogt4WnwOBqqcqo
         FmDw==
X-Forwarded-Encrypted: i=1; AFNElJ/7ZijOHgk//ILIJNsawngPfiTad6aAz8EvtqFMFYzA/dDXYLUc00TBP9l0wMBjY+Fsq5xesQCZUQXgpRVi@vger.kernel.org
X-Gm-Message-State: AOJu0YxRXQ/UgOZ8G++4rY/rZCdpWQQiZcd6+cYTdblI6aGyvlx+HLGj
	eISCuiCo5CmuYuGj6oGUsbE5cK4dXIHW0POUq6iwVEI+n6OcLXGWc8nMeX3us2ksH6YpCcyHsmx
	MO7wsaINYp+WUwMUnzSpyPMFB7fhm0lg=
X-Gm-Gg: AeBDievNAEdZTXfIGFCi/OWP9T9mKJxSL829clnVYGwOYd5itkfB9tHzUEtNIQ7HyKq
	bbnl6XWT6/lnQoFqCZDDbZg8wNR2bQgJzwYE24xFJ2twUPuvvRnTxitjEHoFrW9uTQxg68ZFuuV
	x/vtV+4BPg9f+NGYXDSimjK7cvAPazhQ5TWDrvhTuR/Xs7NvNK7+/fSk3m9+lwRBmB+ZUyimmp6
	6Lv3qat+j0T4zZZ+ucxpgrMoMcqa7W5B9do4hOBqAyzLKxDOV4rA6uEvJuwPF4g/8+yIrt++eib
	QxabfC385rH8sALf0LZLl2n3WiuSyMF+lA==
X-Received: by 2002:a05:6000:2c0c:b0:43f:e22e:e8da with SMTP id
 ffacd0b85a97d-43fe3dc5b0bmr36635519f8f.5.1776885496593; Wed, 22 Apr 2026
 12:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422103603.4554-1-liwang@kylinos.cn>
In-Reply-To: <20260422103603.4554-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Apr 2026 12:18:03 -0700
X-Gm-Features: AQROBzCaS-8QbjrPyc2l81Nj3dNveAR9eyl0wnJlAUBz2SfvlWkj0od-yQhU1ss
Message-ID: <CAJnrk1bfCM3kF83mA5z4iPcw+w1_MHbrF4X2K7kLNRagtPD=XQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix kernel NULL pointer dereference in fuse_uring_add_to_pq()
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 3:38=E2=80=AFAM Li Wang <liwang@kylinos.cn> wrote:
>
> A kernel NULL pointer dereference was triggered when testing the
> 'fuse over io_uring' feature with passthrough_ll. The call trace
> is as follows:
>   BUG: kernel NULL pointer dereference, address: 0000000000000878
>   RIP: 0010:fuse_uring_add_req_to_ring_ent+0x89/0xd0 [fuse]
>   Call Trace:
>   <TASK>
>   fuse_uring_queue_fuse_req+0x82/0x100 [fuse]
>   fuse_chan_send+0xe6/0x180 [fuse]
>   fuse_lookup_name+0x131/0x2b0 [fuse]
>   fuse_lookup+0x78/0x1a0 [fuse]
>   fuse_atomic_open+0xfc/0x140 [fuse]
>   atomic_open+0x4b/0xf0
>   path_openat+0x746/0x1080
>   do_file_open+0xc9/0x180
>
> fuse_uring_create_queue() must initialize struct fuse_pqueue before assig=
ning
> the per-hash processing table:
>
> - Call fuse_pqueue_init() before setting fpq.processing. fuse_pqueue_init=
()
>   clears fpq.processing; assigning the kcalloc'd bucket array must happen
>   afterwards.
>
> - After allocating the processing bucket array with kzalloc_objs(), initi=
alize
>   each list head with INIT_LIST_HEAD(), matching fuse_pqueue_alloc() in d=
ev.c.
>   Zeroed list_head values are not valid empty lists; list_move_tail() wou=
ld
>   dereference NULL prev/next.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>
> ---
>  fs/fuse/dev_uring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index d6d75e024b35..b765c1ff5e2d 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -282,6 +282,8 @@ static struct fuse_ring_queue *fuse_uring_create_queu=
e(struct fuse_ring *ring,
>                 kfree(queue);
>                 return NULL;
>         }
> +       for (int i =3D 0; i < FUSE_PQ_HASH_SIZE; i++)
> +               INIT_LIST_HEAD(&pq[i]);
>
>         queue->qid =3D qid;
>         queue->ring =3D ring;
> @@ -295,8 +297,8 @@ static struct fuse_ring_queue *fuse_uring_create_queu=
e(struct fuse_ring *ring,
>         INIT_LIST_HEAD(&queue->fuse_req_bg_queue);
>         INIT_LIST_HEAD(&queue->ent_released);
>
> -       queue->fpq.processing =3D pq;
>         fuse_pqueue_init(&queue->fpq);
> +       queue->fpq.processing =3D pq;
>
>         spin_lock(&fch->lock);
>         if (ring->queues[qid]) {
> --
> 2.34.1
>

Thanks for testing/reporting this! This lgtm but afaict, the patches
in that patchset aren't finalized yet so imo it'd be cleaner if this
gets folded into the original patch [1] instead of being its own
separate commit.

I think using fuse_pqueue_alloc() ends up being a tad bit cleaner, eg

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 5abf447e9710..e467b23e6895 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -277,7 +277,7 @@ static struct fuse_ring_queue
*fuse_uring_create_queue(struct fuse_ring *ring,
        queue =3D kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
        if (!queue)
                return NULL;
-       pq =3D kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
+       pq =3D fuse_pqueue_alloc();
        if (!pq) {
                kfree(queue);
                return NULL;
@@ -295,8 +295,8 @@ static struct fuse_ring_queue
*fuse_uring_create_queue(struct fuse_ring *ring,
        INIT_LIST_HEAD(&queue->fuse_req_bg_queue);
        INIT_LIST_HEAD(&queue->ent_released);

-       queue->fpq.processing =3D pq;
        fuse_pqueue_init(&queue->fpq);
+       queue->fpq.processing =3D pq;

after exporting fuse_pqueue_alloc() into fuse_dev_i.h

Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/20260416091658.462783-32-mszeredi@re=
dhat.com/
