Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD432ED3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 15:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475044; cv=pass; b=JW/v1XPI7V5dIY6tS7byHWTJUGBVZPHtrfQ9TRndj6/BFRKgNys1l97RmQIXPqOS1WpoAoUhZFQtrhzoqVPrNuWP0yV+0/ABA4Alo6t2lZJMFwov1T2xR8mDMgfBD5M5n+P0L6Sk/AAUgwfS4jfSfxEJr7aWgXrIdH6gk9klvfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475044; c=relaxed/simple;
	bh=Xn20Ep0tJPb6WHmgTqwdnOP1UwpdDBwOlR2HlD3WKso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqdWhHuUCF+wJEhuF+O4QBGrP+af7/LDGnDxIysEXlytVlkCMMaeXj0e7nKA0ffxAiQnL1i3QaGzjZOfK83ZyuFgGki1cj5VPNaqGfW9MUo+OBDeJvGTNHI1DDQXguJ1scDlh3Xihk5KJv1gD2i0/labMJ5aqHTmbJzyr/9RHlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bL5rOFAl; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bL5rOFAl"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d77f6092eso8836183f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 08:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777475041; cv=none;
        d=google.com; s=arc-20240605;
        b=ZoZiwY93uSn2eYPh1DmPasEF5nKmkbCFN21O9fjDiR3x9B6itsxFh9M/G6h+zVrQm9
         ZEIvlGatQhGgQPm9XbxD+Ivd2nu2Zi+K0PbtuoH3TzW3OERk306Anvmlw/Px3Si+koNZ
         n8jmSUcchDMX4BexiFf0dCCHPaMxLy8Jl12RyNgCvLrLxF57W/k6WmeIw8rc3YvU1TnL
         Lx5KhPiAAWLmYI3/2Z9C5UM7O8prv2Jb4P2MZepk+JDRh87fU9KBWrd3NYXWu2PPnEVR
         /z2RcAaltQ1XxSaweibvH5avv+yO1pPJN8NzOyIkgBMsWZuVphByDrAHO+G0sbzhH4+9
         3YHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xWpd90+cmHWeA9XoXlyEHizHPtSDMuT7ivtRzIUY78M=;
        fh=G37a5Bx9A3DOn8Vld6QIGcyTn+LlnRhCAu7lDaDaguM=;
        b=Hrxd/S5PCYTG7WMeNMFFAesRp03VGt5RigMN6U+VMbNVQSJCVU2gSefR/pDTl3GUEa
         U4rm38T+YGptg9KRi+eexJWiRL63kLGNcycToUN8fnu/9gJAJ1fiEAHoB5uE55owTZnL
         6hIaPN5vCBRj1xx7jSQ1EKXEPuikTXpKZ02smOdhfb3ASpRiER/C4rJZSbruD57vTKI4
         eJvVgrCjynKU4WYd2NakFaMzomibsFMFxDTTeBx9FETZLVxEMK3Itu65bNB9nyzkJXo9
         UKiXNq9akkBEWqt8i2XoqpdxeNpB4D6Jg1gy3UbsfEn/qQFKxllpykEUXnEUffSI9qsU
         bVNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777475041; x=1778079841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWpd90+cmHWeA9XoXlyEHizHPtSDMuT7ivtRzIUY78M=;
        b=bL5rOFAl1qocfS8nzHAyj4UPKSjp0iqiWw2+gxiT7rNm/N6aT6LdXKjraUSC0RiNfK
         1UDCsqwA5y+hg3YTFhNveW1ZxLcrszipe79VqwXoFh7qHSHBbyfuLhQy0lmL+GBaLdfB
         gN4aauYuuSlxicdhg88WwygGiXfcVT3aapmpAydN98HSXytsqSIAbFxYxXEaT68ZBQVv
         VuANQBVJbHO9KFHrTM7i7kSXpGusCSJg3CNd/rOlGQm+fmQzliYZnHZEdhcuopaTZzki
         yLTB81xfCcTceeDzuv72QGttoTQUdzX6+i/0Ud6I3PI4zTnn9cUFbi5fHHUztOg1pqL5
         Ypvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777475041; x=1778079841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xWpd90+cmHWeA9XoXlyEHizHPtSDMuT7ivtRzIUY78M=;
        b=LCfsuIZ8LQihp5NxITRf/zfv1JjwJ7Ac4JwkF1T1g9lCHeo/mCG28qwj1yXxEc11jM
         DjYiNaWxCZODaBefRunC0yiOGf2t3u3mkwIFUmClLuOf0Ogi/xYWlGIruNpsPi56FLi1
         1wB7NGmZq+PX76s/SLvCaKMH8wHlGbFrMFrSR/T1G/4vZM6oRIUeWn/0tfKe4F+q7s1+
         SZFodFscTMkK8IBMusdsR+aRcRfU0ol0l00Cv47XtNzSdZT/ncIZZ8wtWSl8i0njcziw
         /jBOwl1WjjI0kJSehjB4nbKp81t6ytVPC25tvBYTsqWEr03iB2kY6SM5gzsb/yr2xthL
         dwbA==
