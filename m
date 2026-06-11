Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D82EB0F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781167723; cv=pass; b=GW9sQEPVcvzGKy/+tAQL6YqDpJYZiZPY3IilkSlcWr79qL4KaCkmKgMrVBNUzBs+e6z3ISnuFNaFmuyL4RvpY4BaHH56QQO9C19vFIslQWNpwAAaRSMV0rJUcceWpN9XWQe7p2He1AsN3Nt9PlmjAXR2bZW5lpHIa+DTkAGqWmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781167723; c=relaxed/simple;
	bh=qYo5FH1nQfoUMSRn32nwr3hNnUW9nA/X5q50wbAgEX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYL1UmY14LoztZIjK2VG/SseU2IdTxZsMSB+HS5mdHyiXI9maxO9yel62ZenTCDSStmkrJOxNIomHnXlixw6BIRy1twbWEXQ/W3SSkXtEEKbxdYxwAaoZ+EXIm2S3bX1em1ekW5wgRroowmCK3yc9b5iCNmxIc9C9k900LEkLqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=kHkdGw4s; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="kHkdGw4s"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5174a3d9598so67229121cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 01:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781167721; cv=none;
        d=google.com; s=arc-20240605;
        b=LSSqqJAXT0yM5uIBq99H9H9pYug+Mp+OVGe3DM5byC8ZAhIVOczObNVxfDPj96vuf5
         CWY93J/BTWJVZT7SimSaNmgR9LhljzhDG+JvOyisl96+mO1ANQ/rWJDPgHq/CydRJXwV
         xB4E3Ceglmetj6vL9XoIU+KBEKMeZSBEyC88hSzAISqk4FALz8zKpsEImjV2rFEMzQ1O
         JQhPBTIknHPEHBYRSnRNJlFfyuSXPmRIeQYgvR1awo7L/SRreifIhyEc6WSjuqjYRo1F
         VZndHysHVss2X+nQiXt2amuNQxSOg27QofDOFFJhIXeJRP2wFePg3cjL4+L3IisiKn02
         N/0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=glkFrNLQVMJAnLiiRtY2t/w0hwoqiZJJfYBdcw6O5Q4=;
        fh=bk/rNd5K3Dpka+Gm/h0/RVx2QgM+UROzxZnxcvfZaDk=;
        b=aL0TJT9F2DVgOigSf0gFVZLtC1JUZFTdRyLOrhZogBUqMv8ERYPPvJYgH8UuSWPHbl
         DBzNgiKegvdCchsIfO0Sk5/fFankB2ziFmYRur45vnm169QXQENINFG4utk2mkaoLStc
         BD81XQ0kiQTIZwJEvn4C1aNZJF1pTl4eXY147jtBqASTnBY7BLj/hYW/xhfFdZu8Tbzt
         Xeb7msRDA2DFtW5MRZFOMwVcCHCPYZSVwpPP3iUI5lfSOYZvkoL2pA1CmdUT6FUXvjxE
         71FfQdPUhPlJmRTNrRZRsFv4UzF3V3s5PMCDS380ZJLKcT4Jf2mUXdvseO0Z0ybo4U1Z
         vFHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781167721; x=1781772521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=glkFrNLQVMJAnLiiRtY2t/w0hwoqiZJJfYBdcw6O5Q4=;
        b=kHkdGw4sESWVfvCLrIt4Sm7leEa47yq8ydCITfhCt1G21Cfx8j2za1aEV9en75QqBZ
         LpwP02QL8Hr7IqBZfdCLEcqFKJQNkxz7EVHohVn8cd2N/9UWMxiQcFqnjThjHX8h4ykn
         umOnN3Geeh+655xu0IcB/PiEUdchLrXvZ28N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781167721; x=1781772521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glkFrNLQVMJAnLiiRtY2t/w0hwoqiZJJfYBdcw6O5Q4=;
        b=Yofja4MsZIxTdfHSUKJ43puOneghKYj5gwGXJZ4J16uNtUSMRN6+I+uAQ9dPjX8LT5
         A3JgmbZExXo01jVXudFkreacEEV5YUOgxn/ir6cGYfRyNIWOqHryvsfESA1c+JGavjJ4
         FWaammAcD33MYXD8PQasgjpD1nuNCvj9ipxNXhRPWGMbxiCp+u36utNIWPCatPCGUXlJ
         NXeXllhHOqgBWBpQ1ewuahmIY/u3Hc4mQEFP1T/yonNV4WYA4Yl6tWuVR2ukBYq55/+3
         LvOJN4gxvAjxB4hdSU3onlD88AtQQLP5+Yrw/DTU/TcEsjK+v9GVQ6gxBD3muj2t8ZGV
         VngQ==
