Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2EA391835
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776880442; cv=pass; b=XaWE9LWvNcOEDah2b0i6u46qDk6PP1sylKnKtAU8I5eGpL+9NXTCMtKqasJibJb93H1/3QLUP7IfUdCW4D/rX2lda32tRoPYFsMVowxzPoY7r3Doar08N5EQci0UXk3sGno6Wpxh5nVvxs8c0my6I+2v/a5D2sJPnh/BE1hCXzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776880442; c=relaxed/simple;
	bh=xy1B9rmgyFzMWJqr+hi7jhwQB2TmZLPGlpFyD0Hwn7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbqFcWiYS5WWn51O/2optRtAm67GeT3j8aH8EeL1eufg2XvHWIYwj9xnJZt8n2/YWGu9vRHu9DFr5bKwIoGQ52/hKOZqFxmPip0ZXX3zC/vXdl3WtgH8m6gjsbN6guLycBQpuqNVXLrpzZ84CZfXSEB+1RKWWMWvxLkBefLwvL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRM6TrQk; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRM6TrQk"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d77f6092eso3976300f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776880440; cv=none;
        d=google.com; s=arc-20240605;
        b=A6HivC/dsY5COhafhAnvuSSHtDkMkKGvIlagXmqpN/6WabeKIgjEcfft/GeCkemK+3
         KuIG2qX6tk0dVW94gzRg4rSoyBujXvzFoDzjKnKPTzCZX0BNPRXRHUfnX2n6lPRsNEVz
         zjAuXReW2vVoYY11Z91XB3UsDH0H2iS4gRGmQM9OTT2MtZMIH9SMOOB3Cj3STWXwrKmN
         dIMFy7SENx/J9I3ZBayHkpP3lewXQCpjBI5KsbB0bXEh18ki6K3X/YzqHzUSr+d1Jr4Z
         YcRAESN2P69S0pNMftKMViwxElXr2Wv06SHbVx9FJ3RFY0Ctl0Li0ZOkdveElfuTc0Cf
         j3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y30SCp7FuLogLWh8oYupZiUPSYbwcxMLbbmd2lv3jDU=;
        fh=qHlki8vVGqJz1NPJKG8t6VVvmWSTaq6kE8YAhUJTm3k=;
        b=XOe2ByYS9EdxTMYC1t8HNV3AqFQ+lq88Uwc+1bQIDlINh9G2/b2DJkUArTADMermS/
         ixcj0hRrhWFpwGzMWaWvRjVxrsrOVYxNDVuv+GxMRdQF5Vygknp/tHqTTi4YiGLbRQMd
         3y/YPxTqJ64NmJQkfLR5aOaII44zmUo2vPbY4xWuEHLysi7kA66kCIFDLRxj9FEvKD1V
         KRfOwmtLOyf+qJ6eV6sdm3Zx2Ybk70Gq15Gx+1D5R5rbUE6vEI1tq3QdEhZch7JRSRu8
         il3HuiwqCpYWBNIB9yKULkzEoxzveXKSnZ72WkS8YYdUwVqj2hnzaQOrHqjwmcr4uhFX
         4nIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776880440; x=1777485240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y30SCp7FuLogLWh8oYupZiUPSYbwcxMLbbmd2lv3jDU=;
        b=CRM6TrQkp31lDuqqr2dYbYxz+glWmoLui8b6i1hpi4OmNqUii6OnSWBhF9RDGyMU9M
         b9KpbFmMfilIoXAkYPfzYbSr0p3qVpitWG+yUX7ms1aKTzIh0KX2HniGMDOkSbVRMNBJ
         SbR5jAwkRJV8praqmUZCqB+rZG2qI8341lC8baQjPe8EUyfG38nOL52+UGuQfDL9MaSO
         1L8YwaDjKTeGfWWeXHbCEd1Wtlv0r9R2E1TONspnXsVXw6A9TtsPCspVtf1sRdV1N4wC
         01CiTyJr3NHEF/NX3k6gZRCKqqwW5XQauyLJO6+4sn4CCd2ejIex6j+CMQskEXTiIY7O
         fveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776880440; x=1777485240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y30SCp7FuLogLWh8oYupZiUPSYbwcxMLbbmd2lv3jDU=;
        b=agb+k7Tvb6mTkPdcTnPtWO/l5bTgpTJmzHMGoE9Dn7EZN8IweOs+CPHFEnbB8SIVT6
         tvSr7/AJSP3PXNKcFSfXKA/J8pyQ4jT+sLEM7K2HjXiaVerZ4kpEb0qov/UhMAN1diGR
         ojsF+291qgsFR4VSPDSoblyJumhJKTRGbHumph7ddhertKrFQD9VfHmksUfS8G9gaXTo
         nr46cDDcIn0bOfgCzFxF+W4IyOg+p5AvaPBQ+TthW2kZIgNiKb9/UWTayjcN9F9h1Pi8
         IckvvfvMe/gcnvsAyJ0H+0JKIc6+O/a6bdalz82+wrLcMnj4h1V/IBqoNOU95XecpZCg
         6LVQ==