X-Forwarded-Encrypted: i=1; AFNElJ8ntMxKQzt3az1yMeYul4TKZIcFde6A9n0kE9md2yEId97zgIhs0/6MHoeVZhgFJWtJ1HWCD5Fy8yy+z+y7@vger.kernel.org
X-Gm-Message-State: AOJu0YyISylcemlZNirLgFZFjef+ipXe9ZZrNCWl9iGosvv3Opmd/ZvF
	CYdbrLxSV7xyWoEASn0lHSFBuLyTEKWyqZ6dunRDD0Zhiy7ZZXLcyv38MlLr4wqEevHKoz0Ke7i
	XpqncbGJ4MtMDyzWOhTSn/fLpYCF0HH4=
X-Gm-Gg: AeBDieuZcSgNpxYAOl3Jh1bVKEKh7XZoHD5ijWXyvk1lxt36B1+6gBJSlsZEaiPnsrH
	6IBWZ2cWEYQ7mNdyPecqC3iKIzszmjna1WJ3Z0FMmMUZJJGKlUWkeRn/oDeOMpPgNkQFUIkylg7
	PzmcHajcZkRwcmLhPoFDRrmUMqTEtj2QofVB6w6rOZbVH8f5Ky9FtK+H23YwS/wjnF3NqjquaFl
	KQ2Ak2BLC8S3utr2D7VgI++YB50pnCR5G0hd+nSrKPxbPitEUbP8Idmp800P7QdZxVfaH7KY1t2
	Ysq512Stw2sFof429OGA99AXGPW08wjt5A==
X-Received: by 2002:a05:6000:18a4:b0:43d:7e11:1b72 with SMTP id
 ffacd0b85a97d-44648f28e43mr14711998f8f.9.1777475040962; Wed, 29 Apr 2026
 08:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com> <20260413-reduced-nr-ring-queues_3-v4-7-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-7-982b6414b723@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 29 Apr 2026 16:03:46 +0100
X-Gm-Features: AVHnY4KHgDY89ptBGr1CKpl_TLkEoKyeuzyb5IGJRn_XlO8dsibZ_Hu5NOygwK8
Message-ID: <CAJnrk1ZnJ-p4aPCkk8=1v5bMFgo50GzGiixZuom9P=3p-nMTrg@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] fuse: Add retry attempts for numa local queues for
 load distribution
