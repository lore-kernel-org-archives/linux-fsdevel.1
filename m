Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF8F15687D
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780107325; cv=pass; b=A39OpfQ0cA6Ea3q6OYGZ1WxKtthUdakL0U3xw4PaJQC/iVhPOVWsjqrSHZlSUB5P0T3Z2rcaWawutjR92tLRRXX1iw7SstHzLFVr78rHEFMALZ59iOW2KPCKTu30likvVYt3c0gWSLtDYFvEC2+jcDDTGQT/zfnmj/76CgKT7mY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780107325; c=relaxed/simple;
	bh=hBo1mZpiq6R1gUudU4oyOhNNAJzH1gaJHQj5Dbqzyik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TUlhZ8wLYAg0JeEurEThk91LF8xd45J7TdCNseZfaXfuG2TMX5LMDcUhaW17K7iOV9pfKxRibPferxrF3WQS7ANbYCglMpsvS4yDViOdoz3u/bsdt/+SkV7YUEnl5m8CMWyb1gDIytwtV/pq4BWdDLTg7dkmxpDIbPBoB2/uhrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/vjVP8q; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/vjVP8q"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eedc94d37so1067775f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 19:15:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780107323; cv=none;
        d=google.com; s=arc-20240605;
        b=NF7tIAarQTf94hyTV2EKF1D5HwtbHSpVsoaQ0+yh6D6zLHNp38+1L9lT9rue8VLppQ
         nssL4S9ctL1cb8iMcO9avaeFIWLT2Opsc2U6NDOCR8xiIyhjP+r1HA4ut4MbQtGRmdGr
         rxwN05GGX4GTdUv7OkP1rc1VDVFb6pvoM+tjMuWw4GU6ybZqMZJwJgTZ/VUa2Xf4ULsJ
         5mHIcmmoPk6znc2cobLGipYzj4o3QvGCWolkp2snRU6SdN30Yvj9fv7fSXiRbdttTEOu
         qluJ8rkNPtGVJ3wm1oIfPJBlhLLYYIrU0sgxVPNjkjbuDHcKpW13NrvkJrB3c/yeKZ8U
         1ksg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gEqMOpP7mfSN7mBG1OQxgecdTpvWjr1mxFCqvGIWdFw=;
        fh=DjSRsVzZGroN6nYbZuyaspgU3HQo6RiA0Z27aOL1BKw=;
        b=b07Por2rA5Cdg2WLoDrGFxP7OE5d5M0sNaSf5xdrBvqhTSqrqIfzGLvaTXz0J2sV9h
         /HzrVbzYvCfEoc1JBWEnmlfa1mO0lym770hJv0bTBCdzwmQkOVUFS2NegPvbDcXMg882
         OqSuRWUCPMI3hDXUey5HSZM288q4gNSC3JHbW+m6f7zSN4WnwCH92kjBVJ3PcItm6eUw
         MlzZb5MVyWnCeeQMGMdJSOgUt+mtsh4ORF2N6DeVYc0mTIAgT4BJgx2QqrfdWIBmAIpt
         ey4jdC2aMEQ8Q78Z/M/SJU0eeTYAih1pr4u/XpTxxxaeJoKnQTWFTpRCpxL0+fohEGTq
         d+RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780107323; x=1780712123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEqMOpP7mfSN7mBG1OQxgecdTpvWjr1mxFCqvGIWdFw=;
        b=f/vjVP8q+q/w9uURSPR2k3VHMkqzP2DRUdPAU0y8pB023VSshd6KdHqB+nNeMZjrl6
         QzidMmubKOy3zQNtu5v2hjxRe7UXMViL5QI9U1ZKAXhtWpXhlkkq0/0rQT3pKVlR4jL1
         eLQWHkMGj9NTYzUPuRBucrZE9H6I9pxlsHhUfgBEmOIG8n+yqZsvtDGIAJA/q/RExarJ
         xTNaUJ4BX4UW/ekGqVjQl9F5J+LmmPGcJG1GQwiZXvcFxZmig2Ag71Nmnqi/nR+zF5Wj
         vlWyWbcK9HbJ6niv2/QqwJCSvss7hU4QNRYB0+liUGnIQOf4nUdhy50FeG/2X2wLbB91
         VHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780107323; x=1780712123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEqMOpP7mfSN7mBG1OQxgecdTpvWjr1mxFCqvGIWdFw=;
        b=WOFyCtf3wVAZk3IJOhQu1gXiKsL5DUyB/bdVio18fOBorXlnV3XlWnpaqN+xVaWZy9
         A75derF8ac0mNMPLevAMp+52KX8tIZqYZU6b1YBBq0Nx/K34pkVMFfvP5JangmGSJFlQ
         kXg103690UNfFFZSA9mBfojcro9tOqbWpuRMbijndzNBkhAUk6O3x5L/9PKIUrDt2cCZ
         whr5J5VL+nDavFZgmhivj+SRBKbRNcBU1B7YXUnDlh/TRxgq2yY+4RRM7XRVhAeFfQlq
         FCdJF6hgU6w5AYkEe0e41eqzDhsEAC5hGhZtEvXi9LZSJ9UYAW8ZGir87MzWes0tXS50
         6z3Q==
