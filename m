Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A7533D6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 00:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952371; cv=none; b=Q4YPVC0/4I9Y6AzSjIsER9BaIQAd6O+srAJB3fXPAqp7Fp366o+7rnZk/A2RTCVSRTQIFnk2b1cT0eIL3mZekxbzwKr2gxdsmCp7ukaaIV0+KT9x3tc21rut6KDOaY3VdaDQq98v8Hx/BhP+KYwGaDH3kgA9T/5IAEsHazW0v8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952371; c=relaxed/simple;
	bh=ZBTgJRyElLAV59IGOck7+OH6JWbiBqiaTdW/BhDr0d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCf4QfF2mDtfmP4MaGpQPjSU1G5LBhytMMRBhG4DcnpD9nq+5FNXBZKDc+Om/VYyBhdkJoeI18ZGJONfgOVq6lrv+/LjsaC3JE57gql3G5zLeEoiTBfeKJ7UdSGgyQ9CQeRkm+clF1Fy/aRWmd6BLsSvKAPFNNAxsF49HOpoKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=h1OAPnv5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="h1OAPnv5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-845ea8924a2so785529b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 17:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1782952370; x=1783557170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=plRvvCAVCrtrhVtrKnejJX+wc0oLNwNwI+sUKQl+JQk=;
        b=h1OAPnv5+SVOwqZlquwgXVQDeshQDv2zfkJxmERm9agFMyXgzj79QUTvKrZ9w1EMNx
         KtDMNnIPquaagubDieUYiihQ79BHJNoPIrCZf89Su1ILznulLJX9rArCILHrK0wwZurh
         j7BHs+YaNRFHrcMPMD8sGyC8xae0xMZzHozDUzfJnfs0b2f818lmV4z59x+dzWHAqXpV
         ZcgJTWrP5LDqfbVxZqNm0qT9u02J10AhCZowFCk3Reqd7IstZhaDdFPXghTQQVgtj792
         vFVcLjkWL/izemgZV2tGEkNn2qMV2XsTCEXHxzlDowYLeTHYgQl06vXmysvzw+UUiSxU
         aaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782952370; x=1783557170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plRvvCAVCrtrhVtrKnejJX+wc0oLNwNwI+sUKQl+JQk=;
        b=H05j5WVUWk8Y1sLOXKiN4omUdzPOEo4bsR5fxGIwAlv8O/3O8dZIkMe5E85Nbk79/N
         +dpnfIbU6CjYkv82thXEIbXkLHcfmS4BWQ0jJJgjhNeSnsjbRt+n2EKyD1f5pfBB8zPY
         OQF348QoJZ4hsFZktweUpzHmGDAFnzS2ACrOX/fh89XOvruHgBk2q0CETF8Uhuxioa4W
         25DcqWzIqFnW5+GM8h+lFBixqRyAVs52flHzKcoUSb9UKR3xRenTGfPX71XM3pggBjic
         Wal68H+IjpI8+dZZxEy/jnNs4jdjfxdeixBFv2JzOm6CrJGPjrHLIhC/8ln8wHVlHG77
         Op6w==
X-Forwarded-Encrypted: i=1; AFNElJ9Hg7q6UUTD1CMfDNvCVyPRFnl/dnU1j6CY2bAt6jzdJ8SrBaQ7LkKNAsHpZs0W9vie2K85vxYi8qrp68cd@vger.kernel.org
X-Gm-Message-State: AOJu0YyIUTkjo9sIk8+d+P+GccQ2NDWF6Nbt5CIziaQ87ziHV7MZdRbE
	p78mHJCSXksRGv4W4nSMxo9r/1cIDyUClLVSnMsTrKat/QAaxMmFjBN22xSjNS819z8=
