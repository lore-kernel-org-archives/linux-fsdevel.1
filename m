Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968E63D3D18
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653061; cv=none; b=XX3ph8UYMzEBdF26F6dTMxfTxyS8eUg+TprShLMAlcEi7/ivvu3mOAT1XnvYj7V/WyPazAu9i8O8XdzMAcccf7RaHtQ1Eb8c7/1CEH9UCNA39UT/XEatFfNtMI5YshUwOKqiISY1NK4zOrCYX1JeFzI2cdF2udn3PuKfwBx/bTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653061; c=relaxed/simple;
	bh=Eu3wfuEQrxBBkGKCkeAzZasx5ExuiXoVmmjPgYkiKnE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWiyOYCvomr2mUL24wL9BtWJW3WprZMMraLVKU0yOBBZE0HGVtbxf7Jlgi+LWyYocwxysvh5SUTUBC05EyqThEdOrW+lZgxNQvuCQI63Tv8hjFFLXGP9JC5Lg0iZjJofVkLjQE76ofOLkh5WF0Uf8MY12xlxgBfR1oZtUgVZtE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW47JDlk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW47JDlk"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa5e9a64b4so1890748e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780653059; x=1781257859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xjcf+ZeYGf95GdPFKMkbVvi+CX0UN2Mwhbe9F7S/JCk=;
        b=eW47JDlkG9AyVc+yVGis+R03w+8ToWfDDo4Y3viCp57B3kR5wbz/FAqd47r4pYFSOm
         FkRIMiTET+hwmWxpKsFkhnrafbjsavxC2M0FzEaXg835X22wv9ZLa4QkUuqymYu4Ynaq
         8FkbMu3QVv/Fd70C0BDUvwGZRDz7ZT2lzCOFjoZlgISZM4oKJPZzqpBAS4ySo6D4fL3A
         uTv071a7XkMBuJViLY3t3Z9lGSFGUfs5ijatPPH8V36SOWbRCQaIaB/SNBIWePTCrX/V
         qbxnHIbjcApzVvHgh0B6WI7h5dc1xUH/mh/dz9blSkfPG/zCpE9t73QUCYijukbosPXu
         fQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780653059; x=1781257859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjcf+ZeYGf95GdPFKMkbVvi+CX0UN2Mwhbe9F7S/JCk=;
        b=tRC0U2eAHxM4SxDncTb6XzdYICOXOMJc7UD+Q1FuGj2s9SykmI38TRUqKet2tQj492
         0/UZV4nPh9crscCTHT13NxUm8a4tuJPVBFDiKiEw89Hps70bURqALUjIve2DIzeU0IJl
         fmkcDT2F1neR7gAXT+UwdG4Nkyfg21tDSDrJNyIaRs2GTIjLe4AiE27OxJTToaXOWjhK
         BBkAlA8Uisua5avdJLRBcjQ9f8VORT9l3cY2CAMZxPiJBA/5ZBVj5GIBqFbjx/JBY8Et
         cRQ7HhgWnlRLJZVf6skXRWKLFUL+cLP4+Hgdmk52BzJ+4tU36Zkm/fcXpQxpiK1rY8ft
         FlLg==
X-Forwarded-Encrypted: i=1; AFNElJ/+gZfwDkCX1Mlk9nREtqKodepBHej1m0Y3hRbu6AEMw1QizLoT3VzPZ3LceGz21zFOba7Xm2SfFMQXu0Zv@vger.kernel.org
X-Gm-Message-State: AOJu0YxJuF0kJ6GWOMyldZBopEj7Xtl4EN9TjVT6S6hVp4wdx91znMhj
	kgAncV8EM7Q6iBQLZ3M8EVWwFgxI4rPjNQe7jP4qOZIUYqQXBMlPD3F4
X-Gm-Gg: Acq92OG2ARI5fAsu4IBlrOXCmekJwPRYx6+KE37vDQomKtsz+LAPUkz+hCW5vDDMlYt
	LiKs951aSNimjFTM2Da4eSAsGiZU2hJLKU6FVvfn8YgVmEjHkW2oQW/6jS+48QjqpnYeOMjXuE9
	106K7g7Il5a2h19BjiwZM+zqjZFs/lXM5zPHqWeYwz1T/4wjEnJr1q9Rgf6RNXa/+NOWjoCp5tI
	+7r9grRvTJ22SyDSxrW+MIldKsIQhLBl2+mxXNu0qHj4pcEnRXosllBjInEzdT1HISza2NuWLIb
	vcPrTpn3XhxUYpA7G9MPtvtJBC/bd0qkLwXNOQRXyqpz622YtIXipFDJc0nlid2LqLMwUbgOExi
	1Iy9UZTUeOVwQn5+pyBA2LBYzuk9EvO82QVExKKB0LWusmAxB9ATyOJiPAMPh1IVRot2y/cXK9F
	YlscmAefaR5SDmtAcff7U=
X-Received: by 2002:ac2:4e0e:0:b0:5a8:6cbc:60f3 with SMTP id 2adb3069b0e04-5aa87c03398mr899588e87.34.1780653058812;
        Fri, 05 Jun 2026 02:50:58 -0700 (PDT)
Received: from pc636 ([2001:9b1:d5a0:a500:de96:9acf:5dca:ede4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97a71fsm1761298e87.46.2026.06.05.02.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:50:58 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 5 Jun 2026 11:50:56 +0200
To: David Laight <david.laight.linux@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, Mike Rapoport <rppt@kernel.org>,
	Jan Kara <jack@suse.com>, Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Dave Kleikamp <shaggy@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>, Kees Cook <kees@kernel.org>,
	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, linux-nilfs@vger.kernel.org,
	linux-nfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/17] jbd2: replace __get_free_pages() with kmalloc()
Message-ID: <aiKcAIbzz3z9vN9a@pc636>
References: <20260523-b4-fs-v1-0-275e36a83f0e@kernel.org>
 <20260523-b4-fs-v1-10-275e36a83f0e@kernel.org>
 <yfzx3jgzwesernofl7mzixa2mhjfii5v3o7yapghtmozixrpfu@6bsh7iixyiov>
 <aiEX4UTxEnBTjVKo@kernel.org>
 <ximvn6jwgtam665a4droqkp73o55kwvd5uukyidwjesmysobth@oe7rigpsjfkz>
 <20260605093332.7b067876@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605093332.7b067876@pumpkin>

On Fri, Jun 05, 2026 at 09:33:32AM +0100, David Laight wrote:
> On Thu, 4 Jun 2026 10:05:52 -0400
> "Theodore Tso" <tytso@mit.edu> wrote:
> 
> ...
> > I suppose we could do it with kmalloc() with some flags which to
> > prevent forced reclaim / compaction, and if that fails, then fall back
> > to vmalloc().  Is there a better way?
> 
> There is already kvalloc().
> I'm not sure how hard that tries to get kmalloc() to succeed.
> 
I assume you mean kvmalloc()? kvalloc() is something unknown to me.

--
Uladzislau Rezki