X-Forwarded-Encrypted: i=1; AFNElJ8n0X76BVw7xazyBEhhkWtx201PQXYNnpuDn1gRybMNgL6tbIYMN6TQ2PuJbT3wg0En7ieaqt0naqyjnbej@vger.kernel.org
X-Gm-Message-State: AOJu0YwpgDQzkG9U5hFTlUjK5VrmRTVncviyxdOEiAvixC2t3bNMngLt
	8aItRsv3nR8im+mOZEI4JSLdZTas17E664EebIr/LaFnPq/4F3cJC42mfAQlZn4Qm55pjeIJIQy
	It56muLCBcP07LGkz+Ide38DPA9J7WhTKPdeIdsuITg==
X-Gm-Gg: Acq92OH5g22zc1YyB6/hqWZNdLUrbQ08vgisUUjNZXIHKttZjPRfrWf6kJGcmmjPXBD
	SFfqrUnCAOmzQhH/grinpx2eBeUOyB7Dl6zcg4quucmlDY+sxnOYhtHkXpTLAI0hv3FLnslINlW
	zNyhkMWYjt8xyuN6ceW0Lh9eyF5N377Zvd87NBm5bWtb6ebVqjmjGukto0HInO76x33LpOUUuPm
	DVvPM7un7lD/roLkEi0YUQ1gA+1mCEoVSYJKvBVtJZpm6OWv/rDxVFW8TgdHB92BABSOe8QpqIV
	MHl4zTHKyFwpcD0HGRdLgX+XpvpDr2EV8U4kmaBloPSh/q/7RlQ=
X-Received: by 2002:a05:622a:144:b0:517:6d95:ef42 with SMTP id
 d75a77b69052e-517ee2733f5mr29833651cf.55.1781167721396; Thu, 11 Jun 2026
 01:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420-b4-new-451-v1-1-1808fa758695@ddn.com>
In-Reply-To: <20260420-b4-new-451-v1-1-1808fa758695@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 10:48:29 +0200
X-Gm-Features: AVVi8CdOIJNQhq2EdXuVCu6DMRSDMP4QazTSz0dTWDwFEVuRqdZyFeNWEuTLRIo
Message-ID: <CAJfpegu-mK5_ZK7x3Z8jKS1kWVud3SVJ1GuTbG4r1vGdPF706A@mail.gmail.com>
Subject: Re: [PATCH] fuse: invalidate page cache after DIO and async DIO writes
To: cding@ddn.com
Cc: Jingbo Xu <jefflexu@linux.alibaba.com>, Bernd Schubert <bschubert@ddn.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Apr 2026 at 10:39, Cheng Ding via B4 Relay
<devnull+cding.ddn.com@kernel.org> wrote:
>
> From: Cheng Ding <cding@ddn.com>
>
> This fixe does page cache invalidation after DIO and async DIO writes for
> both O_DIRECT and FOPEN_DIRECT_IO cases.
>
> Commit b359af8275a9 ("fuse: Invalidate the page cache after FOPEN_DIRECT_IO
> write") fixed xfstests generic/209 for DIO writes in the FOPEN_DIRECT_IO
> path. DIO writes without FOPEN_DIRECT_IO are already handled by
> generic_file_direct_write().
> However, async DIO writes (xfstests generic/451) remain unhandled.
>
> After this fix:
> - Async write with FUSE_ASYNC_DIO:
>     invalidate in fuse_aio_invalidate_worker()
>
> - Otherwise (Sync or async write without FUSE_ASYNC_DIO):
>     - With FOPEN_DIRECT_IO:
>         invalidate in fuse_direct_write_iter()
>     - Without FOPEN_DIRECT_IO:
>         invalidate in generic_file_direct_write()
>
> Workqueue is required for async write invalidation to prevent deadlock:
> calling it directly in the I/O end routine (which is in fuse worker thread
> context) can block on a folio lock held by a buffered I/O thread waiting
> for the same fuse worker thread.
>
> Co-developed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Cheng Ding <cding@ddn.com>

Applied, thanks.

Miklos
