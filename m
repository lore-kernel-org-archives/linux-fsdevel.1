Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE98299927
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 01:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325368; cv=pass; b=Fndo8iZk8kVU1tarGExf/WMJcENeCO2qlTJbQ2OriI8ehA+rYvjMXF6NF6yDWnyEl6yWw9QPqyl6cEif4kH0sfuuZMbFL9Euvh7j1Fh+40TPduHHZeysEBgYsnCGHAKHRmLRrbLDOQpIYVSnbHzEcL72/qfe2M06j57CA4/VO4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325368; c=relaxed/simple;
	bh=w2M4njWribFv5DWMxOVdr8Fj/WFnmlk7WeJiR8SYqsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAZ4iTwcukqfAwV+Xs8pwWzcNVa75hWWkJ/V6gLp/ODoQ6BIRM1EzeGOOp4fZfMoUAH5JAo60yHzhjsJtTWnLnqj8Okp5G9GlhSJ1oQtbdvlhrG1cRfVy+uRfve6FJOtg8GETsOcsjLmr5IzqBSsT2XahQqx90r2HrjzaTETQco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rufryD0T; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rufryD0T"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393da8f389bso51377701fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 18:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779325365; cv=none;
        d=google.com; s=arc-20240605;
        b=XbMag/7xqGljwyVbUfU8rQdqu5whqkNGk4BckKWaaLgWRPadmp43aBN0a/9K4AZ84R
         47nLq2jwldLacODT3ldt+yk0mv1RUtVupVDuiikPHTg+lar1hbqI9V2nAA5ZWURRjblO
         90RFIg0iOoSmTdSHDdK+4wBjQvlzwOSlTl0GFBUJ193T2JSFQd6hcwxzawsCqAxpoJuT
         1S91iQguPZXjQHgVm78opa4bRd2w6mAHk9ZW/G/r1lPH29rWC0PO7iofbSxvV/xFAiFL
         leGLLAYGSkkXprpDqP6X2BouJci9aeuMfjBvQ1TFEbvDAILpwaAYv9vOQyglUqVsAGvh
         WzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kBQ7Nb3HOlDAOP6h7RXwpx3JllFrV2ianaHBvCKd3MQ=;
        fh=9LdbyneTgtTdRjU6HYZZ2VzsMZJCoTBsYFK5SqxXAQc=;
        b=YYdpF0TxlQVAqM/vaQ6Yv24MUK+Xm0pYHQbnSkZAm0ebWRHw2dk2PO5KyHvgyY2Fsl
         LiyOqAAxNBwNM3ActfpBjn3LUk8SMBwryk3eBvzQwhmHfON6c9lftr1BofbfGb1Vqxdf
         /Re35Gh99w5KN8igAlbj2HbnlJ2e//fUrb6aMcqOYbJBSb+kI0Ibd/xs03HfEIqfpwW2
         5ewRbAuozsTBUD8KKnYRNzIGKx+Ft7LsDmgdJwATm25N+PMl+CM8sgP5HGiKvWZFLmaY
         ehn0EfoZ93Imqd2yaXg3bUHwhyJiT0S3pvA2D6Fazjf5LiX+tv7hkDQLXfEQKZHGSuWW
         FERA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779325365; x=1779930165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBQ7Nb3HOlDAOP6h7RXwpx3JllFrV2ianaHBvCKd3MQ=;
        b=rufryD0TtaKtzzE2ThUPio9TtN1Fb6O6INL2yxN2eR7x0WX+bcmWS/0Oxhr/1q6pDi
         Xf93+TlTotuqjYBvVGB+e9LVwbOxNT/jj2EWnysU60DKiW6OWnW+To36RXOOhEM7bQ36
         xVKv/G3O9KQVW+dj64TjK4DsI0lEwCVvRX/Yxe5ez0QMI0cNNsqE5sNGcN1scj/EKI8Q
         C7iurUGenBbGCtkWFMNrIlQFtMAHWvMUtt3FcuTD2C2kmt8VuyEn8q9wVgQCBrcm2hGn
         zVkECcKnE0knSKJrkF8wRvWwxvDtXt7q8YDAcf6tsG2BoOCqydQa2VIgLVH9nev6cW2Y
         0LTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779325365; x=1779930165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kBQ7Nb3HOlDAOP6h7RXwpx3JllFrV2ianaHBvCKd3MQ=;
        b=bqp8feLBkBvCN/Rqw8QF6FL5FXnqFZegZ4zqZhE3iOFeUT5/AwkBcxLl4GawPi+/tg
         Zm8Z/oafoiBro9nfkZ8h6+eC0gz43UtvSKL53peN0RBEMCBdKR4jHkpTr5wim3P23zEm
         mdv3DGgSRNuTJszpQr6s6G3edkp0USS7MAZG8v3kHrbsu9lRuR86UT1IO1h8IaxmUgVu
         Y7QKnJq5lqWTz6lSdUNd6hwKDnygy38aNDq4m/GBWcqM6y1GSQEYNJjX/Zrs10FxP99W
         Lsc8qhQC6mgOBVQfO8u1gYPd8OIZ4NPDWjTBlvDZ55RTUW7W+4XmF37M7xM148b2tL/s
         44/g==