X-Gm-Gg: AfdE7clOyUhKHuVOjKXdUf0WzQZaia+PKt+P29oMrgj53exCrVJhmgsEBtIi2aW4DRi
	B2+5f9mwTUwYCtddvMs7EfCNig7ubRP+NBbYSSb3AsublQLq4QPPC5dVbltrVQxKIJtQarQNJzF
	DY+OAOELEz6OHPuRp96HViAKQy9Y71UMUSgzdeJs3pRvUHfstvAS6EnWwyMKok5UaVhYsmepX5K
	dOi/EbXkbHxtlGZ6PQAcbx4Tk2YjQ+6E5P5npE7dpVzyavyTWaXVLZSlQKoIy67NWUC0vvRMeX/
	jm+tF8siy5h2nbTDVhRNjN60EOiqoGpjyO5lYlKVYK3hoqfRUBGLpdcS4csoI1NyAq9u/ITQMRw
	O24GvuxslJEz2dgY6+Wf37c9wKD3oLEKNHa93Rkwu7UOokYv9EzIcu82MHVFNQuC+cWpYWVJoGa
	d5vE2GhqbN5lCJ9niCTcutotndhS5xOuogcX7b0/l7nF0=
X-Received: by 2002:a05:6a21:50c:b0:3bf:d1f9:b1df with SMTP id adf61e73a8af0-3bfed4c4cfbmr4014145637.54.1782952369783;
        Wed, 01 Jul 2026 17:32:49 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bbdc4eesm2793830eec.24.2026.07.01.17.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:32:48 -0700 (PDT)
Date: Wed, 1 Jul 2026 17:32:46 -0700
From: Cong Wang <cwang@multikernel.io>
To: John Ericson <mail@johnericson.me>
Cc: Li Chen <me@linux.beauty>, Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, network dev <netdev@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC] connectat()/bindat() or an alternative design
Message-ID: <akWxrjOl4Up02Bvq@pop-os.localdomain>
References: <b1af80fc-a57c-408d-bdfe-fa6bae26eaca@app.fastmail.com>
 <aicbyQIC2qEveNd-@pop-os.localdomain>
 <455281ec-3ee1-4f27-989b-c239f0690d8b@app.fastmail.com>
 <aixU_RccxS_BKhgX@pop-os.localdomain>
 <66eb8227-85b6-4684-a4fa-e3e17ac2fa45@app.fastmail.com>
 <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e396ce86-ec84-4189-9da2-98af7cfa6c41@app.fastmail.com>

On Tue, Jun 30, 2026 at 04:22:25PM -0400, John Ericson wrote:
> I'm bumping this and adding new recipients again in light of the
> discussion happening elsewhere in
> <https://lore.kernel.org/all/a49ce818-f38d-41b0-bbf7-80b8aad998b1@app.fastmail.com/>.
> I don't want to count my chickens before they are hatched, but it is
> looking to me like a consensus in that thread is building around the
> ability to opt into intentionally empty/unusable root and working
> directories (at least with nullfs, maybe but less likely with other
> mechanisms instead).
> 
> That new functionality concretizes the motivation for what I am
> proposing in this thread: in such a world, there is little to no point
> binding listening sockets in the file system, because the containing
> directory would have to be conveyed by file descriptor anyways --- might
> as well just directly convey the socket to connect to by file
> descriptor. Likewise, abstract sockets are not appealing, because the
> abstract socket namespace is either too coarse-grained (leaking info in
> the same way root/cwd would), or too cumbersome to keep it from leaking.
> 
> To recap (with some slight changes, like renames), my latest proposal (a
> new version, not either of the two variations in the original email) is
> new syscalls `bind_unix_anon` and `connectat`, supporting a workflow
> like this:
> 
>     /* server */
>     int lfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>     int addrfd = bind_unix_anon(
>             lfd,
>             /*flags, for the future*/0);
>     listen(lfd, 64);
> 
>     /* client, handed `addrfd` */
>     int cfd = socket(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0);
>     connectat(addrfd, cfd, AT_EMPTY_PATH);
> 
> Or, more radically, `bind_unix_anon` and `connectat` could let one skip
> the initial `socket` calls by returning those new sockets directly:

Hm? Why not just setsockopt()? Something like:

struct unix_lookup_ctx {
    int dirfd;
    __u64 resolve_flags;   /* RESOLVE_BENEATH, RESOLVE_NO_SYMLINKS, etc. */
    __u64 op_flags;        /* maybe future */
};

setsockopt(fd, SOL_UNIX, UNIX_NEXT_LOOKUP,
           &ctx, sizeof(ctx));

bind(fd, (struct sockaddr *)&addr, addrlen);
/* or connect(fd, ...) */


Zero new syscall is needed.

Regards,
Cong
