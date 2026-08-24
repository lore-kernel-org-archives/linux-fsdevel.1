Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DED742E435
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579395; cv=pass; b=jvYdz54i88tUxD5WD1oU9Re+7rg5+vZU9XcgNL/XbOUSLd+0V2dB7u/DjwJPENIROf3jNOXCl/LuLQ9wJVlp9ept99SJx6XnHmtsrGMcJ5PJMnJfXrg9qrZfWZznI/RivmNVk+EWBRLqhyvu7GJaXgC4YqoBuMZBlsGecsGq53M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579395; c=relaxed/simple;
	bh=Gdi0w031Cj+0ZM8jnslnu596yibLYY4OhKTpyU6L/3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBAudtPsquBjmlmrT2iyKWIXcC3FUaLzZRh5AtiGAHayt8/B6Arm+ufmgKlCfmKiXHmjprzy5OxQvENg27+5QtYf21uaIBfVinLfdBiDCk5xlAfDxcBe3LvUkZL7bBEJkW8FM93Y+8dWwZIMe9ZXrVG8GUpzEp5ORuSmPaFqKc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NDMoFzvQ; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NDMoFzvQ"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-52de50e77ffso26100711cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 06:49:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787579392; cv=none;
        d=google.com; s=arc-20260327;
        b=kjZIWKaQENwicAwHbZHbVuGaL7zu3VnAfxU3by4M8iwwJWT+5jxETcz/M4mUcT7kpD
         6OB4/uUILm7rGm8oL3rLnC6f2vWJ9luZtdA4Fx7F7bgqpm6Vobf3mBTt/HbQZfY13UUJ
         uytSzevqReZiSaZTsnAqNKuTXbWeLuaeBKgnYHhugY0LjxnQ2IUGt0ePO4yepQOIfTV0
         tY+cY+F7a89GIHPkmybdW+PkBJZdqNKD8yvtM7IsuLDCXMA3Nm7VhoVG2kqwt5LbVN6I
         fkrHgzEoLBU0mmqj2PllK82tIR6l0tbfFIVPilQwUU0qz0wDZp8JPV2fT4/R0WOgNJtv
         xKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UWqjXIcqtIZGoXJHhXghNNIDKwEBlEpB/YPKWMii0qs=;
        fh=CfTV/9PTEhWmTHwD2VKKTMyOhFNCmNYVRTe+1MNl9HM=;
        b=mKyk/Cd8g6gpap0+ZrbYDSJGyyDjZAMuVYqGHoHSL8nPNqv9DSCeP9cUauXj+6fcR5
         C68i4olVFK6OwVK2Avpbg1HRf12ld32RkD7nuXQjDenCsLmbFN02oP9w0eDwZMMJytP6
         VdbVuAtgNXOxdreDQXFvTA6TcWYxnjBTAcE5QPi/zFFFjEyErAg+bxIpRI1lRMeyP4pw
         ngHU/IUyFCfO71rP8smmdZZxJD4cr76CDjndkNIqnL6Ea/HIyOjCe57wo14nRNKvWt77
         Qe6I0sG5erk8x20RY7CWLkiEpqx5q55TT7n8UwFdQPiHl2iOl6nElHMj24YzOLDRMikX
         jF7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787579392; x=1788184192; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UWqjXIcqtIZGoXJHhXghNNIDKwEBlEpB/YPKWMii0qs=;
        b=NDMoFzvQZiYLhYfgLRj1Ktm3K7LltETOkninXMRKeKJsVGrX/f5yYwoKebcqW5zE+J
         Nuh6crj5oNcOPXEhNSWgsZDXUjnF55flY4e2grH5zeQSUf+xTlynxncJqIWBpEWpcJh3
         2iRMqM1j+sNOmGDXD8voA/XnGZe83Hp5BGNw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579392; x=1788184192;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UWqjXIcqtIZGoXJHhXghNNIDKwEBlEpB/YPKWMii0qs=;
        b=U9tkFQrXW2fs6kZc8yvcruoq57T6QvOu3sm67SreS51JAqDWnBt1Bqr2bK1BMYBIoL
         nP1j7uUJEKhgyfN+xa75SDMurlsm/o+J5eoVrloHTYuiMinETdwxNRIeKgaojUyceief
         EcNUnYRQC0eMbzBkWELjEGjXaEvbxEKNu05CF+zo+RSB6Gw94zz8pp2nVmk+IvmVSzhW
         JEReCB3t7+jA6s5Pew7fxrsohNHPx5bWgkQ2rJhSHokRZ+ct1fPfeVNb0ZBjui62lgRU
         FiLZhE6zv7BHjiuJGzfL7K2i8R10rzmAzM6Lx6lJXfe/awLxD6z7IyQX7lhXaIbdF8mz
         xVMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqqAPkXcXmKZ79mp15eQFNWNvsuAbyFkJsHOlts1BJgiTKdmVscjmbnYbnOBmaoJGLRqYuuDBjVV9t1CZG3@vger.kernel.org
