Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3823612FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 11:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819003; cv=pass; b=ErsZ6msUD/ma3bRSfDdNqf6U38O6MrAuMMkQBMMn2erF6ZKcIBnWw3ancH4TmORD0segdU9be+g/tFXMSnNUJRyeq9ryEBBkEVlA3lYk3ioif8Hk5sZRlV5AXIYJIzsCmx4NW115O8bMhgRyiFgS+I+q46SGTug2S7psKiUPSjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819003; c=relaxed/simple;
	bh=ejLyRkZ537mc7OvMaSktA/NDcYaklBBIQdvV8hSA1O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pTKsxiqrvw2EZS+cA1R1fFBQldIklwghqDfs6zzRs9bKt9U/NxuvmDN/zpWrAHidowkN5fGT/vNvAjQuLYp6AymCZU3iLQptRyJf6yAKaxqn+Oeytyv5jAJGvUsY0ljEPxdP8KDRk1Tf2hIu0pdXleFcfszVDRHIh6UduuDIUjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbJhQZO7; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbJhQZO7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9c745e18a0so38212966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 04:03:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775819001; cv=none;
        d=google.com; s=arc-20240605;
        b=WKj3AHXvShdUsthmmJUa6nGHR/k6u6N6gEXT7AYNiZGgo9slZTmQEmUqq0Dq5eEltR
         I7hk2hnrMbirmwRHk0/sejA6UrsEC6WjjhRvJnS9Hvxaj0IRXXRGSZceL4/91fQzgR1N
         fWapZ7f3wt15qke1REFfOrObQ2MIX30iUIgiKmlW3UQKjDVmYGKNpdeFGv1k1pJ2fp1s
         ew0TEI7/VOu+ykutaBru0EnPBDitau45k+DBRn+sG2Nx3krS/hLg+g7xX0U48G1qmpUH
         QuoZAgpA9hzjp61NaTag5MGpt+bZssW3XS7j2153cg4EJeVa55Utu9nntsPVzFbsFuFi
         GMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ejLyRkZ537mc7OvMaSktA/NDcYaklBBIQdvV8hSA1O8=;
        fh=KjYv0NNhhjrmDOCwaiOzS1sX2rr3BMOO+uvdIOw7xRU=;
        b=hgh1/j1+DhAFTjLC8XA2fd8tyAjwZbKMSrxS2YSO5mvOBrgOcy+hSR8xigSxgkWDB7
         Yro9BrocYV9Rqhqm1eei/UDKjgJ7CrJUYFPMELpSUGfC+OqPnHO+6q4fKvfP6yIjLNDB
         HohuKTSDecH2Uj3wt692ItMv8I+FzSI1HXdaj2VrBflao57Lu8vxqU+zintAcfIUcWY0
         9uzjASrbqV7oN6trhVXv7xYnxWbVw0hY4P9gHuoCiX5kxMj02HbrKIUoPaxBKv3ateRQ
         pY/6/VTj3js3Ub4j/i9DWoaiKcvDi3EFHHiyZykKds4GyavUri6gFhOkgId6B6fyoPMI
         0MSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775819001; x=1776423801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejLyRkZ537mc7OvMaSktA/NDcYaklBBIQdvV8hSA1O8=;
        b=BbJhQZO7Zjq4eTcnh9h9Ask8cgEhAzcaXAZHj3BNtiIyaE9RH/gla8x9tPR94ba2iB
         Y/0NruitDhsKLxn56KxpNvFu089RzxLuF0zkay/yh9sO5kVcMSVvtjXFcPhCW1OI4U7Y
         KGN/WCCWXljOZzpHSYS44cJecCbkD6Ys7eIZSLiS41siLEgzmTdSaT/QgD6fIAVZHkY3
         99RFFkT8uGXu4ll10+Cr91e+59rCOMe93+5zOJRF6EFxptELIwCkn5Qupjq/WCodE6CT
         8iQfHpybCM5/aDEbpPr2He8BMsiP5PYq7Q7PHoVuCnWAFYcQ1AAsKrJfnSdBbaV0+BtO
         CsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775819001; x=1776423801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ejLyRkZ537mc7OvMaSktA/NDcYaklBBIQdvV8hSA1O8=;
        b=XyMtpKkp4+QUUPvYeFjvgTFDisRX7nEK1ylU/gnyv451hZxJ2N9qwHLPPk0yd0iV0S
         Tw47ZTv6PZYLpDJqTklAZoEJrD0G/pvLigyVfO2JywWd8A2mgY0SYM7sdbVfe6BrCDsk
         1wqk5WOeClcNq8mmjRPSWvOSJ5iXjxy7eG8qxErjxamCAfwd0M6EqevUxEtUEPnFWL+h
         QsPcz94Jwj3JUthY7qOW6TbWD0+6+1xCmBfFJz7f9vj3wBIuABXb4BOHw3kKLJvuCU00
         fbzHe9l235Ntkam/V3AnYCip1XmkItnpU2UmLGEH1I1QPilauBnQvf4J7Wf1cSGw1rST
         lnyw==
