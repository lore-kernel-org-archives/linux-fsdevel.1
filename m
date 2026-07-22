Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93773749FE
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731907; cv=pass; b=CZ0bPSsTTk3u0fdg0r8bXkkNat8wRyqVorJ/ry0Do7+2BFz9q0id7XKUe5oZhBcyYnHS4QDNe1eOLaHA9tLxJ/micZrHkWydgr52OjR0mdcqOzf9wrkgQAxOl1KIV7TWWIN/8N1sFW+Dk68CRjfXwEdNPMwPkQHpBZiX8yfTPm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731907; c=relaxed/simple;
	bh=lV6eh0HXQiCHgDZYVsDh7LIE6SZj6q5Drxem6nRIY48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGZm4+NR5FfLgkiAVAWkd9c0aonkprt9mqAVg/KhxG3toH+1kIRzlcY51Mfzp4BfoMR7DP6ItpImCPkwFi7AQZU9JoWyNYWzTwIPqvF/ylc5wnDzg4iVS76/d+oKsO7t6bzVhw9Zx5UxJ96ufk+EPWu9V/HJc6YIp11jpVhDk7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=I2dFglAI; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="I2dFglAI"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbb7926836eso1649971a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 07:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784731905; cv=none;
        d=google.com; s=arc-20260327;
        b=Lv1wbwC38AS0AvIwR+UBhtqXl/90TMRWUQsHFYGo9zSOe3Sxb9XPCCRVL+1JEcNJyL
         mBfNRP6z5lKVwpvDBRgsiRZ8TmpdMqnaph72MnJE7yZteOVkKmNPdmvgOyNNSyBoqbvx
         5USzJO4Ot2redX0kV5JIvCqnrIVY/ONOJ1SlCSPz+YQWLzekB+avnWdGVhqv7w1q9B5l
         Odv+CS3dnxXS36WML8nZR4GnuZ/QO9h6pKQSYilr5ioTRpvL2AyU8AX2DNawYPduzLZ5
         H5LXOfFIyuJdc6aByMBwaJObev4h5rn0xteLwu90hGDqR0xSB0uni7TdIhmaUOcA4uw6
         zfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+KGIjEyMqE/ArpiMuHGmGvt5tD+DXkhxxitb3c1zV8I=;
        fh=lEJaayVULRQcdvBkxdPN9rUxlJPSC0qno06L/Usw2vU=;
        b=DNrSi4qMNPY/yeHv0Y5A1nkKP+TDl6efEncIIzrzQInPuJPsJMTOviu5MMAcbLm6Pw
         XrR/2vx+fxESEdHFSZg/D/0TOYwzv6LX03AHsf0Q5iBS2dPt8PHA6kWESTN+GX4OFUJe
         t93zag2j17EGdRbUoNMDd99CU5mzrF4m9uPr9KVHqXTcw8jUOsIJChudnMq/XoZversX
         RWDGrQS5FPRnjhWuX8Oj8fcpQVbRqB6AyiLZeM53FLzNdljX57ctVy2dspl/wzTmj8iS
         rlH8UKLN4/rZGeNaSLNbARAdn1SxbXajVs4tH1CuT0/UlF7NuBBw0TsnT7MK7q4IkvBC
         +tbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784731905; x=1785336705; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+KGIjEyMqE/ArpiMuHGmGvt5tD+DXkhxxitb3c1zV8I=;
        b=I2dFglAIhp010TH5i7pnhbqiPHI20Gopztx8yvJ+fhtPOdfoGc7ihZ3cY8/0HWjt8G
         34lm/V6w0WKAgQ2vLZOxKKl0vHL0Ie0p42gSJ3AgP0bS7uCyMGo2W+b9EFIwc/OxLBrt
         rYwnOBD3Z9E2JN7dMSEssLM2HGrfcBVtSYvf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784731905; x=1785336705;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+KGIjEyMqE/ArpiMuHGmGvt5tD+DXkhxxitb3c1zV8I=;
        b=ELmJWRSCY+Hj4eRIHEYCdIS4s0vis6usa0pyGkYMZQzp8ZiIO+ggxIlS3lXn/cv2v8
         mDcvqchiwcnp3D0m5BdqMl2StpOGGoca46k0D4uQKIL/nVaHD8EH2LC7L6gLlmUWTBYW
         H2MOHnyFNzoRiODxni6ob3AIr4MDxt1C5xlCFwVNsgzexk8XaoI7zPd3roCfhxXr2F8p
         eSPZuAbFOwSPbRV1gaxvYDaKlHbZ+8xrVnrbE1Wcb6tQ6I0Eg4VBdD7zxTTyBWq3ASdw
         WpVtKpNy1M6lHYDrCpo5yAW+sRzQKujEr203p5YIyKQNJAtxtxE+nv3yW+XR2iY+ZVXu
         I90g==
