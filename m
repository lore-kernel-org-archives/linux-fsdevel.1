Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D9440B0E3
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763296; cv=pass; b=GNXHE/dK4BiPbGla1bStcyoK18VkP2YevzLzrvThCZrRP5FMTmAoFfuRvDmMzVOjTJSlAJOurJnnb4rebyvqbbm+R5kCw4LTLWImnfP/7/VN+G986I597mXPJguQqObil15wlV5yZrn2c1yqrqhC98VxvV8qG5P9C65S3h4X0L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763296; c=relaxed/simple;
	bh=Pgl5mTcqFOqWGOQn2TZduStirxwuSm2pRwIjZSucJwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6kGKTgfvcE0r4iUzdL/V/O/y/DKhmTqXp2BiUAwK/NkohcEen4sa6tzOu0ES7Qs99/g0UoIUIYvaPXal/5zVphiQ7YFkMC7Z2SKaiON+4o+rfJrlA7VXkBs277G2vqNcAF1zjC1m4fZBEGpGJwDptYng75cooW3db+ezTv+5Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvxRm/Zc; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvxRm/Zc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69f2c67650aso5274515a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 06:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785763289; cv=none;
        d=google.com; s=arc-20260327;
        b=ruAE6KLO2N79MUt6DPOQWVqCZu2+G8TUNt9GMeJrwRHQ7CLMv/hLj1WrNUf/n36pW3
         hxTwMaDK5x7J1JkjkZCbFF0BHt+d/VZOqjruQLUSvSgT9aGI0ii+qQ77oj4OJUxhvUhm
         TsSCalfbUkGpl1ynQlG5Z+LvbE42Zid+tFMLhI2YyZeAzi/Q/PR6HPNh5C+jCVtDscfW
         k5M0aQVdg9AmJyfYvKRqmJpQ0UrJwXpzYl5cmyWlVSsAwcO01R+P2mqaORNFE3t4/esU
         LXu00uJh4TmeTqaaaNCEjnoVseCSD0nRXV7EZJ2QV61Vg0M+63sTIuSfH2kC6T5whjPD
         ZVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        fh=y5I2lycqASMzW3r9n9NFt4flD8+Yqm3TCWfS09z99xI=;
        b=lTMA29+b7JdA+P5oX1Dfh3xNSJLA9lhR9BdPqa/Vgp7nesuUMSV9lKc+uAoAUBuhtm
         mmWrRCshkgnyaLivG9FN9skPsCnM9HunhwLxjh/v2NLIquT1szAmVVl5E0mvhF8/0mpy
         AUFrSCAMr8vNIbRhibtE+nrrGg974qrCAxVyF5ydUZRbrMDw9ec9zhquUHpxpWwXh5Rm
         cGMI9PBmDWAs7w3bUcV9S0EDuODjjtraDjwkDhuPe9/aUbw+yspdUpnITwcPysGfuqSq
         gIbVqaoArFr+I+PODYkIl87xkiFo9lDChcYDuJ1DibrVTBH9q47PmbLM8FjKT8m4hqsX
         qDJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785763289; x=1786368089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        b=dvxRm/ZcGYR2VElqHNvrbIbP9OvHsQkpvLJObV5wRx/fXOfUt29OLPtE+JvxWK2AOQ
         3VhaxWdK9wr8VU9F7OpdHh93UyXYln1zJIFeKxpY8byuq8uH5aOk6evZeGjO9IkqTptd
         6pqSXC4iIsTM5Q5hI3ihgFCpFYQmHAIH17jBmK2nWesFrnXCN+cLlB30cVLoPE7iBxPq
         YNZUhtvw1JycZThdfbfdyNVwsIyNlqZahx8PqEto4vhXRgRne7m4fkHUxVzQMxB0N/A0
         77oJ0UDkdALZBQIED3QKAmbqVImouGpGGwdcCJe4RsLDjGD4I5xyy4Jr8+HbjvOIgaqa
         GxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763289; x=1786368089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y/+lXFVTL8yRFLlIHwc83PXR9zbnjKq/x3zTQK5cH9A=;
        b=RREQRYF/dV3lp3qJJEIywBebBwIPqOqFH3fBE2XMghBYSEmm2nabpNLRcP6ONRaZgG
         eTtBvHV7zpxUX/JjJUS7TKMnUVTMCqds0xZ4zWP4iONWFGnVfhZfcZpSM7J2ccqRGc2h
         ofAHr8ntvNAgRYE/fLg4/HP4i3X98Saxs1P94zZKs2Dl343Vucd+Ph21weaLay2Xu+MD
         gLgKlZ/r6YWcre5aZW9cEbwUO5sm+3xSXeCRWuTH4weKRtJnKCgiMip0B+pIKINq5pDF
         /wcGtryUF24lqaI7/i/eAxP4dESNXSmI6baBnYUMdPfNP2d3t79XFHRsA+P1x6K+etTk
         hwCw==
