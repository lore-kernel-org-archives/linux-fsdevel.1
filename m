Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D49D3C5DC1
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285723; cv=pass; b=XnjpjoX6q4uymBdn7460wGO1EIjb0cSUiNfbhPupa9/gBm55g8dX7hpspgG4NMncM+K8LpjRkOKUIUZH88GozJ2xi25PDtHGcFYp0DTCfVJ+GyX2F1h37Wosl99h68wvj9QJqum8lq0yF5x7puz5kXD6/vnrqRLqsaHLN6daqUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285723; c=relaxed/simple;
	bh=CcOU59hgsOIs40dixbrh6rGCD0wby6W+ZjEG8az8X3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfFkWQG9Vr8CBzd2V4pxH26WPglRTmzYNeetjH7FydwYr+mYJkR5W6xO2RxM7scEoG7rIenNt5ElK8HYsCdOVEYaS9WW2DDlPKOADFAIW+pPJq/x4panHA0NuqhepPEE92u9p5DyD8i3K8PAGQfBiExZIbE3MFtpPe8UzKXurM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lhQG3det; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lhQG3det"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-60294768235so2044759137.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 10:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774285721; cv=none;
        d=google.com; s=arc-20240605;
        b=fupptFmnRlzghUe7FmzmlxrUp4M0CfoU5YiK14Ufw4g5xInXNpF/xyrOOUyAol/ipM
         D0SkTe8JxKwAPlg10evLW0pIFhDMI4bgSsk67DXMTjR7aSLgT1jDG6M5Ph+y2vEacFc0
         hgQsJjK0oKZjR1GPKx49PB4uDrnR8GL5va1iKjXj2kIspcVDRhX6KrXhG1wfCk+6fpNo
         Z+ZZKiTNLuNW0FvKYez1ty2aUs05oeOeC/mUESlpovMc9+Y7/rD/+jGnerQrQ7kI1/i3
         +HIm56sVXbxjZcwAad4fTYdxaIOcVsWLtJpvtEWlNPbQKjtvtCpDMQJ9ExRwm+Is8A4S
         fENg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CcOU59hgsOIs40dixbrh6rGCD0wby6W+ZjEG8az8X3g=;
        fh=Uj40ze8MmO1zK0C8xMcecfISBV7coK5Gd5lrFidNKMQ=;
        b=dE6mBtlPkoO7FFikzBVx0N8aj9b0N8fI+6XPA9K4s2594OSnFRXJDqwL5c+fEJji9B
         Ki4fDmffb0POHvVqEzW+b0HbHelyGhwom48W9cpLKtz3pMHHC/UOX96N6XenthLAc4Jn
         RX54RMdLbMowTtwNd6PzG5j9lXF1QnhOWAm/BD46hZbcriLaWBXRCrM6+yRoayBXCOdp
         5nkdk2Dq9noOshmrYI0wYhHgqvVcpuXZHhGTTznkXu9WFQ37RJ7Ph5NXXfK+0xOB/WCv
         zkkv6EOklt6fZGCZtx4Wf26s1EzxoARfHyyIiyjx6+9p6DC/GbrX9TuYjYDHNrSVpgy1
         leNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774285721; x=1774890521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcOU59hgsOIs40dixbrh6rGCD0wby6W+ZjEG8az8X3g=;
        b=lhQG3detTScFLglAQEdyxICFtl/K9IifNIhmnLr6b5iR85bMIvjbSOg7y8yzyNNpvm
         q7fsRCSgTjnSKzOqDnsZdrFvZXsV2KhfUt2kXQaaXId4AlBfptD5XAOwAx8t8IwKfHJj
         yCWYuWumUF2jXsGB4sbSSBaQ5ZGWjdXYBhu7jjjyIRwQ/a3XfxS7wt0/FumEdYI1CG+f
         MHlUcxuNgsEAL6Ld6yTjfsMR9/DmO03eQh0K0awf6Q3doNvAFcUq4WC7gnotCxkzfP3O
         G8PeGlXwDtuiVak0KDAtrMmnjI2k+WHCRiV+0xRfbH032whMj7wekHgOhcsfusMRe/iH
         OkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285721; x=1774890521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CcOU59hgsOIs40dixbrh6rGCD0wby6W+ZjEG8az8X3g=;
        b=N5yVvXMxj/5+szk3tB7JFeU2AW6Z0r/Hxs14u7vn+wNn+Sm86xCogMt7vUGdFHhgVX
         hV745O99+hs8dT722uacfhOk9zNGJlM8pDB8WrXeYK1liiYY43fvLufe8p6fUHYn0nmN
         Fj58JvDqFIuztwrBA7gTe/kUK5KMSrjy8xmBHJpKFX2wQhi/IuH6zEQ1u9L8e6/lrFrW
         5VAYO1oSDzPIkybDHS3L22CK3/BIjAiVWUia9TDlsiZ2OVJxtBzKruKIEoocX1YGYKGT
         QkEOwPoGbh6AAN9axHmsAN0pSkkbT764iSjZQ9YW0NHRA3mo8f3pu/RvspFk/H2s+LB9
         oZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1UQckJ7yid+cLk/9SuwUKbKiVF+NNTPtsbpiDSV5RhbELoeRtYMHhWzxj7WOZa6dfY0sU1uIBzOHiBqHP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+Q0mURZKzj8hBeMNKmI9RH6c9NYaDa+0hJ3TxNDMLURJVQwN7
	CR0z4XdiCt7MbQd+VAkPmWK7yxhgOnSzTDlyFeTq6dJNohXBzf0c1JgMlo22wVW5AuIBRd/1L6R
	kqfvu7AwfI0bjAJlS4DTx9wL7YTS6jjHm0xMZe0BB