X-Gm-Message-State: AFuF++lEFA6e47jSPHBcCh4ST6k2wHbVZ5yiLEPbzi6pqiMwvHIfoze0
	ifJJTe5jVac8NeN3dDrfZWbl996y/i0+qW0ZBJW2gd2Hsw1whfxaGPjTNdM9oiyijjq43fe9YwK
	leF54Md7JJRSdtqgdDEtdZ4ulajMRIXIrK77Lo2Jh3Q==
X-Gm-Gg: AR+sD12sNR9z43zQ8SAP6y+MApc211TDsRrmA32qOGrJXik1VAGzsvKaeXIeKYe7r4n
	sOnSydPQPuw5nAGwaATG7tF7dn2lmdvyTEimwV3YoBpVBizxeY7HxjDeWpd6tVdhunnedrX8ck/
	hsBYVxy+7thrRw5rk/3Gx9Nn6Hrc3JRHCnOI+sYwMQOSZH/6qXJgK1WWmQmu/2QXUpoijI8gZ7p
	/n5NY5Cih+2npsa91hl4aUUKKpZ90D80jQx6qy7xU4mlp5rJeC9aGHLa8bIZxH5wn6fc/YA+sdS
	7N1xtFhUBpnykh4UDsnK89qMzdEmrOKptg3eQsBuCBWT3B6rYfJ8QXkWaiZTO32lB3FtmdCjp1R
	jJ80=
X-Received: by 2002:a05:622a:8416:10b0:52e:1109:8f6d with SMTP id
 d75a77b69052e-52e1109944cmr94356391cf.42.1787579392384; Mon, 24 Aug 2026
 06:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org> <20260820193343.3852967-3-willy@infradead.org>
 <CAJfpegvP3i8ZJc2T=+f4rAhZ4E1QcT5+jC6mQPLxtB-yoK9Brw@mail.gmail.com> <aoxHOSC9kTPbKeNq@casper.infradead.org>
In-Reply-To: <aoxHOSC9kTPbKeNq@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 15:49:37 +0200
X-Gm-Features: AcwNN1WXkLYVG2Rn2OXRtnBdlHWAinn8Fn4WcEVqUKiB1DB-194nq79209afcM4
Message-ID: <CAJfpegv3Ak+qNLb=fTSCSz7-taQ3Ui-Hkmqgn4PaGPe=CR4cbQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: Use filemap_invalidate_pages()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 15:29, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 24, 2026 at 11:05:46AM +0200, Miklos Szeredi wrote:

> > Maybe add a variant that takes that lock?
>
> I don't understand what use that would be.  As soon as that function
> drops the lock, the pages could be reinstated.  If the caller needs the
> pages to not come back, it must need to hold the invalidate_lock across
> the whole operation.

invalidate_inode_pages2_range() together with launder_page guaranteed
that no dirty data remained in the cache after that call.   Yes, the
pages can be reinstated after that but those need faults and the
server can then serialize those against the invalidation.

I don't see that guarantee with the filemap_write_and_wait_range()
(with or without invalidate_lock actually) since the mapping can be
dirtied again without the filesystem's knowledge.

Am I missing something?

Thanks,
Miklos


>
> Before any filesystem people get funny ideas about closing the O_DIRECT
> race, you can't do that because you'll deadlock on doing I/O to the same
> file that you've mmaped.