X-Gm-Message-State: AOJu0Yxd5pmjyKYf7+OcUVzDDDeNr2lW0DUMCkIqOtu5UZbnK8vRC10R
	BRJByD78JCR3qMK12B55e8AjjqPI1UrWHOMdbRtQr+YlGcr4yjfLupjOjOw6EhkJYkbexYpR19j
	NjolKgNusAMbOf85XsJcleW4NVc1tHh0=
X-Gm-Gg: Acq92OEfBpr34B9LnDpoUj4nZubXUgIcfG9+/Y61R7Z1f5d3MX9HUykyJ3nwpRLrr6h
	PCxHScwOA6q+nU4fvUdQZgYzPw4k5EU79Tiv8OpNVCfcJQi7VR/0FfbxeBfUShKQntLoFRrVcgY
	kNkuI1WfK9wEu++upaHj6FW7EEcsJJfPcSAoP0HkT2gSttTEILdiAe5D42ZtqTYIMNYmQtMXDbn
	eHdF2VUIgsbowrO7E19p5CLaJ7VN1TlZWPYhEjns823cPI1ak99FIIJ3FeNYiKKxkuRgdS2Sa5I
	EIEYDm0oqcNUsZmk
X-Received: by 2002:a5d:4745:0:b0:45e:9366:94c1 with SMTP id
 ffacd0b85a97d-45ef6b4f79bmr2726468f8f.18.1780107322695; Fri, 29 May 2026
 19:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com> <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
In-Reply-To: <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 29 May 2026 19:15:10 -0700
X-Gm-Features: AVHnY4Jg-QA5wTBdWB9XzXD9Vhbv_0XU_TUz4CrBYf78TUDU44-Us2FtmwrXQbY
Message-ID: <CAJnrk1ZSaNRr-HWw-hbo2=LmbZiNGZveb0MwxZbPtBDFgg2icQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jan Kara <jack@suse.cz>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:42=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> I read through the writeback throttling code and re-read Jan's very
> helpful comments from this thread last year [1]. So for unprivileged
> servers, I think we definitely cannot remove strictlimiting. If the
> fuse server is slow or unresponsive with writing back the pages, it
> will take up too much of the global dirty budget which will degrade
> write throughput for other filesystems (their throttling will be
> computed against the global dirty page count, eg the freerunning check
> in balance_dirty_pages() and the pos_ratio calculation "pos_ratio =3D
> pos_ratio_polynom(setpoint, dtc->dirty, limit)" (dtc->dirty is the
> global dirty page count)) and any fuse stuck dirty pages are
> essentially unreclaimable. Without strictlimiting, there will be no
> hard cap on how many dirty pages a misbehaving server can accumulate.
>
> With strictlimiting on and large folios enabled, the problem is that
> the large folio size can potentially dwarf the server's dirty budget,
> which can lead to excessive throttling. When I ran my benchmarks last
> year, I and independently Jingbo saw severe performance regressions
> for buffered writes with large folios (eg 2 GB/s BW w/o, and 200 MB/s
> BW w/) [2] but I think that might have been because the machines had
> limited RAM, resulting in a very small dirty budget.
>

Update: this is no longer a problem. The large folio buffered write
performance regressions I saw last year was fixed by commit
494d2f508883 ('fuse: use default writeback accounting') [1], which
landed last August.

Prior to that commit, on a 2 GB VM, I was seeing for buffered writes:
No large folios:  840 MB/s
Large folios: 270 MB/s

After that commit, I now see around a 30% improvement compared to baseline:
Large folios: 1130 MB/s

Prior to commit 494d2f508883, fuse was doing its own custom writeback
accounting but the accounting wasn't updating wb->writeback_inodes
(which tracks when fuse inodes enter/finish writeback) or
wb->avg_write_bandwidth (which estimates the device write bandwidth).
As a result, this caused the balance_dirty_pages() throttling logic to
think the device is super slow since it's using stale underestimated
values for how fast the device can drain dirty pages. This caused
overthrottling based on the wrong estimated calcualtions.With large
folios this became a noticeably big issue because each folio charges
more dirty pages, where the balance_dirty_pages() logic thinks it will
take a super long time to drain those amount of dirty pages.

commit 494d2f508883 switched fuse to use the mm-internal writeback
accounting, which properly updated wb->writeback_inodes and
wb->avg_write_bandwidth, which fixed the incorrect bandwidth
estimations, which in turn fixed the overthrottling.

Overall, what I'm seeing is that enabling large folios improves
performance across the board for fuse, even with strictlimiting
enabled on memory-constrained systems. I'm going to do a closer audit
of the fuse code to see if we're missing any gaps that will be needed
for turning on large folios, and then will do some more testing. I'll
also rerun benchmarks on NVMe to make sure large folios don't lead to
any performance regressions on fast storage. After that, I think we
are good to go for turning on large folios.

I'm still planning to look into the cgroup dirty throttling
instability on NVMe I was seeing earlier and do some benchmarking /
experimentation with the folio order cap. I'll post updates on that
when I have them.

Thanks,
Joanne

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/fs/fuse/file.c?id=3D494d2f508883a6e5c4530e5c6b3c8b2bbfb7318d
