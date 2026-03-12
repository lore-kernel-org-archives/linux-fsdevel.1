Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35380408251
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773359565; cv=none; b=JHA2dFRJ147ZJf4Njy29fdzLlUj9WOCpXyvlNGdRd70Y4G50yHvY8IKs2I28f5JpOh/P2zvm/94xjl4Pif7u+z8R4kYNGXFjxudVvPHkHiYUadv5Sf/41/zeYn5n3FUAV65k8DmvNf1c3Ev9GMN2H9wvf2UEpir3QUY5tM/MWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773359565; c=relaxed/simple;
	bh=wOUC16WI4/reo5GvoZO5ESmt8rfD7PE3++Xf9novjKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1WgIEmat5BPtPGCn51/FV/Cmh3gDbARRTX7Zlo2oAef71al0EuRdFxygozDmfYPHApE694x4rm2RVoyUuK8tZxQlk+8ObUGEUinMBPjIJzjcUdjv5fKaWlD92Haq2mhGakLBCqP6CqhO9glSAZUQHfsMpcdiOxUGjHVkTurFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DkxNoTa/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DkxNoTa/"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-662fc12ac5bso3135206a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1773359562; x=1773964362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=DkxNoTa/DqlGFNo7YE6l+GJH9cBdIz6p2fwd2frrDRmaXYORRUcS+LuxLc4OLpsQQA
         AGwFtAOwj3SxMyv8O6w5XJmP9qJqqCe+cW4dI65Y79Eop+3rEasXVE25PFrPq6zhB8JJ
         WIRGA5R3pdGTG3FtjpVKL4jTcm1wB/BpqcrSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773359562; x=1773964362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkgvHL0resGmXTqRBi16uC1NxLEncxIx9i+VLjGIXAo=;
        b=FxxemMypB0sx3P5PupBqtNL5v0APOxWvr2zKujwA+MUsbqDx+jLOr8xLCRIEa8uG+h
         nmg85BBbweWUPEMqwscCRC7lWtOuKpCelfwLgLKNyVJYGdgBcoEXyDfvPg+CSNMaMKPy
         ra7hwi7zBjezL2/iLovPaHq/r7zxdJ0lUuUn87+oy9goPjdbVWqlcFgKdRknanA1skim
         thhpCfD9nX9C5/zD6KuWGROXT4ojRKYWDje0SO59Lgc+VS6ZtGcqaYaX29v7SCaqOl7+
         WGiwj9pl0o7Ud1riYGJX/az1jK0bv+TxnQEov3x+5PKKuyBQwUyW0SlOSsVjD6LzZL+L
         o7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWrVRw4kV3+0yuPubPDTPaOyNgZ31ToQyT4iaPN1dQ5VfqVXAs5yGxwP66KfXCpjHz0lbR1Wu8N/5bpwx+D@vger.kernel.org
X-Gm-Message-State: AOJu0YxdCg2iqOqn/d01dv/fLaB1E7og+uQUg5A05/cWqRdhseQsh9S8
	o9UXS5qqtPUu5R6qBVjN3/G507yCm4wpzhr4CyUSwapPc0fC3+PZwqGQgXo6K2WAyjGvf5kt0J5
	IDRo4QXg=
X-Gm-Gg: ATEYQzzIUnZj6E4XopdW8N4bfNofXMLnFwayiWcBkuIXSsS0ZHCa+PNEkI/T9UjUmNj
	r4xXooShAlbKUCvmUDeqPy3P5CS91RUbdBZtDOwtHYTTotNQb0xfJ4h9qS2bMRJc9JH6cLrXv34
	UAO1k04qjsV9Xp8A6SXRq3rWvmwKfIo06KfLgyNLhHC1A5YM+4M2rkYpweGzfp2tC0hVoQZBrBq
	Cde+uhEEMC6SirE7yqjRi+xRF/BVx+A+sSO/xxK21Ap6sCUzQHDYvihWkyzl8ZeGEH1X82G6m0Z
	vhRKuxsb9sHvbp7sT+SLj/6c6L+Gf4JKkzH1jEoapk/XmX4IGx5roXgJGhr2LT27o+Pv6QNQQ1w
	p4T3FYcZo7/3YL39YMmI6iu6PsMQxuOxi4xvcn5xKzeGEb66vkpWbFwq3BDeVozQaoFO+RayPc7
	8Jwc97lB1IxWvEjXUZZxd4nWm3ODsDz2NjLItW+B1f96dtJrXtef1TMo7hNP6Dj8oANLq9SR6K
X-Received: by 2002:a05:6402:3585:b0:663:a7fd:f560 with SMTP id 4fb4d7f45d1cf-663bac002d0mr724169a12.18.1773359562458;
        Thu, 12 Mar 2026 16:52:42 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66350d80a90sm931807a12.32.2026.03.12.16.52.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 16:52:42 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6611f41eebcso2127539a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 16:52:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU9wn6rxBRKkm4wBoaAQ2qGPvdKOjJ0W7NHPdTsTikoNGLeYUA4Kkq4J/NNumFByYDE9jwDD2C8xFVHf10s@vger.kernel.org
X-Received: by 2002:a17:907:c5c9:b0:b96:d802:8b41 with SMTP id
 a640c23a62f3a-b9764fd8722mr66207066b.15.1773359215961; Thu, 12 Mar 2026
 16:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312214330.3885211-1-neilb@ownmail.net>
In-Reply-To: <20260312214330.3885211-1-neilb@ownmail.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Mar 2026 16:46:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
X-Gm-Features: AaiRm503fTaccEgKNbxF9h_dDHM9fUsSr52XJuxzTwCI0G9L03uDq8g5di1zchk
Message-ID: <CAHk-=wh92deXvH5iXCo9mThXCBYt-jRcVu=z4kiH-f3+wZQOHA@mail.gmail.com>
Subject: Re: [PATCH RFC 00/53] lift lookup out of exclive lock for dir ops
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Carlos Maiolino <cem@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, Tyler Hicks <code@tyhicks.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, coda@cs.cmu.edu, linux-mm@kvack.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	ecryptfs@vger.kernel.org, gfs2@lists.linux.dev, linux-um@lists.infradead.org, 
	linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Mar 2026 at 14:44, NeilBrown <neilb@ownmail.net> wrote:
>
> This patch set progresses my effort to improve concurrency of
> directory operations and specifically to allow concurrent updates
> in a given directory.

I only got about half the patches, but the ones I did get didn't raise
my hackles.

HOWEVER.

This is very much a "absolutely requires ACKs from Al" series. Al?

Also, because I only got about half the patches, and there's 53 of
them total, I'd really like to see a git branch for something like
this. It makes it easier to review for me, and I suspect it makes it
easier for some of the test robots too.

But again - this needs Al to look at it. Iirc he had some fundamental
concern with the last version - hopefully now fixed, but ...

                 Linus