X-Forwarded-Encrypted: i=1; AJvYcCXCYaTEvlmwxCtJ/B6ml9Zdq7wIGN1lqb9S668/HK0w62pfYwWLw34V9MZa/VlRrS+Xg41N15ISiFl/k3q2@vger.kernel.org
X-Gm-Message-State: AOJu0YyU6sFrvzDskxHoTLLNmoQwc+1KJ+pku0lQPIgREmS+ZyInErLO
	7l5ocBC1tx3lXQp2LJ3oVgeTTYR9Z1SS/Q8emVAaH9mGUPInYHIcvUrA/8kXdoLDBu3P5PpiXLd
	ZIUtsM1RCXJOwHLYgW9SW1dBZq60U6+c=
X-Gm-Gg: AeBDievtwpcDNUgrlIARk4fS38/dfCELmA3vB3ziSD77iHtHNQYo5W1IAalIMXlsEG6
	TyYvu1FfD66RDCWIDlDYZsx/Sw+KilcWsemNmUtE9UbDiWnG59D0UtC/gYDrk1SfNdOcGsx7Rh8
	P58tZ33jJSr/5GjY5L/77FftTGN1q4yJ1306zXYwGbH4FL6DDJZ2XzPh8iL0Bo/pmT+1GWlNrie
	l8tRTmIDNa3nGuCZzfQxrkfFSboh3vxPMEYgdxZ/aHRA5EUkVy0YsN7HoyyhqWunO4Plr19rpZL
	dXH1cwKiTWwZvnGCcHL5KOmwPYhM37z/i1q6Sl8KBQ==
X-Received: by 2002:a17:907:9719:b0:b98:284b:53b with SMTP id
 a640c23a62f3a-b9d76d2c9dbmr148199966b.14.1775819000571; Fri, 10 Apr 2026
 04:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsxe=QdrGGPVSUWfJunDKvOXoszy6BnaP0MjHpRS7rHHQ@mail.gmail.com>
 <CAOQ4uxgjDYihoPGcVZMZPu6S5OCfAJ4StispKUYj=+6Ay_qtkg@mail.gmail.com> <CAJfpegsdKww4FQQnyS2K-CLL7ZQiJ5YT9FB_WPd_OAhVCHBKmg@mail.gmail.com>
In-Reply-To: <CAJfpegsdKww4FQQnyS2K-CLL7ZQiJ5YT9FB_WPd_OAhVCHBKmg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 10 Apr 2026 13:03:08 +0200
X-Gm-Features: AQROBzDMl6VO-5aYWlHa6-P3gb7WkIJi73SKYtFBmc87tteXRSuS14OnuhAGSEE
Message-ID: <CAOQ4uxh5bNnxO_mirds4atXX2tcaS1Ynhjvo5R-TsSCpsAw5qA@mail.gmail.com>
Subject: Re: fsnotify_prepare_user_wait() bug?
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 12:57=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Fri, 10 Apr 2026 at 11:46, Amir Goldstein <amir73il@gmail.com> wrote:
>
> > Do you think this will improve the situation in practice for real world=
 cases?
> > I assume that you have observed such cases?
>
> There is a report of stray permission failure near an unrelated group
> removal, which would be explained by this.
>
> How about propagating EAGAIN back to fsnotify() which would redo the
> send_to_group() with an updated iter_info?

Yes either that or ERESTARTSYS were discussed in the past.

Thanks,
Amir.