To: bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:41=E2=80=AFAM Bernd Schubert via B4 Relay
<devnull+bernd.bsbernd.com@kernel.org> wrote:
>
> From: Bernd Schubert <bschubert@ddn.com>
>
> This is to further improve performance.
>
> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread \
> --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_based\
> --runtime=3D30s --group_reporting --ioengine=3Dio_uring\
> --direct=3D1
>
> unpatched
>    READ: bw=3D650MiB/s (682MB/s)
> patched:
>    READ: bw=3D995MiB/s (1043MB/s)
>
> with --iodepth=3D8
>
> unpatched
>    READ: bw=3D641MiB/s (672MB/s)
> patched
>    READ: bw=3D966MiB/s (1012MB/s)
>
> Reason is that with --iodepth=3Dx (x > 1) fio submits multiple async
> requests and a single queue might become CPU limited. I.e. spreading
> the load helps.
> ---
>  fs/fuse/dev_uring.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ed061e239b8ed70ff36deb51dd6957fe1704ec87..e06d45b161d5000e24431314b=
2222b66bdea58aa 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -19,6 +19,7 @@ MODULE_PARM_DESC(enable_uring,
>
>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
>
> +#define FUSE_URING_Q_THRESHOLD 2
>
>  bool fuse_uring_enabled(void)
>  {
> @@ -1310,9 +1311,10 @@ static struct fuse_ring_queue *fuse_uring_select_q=
ueue(struct fuse_ring *ring,
>                                                        bool background)
>  {
>         unsigned int qid;
> -       int node;
> +       int node, retries =3D 0;
>         unsigned int nr_queues;
>         unsigned int cpu =3D task_cpu(current);
> +       struct fuse_ring_queue *queue, *primary_queue =3D NULL;
>
>         /*
>          *  Background requests result in better performance on a differe=
nt
> @@ -1321,6 +1323,7 @@ static struct fuse_ring_queue *fuse_uring_select_qu=
eue(struct fuse_ring *ring,
>         if (background)
>                 cpu++;
>
> +retry:
>         cpu =3D cpu % ring->max_nr_queues;
>
>         /* numa local registered queue bitmap */
> @@ -1336,12 +1339,35 @@ static struct fuse_ring_queue *fuse_uring_select_=
queue(struct fuse_ring *ring,
>                 qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];
>                 if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
>                         return NULL;
> -               return READ_ONCE(ring->queues[qid]);
> +               queue =3D READ_ONCE(ring->queues[qid]);
> +
> +               /* Might happen on teardown */
> +               if (unlikely(!queue))
> +                       return NULL;
> +
> +               if (queue->nr_reqs < FUSE_URING_Q_THRESHOLD)

Should this use READ_ONCE(queue->nr_reqs) since nr_reqs may be
concurrently modified under the queue lock by other CPUs while we're
reading it locklessly here?

> +                       return queue;
> +
> +               /* Retries help for load balancing */
> +               if (retries < FUSE_URING_Q_THRESHOLD) {
> +                       if (!retries)
> +                               primary_queue =3D queue;
> +
> +                       /* Increase cpu, assuming it will map to a differ=
et qid*/
> +                       cpu++;

Here too I think cpu++ can break numa locality. In the reduced-queue
setup, I think cpu++ may have a solid chance at mapping back to the
same qid.

If we use the ring->numa_q_map[node].registered_q_mask and the
cpumask_next_wrap() helper to find the next qid in the numa node, i
think that will guarantee numa locality, a different qid, avoids
having to redo the whole cpu_to_node() + nr_queues lookup on each
retry, and will detect automatically when all queues on the node have
been tried.

If you dont have the bandwidth to consider this change for v5, I can
send a followup patch for it.

Thanks,
Joanne

> +                       retries++;
> +                       goto retry;
> +               }
>         }
>
> +       /* Retries exceeded, take the primary target queue */
> +       if (primary_queue)
> +               return primary_queue;
> +
>         /* global registered queue bitmap */
>         qid =3D ring->q_map.cpu_to_qid[cpu];
>         if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> +       /* Might happen on teardown */
>                 return NULL;
>         return READ_ONCE(ring->queues[qid]);
>  }
>
> --
> 2.43.0
>
>
