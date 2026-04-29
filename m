Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60C519D093
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473824; cv=pass; b=eK7XrCLUm8e4xtmLVNmSzDcSZZ/q3jxFU/u4XgUBiE5gRSA+PQvaZRGvYjMRrKlNAbjYnEYwxcAPEmpkFc6PIACSmeUYKZIOK5r7KxMbzcXjB2MBB6cY7jNW2TUyAm5kGHVTm+IHetsW1vmbW4hh6sGlvOyziRmTYjX1u8oVBjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473824; c=relaxed/simple;
	bh=fj9iIvQFKBIOmBHpxpjyaNLWsWgXEdXq1L17P4HQT4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XIVZT9R572DTLDKYHbSaTB4oCEynrMw87x0Egce6GY9CeEaoCVBA4uncvpxMBnbPzS0yOrkSCxAButf2CF7ZpRVYEl1V5bpiUvG/lCYVKN9XGr67dVQ/NN6GbnM3MZwUKLiSKeOCn9CwkN1vm2CbVL8NUx9eo5OqpY0YsE9VCxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvb4cOX2; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvb4cOX2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so92518425e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 07:43:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777473821; cv=none;
        d=google.com; s=arc-20240605;
        b=f+MG3uha7Loh6GTqqg9CtroTSuGSERkClJ6P5GyxX4jbzeDpiDBOwUX5Jc/ge5BlDS
         qDr9M0ElVjGOlg8Jo2si9B1kxVykoutDDUfife7tZosfKr7RREJDooGWbimePawk5f8f
         s5QbQsLjSo5rU9vEt/FnKLtdpVxIlYd1RnilOV44btI3SsjyUzSlMLt8/JrxJR+Y+EIu
         /Ut2PxnvhG+yKwUpUylfFezbL1UAcovwQHPARje3B86MjnoA5+XhTzBk1g2Ulpe3/Po2
         vbtNzRPtmLeTB9Usg54aVuBV7emsb/LF7AgQuXIR5+ZhCKWIbvFRE5XdgZpghgSGsRuu
         Rzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YQyYnKOozsqEcFsWu45yCfJGFA7QJUJjXimQIfepk+A=;
        fh=5Uimnkoom9hHbigEnM07b6LCdSJ4cB3nC5zC3m1R6VM=;
        b=ki2uJ/14uawgp/tQblPjrxCC4v889I0X64wCGNwtnzrou9plC4NsIl/SG5GVsyo6Lc
         Du/ReGTBZ7ywK7wTKpPwutK90EofPfQ7/XjzQTZdnkGsG1vsS1iP578a2nsv8ahNF3Q5
         9yFtd5eTCKYOtnEYyxZh4uPQw11lOp/wHQBHk0eOKaNeDorO6l3st23+aIpCRw7c49BR
         p1DEJ0a76Hd2EIRxo7aX0zsrMkOvWkoOTcKmAJWyhb3VVxgb6kQCBbVFYBB8/zdZoQhD
         Nr3oE9+BLaWF1MiSfBdWZ4I26Aq+bpzqkolUFhUfPI/Ei6QAq3kly2Iy5tFr9a//s53t
         UKeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777473821; x=1778078621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQyYnKOozsqEcFsWu45yCfJGFA7QJUJjXimQIfepk+A=;
        b=gvb4cOX2SdxeI1/s+OJtYLOOQ2T22pN26L3jDAwCUObK6K+AP4eNJNkGmjpndmE7CY
         cNvCan9Ceuzg4dgLz6OmMyN0gh038s16BcoIQKEuSAgseA99p77eMpQ7E/tueH0bQwyl
         3CQBqp0SFGqKxpcUDgb3V34uoMT0MlLlsZjbSOD30r4xOxZrIaKoxtuhDNXcBnJiCWAs
         F4No3PYPveCtb+EgoHZ0Lif24ZFhO2VYbd+qX0QDpnZknKIYWeRKC3NkuChR81ErF9Cv
         qwiamPW/J6RB/SIw9Lkt7GlK8Zw3ODZIPYb1LZNkrgGHq9lRwe829PL89Q28/nBkv2IA
         eEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473821; x=1778078621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YQyYnKOozsqEcFsWu45yCfJGFA7QJUJjXimQIfepk+A=;
        b=VSqvbIxtD6BB4ZtcZ7RMXoe/9SYzLeycGt9DYtyU0gUgF0lpBfZF7JWVykCSddS/pq
         kxspZzNqRrjLRq0zqhv5rs1TUmIfGo7lTg1tFhqeEcApl3K+Yaq8TjLU7b6TobfsAOHF
         gGkIl5gpSqtkwrAcQ0EI/BX0RqXI1M5Ot2Ga57yvYdpnWcN+wdC5vLCCyDFqC7VC3Lb5
         WOa35P2mQTiEaLDi8S6A8TOyJwXOyAPBmykBgIkJX04PcMcqWDRKWJ8qp4MiK0Ylo3q0
         5Xddqfld/ps7mnZUocwDINMJKaOKcJWsXQvtEXtKO4TwS4vhg3EvyCstfKr9qInnXfDq
         kc5w==
