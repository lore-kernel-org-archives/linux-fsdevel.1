Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C737402433
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777481807; cv=pass; b=YHmxQrm6x2VWW4Q1U2B9gCAmzXfNg4zFbheSUTkVCVrQpgFdnFSOsbp8upHwkGoJajf4FjPQYgFnrtojwz6ZP+D9JQ8Pknbj06Sgdc4AITIhG1DZ9JXq5f+Gt1ZcNdQCNBLoMTn1XmAGxXHbFTlbM9Za9vsNexDIl83yWCc/LFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777481807; c=relaxed/simple;
	bh=fZ8Ycm7zKg1sP6KHX8gxASM6VaPgvHOTmOHq9x33OU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQ1WqICWlhRmOf4O+IkjldmGmqavzj1m9sGbcdVWw1XuXLAihGcXGmoGCTOua6HUI5K/aEfJ3wp+LDxD+74wZZ29B2B+5pQ54PlTYagU7RmirSVnydR7FCjfINw7HOtLsjaTxgeRhA9ijbE7hzrXf0wLrDIzdxoXYaPUJgczsT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfPw88hc; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfPw88hc"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-445795cf6f1so23037f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 09:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777481804; cv=none;
        d=google.com; s=arc-20240605;
        b=deWEdXp8Tcx/XKl90kQwTBYPy41txpwg9Pz7ybqsZnpAJ4gz13srDEhYxsLkSU6TVH
         syI6aCPH74bzj0izFn03WywvP7B8gA1b3kezQ0feXfEgqZbC6166Y3CTANsdGj0XJXKt
         zHwPav2OqyYdgc3WFlBZxTUaSBbecURwe/VBwEO9b2m9veKRGFHOTdQ3yYUmA4aC67XA
         IKHf966JMBT1oQ0mSKsfWonbLlyqmpbFlRUprcu7xKOgaJAfCAewMAvrm2QMwvOXJDSe
         jfVC8d49UpqG2V70ctWDyeAjwUqWG2zVpVz7N6dqDxpDLtOqXKP8gMqiRSkEMzp974K3
         apJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F0AXTpIEPm9MkFtFSOwIhJ7f5AmWbWFLbJPyiwMe590=;
        fh=CTE/GGaMNcuWxdNZ9I7+arl3AC9T874yPzndT2J5TSE=;
        b=OouqY37yzMNDl48PrW2AwBc/CGpj+Cnm/W+8hv/qrCclpnv5C+5riFWzcPJxlCKLaU
         IotyBBC+n8lM+jluFgRjY5QhDaBEHwgMaykskBXXr+TJw3qzK4c4Chrd45d0ZU5aHtuq
         TGYMPbZxP/GVHZp0UxPB4GTLpYAqDg2M82V1JHER6hoL4JKBqu9zrFgnktwazQR5SH4G
         mQGPx180ysAkp/+Qx7k9Ocv7r2RKIQ6mL+kR4tZWddr/QnfYFPEISI73uCLjLLwZT8b4
         ljjYF9tUNe/tX/fmmh1cnn4SVztlwz0h4nzmBlqbs1ckaUvWmWVc/Yp4h9KJsZDUSyVw
         a7dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777481804; x=1778086604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0AXTpIEPm9MkFtFSOwIhJ7f5AmWbWFLbJPyiwMe590=;
        b=RfPw88hcIzMiLoR/xMvPgDaDhx9PqIRaXLn1pQEXeO20q6aitp1EH5Y/klSMSwbDEG
         GCfKIL2EkjGMTxKpS5t9LqW2DVAE8y4y6MneAh1nrnoCSEDdoWz1ov+cBM1EmwaSa10P
         njxN0Fr/rNMbwJFjbC+FjpNKjzLfGDtGRqGa0v/7G1zoraIIv+2WqCxIf0uqQHjk2jbU
         P/XFl7lnRwv8b47k0x/aqI/HcV+BWcNovX8T3G1fprwgae0pVWIiBDvQM21aCLd9rmIm
         O6IpHLWkCYcWX9QTpdx6wqf8oiiVCa7HgTBfTG1jrX/T89gKSl/yqorydP8QJ5PZZjr3
         JdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777481804; x=1778086604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0AXTpIEPm9MkFtFSOwIhJ7f5AmWbWFLbJPyiwMe590=;
        b=Yf3ONDpUoiB8hnZ6Sa1aRijIN9pVWQWLHRJAiipDblJF4H5purGWw+4iXTVjamsKo8
         sgCDRRP6w+yQSwBtvxrKx+U4c7HdSnQK7qugKeyZtYtB2pAcY7LTlWPGlCCDML5oBLAG
         UtBT3qganyT2Za0VCIS+SwoRs+h7Dbk7K4trf13sfTTPqjBRYydBFULcOwcUgfJCYg0M
         nhdI+fsv04LO0dwVsTva7DrBcGF6lITdPjSUMBGs8ziSSi2sPanHKxfV7j1XMU05CHDW
         IbmWleG3ntj5CjHpDTfAtJ46PbGpcs/AzOc3tw4CGeTo41OpIL7Yex1LAiAqRehW9X1H
         oXiA==
