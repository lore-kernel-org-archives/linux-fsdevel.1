Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7F447AF43
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 12:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251294; cv=pass; b=HDtx8LyYwFSe4qLzn3Rn+hMRfqYSA81FrwhIFjm4pWDkrpuKGl6U4+q4SjIr3WlmjysqsQnZCpdH9GlKnNrvI/ZPI8cTU+WNmTWLqXBOv95jARc6VTC6eoCP8xy7d7ANWFyGwIUapBQ20/nm7pyiwkButfV+9/msqmfkxfEuL3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251294; c=relaxed/simple;
	bh=ADUClccYk206h7hPKOGkSKqz/BqS2N7kbEdhZoaJr0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvWPWGojrsD9ny6ldYl6538iXWhSjBnoBFSFUcDApWGAoLM4C4s97PJ1hj0uaYDsITEkxjIToxP62k0Xk2x3lScZzmwqhnyoeI3igF7mzotyuGZ1JbqbY4D30uI+a+aR/9EUnRy//zzZQrn7XNSIKaefwltzmIsBOuXV7SEsy/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5OkRgap; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5OkRgap"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49ccf12bed0so41635e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 05:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790251290; cv=none;
        d=google.com; s=arc-20260327;
        b=nOPa77ww4R+1wKDkK61+gYJzZYJB7s0qaZ/JLUEmavRzoNRMygTmUgETrU/wXGRtZN
         lDQnkj1DAj46HX+VeQbSn2uRylfJLBF1YqvcVHobXUeuJKEqm8paYlpmPNQw/HgTmyiC
         VBxUi2OMLWBwpSLMN4HSnnSADQT22VYAT5pPf1QTbSvioZErlbxPeIjvTcoHeoHCZfdB
         gkn781XyPK/5yEfgPzIeLl0Kcn2MCublW8jvm/ple8YOg9eDWAcvDlw/k4hcZPaQC46p
         rA7ymhfPqIeTC4UG3VCGobz8eiAoeAoRabV/8uhZRcZoPpbX/Uv76PVa16Ld15MlP//4
         kImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ADUClccYk206h7hPKOGkSKqz/BqS2N7kbEdhZoaJr0s=;
        fh=/5cPgs9XBNZDZ7iETBBG09UaJW3wpmmT+01LRbSXyYA=;
        b=YSLFEJeGEQZfdJDzHmtKy4Z4B/dk0tszkqL26xJg8COcprJ2kfp8FoSeu5FiQWawjg
         oy+jQo1UTUH7ESGEZtr2yFBi9HO7/MfMbcOyC6G4hso0Iubolxjgj4OyfrcrcKZfeVHl
         rIULnNwR/B5whzQb2juw56Vsb8z8IycdMZuC5kp5OzNOF71nLbXYlHWOyuF8qX9LrrxV
         0yRAhnByzfhPr3IWCwWwsrQDih84UTS4EiBIJD/HudljwS/gX4XYQaBXU9l68T2HFHj9
         V/1zD61cdctmqA1kx5KLmyjaZHVvXSJSosQ92KzJtc1LOHhqKI5L/FO6gkiBTglKuE+J
         12gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790251290; x=1790856090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ADUClccYk206h7hPKOGkSKqz/BqS2N7kbEdhZoaJr0s=;
        b=W5OkRgap3yQQo+gVYE0JiSd4ki5m8eK0DLUOU75qePH3XxnmKCytHlN1rxQmPqx0xV
         QEHlbp113QWtyQWka9CaUg2UNuICo6u95XEDMlTSJvGg+iZorTjZZf/1fto4kStOmIxw
         2772l5DYKQTTb200R57cmJU19rphP8ZRvIF/ddRog06dvdUQTTv410LUgAg30HW4EiLs
         jyy+4aEbbCm0p1GEywkhD0JmLjxTGMgIE5QvZWa4a1REJf+kocjVtjqqpFGduzhf/V1N
         sWx3QBapmGRiC32GJoscvyOOqEdgeohS3slkuSrwTaKlpbH4eFnQjKjnm30Ym6BP8UB3
         C4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790251290; x=1790856090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ADUClccYk206h7hPKOGkSKqz/BqS2N7kbEdhZoaJr0s=;
        b=JQI2aa82AG5cN+hHIAuuMWZSNOH62uLB+MM5oUdGWLoUN/b/ye5oPRpOjK4Fn3cdUc
         5sw+9bQw5+syw5GzofbqoaqflKnoyeI0W9wl3a2dW2Ury92212dQSKRbsa1AZ+yhDQDH
         MiwbOD2/tRGaBPDKndpz+wDd9ZTSZg19hDHVnE+8JZI41u3pJbnDzlwfylN1JDIqVV+u
         5X7dlJrrFgIbK0ZyF1eAAxAqVfenkqDmPE49C0B0unZylbjQ7nZTe2rEBaO8mAsN8G4P
         /smyLzKRxXMnXHAVu4R9IoRT+RivBE7kpL8MWVOAImc5p5zbT0fJe8zdl67gXeBQBX2c
         tmWw==
