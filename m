Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DE3F9F45
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786372647; cv=pass; b=kkVmq6vQxYEAglfXgKzpiGI4FaZZJ3I6ie+Ze4xs2UGrlctHhczs482skYar347V5aKZKReKEu5r5UJqW0U+/sOyL/F3WuxpNTRu7l8TgMJMq0+DSN5p+ka+yhvRr6HO/h+OtvAq1URuxhA08Elo5Z8e9MQ8okATuMobLAU1LkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786372647; c=relaxed/simple;
	bh=1TOh47GuX2DYZgrLBuHx9ZqIJlL5qlbKX0nFvU4QG8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/XYqpreRUN89ktFZMScO17pLVh7rqAGIUB4h/Ja35iDJGiWrVx0yIHflgi331R2mA0kMxlFWLZKIPH+KGKtJQpWMNWfYmll9dMRDr7Sh+hEAdw9gJvmOPX8uSYspNlmKxMwT+XVIxW3rOFRSMvaJPCz7F3WM1Qn84OHEno4EsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BnjWOSSE; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BnjWOSSE"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9063b380982so22034626d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 07:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786372644; cv=none;
        d=google.com; s=arc-20260327;
        b=oYS9C8v6+ftaig0zUKjwEN11kU2B6sU0wnsyaSvhcI8ix1U7ll1GVhfT19VWRYJNWD
         I812uws9UkGdHHt/o9342hIfkK0oU3him8FcMUYEAR0oDvVaC0eYm6iAu+9bFr7QiFTz
         bBCmTNU7VFCDvzdl15/n1x9ZAllZJQ/AQpeQi6HGGEjKiajk0bvWFDCaufq206/GjHMR
         xTHxOsqyCxFyi169g4HsBOxEPeLWhI4FJF4gHbiyQMy29kYJE9JuoK3nQ1knVrhrAiiX
         LgFOlTE320H1ykdSvBtV258nSBoSv0oJcttmTeinFHjFYdd5ezAsCSXvJX9A4nNP4Qky
         S3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        fh=1sgIdUow/zL+YnufEoL9jRDxYRwLjbf0zN8bHyq0I4k=;
        b=Lfo4GRVzcpmo6OXBNnKhZiTrNscC0tDAKgrsArRXdGfSnPUjbemu3Cx/vPqSOWh82K
         C5uK3Ls7NcUpm3mBJo5Mi1AlxdZjsyXHtojRb21Zs51jCMBa64Bx0RIMyQQ40JCHSQ1Z
         FJbsljyFArl3YahK0yK26icvmBYCMo7D644jRoVXbD4Od2CH5doUq0xW7RYFZNUQXvhF
         ym3qBxvYClang+krxrt6mOGTKnjsc0qkeCQb8TQJUU0FYdpdStmBpcex9z51pbSg9jiP
         Ubq8TpxjCo7q/+1nZ2ua2647wGIp8VswjXquSoFWgs0hpqrN39Bmz+4LEFPDe3tTFvhJ
         3xYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786372644; x=1786977444; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        b=BnjWOSSEvEzWJR5J14cWubjkTZghiLwSDr8kJW4rvp0BwKy+nI2ukNW8e93CAslQWz
         oCQhP/5/uCvPqx210NpA5dAr7YKD1Po/1H7JGoWx0owTdLfkUjN6DLKhHhLpSAH2I+iI
         vgQcsTPjEjbabHAo6lj8yF/WExkf+DhpOI64s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786372644; x=1786977444;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N9K6RvXQXpCBgnaYxLabarFuImKKDVr9pRNexvL1dnw=;
        b=fdp7NuXIn3do0BEfs2L7NAWXp0mdws60OWVvTbMgJhHYoyDgJvYc84cpMfo03HIR78
         0DX8mLfxvP24bN2Jlfq9YsFtwvyCXac3BqilOZCC7neMTyBwZpqJa4Q8zFCBUcVk4zAs
         BGbHInb0DI2uJSu5HTebeuHJISKXZEFZmdaB6xj4xmcX4qP5hJ7EQa043md1gxym3VyG
         fiS05TZ5gfKUjjezP/6s4O3BljBuXgCjTuyM5jmZ3TJkIS3slxy+Ch7+Hvd5+jzB89zu
         z9tkgeNgEJsuomxiDBf4Khb8317KPzlH5KxvYUdGs15l6FhFyZneXeOl9w2atrKaLxot
         09RQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXPLqTZZ0jWhaKOGfNuE0R+/pmZZdUEtWdki+BWuX8rSMRSCpA/Fdeu+3o2VGeHWMnH+dy2Mu4WymagQxh@vger.kernel.org
X-Gm-Message-State: AOJu0Yze1T/G1zF7zoAAOb6F3fTE9pLSTn2JwOCbRVNhlvvl6xlHFItk
	/g2uQPvVju8oTIL5kVEuJ4fReQkbmJm3EvBhhYRB30RIUZfKTG2w0bJbLbg7Vb8O8CfMynFeDpn
	NzjcHsXd6q/5yT39Hoj+oOnN5hZbxI+U14AZ3P+EPaw==
X-Gm-Gg: AR+sD11zexv80AsKEp2NvOG5SlkUCMG7j2+d4Nw1jyCs10SZlH6xEXmutVne5fGMWeK
	DLhLFkPN0+Bv/GmVl94WKua2+iPKHnAXgivWLNpqiu5uX9c4rCDxtxzMB1oVrb5698+a6urupUT
	gjJRFOkdY4YE9S47ZyKhL6hezDU6H2X+Kpn585XqbP4QJha31aXbua02mYvEz+YYy10Qq33dQST
	LKJZUja1PoIRWqZt5EbUW90OkQD1nrAKPvIFO7nuRpkUe4NhMNcbvhDrw8gnqU4F9ltXs6Lzmyr
	hAId6zjWqzddLOzsz+5VujxBxMx0z+4d/7FJstD7dV2TS92KYwDNLqMZDPPrDVzeOTAvTPnk71F
	wlZinmivlQg==
X-Received: by 2002:a05:6214:20ef:b0:8ee:f531:4de4 with SMTP id
 6a1803df08f44-90a5dfa37c0mr27777156d6.13.1786372644393; Mon, 10 Aug 2026
 07:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803012648.2195405-1-neilb@ownmail.net> <20260803012648.2195405-5-neilb@ownmail.net>
In-Reply-To: <20260803012648.2195405-5-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 10 Aug 2026 16:37:13 +0200
X-Gm-Features: AUfX_mwDV5L6hLfp08WK2RA4_U7t0g-kBuPpgpA2dBgLwUCWyqeJ369EboEHc-4
Message-ID: <CAJfpegv2TTEGgfFBvAB1j2ixyEMXruG0AhL=R9iMC-LMJToiAg@mail.gmail.com>
Subject: Re: [PATCH v1 04/12] fsnotify: reduce i_lock hold time in fsnotify_set_children_dentry_flags()
To: NeilBrown <neil@brown.name>
Cc: Ian Kent <raven@themaw.net>, Chuck Lever <cel@kernel.org>, Jake Edge <jake@lwn.net>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, autofs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Aug 2026 at 03:39, NeilBrown <neilb@ownmail.net> wrote:

> +       /* Find the dentry for inode - there can only be one */
> +       for_each_alias(alias, inode)
> +               break;
> +       dget(alias);

This is __d_find_dir_alias().

Could add a get_dir_alias() primitive that does the i_lock locking as well?

Thanks,
Miklos
