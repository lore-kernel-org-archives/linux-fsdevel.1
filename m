Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CF1A0BE0
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Apr 2026 21:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775511922; cv=pass; b=ZZTBNjL/DWqEAvnZm+lwd2PckuNMXCpkKQrlQ/vX9dQvTGBdiGufw/94HdGTwJyMf7pb+roSqUkBQC75qR93T5OeorVEULVkgRQz9QHjDxlBM3os9RGYAoS4NK2253uARNzxx8yfzvRZe6RVspCSWTsLdDfdgIDFkk0tR1oLVhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775511922; c=relaxed/simple;
	bh=40ijEJm4ac8kK8z0F+SbCs5yGl0NBVs6OVYTI813+Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEmsqY1El80eeapIu/zYlpFWaRBCotWGaFOHnK+kz0MpIq04RTZoTwPTO59de5BSPRsnwd09SwUuCbOgJY/IhZJlzCWWZyHOyhp2Uf3/I7dJ7emJAthSoJV/NJHOLwD1yhkm3lINO2dpx9BJzWHQ7bxJ2J4uzOaREMgjp2elm8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp+J6ro2; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp+J6ro2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66e8cc747d8so3011553a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2026 14:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775511919; cv=none;
        d=google.com; s=arc-20240605;
        b=iS1aTv4cn+R6/HpC0/L09dIwOFjGAWGZtias1K+omnOVWuqHR1K6bt8WO2L7nsfiTi
         yOTL56V4/nuXSDA1cfB6sTqQ8DEzdK1kyUGtQ2YkORK3RN2X/2aYYm0CPis2F7RJHK3+
         TiFzydXXq3TpqFkL159cGjCh5VL1oFoAgIYqsAUKiUJ7SLVquL/if9Zvv5/4B+GSz8q8
         pjxqpWB/3IjwXR5VnBFG8940SEP4KB1l/6Gz3mD3pYr2721898nO99NRow3qtTMXkQRe
         I0mjSgbmXItHJlNQZGN/q6qGnBV94dOqqv7Od0RaZn1qPhqrKLsgBIvuplrx+EK91o3M
         DqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40ijEJm4ac8kK8z0F+SbCs5yGl0NBVs6OVYTI813+Lk=;
        fh=IknLau85xGV/adNo9oZJGDYKNdDG+WfBtqpFA/r1ebw=;
        b=WXmuRbCe5YjxS4f9/b2dxsXzpMyIwKxD+QLzwoUsDIWXTt5Seajsey6fOcm1ao8vZD
         VDnRSzcJcJNHJF0rGdZXyTkALZdHUCx946ZXeiplxDo3OGNeiiZM6HvIgLkCpWD3stD9
         b2cSrJSpMBR8p1kDSzzh86w6Q5BufKPDnmZL+sgNtOodNFj4yAvHQg7omaL39Any1r++
         cvSR/VXUWVcbOj3BrEefEvsw/ZqUgIReHYzFi7FzMPL74sQlqexJrnLINWxPwglonQZz
         MEJNVeSr4K2V2MpGC0v3kJKCy9X1f+J+QoWNwf5xYsY36505bQupqJUIO5Uo5WD+6q7c
         n0+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775511919; x=1776116719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40ijEJm4ac8kK8z0F+SbCs5yGl0NBVs6OVYTI813+Lk=;
        b=Mp+J6ro2MAwkhbQ9UDTSc/ulFWNiC6UelTP9aesZ4I0jnRVkHDNxXrPTEEq+nBnu5/
         za/NcxjL6OUyLPn4EoJ3JKn3F+xQvujms2N6m8trpbZQJRk2jRXh3+aXn1OqyxQN0GB5
         cBgrEm0DFH0c9Kgxl8BKpUtapQUtJFVQ4V/ZD2R/Yzqy5VGrbUnt4uAf8e9SWQ4wC3ty
         IHKeY15vNriBwrncWK4FB1kY0iQdJZuDdDbgnDlB6G4nzODrHJMNocc6/hZ2VYdGbWKJ
         gdUWJbZfIBejUquuSLc7QnkZ6UZS6QfqdhRJ99QMJ65dOKgNX8E/oD0PpmjzcWehVsc+
         epiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775511919; x=1776116719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40ijEJm4ac8kK8z0F+SbCs5yGl0NBVs6OVYTI813+Lk=;
        b=a8Vhhg8GWzqRGDjsjtq3hBsX50Bt/fBGVXX0DuDt4waZbrPCTrpTACxuWbtvwr7Nmc
         XzryfUSA+6FYN5xMVopxWPVi8sPNo7cr7F/0ePZf/UVnqO9TWAh6AzMrbLPsgLeAPanE
         coSQmcxkweE4QrCyqh8eQGd/bykzzbe+Cuqw5NPJGrYIj+/9CmHOexCt+anzvPAONuMu
         j2GGtIP4U3+1xNwr2I3V2sy+EEYmOt7L1fJ2LKdQ/GYh0mrOcpHskJEb4Nym848erD+I
         KBPIQIVfA9mNCAt82Osmf9z0XtIZX4veQSMwJnrip79IC3nSWBaqxnG38dZBWK4maDGp
         jn/A==