X-Forwarded-Encrypted: i=1; AHgh+Rr7MKe5GVovcF3agst7+yZvb2d6YfypP538+nO5XTH067TdV4GH4q1XlMfvDyjebtkK63NxO/5Pv5tjlANO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21uL+ycyFOMew19nAgngaFk2435BMqzfiRb326/kKb2ViwcCf
	ku3GK6NZBH5+6hhnB+z+CQqPz9L6FJOzYLd7l/Wa/uQohkxzEe5r9G1pm9/ALcJrTnJlaL4F/dt
	/x2aF4gXnWjbzN0rPTp65jRvbcEg4k4/OW/RcNiO24Q==
X-Gm-Gg: AR+sD12o8jBeYf8OadxIUVGn7cagy+5jmJ33KU21wu9tDx9Ib8kt+vSEEBe1i5PyLrT
	WpEjQbdBmmYxmUC2DO0zHKmmgi/zLQQFsP5DMLkI/QsJjUQUfPMQLWra6ne23+i4wD+yY+RYBJ0
	ysAGxKd4GdWCKHELRJEGfaDeSGiHQ9IqRGeZfCNy/C4emoHlonH5h9BhHaYIOzqdUBSlWfoB4BQ
	l+bZfJEg7qbwInrU8Wt8Fzra75nytjFukISSCgKMHk2LqRsJKcSpMDZUAbvInnBJBjpA3EjzaZh
	3VUMK1UlvKrysE8kNQ==
X-Received: by 2002:a05:6a20:d492:b0:3c3:a1a4:862c with SMTP id
 adf61e73a8af0-3c3ada53e11mr26768547637.68.1784731905213; Wed, 22 Jul 2026
 07:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715101107.973997-1-mszeredi@redhat.com> <CALCETrXYHX+OSwm6vhzQqvdk9Fkbxzh_dGuVm2tjvPJG_x1XdA@mail.gmail.com>
 <CAJfpeguxCOw4cURjPVOMj5-A7JnLrmy8zx4qE9uwxg7x_Wr+zg@mail.gmail.com> <20260722-erraten-hinblick-erlesen-2520fd1a3726@brauner>
In-Reply-To: <20260722-erraten-hinblick-erlesen-2520fd1a3726@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jul 2026 16:51:33 +0200
X-Gm-Features: AUfX_myoOxogLBx3AVNQWfe_n3afhoBfiMuTAn8Y0Wpj1xcWwQS0hNa4Avph51g
Message-ID: <CAJfpegu1mzQGQUvRTqLbNOp4B4_QqddUnXyQFs0MLuNFa4xAoA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Miklos Szeredi <mszeredi@redhat.com>, 
	Giuseppe Scrivano <gscrivan@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Jul 2026 at 16:25, Christian Brauner <brauner@kernel.org> wrote:

> I'm still vehemently opposed to stuffing more creepy apis into procfs.
> So this gets clear opposition from me.

Let's try to leave out loaded terms from a technical discussion.  I
never said this was creepy, Andy was qualifying the O_ALT thing.

Other than that, do you have a specific issue with the proposed interface?

Thanks,
Miklos