X-Forwarded-Encrypted: i=1; AFNElJ89jUAGrs6Z4AZ5TtCJWDcuZw5bvJ7icnoowXAnpCCfrdHGf4fmvMnknBUD8Ua0Ujo1wiyXxriHu0SE+Wfz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Pemy/tiLsiv/3n3fiXnI1kBqNzkYXibJAi+eeAUm/sjl7oFV
	iYbWdEzdfR6o1q2RB4S9gubos0Fbq7QClaPCNoIz7PjyLY0TVkmh/9VbGxUrLlWoNhwD1f1KBIj
	3Nj5bo83fbUNpLDC38Ba46dyzPxtP5AwrSHfG
X-Gm-Gg: AeBDies2hLmCnZgDAk4n89Y/7jI6PMwDffoiRrDmxKN8jQ/4B23bX8jsW4iAIGI55yJ
	ah4AW15RsXbP+fUFZp1CHri2LeyZJb84f4CzW4WHj81qc7+4r6KXrOa4c++ejjVbFrasRuWajnN
	+V81SXi4SdB6RKxHWBBKaOFRLladEJWhwwrOTH1WzM1mE9QFi49/aVIgnHSPdpD+GVq8fqK0bbe
	eXdy8HmKm/G38Wk38um+PSCYUF/ZTDcKyZ4ycALvyhC76azMTTHP0GuNRMBL67+HnuWrB+mf1mh
	jCDpgoXE+Q2t9tbj
X-Received: by 2002:a05:6000:2890:b0:43d:75ec:26f7 with SMTP id
 ffacd0b85a97d-43fe3e08f96mr37017012f8f.29.1776880439620; Wed, 22 Apr 2026
 10:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091658.462783-1-mszeredi@redhat.com> <20260416091658.462783-7-mszeredi@redhat.com>
In-Reply-To: <20260416091658.462783-7-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Apr 2026 10:53:47 -0700
X-Gm-Features: AQROBzBjMac6YzBfh2mO4YHPH0rWTjIMw3YS_LPPCnXqypGc-Uq1LPnDyaTChgQ
Message-ID: <CAJnrk1a+wEqZxgLDYJObfGiAiW=SgVvV4LgR6_PnwwW12t=1LQ@mail.gmail.com>
Subject: Re: [PATCH 06/32] fuse: move background queuing related members to fuse_chan
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 2:18=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Move:
>
>  - max_background
>  - num_background
>  - active_background
>  - bg_queue
>  - bg_lock
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/control.c     | 11 ++++++-----
>  fs/fuse/dev.c         | 45 +++++++++++++++++++++++--------------------
>  fs/fuse/dev.h         |  3 +++
>  fs/fuse/dev_uring.c   | 24 +++++++++++------------
>  fs/fuse/file.c        |  5 +++--
>  fs/fuse/fuse_dev_i.h  | 16 +++++++++++++++
>  fs/fuse/fuse_i.h      | 16 ---------------
>  fs/fuse/inode.c       | 16 +++++----------
>  fs/fuse/req_timeout.c |  6 +++---
>  fs/fuse/virtio_fs.c   |  2 +-
>  10 files changed, 73 insertions(+), 71 deletions(-)
>
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 459f37ece46a..efc321b2bf5d 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -93,6 +93,22 @@ struct fuse_chan {
>
>         /** List of device instances belonging to this connection */
>         struct list_head devices;
> +
> +       /** Maximum number of outstanding background requests */
> +       unsigned max_background;
> +
> +       /** Number of requests currently in the background */
> +       unsigned num_background;
> +
> +       /** Number of background requests currently queued for userspace =
*/
> +       unsigned active_background;
> +
> +       /** The list of background requests set aside for later queuing *=
/
> +       struct list_head bg_queue;
> +
> +       /** Protects: max_background, congestion_threshold, num_backgroun=
d,

nit: should this comment be updated to remove "congestion_threshold"
from the list? congestion threshold is accessed locklessly.

Thanks,
Joanne

> +        * active_background, bg_queue, blocked */
> +       spinlock_t bg_lock;
>  };
>
>  #define FUSE_PQ_HASH_BITS 8
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 6185b97df106..ccf0db3a4eeb 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -566,25 +566,9 @@ struct fuse_conn {
>         /** rbtree of fuse_files waiting for poll events indexed by ph */
>         struct rb_root polled_files;
>
> -       /** Maximum number of outstanding background requests */
> -       unsigned max_background;
> -
>         /** Number of background requests at which congestion starts */
>         unsigned congestion_threshold;
>
> -       /** Number of requests currently in the background */
> -       unsigned num_background;
> -
> -       /** Number of background requests currently queued for userspace =
*/
> -       unsigned active_background;
> -
> -       /** The list of background requests set aside for later queuing *=
/
> -       struct list_head bg_queue;
> -
> -       /** Protects: max_background, congestion_threshold, num_backgroun=
d,
> -        * active_background, bg_queue, blocked */
> -       spinlock_t bg_lock;
> -
>         /** Flag indicating that INIT reply has been received. Allocating
>          * any fuse request will be suspended until the flag is set */
>         int initialized;