X-Forwarded-Encrypted: i=1; AFNElJ+/tznWGEHeoTXaYU6qAxJCQzag2nCjzJE0mAlvjo//DoKZfRbvmbdz1Up9gz/clG/U2bC/8uvJSJdZOzNW@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJUfEMCsAcjXyG6bTPYX9N83xKVWmFsh8HCF3AKZqef2QxMvx
	K8BkDXhSsJXx9X3JxSc+6flcuBk2CLjnmJJLBanmyDl7GbLwLYcRPxpKGAMG+NwAUM9bjfdnDTf
	aoENip6ucyNty2yNOWpzHKgoIarshhtk=
X-Gm-Gg: AeBDies6utpYjAptDEURST3hzmLoiLGct/N8pVGNv19rxbXsrc+g+OTRBAIO3iNbgL4
	fwrG0pOvfql1kUTbd+MP3mmVIFH629VJIbTNBj5lD9OL1ZdQKbtgcw9My5DJioGcwlnXe4Qzq3B
	HkXDijslGyQpsJJpUVhwtGhULJmeU9DJAXnTcCkIdhOLqMN/RIxIG8UYEqBHEvvI+cAoxEXjiOM
	9lNzB4HmpqWARyn4AKCmtq3bzP53FnJD7cmxq3oBavcyaMCNh1aLHKLsMiwf2LpagUVEzV/Z347
	ZCIYi0AVI21x17U+A/t74aBKU0+q1jxfwcSBFUIiV9GV
X-Received: by 2002:a05:600c:a401:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-48a77add545mr95173445e9.4.1777473820913; Wed, 29 Apr 2026
 07:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com> <20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 29 Apr 2026 15:43:26 +0100
