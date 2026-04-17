Received: from mx.fmap.me (fmap.me [51.75.121.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0932E728
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.121.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407419; cv=none; b=hX12oZP4/SMTsWW0ecMwcQbeSWDvsq2UhFQNpEPoSQJLeOlf0VQaFi+vazML1ZAioSkBsYqtO4Mw19Cm+WybNpErENZUnJFyyhpAo3wZTz85RO4pImBajizCgkvYS59GlXGEEDa0MQqAceizupWt8wwlTYNGDfmhgCpzWpk0ocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407419; c=relaxed/simple;
	bh=V2ZHi+mhd3PItDS7aJN3IS493L2b1OwFVjkd8QcLsh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mwQgX1JdEEvpXufFNcX+xxGWD90VYxWD0OYYy/aM4it68hTmrtr3Mo3zX2ZcmSexTMOo9ETJlua5HTEkPWf53kB5q4PlD7Itkh1P38Sej8ohL6zWpkpv4EZGwI4qOxXXQbRo1QXZ3vCvyXJ+1Dx/eEc85UUzKPAQd2AVmWYajQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me; spf=pass smtp.mailfrom=fmap.me; dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b=qzPQT5EA; arc=none smtp.client-ip=51.75.121.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmap.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b="qzPQT5EA"
Message-ID: <2f9c9c9b-caeb-4146-9186-08640a7be801@fmap.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
	t=1776407414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hv18bmGq9S32+wkiVB19KjJBEl5t1ng6XjxY+QQUO80=;
	b=qzPQT5EAysUKS3UlDhW3ny0doH8oOl+mjNq6Ic8el2JEwxK5b2Wbd0hEyzsHvgz+YIyuWO
	hUzfnBGuy4WwVm1HCP/FIyNfEkeQ/qly4VQSKqMp7jgYrMWCxvZhr6xOlbaQkMXewZcavd
	QnF/qnbH3/5TprCVubWZqpju0GMF0pA=
Date: Fri, 17 Apr 2026 13:30:10 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: fuse-devel@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
 <aeFuarTL7xBbut0F@casper.infradead.org>
 <800fa535-da92-41c0-bea9-40ee27639502@fmap.me>
Content-Language: en-US
From: Nikolay Amiantov <ab@fmap.me>
In-Reply-To: <800fa535-da92-41c0-bea9-40ee27639502@fmap.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Re-sending this to the lists which rejected the previous message since I 
failed to configure the email client to always use plain text.

On 4/17/26 13:24, Nikolay Amiantov via fuse-devel wrote:
> On 4/17/26 06:19, Matthew Wilcox wrote:
>> Yes, at this point, you've left the folio in an error state.  I'm sure you
>> didn't mean to do that, but the VFS interprets unlocked && !uptodate as
>> "an error happened" (there is a minor exception to this involving failed
>> readahead, but let's set that aside).
>
> Thanks, I see!
>
> To save my reasoning somewhere: another way to do this would be 
> NFS/CIFS-style, in a lazy way. They set a flag in `getattr` and 
> invalidate later in `read()` instead. This could avoid relocking the 
> spinlock; I still opted for invalidating inside `getattr` though since 
> FUSE already has invalidation later in the same call, and the cost of 
> relocking feels low to me in this case.
>
> Any ideas on how to resolve the remaining race condition [1]? If I'm 
> correct it affects any network FS, and can't be fixed without changing 
> the common VFS code somehow. I'd like someone to confirm my 
> conclusions though.
>
> I'm way over my head here though willing to learn; if someone is 
> willing to mentor me on designing the fix, I'd be happy to. My best 
> uneducated guess is to introduce another flag for a page and check it 
> *after* we get the inode size in `filemap_read()`; if it's set, retry 
> reading.
>
> 1: https://github.com/abbradar/nfs_stale_cache_test
>
