Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034F3002B9
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818650; cv=pass; b=avqEv+DffrzC3lxd2PFOc/8lxAy5O1M791XyGYPw/o3YqdAa5Zjljefua+OpX17UDJI7vzzHMsboBDABnMVJ58ZS6m67HC3sayBARQI7we6Yj+oJfjC4Q9bGlBrQsdR3Hn3BmhUs3He+oYwKGRO1L+EdpTb0grSlKaYpEErP5qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818650; c=relaxed/simple;
	bh=H7mv/ZG9KZSTQ3A8DZwP03i4ew9OTFpKK7oiylr4fFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lN2C6SY4DH1lCTjg9UXgpI3ewaPvH/krVULtWqjT7QeqcGGC2eF66IOsxjz4j0ce1uN8T43jKve5YxKwnlRGpIu2tv1JZDeFW5hS6+JmxD4Wz5nFwOUsFnEwqNlwDSifOIaj5OnkxpTNjJgKFaJ8uULZAW2fEx72+aiaXkDICv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=jxqonK3I; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jxqonK3I"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50baafd6c4aso19630801cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 03:57:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775818647; cv=none;
        d=google.com; s=arc-20240605;
        b=YS0O6AXyMeVaJved8HRxj60ip3yKAjBTd5276TpleMoZevNgV2FPY36N21521UP9zo
         b92wQ4J269yAcG8H/EMyivCwX/2cjrQFRnFeV/6hKkJa9i6rUY/Oy4oEBD83NkWS08SB
         hw+sS0zzX7NJ1Y4TKqm0PVS/flCNWa0wgaBER5AX+9/QO/Bgr1WHMteRCeTHfkm2h3N0
         h/D+4Pw8Ch2VyEjsS+W5ZAS/jx1+Gq8z6JavGxlNytaUEo/6GoM2UUr+ZU4DN4c4wEwU
         ZFUrNofE72D/pXUMIUbadfgDneRHItqicf+La5oobMtQjnRIYaawdBrXwgvPfUfrQJfp
         VOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H7mv/ZG9KZSTQ3A8DZwP03i4ew9OTFpKK7oiylr4fFM=;
        fh=nZH57Aq/6mjKrWZhZxJE20vTSOFKHiS9GAa7XTqNdUY=;
        b=TXrN7TM/7ScRr04PZ6kn4JAqBrD+5lD6kC0sOrdNOfu55yF2LpfxZmU9lzDo/6+E6A
         n9qNl/VrdtJ44uhz17VUciMgcRjLZH/c2SnK7BEXNG2EWDsCWbjIJOWy1ehHdBBh8mdA
         EOrI35bkkH4q46PyX2mk3GmO5EMaKft5pnI01lDxMOWdDUxRvcqMn5cMIZYeyK956Itr
         Nb1WKGiByDVNId0b2Ej7HoOWEYY5/T5m7lGM8bdZObZV2sCytIMdgsB/PrEEadoFkl0L
         BczKZIxUSrgyEqZUydK7eIXyBYGXtI9UuUPoCYIQfFdyQTtXROYT782ohDRALhLhC0bu
         R/EQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1775818647; x=1776423447; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H7mv/ZG9KZSTQ3A8DZwP03i4ew9OTFpKK7oiylr4fFM=;
        b=jxqonK3IPpj4OdJs2Q015PcqpZdBcZwTuAxNjeihTvkoova7otxZxhOb6xHKppw3SO
         JNXePcwZygHv7n5b310vnQ5fv2LgoWeTYfssSITxHXFWPXI7u2WP/ijkpqxyGtTBUegA
         pUjD9wTGZHVcLBhMSBRyKNL8yoNj/ph6YoBtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775818647; x=1776423447;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7mv/ZG9KZSTQ3A8DZwP03i4ew9OTFpKK7oiylr4fFM=;
        b=eApuBg6yeAukJ5h9J6JY32zKv0v6ecb3PAkb8kpLdZrOke9bZy0Y1d+iXhEylhJWS4
         hdh3Vu0zLWrDmOn/zBC7dIphuLi4ljcSgeRAoNJUJM6QEAPx4URn21stym4T3qG4PBpD
         w/v1x/iWYtGl5YhqdW9KNz809vH6EVXxZx3Zc97Qr7GX92Cwrb1PfoAc8mXczpRwcGP8
         tS2HMLDvLkbP0HS6RfhTLiTGJOKjsxXXCtPP5G4d6B0D2/GZXH8F8bt03hYd9nKrcpBl
         sWXtUg7UnGYpEK/QeY3q8IzPJQozHxsf8Ko4a3Eh9UY6g/LVElhoxA9FpzIempIjA/e9
         2lOg==
X-Forwarded-Encrypted: i=1; AJvYcCUJc4WScy5uttJV+EG5OhQCgdJVtHvRJY7II5CUIJotDXPu4jmQ5bo1yP1gQf74o1NSmYAKkwtsLUhKLLgg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9TUGm041Dy1MdQMcFyGLHgt2RbVOCI/D0u67WB/z1NN62pGQG
	I3R60GZsRpdXu39LIC3vF6HFCMXl9NqWVaeHBrSP7Ew6sb9ZSG4oX3cq08JdCMF5lM8M1cCjAKj
	+ByoxFUQFek1yKv0SOXU/wzCI1d/6PDkdDLc8xjrRSg==
X-Gm-Gg: AeBDieuY9ZzKb3RmYFR2MiXa6R6/5rlKcLzfDZPbrQ0BUR4YADDF8gosW4Iu9+i49Ph
	YzrpF+Z+Q+FpQ1LtPabIq49m7xN0ajJlsWbAa3Bs56W36cjNWBUsqJDK3QzDwfYnu8Hvjz6mlqe
	4C6bzUXSlJ3A3usaUsJaENKMOW9brIAwneB4JLXrjztu24Tlvrg6P95/c5iL2hdTIMBiximH24K
	qWZGFTEw2fJ+hDRTslUCPMjeRfKJu5FyDsMiaLscsjhII5t90e1h6EfCo5wTsOnq4f3HrxX1KnO
	qRCh4VVgk7wQzBFSziPndUxvyYQK5IxWdHDOLOgwSg==
X-Received: by 2002:a05:622a:148a:b0:50d:6a40:692a with SMTP id
 d75a77b69052e-50dd5b72c30mr45047911cf.18.1775818647473; Fri, 10 Apr 2026
 03:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsxe=QdrGGPVSUWfJunDKvOXoszy6BnaP0MjHpRS7rHHQ@mail.gmail.com>
 <CAOQ4uxgjDYihoPGcVZMZPu6S5OCfAJ4StispKUYj=+6Ay_qtkg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgjDYihoPGcVZMZPu6S5OCfAJ4StispKUYj=+6Ay_qtkg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 Apr 2026 12:57:16 +0200
X-Gm-Features: AQROBzD5x3SVUCyIj0D-jd6R_PnN_vT8QXHLMsvklazNd4_QpWiNPvjyA_JSWT0
Message-ID: <CAJfpegsdKww4FQQnyS2K-CLL7ZQiJ5YT9FB_WPd_OAhVCHBKmg@mail.gmail.com>
Subject: Re: fsnotify_prepare_user_wait() bug?
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 11:46, Amir Goldstein <amir73il@gmail.com> wrote:

> Do you think this will improve the situation in practice for real world cases?
> I assume that you have observed such cases?

There is a report of stray permission failure near an unrelated group
removal, which would be explained by this.

How about propagating EAGAIN back to fsnotify() which would redo the
send_to_group() with an updated iter_info?

Thanks,
Miklos
