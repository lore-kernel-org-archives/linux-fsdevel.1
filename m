Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FD30F94D
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 11:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290090; cv=pass; b=BZpcV+b6q7/jYq1ECJ7Kzn0i7WqjAi9VIcpSI7uqYMBUfmDMHgsqVvg6i11nSgBPOtaEp/p7Pyaaj0zeJ3bSxFFK2ojdD/3B2gw3MpajsPk0I2XW7XsM3UR2UV/1V8PHroKwi2Kh9/n02At683me59s1nw22p3NcI4qpzut84Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290090; c=relaxed/simple;
	bh=wTL7DcS2E1yrlCb0noedQpMMItWRmCTLLjo4xGooGeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkCGl1uwzFolBQaFINz+t7FiqjmHa4wW3t3wi1ru0WcsHhiBtNV6UnMXWtCTdDA6CwziZs14e4hWVM6j3lsB/vbZQqNgTn+udbFADR1Mv6WQ4hnaAeXBlgr9+xkePu0/kK0cq3fxnr9i+43CIDWxiLnNYLX0GUbVLX02d1XsIZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmCALxlf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=W49/Dkl5; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmCALxlf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="W49/Dkl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777290087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PK50sUFtD9wC79Ym2+1b4rOaaH2eGEd7ZGmhf/7O580=;
	b=dmCALxlfkXz3NrA2LbmFzqTq0hBxCiJNiqMtwu5lD9Fq5fUHtTeOKpuEv+s3LD5HmpqlWs
	EQ1Zvz6XJuldYAwCH9bm0Gc2nn+VyJXfdTuNBby1n8An+cXut9/CFYRb83ed6vTN26InBW
	Kld2bbvP7BdErZwCBSONhvFn8uDe1Yk=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-7_4U2LmAMZao_5qF3prtNA-1; Mon, 27 Apr 2026 07:41:26 -0400
X-MC-Unique: 7_4U2LmAMZao_5qF3prtNA-1
X-Mimecast-MFC-AGG-ID: 7_4U2LmAMZao_5qF3prtNA_1777290086
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-60599e65115so4724417137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 04:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777290086; cv=none;
        d=google.com; s=arc-20240605;
        b=BHGr8cTFmsRVZRuhfdn1tueF2GbBC4VF1TKkFrwUJmyl1nDQ4GenCKBfsuEbDpDJF4
         YqPtYYyOUTJ9Hixoaf9sCiBstqOi3sbkljQkXVFqV89QrytR7cEVA8qvkfb0FIiBw8uW
         SLhSnrSkRPMju+DzZGs0mOYuG5MLydaq7LuNPq9qrV+ld6Iy5ss1w7no68WEUnskpv/h
         KSvkHlT/e8HTUrGyaqN4gthaCTsw32aEeD7gvG+HogM/YyNQX76Ydl0tjlpA67sGy5/9
         pWdx1hhHdkAr7qJJTFASvBqct4VQl6XzS2AY5uLP3mMZ+t1YKj0w+pRVvrTZnVPkfzqh
         PXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PK50sUFtD9wC79Ym2+1b4rOaaH2eGEd7ZGmhf/7O580=;
        fh=GEqwxTjUZtqofYX4q87AoPjmhM4FF8S3GZ4aFkuMm6M=;
        b=IzhsEZenx+F3N3sCnFpluJFHdSDYO2HvP6w9Wr4q9b7eV+nopP+0/mWw7LBLXD5igM
         KFI4/CaafplUuC9+xusmzzVsmLO0PJ5s1tjVcP9l1axiwgbDjM0zfMhLxji2rtIoA82K
         5zK5Ok3JdY3ywWIu8S1QZUwrku6XP0J29g0E2lV/tvdBlqdcc2rQwb3/a01z3uo3HpcQ
         wykPqAWOykYGyxueaGamAaCUCNx78letHv3qjH9EuZj9dRr4NCcQ/ORAiZzZT9U6gRiJ
         E/ARwgMZB1D8f/ym8o+IqVw57YvFqxyTC//PDff2oGMM1w48PgBxsAF4YBkech5GfM6t
         D8kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777290086; x=1777894886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK50sUFtD9wC79Ym2+1b4rOaaH2eGEd7ZGmhf/7O580=;
        b=W49/Dkl5S4TYICw/Gv/LbiUcDuupGcKviYfN7uNf8OFUnYBApOkO12HOnnTAcB25nr
         Dr4HIa0LzSUVRlXhrIwV/ZW2Uovlufh1MdC2UdMa8LzT44zjlPz6FXuD4xsIXQ20Li7t
         WWoHWw974EMc95DumG8vUxuEjYLf0pLdHJZBz6ox6baUq7Wen3o4lRFeDkmBg6To2BMr
         Lq2OAOxIhY8tYVpjicp05P3dTBUz3dgwaSp0d30LF3+Qb+bCwfJ7E8T+tTf2RDM6SjwW
         O9H+C2kZdPXvx+kfnduPA8eFgJSQ3txl8Xh9bCCp+Kw0tJay0hMcQ7GfazyOVFD2/A90
         A8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777290086; x=1777894886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PK50sUFtD9wC79Ym2+1b4rOaaH2eGEd7ZGmhf/7O580=;
        b=QZU9pOL/W1K8DQefr3yOHeZ8TdotgfjyECSub53uOlpf1cHYuQbm4nfSGUSGMTGbiX
         yryV65WX7BtccQDcPimX9hZWZxtgB4xJT/gIyM8u4XR6VPYLoHPH51CmcmTrSg0o4V77
         VC6V9YFG0igPB822ZrxlB7WR+5MXnwBEFLd67UTrQ8P6LxmDfY3Fknk6l4XphvE0wvWo
         9I51eFGefsFX7mQ9xVoDHEJZqEEdWbowS2HiIshpGK061G/B0SzOu/T7aRB+or3b97fV
         HkE+2VaUQ5OWHvDHwNA/BIPQNVb3PPvXC7vyiV+/zpmBKTdIJxt/xoCVUdB3Y1GZffIo
         thdA==