X-Forwarded-Encrypted: i=1; AKwUvBxCXf53rLvpGSLFYVtC7OzJcknwlfdpBd7aT6TgrVRB7xwN7q3v33Nrl142R7fJp8pDB1P3aEqfzqeRk19s@vger.kernel.org
X-Gm-Message-State: AFuF++nh6plg+vyTCRtTKKT5+qwuMdYSWz2p3yo/41w1M9HZ+zmB1H96
	gjjwZlRRgQI3rGrj24HJ0mhrKu/1O5SFa6ySiexb+fnba5HIM+VjBJX3O6qh77ZYYZFh2JFnWzI
	PgBgHc/jA/OvX0tPJoinceHw9BIS3wcezMlVtbqgQ
X-Gm-Gg: AYBFou2lUt7fD10skRZNczgRyGXvVweo9B8W0Q06/MKcvBONDhW2HCVsPY4TLfcoJrg
	AbbTGJKog3TSJlNlqmkdqX12senxBeAhh1XlEwYDFidcPZWeccbAjrg6RIuBO8jOspKNAxcfcPJ
	eEC9DcUB5Glb8cqciIUD8ItRZsCY8ys8DDwNctLXl9kloanS/tdFBHumNHPnvGhZAT+xyddZaVK
	uTcCuS0907SVwyP5auTwFsPt71KhRzoVWMtHjFoGqx11Nk/PTix4UaL6gUI3V3NewyA2LmYdQaX
	Z8qDlOIjVgUVycQHQRpUkaaeZkUKNRB+z2xpBV5pLFbuMr6flTTj4Zx9rCahbTAEGdm7xbfyhc+
	zY+X1p/8=
X-Received: by 2002:a05:600c:570f:b0:49f:e1d3:fe03 with SMTP id
 5b1f17b1804b1-49fe5996f16mr573675e9.3.1790251290130; Thu, 24 Sep 2026
 05:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909232351.1533034-1-shayba@google.com> <20260910184424.156341-1-shayba@google.com>
In-Reply-To: <20260910184424.156341-1-shayba@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 24 Sep 2026 05:01:15 -0700
X-Gm-Features: AclHuK9Au5z8ENRx2IaBAjigCgDpk1SWcfpHMs-ScW16pQ0_dNBiZHTtShRfceQ
Message-ID: <CABdmKX0B7zVfLY9Rov37U+gOTEXYSCMUe6=xFddOrKDVneiBGA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Forward vfs_fadvise to backing_file in
 passthrough mode
To: Shai Barack <shayba@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, Sandeep Dhavale <dhavale@google.com>, 
	Akilesh Kailash <akailash@google.com>, Suren Baghdasaryan <surenb@google.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:45=E2=80=AFAM Shai Barack <shayba@google.com> wr=
ote:
>
> When an application invokes posix_fadvise(..., POSIX_FADV_DONTNEED) or
> other fadvise advice on a FUSE passthrough file descriptor, the VFS
> currently only executes generic_fadvise() on the upper FUSE inode
> mapping.
>
> Because FUSE passthrough does not forward fadvise operations to the
> underlying backing file, pages residing in the lower filesystem's
> pagecache remain resident in memory.
>
> During media-heavy workloads (such as image thumbnail generation or
> streaming), single-access file data accumulates in the inactive pagecache
> of the lower filesystem. Under memory pressure, the kernel retains these
> stale media pages and instead evicts active executable pages from
> running processes, leading to severe direct reclaim latency spikes.
>
> Architecturally, Linux VFS supports filesystem-specific fadvise
> delegation via the .fadvise hook in struct file_operations. Implement
> fuse_file_fadvise() in fs/fuse/file.c and register it in
> fuse_file_operations. When passthrough is active on a fuse_file,
> fuse_file_fadvise() forwards the vfs_fadvise() call to the lower
> backing_file under the opened credentials, allowing POSIX_FADV_DONTNEED
> to cleanly invalidate the physical backing filesystem pagecache.
>
> Signed-off-by: Shai Barack <shayba@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>
