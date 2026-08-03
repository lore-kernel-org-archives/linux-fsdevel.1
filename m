Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112C3B27F7
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748238; cv=pass; b=pccG4Yy1RnDebP5txLpUR/UEbnndGViDLgmk4Fqa05PzW1I3C/XogBZwbraY7BlLH3z98tHjyEbZlwmYxjEVpsqdpyL1PQwUFINC7u7oXWfYhul5HuP2+QNvtQMhrf1VBJQ9elPJtbptw0L66++4x6BC12UHc69CSAKvIvL90pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748238; c=relaxed/simple;
	bh=pb4b9ti4Lu/3RkGlgEdrOnZL8E4Kq5qLvFGE6xSqQkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mr9zWoKiztOpHKSwVuTKSkNj5xZkvyLofzmSTAcgua6SpTo1V9k9acEsEsJkaO3n20yCkeZAHE2YeZ0ENtxnXkhKl4RlfpLl4vuiG1AW5zdO+n681A/M8Vz+bv6suBrF1AIk6561EJMlHxFEzXMcuRH8l6tGwv5EIW5ZMHx5FxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUhr8tsH; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUhr8tsH"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a0cb6e96dcso2048088a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2026 02:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785748235; cv=none;
        d=google.com; s=arc-20260327;
        b=APZZs4R4XxAflV8a5d/YY8T4KTRp7qv9gYK+N2XRFzHZdFlKfHTTwTqWQZAhye+wO4
         j6otLe4gvHpdQryIQUKvYJKws/DjFwzcJmzYCbFrNW65v708jr7V7lvI2hAvX6EgGd5i
         fdayf01zLJE6c/CVW94F95d91SiOeeqU4ChfPQafg0CFkOaA5fcU95yTkiqJJEzIhW4c
         G1riaV0dAMry+YbIOJo3KXNdhCQMOqSMX423uTJlSet9Cy4/AKsKhLuHDdhWUxo6BVQI
         hiZclxuRoAAs1Vgybu0FpZyRjAnelcskZIxWBRdQBahd1DFJre3qMmV14rNPQEpCnT/Z
         Rayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=7J6HVJzNjrFIN3yFUdHtYdOfwELL+FfzhQlBDyNUu60=;
        fh=72H9Fhu3mH3LxmTlTHb4lq8hrcyVkkopJRZR2cuPWu4=;
        b=rW4ua9ahbRhxhrckcMci+lvWpcDo6+wKjJernBQVYrf1Y2OaHTeFuRmAmpDvTPi77J
         QceJpjLQrj6icxm9x6ncRzu4jfIhQwmyTgquqEHzQNKsKn8wXNRclsYOtwvVtTjQIIlL
         y6k5rF0R8+/BLoq4RT5+7ZvrHv88be+zkd/fAJ0lyxFfIVsGC9if69a+MhxV7BVN7wpv
         9ora4IXDijpB8PTqZGqzw2bYoLtWSHcmRTZeFIxhwtvBKTmUoEk2Ux8RmyJ+jrNGlYq6
         krJm3H91AMcyigZvBKIXoX8n+TWxHRXM4cNNY8ZKvSBCFi+9vZFQnJJteRT3EK/baIrw
         XZNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785748235; x=1786353035; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7J6HVJzNjrFIN3yFUdHtYdOfwELL+FfzhQlBDyNUu60=;
        b=BUhr8tsHVMZ5AlMVcgEViL/spohh+YLXDGPoGDvcEhGRXuK3RRfRzwRhC77OOBvojo
         lF704FEUulsA86RhnQPKSXLExJRH+MJy8zIHMvFDR71axPYAg05awgyvLFdkoYOgW3jp
         6Cs108uN4yF2iXreSr97dLbZaG8Or2IlltUxNLqYgBNTXx6mwBwenxLo+E5zFJy4y0Fn
         Mp1poSg53KPx9b+kss78VFG26pOIMTXdrNLmEO9SecbxO/YoEHL1YXF3gtVMfqjzXzOt
         wPIzAmLwURIFVJLHr1nBbgYpDW0vCJYr3xAVoFHyEuwQc6O1x9+ntNUgnkSB00c3FWPo
         2ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785748235; x=1786353035;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7J6HVJzNjrFIN3yFUdHtYdOfwELL+FfzhQlBDyNUu60=;
        b=MtyQwEVpdrrAjbWjVBgEASYJa2yFWL1D2Kh1E2XaWJG4bHwqYJmz26QyUySCIDjn5s
         TxAGrQWelawewapoiKCVAa18VmmrAeWC8SKf/eFDIasuFXzgO4oHx6iuMcJ1XUe7TZHb
         ZFwGXieuQ1zyP7jPt6wIkrAWOp71KF4IhBwzontglBMoCfsCTyz44VwHQ2VTCY9r9meG
         v3NVRzMYCvZUvehXOvFNgzlf2Mw/Sgage0qmh+toGC/rvUrX7EN9kYWK09JznJXa56/5
         Re7FrQ8WHi/pPcVScxYiZUzQklry8p0y/UztpN0DNsxjwzPYQ5BfR376Qk8Y/I1fo744
         IJGw==
