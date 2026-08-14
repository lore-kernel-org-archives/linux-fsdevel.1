Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E82110E
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 12:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711355; cv=none; b=jPHHxhsgyi291h5yvIfk8xjz6pI9kkJiYKJCJJQ574k6zjL9OXrQtRTWqv389cj1swTVR+6meK7MOKhTr1C1gKXnWKcexi8vlyPaSK6873c27J5zs9EhWK2c4dgoAj0fC7TPbRbZy/5e63/ZNiWePee/Q/uCsHcTlfJqVFuZkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711355; c=relaxed/simple;
	bh=nhSR11Sm3nS77wkMHFQnWWfOnpgqw8EVsq2wPBuc17w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAk9TVs17Q3dF6G/kRcHmXXBoJLgi9jkPoD+UxwSY6RC2j5UElsmoyvUuu/ba4mCvytILyXHP4Kfv4GiqPiHxroWi/qSsUZstbgskmtUJKW0/xw6m0AXEZwpQSh2rYoNT17Qmt/oJDjbwMloD5nDAW6l73MU/LRONpOssiRwgZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUVgEusJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUVgEusJ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cacf197759so15015285ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786711351; x=1787316151; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1xE0YTQHVZ9zp3EgVOxgxpvZ7rS85ifpjNXTOUloYGM=;
        b=jUVgEusJcnbpRg1d/dNnG1vW9ye06iZilTLhkeOsFpDovepjMAvycW3Dk1dlSecy2x
         B3E4a8aQNiaPa+otR6dBYH0gfnHoU2CYMXfNkv5omffXX2UuF9ogr7ka39JHa60ajF5i
         JkU9L1znSOL0Gw0J3g3MRN1gCuRbSPpbJlWGAvfIupiG6x5EUf8DKpmSAixt/rL6HcwE
         RVFtErxkegmqowu4McPZuaRjO3FhcSsMrOtgdXcBSkWfuP4uFaIKbr6eo0JMZWA9lKfZ
         kKVuEA0X2jUVN7/9N1sn8Bi04LT6eDjMTb5VT1FDAbPKFR6yQ0gn5zR8AGKRI3BSDANP
         VKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786711351; x=1787316151;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1xE0YTQHVZ9zp3EgVOxgxpvZ7rS85ifpjNXTOUloYGM=;
        b=S/PhsoNWUm8TGJ9vwJ0CCS0woSvKltSkJySKEjTWm2nmIKF+6mtT1A6qsEvQ9hmeRE
         VVGDWnRQAsXQTfkyNGdYRAgwIZFkQ2fzc5Z9abICAlWS3qRICVIdfPsyNePbIZdQepDL
         opcThCCQ+NwCsBEruTh4lMyF5LIPO3eEbUrKcvXIh/ehPtTgyUx0zQWfIdCJvgtG2kf2
         3arGq2wmTLuUGA09/3lbdSyW0lRjoQrov2O/lblcscRPNjbQ8rX2oVA0LnU2qg77CyUU
         xOfjZWxoBACOU0ovwQMRpzoIujobR2tzc67hquj2I4TI0KGvQZEb1qarVx+7Fd3Y0m7w
         oWSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmNEW/dR3uf9tacsfvAGs5AxoVr7c6KtNb38UIJoqh7Zfg4Cawb5XP6CeJBivjxsISJOGW0ceW9FVcccZq@vger.kernel.org
X-Gm-Message-State: AOJu0YxhMDdMC0ppwPIPN1RWEnDfmHmG8StB+E1Phn6IUEA4nn0nB1ob
	hDPJYDePdzcR6VxEMfibGaad305XFu+F1QjPCkvEHGcPMhNqze1m9OdQ
X-Gm-Gg: AR+sD105ax28OSkNQhE4kO+SkrbaywSiXKxvCYAUcbG7U2Lto7KhUkUQm78E3ccNYo4
	RlLccnVrnZ37V+ZsY6OiR1NFC3tPj2Sx8cB+cXpcqXqpKrU3J8q0Bg1xYCvo6CThkLTsq3JaPDX
	YLNPHOtQMVocZEqSdS+ZmYIgHpw650EcwBQ7x7SrUW0Pj07MN8v2Agsi6TSuSq2by4/ltK0MDBr
	tQgok4KUXl7/I2GSO0qvFd0rtc65/XvJRCaUe+jHbAw4NaitaLbmVXO9PBEbxBL9MX6IA95y/lk
	kNvDp5q5fUXjqAmOH8x+un24iYbgsdLojq7LMRC+BH7c/UzCKZTBESub7oi4a8oF0XL+EYeA94B
	w+9cBITX9tQx5/M5qyBglMDqC94QBluOMAlAc1osoC5oYIEIUNEeBMdruFfYMGB79GN1dEF47rB
	y0sptY8pPd/MF7JxBfo/TUTksY1MZ1yaNbhxXx3jY6NtW5rpIK++8FzM6sqpWnethD74fon5Yoj
	UbNqpdMzjW4IlZGICgIW1hIlWQdCsX2uBnz6ALd79NbluH+F8wGI4vCwHp8H9AVOFaGfStkjxj8
	+nDDMfpjlb8CjmUZkfYfnA==
