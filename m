Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61F439354
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525073; cv=pass; b=o8ftyQRF8bLMA+6SWAPk8lWq/fINuRjaxcjELwEd01hhGG/6cpUNw1ZSJDeT7Vk5W3pAl96XU4MVV1o/ALjGGodcWkvDKd/KUw8Z0jghEq3kix0k0zST5KZGZdZtWICrFsRMR36YXqHhC53he5zqdQbr8RkzsEof8ihBNBp9elo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525073; c=relaxed/simple;
	bh=WEa0OR9IElvwaCWw2siqSbeNFwXC1Rtf30r1klHV9/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMYZYVdRI5fqv/Tx6jhNEcRpgQj3JYnDtpOrGrx/K8WZB8OGGqMHJJ1gMefYkyrv5n1BLakZlsAOoGzzbGXO4IGEE94i9i9xpNydGDLbQ/AYKOXBR5JJnE4bnyJNtB5w8cBQO+y6K0RbqMXXYzj+m+hjhZS1EgPsCDQewhJdc6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CfxeooCZ; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CfxeooCZ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfe810293so4010091cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 08:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525071; cv=none;
        d=google.com; s=arc-20260327;
        b=HnODiHV1SUugqZM6gNnWZXPrvQxxuFR3f+vfyK5epuYSRkC0nW9UJ6ZQgu4FwR69Qa
         2XCQNbZ/NAbxbVOoWU6hH7VrcI2dWLaID1mTcfpEVgIPtxjYGtvkuhWfUswhgD76BAnw
         ZseidqAXIHwtYA7WEF6TqxCXfJVADSFhYTEMOdAvNLXpn4Arc97N9dKTbTHmxJGYmqpA
         RPjH3L+YTfnEkeGTofwI83Z8wgH8eiVy7TfTTaIq7FIJXblsPJaASf4UPHVZzATznUWr
         nbuq6b1h1cBD2Lm8z8xSfK72xrH5ghj+jtrqcF/Ol0FQEDR6kOPcChtHuLSP91ajUkAu
         R+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qkeAjSrfipPZ3gYTMXBLe77/aSlGkx1MoDJPCEzD0Ok=;
        fh=lc4O4hpj33VYMIWk8hx/1AFpCTicqRCNiePSvvWaDNM=;
        b=PV1DqwdUFUW9JRg/m5NvKNMZV365OLdQ7Y827le6Q1TFHmylR51Fabar0h6QImoHEN
         MWEGdxif/oMIBVJL0qOfWQ/LwfaTufG9iaVlIxUhraFRuJPTQ6+AP9vlw43Czt8tg6A7
         bQabJQqFTHvC1546/wakprIYA/Se3+l+712KSmHsEM94iXfu2TwC/53xIgM45eP17stU
         uJmEdLthvgihvfUp0l/xXXAIaQprnXnOr/zLFHor/wH9FAmLebdTtvhrTDDIgRGF/lIm
         pZWXQq20yJAO+QAKAcWXFkFCfUZrhJ3f0rBVqke4D4ZYWmF+CSlK6zmLxgz6Wpd/IZBf
         oQTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783525071; x=1784129871; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qkeAjSrfipPZ3gYTMXBLe77/aSlGkx1MoDJPCEzD0Ok=;
        b=CfxeooCZqaSrdwi28QEVCapXEmZ+UNJ9JNHRzdjYh9wEyoLuNv8bVSqQKlXPuf4bs6
         E2Mczkycu1BZMmfcskfPLiv/3x1KoTLz9ENujsVPqj9ANro42Ffa1s+71ilozzYwtrAi
         JwbKK5HtKlBOjxiIBgiMqzuhA9ilvgig/Lo4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525071; x=1784129871;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qkeAjSrfipPZ3gYTMXBLe77/aSlGkx1MoDJPCEzD0Ok=;
        b=stwfa+ZnmjNywM7MY8rgLNA/qBJd/mFqRsAELhhQLtcbSBpqqStv9aeE2ofXBXBR5p
         zQBE9lyx/e0iZaBLQNPgDc4ugSHjv/RsyWYomKwNzSSo7TkuXFl27ynbtz5VQYhZ8Hej
         9XOZ4mCWnHOUpwFB0K2sXCzWqI5yk38RDiBz4RQBvR0rxqovPEo2FerchtPits6O7ZKq
         exvAlqoOY8gByt1Jsy3vQn0n/c53ZjfoIT7K4DUAKdUnCAwRY5kdh1h6wLWAxHa9qxQ/
         KHjBYzNkHaBseuHC/FPEiUcMM5YZxBmryoss9FvlETiKfM5T6etvMajhsohu2nsCstue
         YLwg==
X-Forwarded-Encrypted: i=1; AHgh+Rpy0bN/BTS2L2JstA+FMzqpWjw/UQLnWw2I8kmzdMgC8y2MVeDlO5U6w4aekcuUYT6V8aHmeKG/A1XqQ8gZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyncRuhNacz3rBQ4stcKxkT9LmNiyDQ2p19dhD73ymQgut5kMPz
	yaIYJAt3yCX+3sgp2uvJzke2BbYdvi5+KLkohcbZjxSVBjCjJhomV6zJqgmeMT7quHuSIMOs570
	2RgRDRQ0DuDdk+ndaXTDInWUPCQG6QyQML3V1tRIFAA==
X-Gm-Gg: AfdE7cmqGV+ySnnBhZS/8q3SIp3HF4AXieW1mbnKg59fYP5IGazdZI8mrzaJ1J0d7Tc
	lSJo+7R7R++E6JPsTL1OziiL//1K7ULPVXaVDnFDgfrobJaNv8faEOzWHKdAO3iM1fmxihz/4ef
	xuGBt5btyUnGUp7mP0OjDHp7lnEAkpZruepBGu3WInmLo+63IO5018WpM1VG2RlN0OLIpnSJ9Ol
	IXWXmpg4AE3xUIGL2pprBLsRi/sJPH9Jb5GHxQXlli790qLiN4W4CYiRKZpWoWI0CtVBValKJ9D
	bgepEjjoGYQldDwS7GtV5x0zePtNAcTcS0BtOA==
X-Received: by 2002:a05:622a:410d:b0:51b:ff78:f221 with SMTP id
 d75a77b69052e-51c8b2f174dmr33523261cf.29.1783525071383; Wed, 08 Jul 2026
 08:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com>
In-Reply-To: <87wlv57dt1.fsf@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 8 Jul 2026 17:37:40 +0200
X-Gm-Features: AVVi8CfqzC9eOvDm8nHA-5UYAS5HPZI131ACQtCWE5J--FkjXHyF6qlMxysQysU
Message-ID: <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> wrote:

> Amir suggested to add that functionality when I've asked for some
> feedback before sending the patch here.  I am fine to drop it if this is
> the consensus although I see its utility from user space.

How about a completely different interface:

int get_fd_opt(const char *name, unsigned int index, unsigned int flags);

Enumerating layers would be as easy as passing an index stating from
zero and stopping when -ERANGE is received.

It would work for all filesystems that use files as options.  No more
fs specific ioctls.

Thanks,
Miklos
