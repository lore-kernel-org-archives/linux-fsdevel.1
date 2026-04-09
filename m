Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D43C3C0E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747477; cv=pass; b=lb73eVv1SBZnyy8yByS6A+NeqcT4ScdveZq6ro4y0TWAsEUKJRZjdreZmvietPWl4rpv8bZXiZKvZDe/DlcVps4Chb3Ziu5C3wlINX5TGYwOhxrOFDJDBhae7u6I9WOd1H4DgBOG7RLeeS4UBctvHFIReXDv2Y9jK3yHtk0F5NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747477; c=relaxed/simple;
	bh=660ytwGdCFipcecnJRMdhbLivK3uL/iOdRo1f5tFBls=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LKlGKKdZs1OoyqWU+QG/vynO1uuO8yWuRiN5Cd4oTf1/ObtGJY6HSZOXMlCV0UxEAW+Ttyjm4WzZu4N9FD9ILwMR/rLi4GCN3EFY9S+stLhzUNViTcrM3/P9ldWM6fHkoMaAZqaZYiQwiWhkeMJ2xGS1LKCp8MAb8alUY6NhHX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BI7NfpCs; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BI7NfpCs"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506aa685d62so5328931cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Apr 2026 08:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775747474; cv=none;
        d=google.com; s=arc-20240605;
        b=FVBBtS4SJOipMXlZW8o9TYFwO+9x/wPaHEbzUaSizhxy+LtIi40yNE7+BUV9G7O+XY
         VZB1t6uenaWnOlTIsb57p00yMO9IFtOY6dL/KIWneRR004QSQdPfLH1SeE9blgw8A07c
         yzCDdVMGc1Ju9kFta++tcXywM3WcYb671rYmVzAC7L7kUgf2KFoQjqejqP6WX7KsbSmL
         xgjZ8yys0OUNnZgEzCCDOPkstEQUs5sLqh+0eD/eR5qQryRPxWZZ3+9JJZM2G6PNzeVh
         RfGABA+Mp5J3AyHp0Xo4T7k6hHLHWhUOHMzRhhmkXKHmwdINMq3iEjq4GDIwXGZ35x4B
         9WgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=660ytwGdCFipcecnJRMdhbLivK3uL/iOdRo1f5tFBls=;
        fh=tSxdqRTOhASNgR/orh4Zmgr3JP5xIXUKwWJ2N+MoR7E=;
        b=dtq1Ewd1WxHHGhQpEuwdwclsrBPhygQdgnz1tXMIxXSTuCUOYSfjBUosiHzjABtO+Z
         1Tc3mRyA2JNbbhnEm2iVfBJk/I9M5XbI7dxm8gXKbiOIH5HwIkBqwxyAPn5fDsdWwq/p
         T12/kLYn2uYWApdxDq+Y2+joarioK97hMQgLJJ1HrG6rodMw0DqHTpXauJWm8QIQEuvp
         TR+fAKJLat7p8Qy0ivtWBuEXdxuBJJiDLzZmp6v6FE1w7Q30nkxpad4ofbz44dvzrab+
         Z0NhRRRqSZGs2mW5WA5Y9l2Gu6+0M3ZAKZ9LbdRpVYJcd4lNArRw6Gq+Vr8xO/pXndCo
         leCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1775747474; x=1776352274; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=660ytwGdCFipcecnJRMdhbLivK3uL/iOdRo1f5tFBls=;
        b=BI7NfpCsXQ1FMOhUXiHbGbMG5/zYuWGRz9HdPKIlJQQfWS/pOyXcgpzxX9FEHLONch
         vcjmT0vqBAFFqR7FvKS9+oNEKwFswyklDcl+5CA7VpPjsxNksWYxtE3f4ffaUVTQZ2wo
         DA54G+ByCIP23j1QThms3halHLj/D4XLLqG3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747474; x=1776352274;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=660ytwGdCFipcecnJRMdhbLivK3uL/iOdRo1f5tFBls=;
        b=RJNCm6kdecrguzqGm8jyLPKGcFxFL7hG5gEOuWAZQHZ7YnpecGCjTe0VVBN0N8udt2
         UNKx5zk7q6OzGpwYk+qQ3IIt8V9m2wp8rWdKXq1riLLT5ThXhidN75de/ljf2Nk32qtS
         agqmiulK+Gttg8eeteikDT7JRW0q4WdU3jN6pG4ZQBWZd0/uF0mB+0yprZC6bx6pDQ3J
         JgU1MDS0XNBMU//6T+lpgvUs5Spd3LRoPCpMc0x5u2joqt1iGrV9MdSKT/4TXFkzN4mD
         iHr3NFEQAc8/RLMd/VRvQn/9ugxUToyi0AhazXImbqlu0nWG/dYvz5yIdXdbwAtfC+8u
         cS5w==
X-Gm-Message-State: AOJu0YwR7830GFUgImB04khMvxQyl3dNly3N1jEkax+kdyks2B5FoKvI
	Rr8uQUymd1zGr/SHSo64Mpy7jK0GNAwVDo2mf8fgh+hx9DJ5WpIYW7oFY7tFhp0lz9Q1NMXlfKp
	0ATU0jbtwe0UFUaLn+3W9yukl2YBFYnAkaJj4+1wa4A==
X-Gm-Gg: AeBDievJuW99JorU5eXtZ7DrIYtvkEvHJYgAlZxqIi//N7J2Qok1SBvZGezb/cZhoTP
	G6YzNFWtvNVjrzGkWDVkIR3qbErBpT2HvvYQ64msTucwcn+N0dnwm7JDKlkO3uB8FsybdDNdomv
	p6VDU1NByh9q/bD45KHiphTG8rJll9wUWiAC59hcO4LXfBhdggv2S/yePWDVBFaspQ2cpkUBH5I
	EdaeGFUZVRLBJuUinXyUMmgcJPd97QzXWAb7h4En3ZFC5Juh5v1f1oq+sdmy2Ai40Jr0pZ/BoL3
	pNLKD06XhA==
X-Received: by 2002:ac8:5f09:0:b0:50d:a602:1263 with SMTP id
 d75a77b69052e-50da6021b8emr153731801cf.63.1775747472989; Thu, 09 Apr 2026
 08:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 Apr 2026 17:11:02 +0200
X-Gm-Features: AQROBzA_jumnGHTkG244U7GC7e0Lq4nDolWVxkvWe_y17iutpYA6vGvZlFm4XUA
Message-ID: <CAJfpegsxe=QdrGGPVSUWfJunDKvOXoszy6BnaP0MjHpRS7rHHQ@mail.gmail.com>
Subject: fsnotify_prepare_user_wait() bug?
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Maybe I'm misreading the code, but shouldn't
fsnotify_prepare_user_wait() filter out marks that are in different
groups from the one being acted on?

AFAICS the current code allows failure of a permission event, for
example, due to an unrelated group being torn down in case the current
group doesn't have a mark for a certain type, while the lower prio one
does have a mark with that type.

Thanks,
Miklos