X-Received: by 2002:a17:903:98b:b0:2d3:14c6:2372 with SMTP id d9443c01a7336-2d3b080bf23mr71252825ad.1.1786711350587;
        Fri, 14 Aug 2026 05:42:30 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb27e40sm9037135ad.41.2026.08.14.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 05:42:30 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:42:26 +0900
Message-ID: <m27blsrhzh.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org,
	geert@linux-m68k.org,
	daniel@thingy.jp,
	arnd@arndb.de,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to /dev/zero
In-Reply-To: <2026081355-remold-sterility-84f9@gregkh>
References: <20260813063401.1786548-1-thehajime@gmail.com>
	<20260813063401.1786548-4-thehajime@gmail.com>
	<2026081355-remold-sterility-84f9@gregkh>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Greg,

thank you for your time to look at this patch.

On Thu, 13 Aug 2026 21:19:47 +0900,
Greg Kroah-Hartman wrote:
> 
> On Thu, Aug 13, 2026 at 03:33:58PM +0900, Hajime Tazaki wrote:
> > Upon a private file mapping request to /dev/zero, it calls
> > kernel_read() in do_mmap_private(), getting a failure with the message
> > like: "kernel reads not supported for file /dev/zero", which is because
> > zero_fops defined in drivers/char/mem.c has both .read and .read_iter
> > definitions.
> 
> Do you actually use a no-mmu system?

yes, and wish to use in future.

I'm going to make a long story short;

nommu kernel is originally for embedded devices but I wish to use for
virtualization.

I gave a talk to explain this motivation below (which you also had a
keynote remotely).  I'm not make a summary for this talk in this
email, but am happy to explain again if needed.

https://www.netdevconf.info/0x1A/sessions/talk/improving-debuggability-of-nommu-code-with-uml.html
https://speakerdeck.com/thehajime/nommu-uml-netdev-0x1a/

> > Even fixing this issue, the map request to /dev/zero works fine without
> > errors but the allocated vma isn't marked with anonymous because
> > mmap_zero_prepare() isn't called under nommu platform, resulting
> > vma_desc_set_anonymous() isn't called either.
> > 
> > This commit fixes those issues by:
> > 1) use vfs_iter_read() instead to avoid failure at kernel_read()
> > 2) calls .mmap_prepare on private mapping in do_mmap() so that required
> >    preparations are done even in private mapping.
> > 
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Liam R. Howlett" <liam@infradead.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-mm@kvack.org (open list:PAGE CACHE)
> > Fixes: 4d03e3cc5982 ("fs: don't allow kernel reads and writes without iter ops")
> 
> Given the age of this issue, I don't think anyone uses no-mmu systems
> anymore :(

I tend to agree; nommu systems does have less users than others.
but I believe this doesn't mean there are no users.

I should also explain more, but I found this issue via a Sashiko
review, which pointed me as a different comment, but when I tried to
reproduce that case pointed by the review, which is about the use of
check `vma->vm_file` v.s., `vma_is_anonymous(vma)`, I found that
/dev/zero is not able to map on nommu kernel.

https://sashiko.dev/#/patchset/20260710054648.924005-1-thehajime%40gmail.com
https://sashiko.dev/#/message/m2cxwvti7z.wl-thehajime%40gmail.com

The alternate path of open()=>read() of /dev/zero works fine as it
doesn't use kernel_read().


I also understand what you feel from the age of this issue (almost 6
years old), and that is exactly why I start implementing test cases in
kselftest, which is currently not able to run (even build) for nommu
platforms.  This series also includes the extension to kselftest
([4,5,6/6] patches are for that).


> > -	if (!file) {
> > +	/* private and file mapping will be marked anonymous later (do_mmap_private()).
> > +	 * and /dev/zero is marked by them at .mmap_prepare,
> > +	 * which should be _before_ this point.
> > +	 */
> 
> Wrong coding style for the comment, which is very typical of
> LLM-generated stuff.  Always rewrite the output of these tools to
> actually be sane.

this is my fault.

As I mentioned in the Assisted-by tag, I indeed used an AI review
system (which is cubic.dev), but I wrote this comment by my hand.

Because I thought this part is not easy to follow and felt that I need
additional explanation rather than just showing diff.

since checkpatch.pl doesn't complain this, I didn't carefully look at
the style of this comment block.

I will update this (as well as bunch of comments from Sashiko).

thanks,
-- Hajime