X-Gm-Gg: ATEYQzzgUy3YC1RmMsFzX78BK/A9n5Djw0ywSr3+zNFVMUBqUBZevvPAQzcEHYurm+O
	sMzRA6xZd/2sg7GDagEjZkwk7SyITd75NworWUNJsa/N9s6c29zNhlKqSrI1gyLlJWiiyD19EoD
	ckvskbKAomGyrAuWFptM7qHeD4qc+FS8+r2sqe2/6rsHgy5dznDXqmGFyXZnXYDUM+Q2HBgReuF
	7pOJR7xQvb8BvejmRqMwJbu31uYTSOI2VlsV+THXp1v2jeGOtGpgg7SfKf7nXwGIBBasa+W/89b
	RdTKSa8SKRnkixRA5n8kBpE7Z897/ZfLlZfaihrmJ2trMLbbsWk7R1qeLKRfX/W0H+E=
X-Received: by 2002:a05:6102:508d:b0:600:edd:b36e with SMTP id
 ada2fe7eead31-602aedbda52mr6628943137.36.1774285720799; Mon, 23 Mar 2026
 10:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617221456.888231-1-paullawrence@google.com> <CAJnrk1YWd9HvVLTtZDEM=XyOaPvkuSF8O5uOu9k=m=tUREsw-A@mail.gmail.com>
In-Reply-To: <CAJnrk1YWd9HvVLTtZDEM=XyOaPvkuSF8O5uOu9k=m=tUREsw-A@mail.gmail.com>
From: Paul Lawrence <paullawrence@google.com>
Date: Mon, 23 Mar 2026 17:08:29 +0000
X-Gm-Features: AQROBzDZBEoqpfuK-v8ANfFmeT8_3TvulpEn4XFg1anJ1sSbmx8Q91Axx-RPuEQ
Message-ID: <CAL=UVf7eMk0E5w9bMsBYCtTg=AQ4z_R5U=4HmOt=ohb_78CU2A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RFC: Extend fuse-passthrough to directories
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Unfortunately we will not be continuing with this work - those of us
who were working on fuse have moved to other projects. It would be
great to see someone complete this work though, Android would still
benefit strongly from this feature once it is upstreamed.

Paul

On Wed, Mar 18, 2026 at 6:13=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> Hi Paul,
>
> Are you still planning to continue work on this series? We have some
> internal users at Meta who need this feature. I'm happy to pick this
> up if you're no longer working on it, or collaborate if you'd prefer.
>
> Thanks,
> Joanne
> > --
> > 2.49.0.1112.g889b7c5bd8-goog
> >
> >
