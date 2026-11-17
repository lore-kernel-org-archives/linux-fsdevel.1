Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794956928;
	b=SqWJYGowMS4PvGTKpFAVNIzASPs4/WFrQI6mOxAx+yu3oZDzljDo59xXqFpvkShHFHo2
	 M4jr7UbqFz6+6quDtxlI9DSXI+xybeTcZoVhhiXvmLqrK5wna4fFhfetYXohT+f24QV82
	 RI524h7mqLvVkbuUVYZOynpd5p6bLu+a6FWEFAMmHs94HeIr0mxM2PU5OelcEyrnklyH9
	 eBY1OqtFRNDV1Zvb86I3lEr78ugZhDtqM5gKfXh0TMuq/Kk39+JNZ1yDzoINEllu1S6SH
	 oXYDiJx+C9URVL7vca4ZYcXfOZt+Th9SLKwbOkKYORc6tBw80xDz2ZKrFRayFUR7xHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c5oD0tLMxNN+L1nREdH0vs+Q+g0/BB/zfqPp5PmXkHo=;
	b=rCb+XYAAJ22ofsrYx3cjFW8QhR8+nCrc0BQk8qP94AiK7Lzg1JQEO5GNJot3P71yEhDC
	 N1qQAx1YFtSJLXT1a7RCqFi2PYHwGjpQgjuS/6YgUYWhDhOuzf9Y45ZgfmmLKw2zog0q6
	 CRnEEQBoDnADgE3L1bI1FCnyCREBoncRawZjUotJMJvGRiCYmwO1PQQvH3u/YUYLnHFbi
	 wul5LMsZI9OCjku48C6+agY4IG7WkvScEIHxb+6sFQoN1XRMCz2e0+5Lr7/lXwcQ60Nip
	 gKq2kJYpFhu9NuQg5NZW1HvC4tImldwxWjApd+HxAwQuvqvQ/VgY/Gy01+L6uznWjgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tv5L2OH1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F718606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 23:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F718606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tv5L2OH1
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-9495e8ae239so44598685a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 15:08:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794956927; cv=none;
        d=google.com; s=arc-20260327;
        b=lY0niVKg1It4dYrngpd5wJPOFIGNLGLYFox1LgnHPOEHdsmNVsqk/da6kqlv8UuvAi
         q1Ow+BEYqi8/8ZHJupN7RSiWljJkVfyoer06C45FIJmDYC0Ho+3Hcoo16nQ+0ewP+HaT
         9yZwQgiVUWdxTijYzT/Y4hfu0YoRe9svM83/eiYOo2tLAT58/7QSkbGxW1HNOwQnp/u4
         R+ttUOKVNvA8QVK9n/vo26FQgb9gfxmCRXk0Gkr1lZ23huXHHYf0ZThHcuquTbndnKXG
         fXQTtkjosSZXhcq6FjZQfi2nBlMC0pHtVLYgS+go4tdTQwbnjOzkTvA60vIWLoMa6LUg
         ykyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c5oD0tLMxNN+L1nREdH0vs+Q+g0/BB/zfqPp5PmXkHo=;
        fh=WI+RHyvahshLiDWII/rEVYrODH9xMYtTE3PEFgnE8ww=;
        b=qBtRiLhPg6FwfCCo4O6HGMXZl5n58lqHoMcNLIkHxwSLi0tcDuYMXeRdZbsqxvbgEq
         dsGgDELS/nUiLPq2wlRQnekoh/WNXAE/Y6+mEJrLReHh+QdGuTHJMr7IzxRi8KUPnhKs
         YfjEc2yoK1I9qoKxegStrmxTDCo+3tMsDgf8X3/b+AhSqdTZ+M5XRhObrZ6vYE+ABKue
         coqlYBabY33qYA6kAjbCOLQKGSW09wjCQjPIqp/AipB6SGrBBu48hNb0kwKGd6sfh5DQ
         TJFUXBSxIJWAmJxqOcXxxjp8unUkq6Dsyu9coz1SMCpPOSRxiaahXE7uO/+fSSdzvBkL
         Z79A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794956927; x=1795561727; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c5oD0tLMxNN+L1nREdH0vs+Q+g0/BB/zfqPp5PmXkHo=;
        b=Tv5L2OH1FQpdOSFR3ZvqD+zPqDpGvd4wbf71Cu/yrag1dW1t0h4FG6jYLxaoyMi72d
         UwvNOB78cpsZPgBd21kka2hA0sSG/6nRwSdZnGPJu7QZoBDat/c1Ve0prfridK6Knyn4
         ckFi9dB5sEtfUGFlv2fOkkkwrUAxGd5WaO7nSfQLS/PuYhK3RWeojpHpS/W4vHq9A+1D
         zj72iiFpbWFlt3MPfrkQvFLnONhyzEwbzKq3zINBl0ZGArn8PdZye51aw3rCON/ObgX2
         +x98YmkqReMGOg2bNRqKPOkKuFUsi3jI2K4M3QnpRK29kcfBr6Rryi6zUUwUsP2BbCFi
         ebZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956927; x=1795561727;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c5oD0tLMxNN+L1nREdH0vs+Q+g0/BB/zfqPp5PmXkHo=;
        b=hSNQ8HwYFAuZke/is8YBUOhN385xgDHLmyKOxnKtNAqTLVU+kUuOyT458Ij+d13lsy
         PwMjKX6DAomv8r2hQvM/xd6HIE9KuWOFP4meKyrGqO8RVnHCXK9879lyZKOxrVKjDCX1
         Aeh3nLxTDMjC2FozpcUhPbbxbUeMbWH7HF7nMkZpWiBCYiepTAqhAnaFXsEQilk4c/3W
         prgr7ZNxHuwVAufbRJtdGYNqIt/ovaGwu7Y9spLqlQCtj+NYmnZlWXDnwEThrKqFySMt
         ZF/yMOKCOsAwKw+wUa9+D9jQdJ5TPCaue5Cj8/iyIHhI3jx9GySKrhk7JI6aGZUiNdZ1
         P1yQ==