X-Forwarded-Encrypted: i=1; AFNElJ9poLrTXuZ5KU75XRGyw/204r2zOZ/SHlvXVBEaJg/rlnS+S+X4Jt50NrX2eSxk3oZp3kxKLMaFhRBOua80@vger.kernel.org
X-Gm-Message-State: AOJu0YzooBG2iwyXbDW2cL93hveaBEs1q5HVNPD/yifOhZuNLCOkj96c
	CH6IV3W2BlZ+mIoI6EtuIyznDoKyrmothw+cxl2aeVaciYQUkEWq/cCDXysdPw9qVBLnYrsDuRw
	2mSYbeoDH209415yFkEWznarAIoeL+HB+ZsXVHMhcpaYsEP9m4cazzvXbme5IF4yg4gpZcOkTrZ
	prbh+WEecZ9RGNY+XI9Y3UapQhKzFZK/47ZNp/q3RWcQ==
X-Gm-Gg: AeBDievqCd0lU6J/tiK/M3UoA7kJpQWE2+5PKDg3GAECGiGCiUprklYFQhb7muF+4FK
	NEvKMUn4M1zVYPV7HfKknjWUDz9OOxbIeTI1s8RJwXh4G+s6gIr7M7otTWRRz9yrCIbJBBUkFHI
	JQq0ebliz2bgAJ3noa9QhSByl7zeRGKevSpdroltUhYWvOvkvCo8g8mCwmCcSvOOO/PPFaMXJQa
	H79v/yUiwfDjgU=
X-Received: by 2002:a05:6102:c51:b0:612:c135:1b77 with SMTP id ada2fe7eead31-616f88b4239mr18746505137.27.1777290085870;
        Mon, 27 Apr 2026 04:41:25 -0700 (PDT)
X-Received: by 2002:a05:6102:c51:b0:612:c135:1b77 with SMTP id
 ada2fe7eead31-616f88b4239mr18746498137.27.1777290085429; Mon, 27 Apr 2026
 04:41:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409193832.318303-2-slava@dubeyko.com>
In-Reply-To: <20260409193832.318303-2-slava@dubeyko.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 27 Apr 2026 14:41:13 +0300
X-Gm-Features: AVHnY4KD1EYx0jCLM0-mkaTaeru5bJKkFPryoQlvnJKC-66PL0-5j9Y7KWAqtGw
Message-ID: <CAO8a2Sh6otfEtw2MTCy2vdeJEah8HOy94buMP+pxGzOnjxQ+kA@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix a buffer leak in __ceph_setxattr()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

On Thu, Apr 9, 2026 at 10:38=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The old_blob in __ceph_setxattr() can store
> ci->i_xattrs.prealloc_blob value during the retry.
> However, it is never called the ceph_buffer_put()
> for the old_blob object. This patch fixes the issue of
> the buffer leak.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/xattr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 5f87f62091a1..c6fcbf428317 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1294,6 +1294,7 @@ int __ceph_setxattr(struct inode *inode, const char=
 *name,
>
>  do_sync:
>         spin_unlock(&ci->i_ceph_lock);
> +       ceph_buffer_put(old_blob);
>  do_sync_unlocked:
>         if (lock_snap_rwsem)
>                 up_read(&mdsc->snap_rwsem);
> --
> 2.53.0
>

