Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72994A2E01
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137909; cv=pass; b=kCMAgBXttFCnn3IpUda9gsOobiw5+Drn7ec1sq8VsaAb2tchRFkKZdRT7tJW9V9rQO+w74IjMBAjMF2dwuKWBh6M77wP1eaeW+TgoRfPBpeeMQjKlYyo5WzkTQ+bO4el27wv2uHd3Y7ZUJ+a4KYsJIHXltEJSDWsEbUH1lmHCzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137909; c=relaxed/simple;
	bh=DU6lIIGiAmL3vAHbSfUlkC/knXl8i9oP0EzDpJow4Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cXvDzgS3n2ioScYXyTwU1Iz5Afel4ZDPrOuhrya2IQBQcs3pwANs1jWVLrHYIe3EgbBhs5zRlKITPpB70g7mr/veKjY9dGj/anzT91unpk3xWMfbBzdrILdYR3S1eFr7+J1/dAsr9ehO7v//6tY2vnNbjJYnQ6/5Xou2SpaxU54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND6gWWUK; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND6gWWUK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47db714766aso559762f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 10:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784137906; cv=none;
        d=google.com; s=arc-20260327;
        b=A4PskG+2+yrudBS/QcceuHAECmo5GpoHGUyJRBYW8i8kwv/PE195HH8eTUeyK4Apyr
         SZB1g9AeRFSP7oArlD8aImUA/nrPrVI1/wFe154yUqtAhPqg79qQEDL9zsd1zcr9uJHH
         jnt2piMCgsppXucVwjOCeb1ZDPrEkFkfJez1MVSPwyoh4M95+udSJ1zyVgO8hR1fjQDC
         e6GCVD0Mdv9h7G/L6GAFL2zNDh4eIDnwTuzHZaRUSiQCaG08smW6vxZm+plmXbf3XHpu
         D0WN2K0RKayIfFscV62TPmsDa3fWArqrwd4HmrduKoIsDmjcof0lQF9jCP+TIry2drkO
         o6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DU6lIIGiAmL3vAHbSfUlkC/knXl8i9oP0EzDpJow4Yo=;
        fh=A9FbmGinliavictJYFJP+9aL5GjnEUGjuDuOK72zopI=;
        b=qSFiYXSlRqXSl7xg48k4jmFwthhKaW4wT33ESYMQVbQtsi30/HFokMLsnhAr7B/p/u
         /Pd9sxsPdrscRxPTHLtAW8illZfqfcTZr0sLi/NjtYTX9BOYT6QhiZbz9kjCNryFPGT/
         0W/hFb3R+ozEdEoAGjBZAJ1LyvpzBc+T3ZMoOdGVOkn/jQHIxVE9UzgFD6W4uCigl1zI
         KJNQsFvB4YmFAjPBmfDfcH7UOrhoumB834t9l7RKg6vgJ1Z++fGzgLtrQimfAwGEKAee
         DY2HZJ8lShAyCY0SwcXKDRs8WObKEB9pzL2SU6OE7J6azvz/EIWDIXxIrAMeGF1srlN4
         wT0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784137906; x=1784742706; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DU6lIIGiAmL3vAHbSfUlkC/knXl8i9oP0EzDpJow4Yo=;
        b=ND6gWWUK6MKolAMv9f9ljm9zlhi2qrQHJYYMRAeyxYrH4n0lMLH/lPjarEaew8ua9o
         rPGpVXuZzFTqXKu0i0xkfFgIoXfLgies7YaC6Xsdc3V9OGSSxmhhNmTbwgHgLac8B36s
         xdYuqMcqNIOyqxElojYjcYmEnRWUwU6sS5XdLYZyhhCVfJIM3qdq/hjFf1CTOAxuB0AK
         sBrs6fhroUG1cGnMOXHOhLUsTEhzQpIk8iddYGlXcmHLx/5JLvnjptFClZyxFyecgbPq
         J7/PYZXEHA5lOCwUMh3HaZSy20KgHundEIaVeQkPHMwE+CXdSnieDlowtLsUbTsLzy+0
         3OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137906; x=1784742706;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DU6lIIGiAmL3vAHbSfUlkC/knXl8i9oP0EzDpJow4Yo=;
        b=Pb1cjn2hjK+4NPhHep/hQtlTuaWl3WQnszjaFtN8QAAGMMjwdfsAphRYwtsJRmT7zI
         mEutwaaxSZBMU+8WDRKoxhRWPnjY18mMYhm93QOjpvW7ZWPlagm/22O5HEnrMqaJNtTO
         QhEJ7BoXfLd/Qz6KxI4tN9CGP4jpa5d2KpPbMBXmVO9xfHqns2DYeauu1LAekgj+Re6s
         t4oSRL2kQEAFtpTwACRDI1pZzKZFs/x57CkkHZJFcbSFk2fIs5C6bGSqWBP3rFbd98pL
         d/PaycnScyCfc36004OubcVN43BOGBnVeuBnYA+aB4qlpnLYpw22edbehrzBmBP1qLMX
         WOXQ==
