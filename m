Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D8043DA55
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582183; cv=pass; b=BP/QLHWFIasWx62sDufkYVvo4uIsYBWmBSAZ/sDAABxnJgjLtQr00q+GKUtydOSeweUUTUBXO6rsJDuvG+LID3FLd+woNL/ND1JUPPhXqgBRr5vv+mqE+w9yLw7b12c0NqdxhFp5BYbCPb1z0Dlp6KyY+6RvHtFl80nHFNJirfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582183; c=relaxed/simple;
	bh=FWrLTfIezHHV6bdbo8wEPlH1ravV7EnEvXRXHmJDXLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgFCoTJ3SlIBmGicJJqmJwvYvHDF/XQmdTDVuLh9CGwWZozoP2R7icv03MKrqVJJlj03qqr1JB8f97/xt6RuprbTadcuiHTYAGEk69YmN/Z58toFWmveFYGr9jLXLex0THYmYp4AB1M57xCvWnzkKsJBBTd9DPflhED5IOfFRzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Fyo9rlMx; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Fyo9rlMx"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5174a3a025aso7086081cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 07:09:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780582181; cv=none;
        d=google.com; s=arc-20240605;
        b=GnRX1Ndhx2FUasR/1zBleODFh9d3KR3QHQK2Ziu+292sNVA80DAy3Ck2Slpq4GKrow
         kMUVUZZ/xm83GFZZii316Pfr27VhREljhilIuge6VfDgYjc3DbP/y4l83WnIc9Mrn71h
         PRi1OuZEfYGBb0TRtFtayuojRwsAsVSrLBWHdYndUXokP+ahXEiR/zk6Dd6hnCyNl7I9
         QQSolgnUBGEvxwWh/XG8wwjP8HDuu78/eyC1FJiaLEyUxgWhV9SIyM3Hr3J9Dz28BVpS
         n7p6IkDkgsaltYo1ggWHQFvWm3L1u/hV0UtwqI3ju1WaK7FQMkjHtf9028/hJ9DieYqP
         4A/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=98FPmbhpLPJM/7zR853zuqkdkvn2YZkHMTwfaIfPgDw=;
        fh=ghf0MkKUCze/BCa9uPiXjw3WEdra3OeCM8eTnHlpVaI=;
        b=Z4CnahRZ8UoRsAyobQt1g6WOU0RZ5lm6xtXXueKQWyCyrox6WTh5DXUN/u829wkg7F
         XT0zXnFQOiy4s1sDeqVsU9+xcEmpTg2LMYiwv4KkHuGJcL8dvzwdaLAS/BcsNh0FKTjW
         gulhNNZVpiRXwC22F2PTsJV3ljqmGajfgu+GdeGdk8jEAKlb7ZKgohRkl/DTxQLvaba8
         9/alwu/kbXtqia+7RAQowuOkDfI/fsXWveJrD0VJ5QNuNFw2WfT5YtZe+fBoDYrs2csV
         vI7LYFQpVy/rMBw86Pgws7biqatnFNUFvPr3zGj0+ImjkkcuTnu3xfZUx014Zb+mxm+q
         jA3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780582181; x=1781186981; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=98FPmbhpLPJM/7zR853zuqkdkvn2YZkHMTwfaIfPgDw=;
        b=Fyo9rlMx9HqvZ1q/TddHmxvTdTGZxnvBFHWH7FpUoqtOoc2RRRJrL/uMmSukLHL14L
         T7Ri0IyLPvvADVgcDsfslNPbh/oJ6TKnLl7j23RIIJIWq0HToQEzbrC+zEpr2qVGYk3D
         dldyMy1virWw5V2Vta5gTkD2KgUvEi+CqLslw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582181; x=1781186981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98FPmbhpLPJM/7zR853zuqkdkvn2YZkHMTwfaIfPgDw=;
        b=ZAcoC1VrVa6aRPtLER6J2MscW4ZDkclLUNX4mwi1OVGQFo9nuAKHPn75e95BSmA7M+
         YYFPuh/iXcoE9iQ9DWw85+OVKJuJjGl30m1DpVISySRvLWxAYPg/44bMnWJdOibLyGeF
         mR/+i8aGVaPraSAWtp08WKu8w6G4gmBLkvYKUZiKFQfslPfoiVgi8A6F9gumkSa2DxdJ
         vxqmfiiW0B4j1LKGjThhisikWzP8yPlg5cyoNo9DjjIWbYuQz7ZOpcC4ImmxUzPSE5c2
         RjgB9ZlzVjKOyrKOLUWfz4F7acRN93IpNjCcZ8LlfiLhWLa/MXCoF9K1vno6sZ5sWbb6
         HuYg==