X-Forwarded-Encrypted: i=1; AFNElJ9oKJJROP5Q9tjIhdlp/2VTftlY3/Dy8eWUfaM7hjDOPStz174rBv6Q/ZIL2pFVPXfhI8Znw2EYkgOe+R8S@vger.kernel.org
X-Gm-Message-State: AOJu0YwPqdT2OpxkxisWS3vzfOW2K3HrIo9D/lK2ocx7Y8JaX5wyf0yW
	krPbAjqrGj7z5mIMUT+XkAz/qISur0LPo6t2dVKQIW8A6I+P5aUqHk8E9chVQqrDzn60vHcwspL
	eJoM3yyTql9IEitIspREkQk9qhpTxXZM=
X-Gm-Gg: Acq92OEDKsWO0ywpEJddb1rbkbjpfVjmD6cgg0NE96mApBqbLIetzXduSoEog1LvX5s
	WN+D68vQhnsggrYyIrKhOT0gUxZyj4K4IXGWd23NKJ3PteiBRH1tewKBirinocjmzTxlZpvkMkE
	FziRCDo7vBBxdtIbDxlqUlPSSvqUqucZXkWbJxore8v2AGR3ZOyIi91RlWpd1xFpMilcSn64emH
	v1VDdEFRZaXUnHjgbiG39ArdnJ8MT+zbodQfb3eQHhw0MxqPtl2bqabmAHQqy6L2RG5dgBF4vwD
	eHoV7yI=
X-Received: by 2002:a05:6512:607:10b0:5a8:8eda:bed5 with SMTP id
 2adb3069b0e04-5aa2ba9abacmr170292e87.32.1779325365276; Wed, 20 May 2026
 18:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com>
In-Reply-To: <20260520170151.4115308-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 21 May 2026 10:02:33 +0900
X-Gm-Features: AVHnY4I6pR2j6tqZCpGp9YVDnZoflcj_TehSGZPEWapZhvz9XYvX2PqSMn_BlYk
Message-ID: <CANFS6bayB2QGpov6e4OxK89pi5DJ8X2OFub9qBzK5DNDcb0o_w@mail.gmail.com>
Subject: Re: [PATCH 0/3] ntfs: fix mount failure cleanup and free-count setup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi DaeMyung,

2026=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 2:01, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Namjae,
>
> This small series is based on current ntfs-next commit d8756162c6ca
> ("ntfs: remove unsupported quota handling").

These patches appear to be intended for an out of tree version on Github.
They need to be ported for the Linux kernel.


>
> The previous quota_ino reference leak fix is intentionally dropped
> because that commit removes load_and_init_quota(), the $Quota/$Q state,
> and the quota out-of-date marker path.
>
> The remaining fixes cover mount failure cleanup, a free-cluster precalc
> OOM path that can otherwise leave waiters blocked forever, and the
> $UpCase default-table alias check.  The free-cluster patch also clears
> the per-bitmap-page free counters on the conservative zero-free-count
> path so later allocation heuristics stay conservative after the known
> flag is published.
>
> Testing:
> - For patch 1, I built a DEBUG_KMEMLEAK/DEBUG_FS kernel and injected an
>   ntfs_fill_super() failure immediately after load_system_files().  Befor=
e
>   the fix, kmemleak reported the leaked volume label allocated from
>   ntfs_ucstonls(); after the fix, the same failure path produced no
>   kmemleak report.
> - For patch 2, I used QEMU with a debug injection that forces the initial
>   precalc readahead-state allocation to fail.  Before the fix, statfs
>   remained blocked in D state in ntfs_statfs(); after the fix, the waiter
>   woke up and statfs returned with the conservative zero free-cluster
>   count.
>
> DaeMyung Kang (3):
>   ntfs: free volume-wide resources on fill_super failure
>   ntfs: wake free-cluster waiters when precalc allocation fails
>   ntfs: only alias volume $UpCase to default on exact match
>
>  super.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
>
> base-commit: d8756162c6cab1ad4478539d33da6cab413af1ee
> --
> 2.43.0



--
Thanks,
Hyunchul