X-Forwarded-Encrypted: i=1; AFNElJ/7zEBO1eJT2ZHHEnu3aVcuHreK3aHaw2y2+mtgqx4kod9Jbf+UqWyP9W+68gRWFxFx1oTzdd+849X2tf+F@vger.kernel.org
X-Gm-Message-State: AOJu0YxPO3d/Fzg/E/ijILCLtFXyhhecE+rIRHAOeRnSZ3bJY94rTkRT
	etHf1Q2G+c6hYZ4Ohl9avTOwAw9V0vGzDQuBNvBx8rJptcjJS5matmj91eQD6JfGGgaz3xMsYA5
	moU4xXs5A8NDMcVkron60HBG87HH89AY=
X-Gm-Gg: AeBDiev/XeV5Z5ir9QVZzBuPMe7TlV2PJO6NwXR6sFtaTWNfqvnW4hjHhtNoFc81KrZ
	XTwDQFov1vYdypcs77b3mHECKwfRY3nB4BxQPZZX0Tz6mhtdLpwwKjo4ePk0u2A6D60H1PjQjDR
	gc6f7rxPp8JOF2HpVdY5RL/a8qawpuszlfN9HLyYudJMAqPuzTWRFwr9RmIizZh3so39ugd/Qoo
	XuzrZtyFSkam3kRU29ercwQ64hrly8tZnztIrJaB+MZAYj3EtH6MjSLfYqhM5eZDRCyaNtPacb1
	aIeRIdbAEBcZ+xia7GzuIXni8n4rRGJJDA==
X-Received: by 2002:a5d:64e4:0:b0:43d:9bb5:bd9a with SMTP id
 ffacd0b85a97d-4464aced574mr15609133f8f.23.1777481803667; Wed, 29 Apr 2026
 09:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
 <CAJnrk1ZBFkQSE1XGvM0zuVpiMVpCvh7W8nrbsbFRt2Upt-KAAg@mail.gmail.com> <f3031d36-0f58-432b-8494-7cf6b1762925@ddn.com>
In-Reply-To: <f3031d36-0f58-432b-8494-7cf6b1762925@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 29 Apr 2026 17:56:29 +0100
X-Gm-Features: AVHnY4IMAJa3VXKhrChMf8gnvd65E17wNGXIsRXVlLIT_27wmjd9GXEX1dAltmE
Message-ID: <CAJnrk1Z27=vrW4tC6czXP3T2TSV3aQ06Agp=xQvbmvJ41nrCug@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] fuse: {io-uring} Queue background requests on a
 different core