X-Forwarded-Encrypted: i=1; AHgh+RpZtiu6kavm3qK03BPSMNydWDUn+Yq1wl/+x1d79SQFgQcRsiKUzM6GMe9zaXcWdOgtBxYxUqaE9n7UQqJ5@vger.kernel.org
X-Gm-Message-State: AOJu0YwOIBshgbWbUaIlW9Ji0dKSS0M3+SpQvzEoGhZUKXjGXGf0Ur/g
	w/gn8S0psVoBT3Ea2DS6HWIMIU0ueKP6AY8+OwpTAHWBfHJ+B5NHZ3lfHXmgW5pYy9pAb0pG5Ck
	oVZgXRJGWKEZCJ5vzUXU06nlmt72anQ==
X-Gm-Gg: AR+sD13AaVdGfbSUKCc1wbX2iOoSCmlTOzABgbA+cIIYnvdAB7ClMUy/fR7uvUo4Ze6
	AzLU+UYPBVqI7D7ByPhzjLkAW0qBWvLLoHdhEvrx6U4arbBGGWqzetyT2MIHGB+ZoKqGrd1hj+i
	6sNmFiNlzsoghTmr/Ny1T8iva2rFRpMSzlZtrS/w/SCKrgmtxyo4AXgNewhE2UEu8s2MBdN1OVy
	s5W7hRnBUZFtn9ibApsUrbv3z7EhPq7DRS8ErD1ZN+VzF11F7Xqo47IMYuruP0GrWhWygUwpqXp
	IEFp5ePwSr8faVj/AO0B6j1HwRDVV1TzlGEXAr3c26Fkh12ogdJMXI2g+R1cjrxrnfntctXz1PK
	enZ84b8qLQHeO4Aw=
X-Received: by 2002:a05:6402:21d9:b0:69c:794d:4862 with SMTP id
 4fb4d7f45d1cf-6a0a7c614f9mr7875783a12.7.1785763288576; Mon, 03 Aug 2026
 06:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785596451.git.asml.silence@gmail.com> <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
In-Reply-To: <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 3 Aug 2026 18:50:50 +0530
X-Gm-Features: AUfX_mwnLWCAPfRurFp37qU73Xc2KDpD6en6Q3cA2kgelroMq6uNFVC_YKEZqSE
Message-ID: <CACzX3AvwBF32_ODomei3XHSZ=KtRaWLN-_Tfkwv7sV3Ssc3wmw@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Phil Cayton <phil.cayton@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 1, 2026 at 9:19=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
> @@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const st=
ruct iov_iter *i)
>
>  unsigned long iov_iter_alignment(const struct iov_iter *i)
>  {
> -       if (likely(iter_is_ubuf(i))) {
> +       if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
>                 size_t size =3D i->count;
>                 if (size)
>                         return ((unsigned long)i->ubuf + i->iov_offset) |=
 size;

dmabuf_map shares the same union slot as ubuf, so this reads the map
pointer as a user address. gap_alignment() below already returns 0
correctly for dmabuf - this should too. Checked the rest of this patch
(advance/revert/restore) - none of them dereference the union pointer
for dmabuf, so it's isolated to this one spot. Doesn't affect the
current series, nothing reaches this with a dmabuf iter yet.

> @@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov=
_iter *i)
>         size_t size =3D i->count;
>         unsigned k;
>
> -       if (iter_is_ubuf(i))
> +       if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
>                 return 0;