X-Forwarded-Encrypted: i=1; AHgh+RriQY/slX+TXtaNgPmxhFoE+PRGsGPyO1P1MgvFDJ1b1+OC/PKx1zWNlgXKQFVZ4qHVUhypi+TclP2RoJhQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwwR7LPAI8p2YTK33VO/AF/94+VBpbhFQ63vywmnIrbjWu2avrj
	gEC7f1kCApyimJQ6rI2nHi/aETK3catz9aPSFgbGjakoTRMCAo2F9U3dZ22A6Wl7Rll5wDT5e8j
	J5/SJeO/W9RNeZhjvGBDwcDJc3nBG7Y8=
X-Gm-Gg: AfdE7cnlSaeqUEWG2qcLiyF4kF1ZkPrWrs14bmnHg3nRwW/nMCCMEPY5CaLSReoSO9v
	5PNiKM3hIpuHRes1c4OwIuqbQqjyJvxJhDfQ9URmYU5ysewPMLd5cD6kr/5BaAeFpopfTwe9WlB
	Kq+oKOiWn7NJjWwCeXwsra3lpvf8YvH6qoHTFqe1zuoeeatA6h0aY6PQ6fYPHFcTcc3AlQl0aJ3
	5AHz1wfo6kkC8uZpRgcHYARdNi/UgvUyLw2xQuN+NUiJ0RwKAGC7N4j5jKj4TaVZI1t7TLN2LDi
	4pSarzUjhU+EXUPJft0wSjyOePh6A6/Z/+JLcfJDZtNi1y7lgkcp
X-Received: by 2002:a5d:5f53:0:b0:472:1424:fc7c with SMTP id
 ffacd0b85a97d-47f55ee9da5mr478466f8f.10.1784137906052; Wed, 15 Jul 2026
 10:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714073230.4324-1-liwang@kylinos.cn>
In-Reply-To: <20260714073230.4324-1-liwang@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jul 2026 10:51:34 -0700
X-Gm-Features: AUfX_mxBCrYH3SWRPEpomKoHZuZ-9fFN3rytuVNZOII2RvIGvdwYcVXmSeGcPQw
Message-ID: <CAJnrk1ZGVFJykTmtLr2jbxtvrJqq1P+-T3LgHsyrUQPj5wFxLQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: select alternative io_uring queue if local queue is full
To: Li Wang <liwang@kylinos.cn>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jinxu Du <dujinxiu@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 12:33=E2=80=AFAM Li Wang <liwang@kylinos.cn> wrote:
>
> fuse_uring_task_to_queue() always maps requests to the queue for
> task_cpu(current). A single-threaded submitter with high queue depth
> could leave other per-CPU queues idle while one queue handles all
> traffic.
>
> Prefer the local queue when it has available ring entries. If the local
> queue is full, try other queues on the same NUMA node before falling
> back to use the local queue.

Hi Li,

I think this is already covered by Bernd's changes in his reduced
queues patchset [1].

Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/20260529-reduced-nr-ring-queues_3-v5=
-0-1dc08c2fccf6@bsbernd.com/