X-Forwarded-Encrypted: i=1; AFNElJ9nYOeoJn4gZz0O8/qQ/UJfbv36D4FFnjNBUZkMlN5q8nfY80gxa7rxaOE1I8JZd1lD0ESA39D4mXWOSQV1@vger.kernel.org
X-Gm-Message-State: AOJu0Yxir1SP4HACpWelIrl/Kdio43jW6KNgNDsgxHApog2Xm6LnkPCA
	9tDjc/L5hkT3R/ln/JHZWjFNp1VKUoaZZeC4YhJFQ4/mZWR16/Di69Ns9D1oii90kUIgC2M/O/Q
	7tb6dm67ckxjbuz1V6IB51c2b4ZKjM7DWuyweB4fwog==
X-Gm-Gg: Acq92OEbKPliaEoDJFBXxE3UhaZ1uPaqSYMS3m5BBfTN9JbmtjGfvcOllkrG/NANAbU
	mlcbPyM5MQIi5JK9h+e7i7gyfau/GfbsQKpf9oc37oaQTKqcwDVjEPYaciIRt4+RaoXtB1fWOlt
	baLAg7RXhKej52tNBWELUxoE1i2RkPmk5x462uM6zZmPTDVOZQCebBwMoHMj1UFxt/wKlE29fnD
	tboqxrlJtzaE2Q2BvizNUB6HAlOIt1UC57Ym2SZVy3iHvE6geBMGd1onfyQAewx1l9CirUN5tZ4
	JMrI0SFRlzvAEGrPc6Vvoio3zxrwva/3Q4EhGqOxSUmfa/Q=
X-Received: by 2002:ac8:5ace:0:b0:517:8f2e:5d84 with SMTP id
 d75a77b69052e-5178f2e6022mr18814601cf.3.1780582181512; Thu, 04 Jun 2026
 07:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601152327.2069787-1-mszeredi@redhat.com> <CAOQ4uxjFg4rjwGjU2LvZT6AhC+gBk_6Ej5S4p4DKuk8=a71cRw@mail.gmail.com>
 <CAJfpegt5Q0nmK0JKAfa4Bp_SydR1qiqu7pB0JKkXSCFOYSVDDA@mail.gmail.com> <CAOQ4uxgc_pW57_xeHjm6xauB3Cfx3ZY3Y-NaXO_xvL==vKcFOQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgc_pW57_xeHjm6xauB3Cfx3ZY3Y-NaXO_xvL==vKcFOQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Jun 2026 16:09:30 +0200
X-Gm-Features: AVHnY4LyHhg64celmgzEtz2KBQSkvIzUmA8zTzW76PPPmG_BU1hVxiGNUOLD-W8
Message-ID: <CAJfpegsiA9A8tc0w4JdQ52k2qMr9UrYFF3PRsxRTd1PAfhf4Wg@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_FAMFS_EXT_INTERLEAVE -> FUSE_DEV_IOC_STRIPE_OPEN
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, John Groves <jgroves@micron.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jun 2026 at 09:39, Amir Goldstein <amir73il@gmail.com> wrote:

> struct fuse_backing_map {
>         int32_t         fd;
>         uint32_t        flags;
>         int32_t          id;
>         uint32_t        ops_mask;
> };

Or make backing ID 64 bit (same as node ID, can cast from/to pointer)
and ops_mask be part of flags?

Thanks,
Miklos