X-Forwarded-Encrypted: i=1; AJvYcCUjJYba4s7ADuNjQAeMfi26kZcpDhlYH+egbNp12nbQdNYljRtTZqWtO77jvNyN/pwTSRmFaeQSqA45YBNA@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQNuk0vuphTzSZhzdamm9axD/hEXQAq+omFuiNt8glIIWWeyX
	eCXN+XMBDVS6G/GGSESpQG27A4YYNL9MgP4aCKZmhY8ocCh7a7AHwyaSKh0GpF7hoU7rzXnuBbY
	Y6jusRWnhwOkUTtlSLlcLqmEr6Z+aIl4=
X-Gm-Gg: AeBDiesr7O24gFKj2AkKmsVB0zSbSOsh2WzMe/rp6Z0umS8r9BzECGW7RzJgq9O+ho8
	pCNcfo7JXO7wRNI+IVvH0ygfYcTQtezb/8RtWbMksoF6R/9xGq9ODxuZXXsW5x2YQZ4B/qUqz1Z
	8xN28yNRvIpCYKPxd06bQrgEgtZ421MIwaB82P9cTd5UeRi2wPXXhn2dThnBrPxwS/my91Cftdi
	q0f9a9VgL1u/oEYtSzXPvlibKptcdbhhNXfL7KZ3Kyg9pGQSD83jX0lu1lo8JNYg7NWhI3BvLu9
	CnIBQxfnJ1FdhxCI9YffTkmZFYbIQNdoW1Vc4po=
X-Received: by 2002:a05:6402:1473:b0:66e:44c:dd3f with SMTP id
 4fb4d7f45d1cf-66e3f3c8909mr6217791a12.2.1775511919127; Mon, 06 Apr 2026
 14:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328173728.3388070-1-mjguzik@gmail.com> <20260406211650.GD3836593@ZenIV>
In-Reply-To: <20260406211650.GD3836593@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Apr 2026 23:45:07 +0200
X-Gm-Features: AQROBzAOYc6qRMmA_2VrJ8xvvgX19fY0MQP-hUyhn5HJw8ih4HIk7HyWZxqsOM8
Message-ID: <CAGudoHHpvBMiJNdW3rJHMPgJt9qBDz5Q3GhObL9xdRwZfTnjyQ@mail.gmail.com>
Subject: Re: [PATCH] fs: hide file and bfile caches behind runtime const machinery
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 11:13=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Mar 28, 2026 at 06:37:28PM +0100, Mateusz Guzik wrote:
>
> > -static struct kmem_cache *filp_cachep __ro_after_init;
> > -static struct kmem_cache *bfilp_cachep __ro_after_init;
> > +static struct kmem_cache *__filp_cache __ro_after_init;
> > +#define filp_cache runtime_const_ptr(__filp_cache)
> > +static struct kmem_cache *__bfilp_cache __ro_after_init;
> > +#define bfilp_cache runtime_const_ptr(__bfilp_cache)
>
> IMO the entire runtime_const_ptr thing for caches is wrong;
> statically allocated kmem_cache series got stalled, but I'm
> bringing it back next cycle and this stuff is going to get
> reverted as part of that.

I'm not going to spend time arguing about this. Given the
aforementioned direction I'm going to refrain from patching up more
caches though.