To: Bernd Schubert <bschubert@ddn.com>
Cc: bernd@bsbernd.com, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 5:01=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
>
> On 4/29/26 16:43, Joanne Koong wrote:
> > On Mon, Apr 13, 2026 at 10:41=E2=80=AFAM Bernd Schubert via B4 Relay
> > <devnull+bernd.bsbernd.com@kernel.org> wrote:
> >>
> >> From: Bernd Schubert <bschubert@ddn.com>
> >>
> >> Running background IO on a different core makes quite a difference.
> >>
> >> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread \
> >> --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_based\
> >> --runtime=3D30s --group_reporting --ioengine=3Dio_uring\
> >>  --direct=3D1
> >>
> >> unpatched
> >>    READ: bw=3D272MiB/s (285MB/s) ...
> >> patched
> >>    READ: bw=3D650MiB/s (682MB/s)
> >>
> >> Reason is easily visible, the fio process is migrating between CPUs
> >> when requests are submitted on the queue for the same core.
> >>
> >> With --iodepth=3D8
> >>
> >> unpatched
> >>    READ: bw=3D466MiB/s (489MB/s)
> >> patched
> >>    READ: bw=3D641MiB/s (672MB/s)
> >>
> >> Without io-uring (--iodepth=3D8)
> >>    READ: bw=3D729MiB/s (764MB/s)
> >>
> >> Without fuse (--iodepth=3D8)
> >>    READ: bw=3D2199MiB/s (2306MB/s)
> >>
> >> (Test were done with
> >> <libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
> >> [-o io_uring] /tmp/source /tmp/dest
> >> )
> >>
> >> Additional notes:
> >>
> >> With FURING_NEXT_QUEUE_RETRIES=3D0 (--iodepth=3D8)
> >>    READ: bw=3D903MiB/s (946MB/s)
> >>
> >> With just a random qid (--iodepth=3D8)
> >>    READ: bw=3D429MiB/s (450MB/s)
> >>
> >> With --iodepth=3D1
> >> unpatched
> >>    READ: bw=3D195MiB/s (204MB/s)
> >> patched
> >>    READ: bw=3D232MiB/s (243MB/s)
> >>
> >> With --iodepth=3D1 --numjobs=3D2
> >> unpatched
> >>    READ: bw=3D366MiB/s (384MB/s)
> >> patched
> >>    READ: bw=3D472MiB/s (495MB/s)
> >>
> >> With --iodepth=3D1 --numjobs=3D8
> >> unpatched
> >>    READ: bw=3D1437MiB/s (1507MB/s)
> >> patched
> >>    READ: bw=3D1529MiB/s (1603MB/s)
> >> fuse without io-uring
> >>    READ: bw=3D1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
> >> no-fuse
> >>    READ: bw=3D2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...
> >>
> >> In summary, for async requests the core doing application IO is busy
> >> sending requests and processing IOs should be done on a different core=
.
> >> Spreading the load on random cores is also not desirable, as the core
> >> might be frequency scaled down and/or in C1 sleep states. Not shown he=
re,
> >> but differnces are much smaller when the system uses performance goven=
or
> >> instead of schedutil (ubuntu default). Obviously at the cost of higher
> >> system power consumption for performance govenor - not desirable eithe=
r.
> >>
> >> Results without io-uring (which uses fixed libfuse threads per queue)
> >> heavily depend on the current number of active threads. Libfuse uses
> >> default of max 10 threads, but actual nr max threads is a parameter.
> >> Also, no-fuse-io-uring results heavily depend on, if there was already
> >> running another workload before, as libfuse starts these threads
> >> dynamically - i.e. the more threads are active, the worse the
> >> performance.
> >>
> >> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >> ---
> >>  fs/fuse/dev_uring.c | 14 +++++++++++---
> >>  1 file changed, 11 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> >> index e68089babaf89fb81741e4a5e605c6e36a137f9e..ed061e239b8ed70ff36deb=
51dd6957fe1704ec87 100644
> >> --- a/fs/fuse/dev_uring.c
> >> +++ b/fs/fuse/dev_uring.c
> >> @@ -1306,13 +1306,21 @@ static void fuse_uring_send_in_task(struct io_=
tw_req tw_req, io_tw_token_t tw)
> >>         fuse_uring_send(ent, cmd, err, issue_flags);
> >>  }
> >>
> >> -static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ri=
ng *ring)
> >> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ri=
ng *ring,
> >> +                                                      bool background=
)
> >>  {
> >>         unsigned int qid;
> >>         int node;
> >>         unsigned int nr_queues;
> >>         unsigned int cpu =3D task_cpu(current);
> >>
> >> +       /*
> >> +        *  Background requests result in better performance on a diff=
erent
> >> +        *  CPU, unless CPUs are already busy.
> >> +        */
> >> +       if (background)
> >> +               cpu++;
> >> +
>
> Thanks a lot for your reviews!
>
> Ah yes, I think the fix is straight forward, by only getting the
> numa node once on entering the function.
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 44e1b795a636..dbccaa0971c9 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1321,6 +1321,14 @@ static struct fuse_ring_queue *fuse_uring_select_q=
ueue(struct fuse_ring *ring,
>         unsigned int cpu =3D task_cpu(current);
>         struct fuse_ring_queue *queue, *primary_queue =3D NULL;
>
> +       /* numa local registered queue bitmap */
> +       node =3D cpu_to_node(cpu);
> +       if (WARN_ONCE(node >=3D ring->nr_numa_nodes,
> +                     "Node number (%d) exceeds nr nodes (%d)\n", node,
> +                     ring->nr_numa_nodes)) {
> +               node =3D 0;
> +       }
> +
>         /*
>          *  Background requests result in better performance on a differe=
nt
>          *  CPU, unless CPUs are already busy.
> @@ -1331,14 +1339,6 @@ static struct fuse_ring_queue *fuse_uring_select_q=
ueue(struct fuse_ring *ring,
>  retry:
>         cpu =3D cpu % ring->max_nr_queues;
>
> -       /* numa local registered queue bitmap */
> -       node =3D cpu_to_node(cpu);
> -       if (WARN_ONCE(node >=3D ring->nr_numa_nodes,
> -                     "Node number (%d) exceeds nr nodes (%d)\n",
> -                     node, ring->nr_numa_nodes)) {
> -               node =3D 0;
> -       }
> -
>         nr_queues =3D READ_ONCE(ring->numa_q_map[node].nr_queues);
>         if (nr_queues) {
>                 /* prefer the queue that corresponds to the current cpu *=
/
>

I think this still runs into some numa-crossing issues. for example if
cpu 3 is in node 0 and then cpu 4 is in node 1, the

        if (nr_queues) {
                /* prefer the queue that corresponds to the current cpu */
                queue =3D READ_ONCE(ring->queues[cpu]);
                if (queue) {
                        if (queue->nr_reqs <=3D FUSE_URING_Q_THRESHOLD)
                                return queue;
                        primary_queue =3D queue;
                }

                qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];

check will still assign it to node 1 in the "queue =3D
READ_ONCE(ring->queues[cpu])" line and in the last line (" qid =3D
ring->numa_q_map[node].cpu_to_qid[cpu];") I think this will just
default to assigning it to queue 0 since cpu 4 is not node 0's
cpu_to_qid mapping.

imo the simplest way to get around this would be to use the node's
registered_q_mask map with cpumask_next_wrap().

Thanks,
Joanne

>
> >
> > I think this may cross numa boundaries in some cases. I think it would
> > be relatively straightforward to just route the background request to
> > a different queue on the same numa node, using the
> > ring->numa_q_map[cpu_to_node(cpu)] bitmap that you have? There's a
> > cpumask_next_wrap() helper function that returns back the next bit set
> > in the cpumask after a passed-in index.
>
> I think the code already does that, except that it needs the change above=
.
>
> >
> > If you don't have time to make this change though, i can send a
> > follow-up for this.
>
> Friday is a public holiday, I should be able to send an update that day.
>
> Thanks,
> Bernd
>