X-Forwarded-Encrypted: i=1; AL+hErEODDAUmVXSE3n5pJ5+3WARjVPfYkNV1icBbXjoQViWRnPtQrX2dRYDR4B4QHj8es61nFtQ6OQlekPpZLaR@vger.kernel.org
X-Gm-Message-State: APuU4Z8p43AKmZgg3dkm6n9Q1c5ipIziQjIzfPKF91RromK3s2bH8a9T
	zYLz0PzACEKxyoEvtLQVHvhF4W3s9aH8wAIZr6M2Fi5DHx220bcW2nqtJAqesbKYR2z7790vGrB
	b94GLFOIV2zw02B9CFbAb/NenqhsP5T0=
X-Gm-Gg: AYBFou0tRmCFdNEJDjWdS4gJj8JK/cOW2jkhu/1JzDHPhoriXp6vVR7JrnToQfSxc//
	5s7xx4Is4hWtbKIZOJNFekvA30bhjdHh6sJEOU/GsCwkjP9uK8GYwHmPj4RBsarCeDhxSsABi/f
	nBfcd4I4lhBCCtHEtqj7BIcaicHPu1xk5eP7xYUTSJScZ+92PR5jNV7PVT+75H5WE3NHbOEQWHl
	MmFJIt6usz34uxsm08kwQrd1o5gPooBvs9aiBoDmwBYXjmu4oE71A2YjTiff9PZoyn/z4BuQFiq
	njWCKo6KuTJw5NByoUTn3KH9Dn9d/Hh+MoIuLmlZxFut7dySoS6ZRwcIGIj1NojVklZI5/qSdkw
	olr7rScyQ1Oi0IHgKr9YD1C4kXDwQdKYlui+X0A24fxjU1qi6WqpKUdUG4E4B4Bn2+8ztglhzDP
	o4Dh+7T0MaREPJlhwRtVBBEYFkl5A8S+UatFju8SKfvAJ/5eFWMhzgV5JwpDbYuzRdcIsh003f+
	cJ/RpTCzgNIFC2MzGlbZd2I03rDZJN0cZHt07aKcoTxibj772aHioJTcQxKjYmWT8I8y3W2ur6F
	I87gIEmJfpYa
X-Received: by 2002:a05:620a:46a6:b0:949:64c2:1630 with SMTP id
 af79cd13be357-949995d909emr225332085a.47.1794956927022; Tue, 17 Nov 2026
 15:08:47 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117164756.97065-1-jain.sm@gmail.com>