X-Forwarded-Encrypted: i=1; AHgh+Rrav83ITBoXk0U7qTrRIW6TEO/tPmOt1gCl8Fy9C7z6zISaARqi7jkxBZKJpT9/kNJ+JXqTdLTQGdLVIDiW@vger.kernel.org
X-Gm-Message-State: AOJu0YxiTijDwmURUxooZ5UJ7GtYy/1n3NexGViH2JrIX44VZ5PcjZvK
	dWoJmPq5mi/WjvAVtdy5i9wyANzTGyY+GGkJZqtaBUj7A0Looft0/MI3DqBJJuWnb1/gAm9bukZ
	7Chx8syQ5cph+wO3pGhufxAUqBIKFAONBwA==
X-Gm-Gg: AR+sD12a2KGTCCoNfpOFCUxxxlebivWMybMzRNTMDZl6fWGHW42iabhAH6q+bQ1ksM9
	i2M2GAd+dVW5FMgIoAzn1AdsNlRNgcQjb0u8H85PyOWTOm2xT7iJ8Jm+Xsv13iQFM7wuBzvIjGV
	4aYvmPKx87Cnxa7Ca7zxT7JQ41D5sHD+7+LgpaJMdmdl+4vLqC5QP/5B78fG0Fk+hewLrp1jCQQ
	ERuU7sEZGcaVXXM7Bjvg/8qUKFaXsYb85W1+PoJyoUgY9XAR+LKtV3uaMVnq6fMGWn1i39QNYof
	BjDNsnLQF0lsdMPhXLw+M3suHNCXxwuwrIdC8bLcftvSCxs=
X-Received: by 2002:a17:907:1c94:b0:c16:9043:7973 with SMTP id
 a640c23a62f3a-c1fe80b9b86mr648019566b.4.1785748235175; Mon, 03 Aug 2026
 02:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729110036.12129-1-linkinjeon@kernel.org>
In-Reply-To: <20260729110036.12129-1-linkinjeon@kernel.org>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Mon, 3 Aug 2026 11:09:00 +0200
X-Gm-Features: AUfX_myjvaCFWmA02c1yymsrIEKUOb3dI7yRNTdkV8ooLN0Xyuyio_0Xubo8r9M
Message-ID: <CAPJSo4WUxiKcfjDkHuOVhqBmvHng7JdWX1dibsYFjW6qwTCUSw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ntfs: add ioctl support for named data streams
To: Namjae Jeon <linkinjeon@kernel.org>, ntfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Jul 2026 at 13:00, Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> Sebastian and Cedric requested NTFS driver support for an interface that
> WINE can use to access named data streams.
>
> NTFS supports multiple named $DATA attributes, commonly known as alternate
> data streams, but they are not directly accessible through the existing
> file operations. Add NTFS-specific ioctl commands to let userspace list,
> read, write, and remove named data streams on an opened file.
>
> The new UAPI provides separate commands for each operation:
>
>   - NTFS_IOC_STREAM_READ
>   - NTFS_IOC_STREAM_WRITE
>   - NTFS_IOC_STREAM_REMOVE

Wouldn't it be better to just provide an API to get a fd, relative to
a filename? Win32 named streams can be sparse, and it is common to
punch holes to deallocate sections of streams too. Streams do have
their own timestamps, too.

>   - NTFS_IOC_LIST_STREAMS

NTFS_IOC_LIST_STREAMS looks OK.



Lionel