X-Gm-Features: AVHnY4J-IPJUmpQOmyfZVsd_ZMwLIW8Vlu-oJIekFLSnMrLqj6PHVe28hq4F7d0
Message-ID: <CAJnrk1ZBFkQSE1XGvM0zuVpiMVpCvh7W8nrbsbFRt2Upt-KAAg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] fuse: {io-uring} Queue background requests on a
 different core
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
> Running background IO on a different core makes quite a difference.
>
> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread \
> --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_based\
> --runtime=3D30s --group_reporting --ioengine=3Dio_uring\
>  --direct=3D1
>
> unpatched
>    READ: bw=3D272MiB/s (285MB/s) ...
> patched
>    READ: bw=3D650MiB/s (682MB/s)
>
> Reason is easily visible, the fio process is migrating between CPUs
> when requests are submitted on the queue for the same core.
>
> With --iodepth=3D8
>
> unpatched
>    READ: bw=3D466MiB/s (489MB/s)
> patched
>    READ: bw=3D641MiB/s (672MB/s)
>
> Without io-uring (--iodepth=3D8)
>    READ: bw=3D729MiB/s (764MB/s)
>
> Without fuse (--iodepth=3D8)
>    READ: bw=3D2199MiB/s (2306MB/s)
>
> (Test were done with
> <libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
> [-o io_uring] /tmp/source /tmp/dest
> )
>
> Additional notes:
>
> With FURING_NEXT_QUEUE_RETRIES=3D0 (--iodepth=3D8)
>    READ: bw=3D903MiB/s (946MB/s)
>
> With just a random qid (--iodepth=3D8)
>    READ: bw=3D429MiB/s (450MB/s)
>
> With --iodepth=3D1
> unpatched
>    READ: bw=3D195MiB/s (204MB/s)
> patched
>    READ: bw=3D232MiB/s (243MB/s)
>
> With --iodepth=3D1 --numjobs=3D2
> unpatched
>    READ: bw=3D366MiB/s (384MB/s)
> patched
>    READ: bw=3D472MiB/s (495MB/s)
>
> With --iodepth=3D1 --numjobs=3D8
> unpatched
>    READ: bw=3D1437MiB/s (1507MB/s)
> patched
>    READ: bw=3D1529MiB/s (1603MB/s)
> fuse without io-uring
>    READ: bw=3D1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
> no-fuse
>    READ: bw=3D2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...
>
> In summary, for async requests the core doing application IO is busy
> sending requests and processing IOs should be done on a different core.
> Spreading the load on random cores is also not desirable, as the core
> might be frequency scaled down and/or in C1 sleep states. Not shown here,
> but differnces are much smaller when the system uses performance govenor
> instead of schedutil (ubuntu default). Obviously at the cost of higher
> system power consumption for performance govenor - not desirable either.
>
> Results without io-uring (which uses fixed libfuse threads per queue)
> heavily depend on the current number of active threads. Libfuse uses
> default of max 10 threads, but actual nr max threads is a parameter.
> Also, no-fuse-io-uring results heavily depend on, if there was already
> running another workload before, as libfuse starts these threads
> dynamically - i.e. the more threads are active, the worse the
> performance.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index e68089babaf89fb81741e4a5e605c6e36a137f9e..ed061e239b8ed70ff36deb51d=
d6957fe1704ec87 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1306,13 +1306,21 @@ static void fuse_uring_send_in_task(struct io_tw_=
req tw_req, io_tw_token_t tw)
>         fuse_uring_send(ent, cmd, err, issue_flags);
>  }
>
> -static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring =
*ring)
> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring =
*ring,
> +                                                      bool background)
>  {
>         unsigned int qid;
>         int node;
>         unsigned int nr_queues;
>         unsigned int cpu =3D task_cpu(current);
>
> +       /*
> +        *  Background requests result in better performance on a differe=
nt
> +        *  CPU, unless CPUs are already busy.
> +        */
> +       if (background)
> +               cpu++;
> +

I think this may cross numa boundaries in some cases. I think it would
be relatively straightforward to just route the background request to
a different queue on the same numa node, using the
ring->numa_q_map[cpu_to_node(cpu)] bitmap that you have? There's a
cpumask_next_wrap() helper function that returns back the next bit set
in the cpumask after a passed-in index.

If you don't have time to make this change though, i can send a
follow-up for this.

Thanks,
Joanne

>         cpu =3D cpu % ring->max_nr_queues;
>
>         /* numa local registered queue bitmap */
> @@ -1356,7 +1364,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>         int err;
>
>         err =3D -EINVAL;
> -       queue =3D fuse_uring_select_queue(ring);
> +       queue =3D fuse_uring_select_queue(ring, false);
>         if (!queue)
>                 goto err;
>
> @@ -1400,7 +1408,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>         struct fuse_ring_queue *queue;
>         struct fuse_ring_ent *ent =3D NULL;
>
> -       queue =3D fuse_uring_select_queue(ring);
> +       queue =3D fuse_uring_select_queue(ring, true);
>         if (!queue)
>                 return false;
>
>
> --
> 2.43.0
>
>