In-Reply-To: <20261117164756.97065-1-jain.sm@gmail.com>
From: shashank Jain <jain.sm@gmail.com>
Date: Wed, 18 Nov 2026 04:38:35 +0530
X-Gm-Features: AclHuK_stX8rGF7FB55S1t8qyAd5lXqjdL2y4CcMcGEKh7vJZTeOKIecSE-swS4
Message-ID: <CA+FWx=nHkuDf_+Wq4Zk6BuxKcC=EwcmZsVVviyQj3WyXF5EbHA@mail.gmail.com>
Subject: Re: [PATCH] iomap: fix offset truncation in iomap_fill_dirty_folios()
 on 32-bit
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@lst.de>, Carlos Maiolino <cem@kernel.org>, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

One correction to the note under the ---: it was Willy Tarreau on
security@kernel.org who asked me to post this publicly, not Matthew
Wilcox. Sorry for the noise, Matthew.

Shashank

On Tue, Nov 17, 2026 at 10:18=E2=80=AFPM Shashank Mohan Jain <jain.sm@gmail=
.com> wrote:
>
> iomap_fill_dirty_folios() turns the page index at which the dirty
> folio lookup ended into the file offset it returns to the caller:
>
>         *start =3D (pstart << PAGE_SHIFT);
>
> pstart is a pgoff_t. On a 32-bit kernel the shift is done in 32 bits
> and the upper bits are lost for every offset at or above 4 GiB.
>
> XFS uses the returned offset in xfs_buffered_write_iomap_begin() to
> trim an unwritten mapping to the range covered by the lookup. With the
> truncated offset the end of that range is below its start and
> xfs_trim_extent() leaves a mapping of zero length. iomap_iter_done()
> warns about it,
>
>   WARNING: fs/iomap/iter.c:38 at iomap_iter+0x33c/0x36c
>   WARNING: fs/iomap/iter.c:39 at iomap_iter+0x34c/0x36c
>
> and iomap_zero_range() does not terminate: a mapping of zero length is
> what the iterator takes for the start of an iteration, so it asks for
> the next mapping again and again without checking how much of the
> range is left.
>
> On i386 with XFS (4k blocks) this is enough to trigger it:
>
>         fd =3D open("f", O_RDWR | O_CREAT, 0644);
>         fallocate(fd, 0, 5ULL << 30, 1 << 20);
>         ftruncate(fd, (5ULL << 30) + 1000);
>
> ftruncate() never returns. The task spins in iomap_zero_range() with
> the inode locked and does not react to SIGKILL. A write behind an
> unaligned EOF which is in an unwritten block above 4 GiB fails with
> EFSCORRUPTED instead, after "XFS (vda): Access to block zero in inode
> 132 start_block: 0 start_off: 140002 blkcnt: 0 extent-state: 0":
>
>         fallocate(fd, 0, 5ULL << 30, 1000);
>         pwrite(fd, buf, 100, (5ULL << 30) + 8192);
>
> The same calls work below 4 GiB, and v6.19 behaves like v7.3-rc6.
>
> Cast the page index to loff_t before the shift.
>
> Tested with an i386 kernel in qemu and XFS on a virtio disk: the two
> sequences above hang and fail without this change and succeed with
> it.
>
> Fixes: 395ed1ef0012 ("iomap: optional zero range dirty folio processing")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
> ---
> Prepared with Claude Code (Anthropic), model Claude Opus 5.5
> (claude-opus-5-5).
>
> First sent privately to security@kernel.org on 11 October; Matthew
> Wilcox asked for it to be posted as a normal patch. Sorry for the delay.
> The code is unchanged in mainline, so this is the same fix, rebased on
> 666539eecdf4.
>
>  fs/iomap/buffered-io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 6d843b1..846f87a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1735,7 +1735,7 @@ iomap_fill_dirty_folios(
>         }
>
>         count =3D filemap_get_folios_dirty(mapping, &pstart, pend, iter->=
fbatch);
> -       *start =3D (pstart << PAGE_SHIFT);
> +       *start =3D (loff_t)pstart << PAGE_SHIFT;
>         *iomap_flags |=3D IOMAP_F_FOLIO_BATCH;
>         return count;
>  }
>
> base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
> --
> 2.43.0
>
