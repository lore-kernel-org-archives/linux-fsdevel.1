Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D32874FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787855718; cv=none; b=r0YF/Vzqb3943CcPFX3eqA5RkXxmSTHoy6kNKklz8j7ShktQS8HxzFZWsvZu5QXA/RDNAnnSppprro+xXZxsfOzvybM2TIZrdtBeLIIxuHaE9y74/8EPcWCb4CJ298528iAYhM1A4rHcUtF+YhxbB4+hDsSmNz3nrQ2AU9Hivt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787855718; c=relaxed/simple;
	bh=buqoy4ey1O0GS5uggVv2tGWIIAUPUFfsCe8wWDFBff4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B3QkCIBkS5M2XIsCEUOcBfgT9qJHMtJ+nwAxvUjMomy7dufWKM8QCmEFBnLhL9EmOag7Oq/IXHLzhbvA9uFv2rc/+Kr3JxhONPQo9kSysi6kUDbasp/RqMBIsSUexLj8YMIqEi4YwrJqDlV4oY/AmB4GVFqyn0puw/9pK1C9CVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=pxQfS1qf; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="pxQfS1qf"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66e452df0easo349922d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787855715; x=1788460515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=buqoy4ey1O0GS5uggVv2tGWIIAUPUFfsCe8wWDFBff4=;
        b=pxQfS1qfFSzCsOIifk1eo2f4YuQNCqzxMTC3Rt+irI258MayRznbI2vqCRS6VucCD+
         Bq05ugSg+OehqFBOUx6WB7li+KlPuV6feOtirscfE47NriSNsDi+nSG7I2Lc13479MWP
         RcjnbTnbnY7S9C2XTMoR6am48dhdSjdhvMbT9x1F8FcoX2Ucrhf4pKZX/aS122vjYU2h
         Yye9eueVotBeBy7kQ5EnwAqmvoXogfS10TBMJf9TS1LVGdnEXpEfmkUB0pP+zrZ++RUQ
         GcRvdcSCIij93EIcO4uVtJRfZk6Sm310mzkWd2LRCsGeUQg+5xXHzfsh6UqjGtPbZfs4
         ixuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787855715; x=1788460515;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=buqoy4ey1O0GS5uggVv2tGWIIAUPUFfsCe8wWDFBff4=;
        b=YctuBkB2RJVcku4UQTTOkWfCj8dS01z9ysvFf8aWMGcP6g8OKrBPMw9sk+CTODDVoB
         kQ3h9OX4OY8DAbPHdxhFCmGbwRvh9Y8kiZubvypvdLsohoswqhS3sphjr5hM8K7FykgI
         tyF9Erqq1TNEPY3wPSxxTEAn65KmX91szkz60ftVNDx91Te0hDHZU3bE2S+HM70/5YKk
         lkcB0R5Q++SvaEUQ4KZIlzUBgG1tWD9OvF3ko7tTrx+xBYNVZYjE/Enfz9rEVUU+58fw
         VTyksemco+vfjHe8BzY5kWjxiMtc+SwWriLcMIcP8E/W2lzZHJUxL4WGxAGDBo+jkMjD
         4yVg==
X-Forwarded-Encrypted: i=1; AHgh+RqTij18vKT5PyacjZNJQyUntmYYAcRH42IvbESI8w+xXa1aPy/ps/hsi0A+NEP+TxsrWyA7cmCjxgztwoKa@vger.kernel.org
X-Gm-Message-State: AFuF++mzYalZFtT2qccvImMUBg+taBwh+lBGTJJJ5M8pJySX0Gtq4Zpy
	hfDgC/JZjnmkiWwt7OrNFaKb92kmnWTPFsojc+5ij0CVpIFMb7R1qebMRUOdLETieow=
X-Gm-Gg: AR+sD10d03u9EFKjQswYTCCL6LThQwUQ/fhs7ZQK6AUfDAXAEaddhXDCSTFt1SJqIU5
	S8dvZY0RQVoGKVEwynKBb4JoxOvE4Rsk5Y09NXZTcw3LZLkPOtamJMCDSi7QJNIt8ihMkoIdjoi
	Rb0DkijS5LKVxJ0jVmZ2StxlN7uFlZeRG3NvHnXaboY/eyJ90Ib5xqMEWeDXesLa9W4OAXlL285
	Negw6llS8M9LZlT6iAtERRieO7kMAwXwreSh57Wlf8OvrM/E2iRoWPIz91JzFyCgvZCWQUE2411
	cyzjIHd8d0LS9Apuxym0X4PZZKDbWJKb2YhS94DzNQRLyJSZ3w4ojeIY7RZmu0OYiNoY763VfC1
	cT+fNgMe1XrXlf5DIOWSmUPF8VU3qe3Fds7+6OrWzPgr7LV362M4m+LeyDGUusVt0eEb/M7OK4Z
	eJCE+fOqojkDaOVR97hLRwSUQ9TD6tbatY7iRGObd3jlEDzRxaITieA8ribjPUqD7wFmH5mG8j1
	LMs+SUgWIFGxJhcmZA03y+Cq3H+hxORVQ3xtrUHpMfesQk+HngP3muUAn6PsePS+OAVsrz23Vw2
	kVX0XSd7pWEazn1u1sRJhRq0mCephWiPMzDyZu4MAVe7HAx778XcTw==
X-Received: by 2002:a05:690c:660b:b0:81d:bc5:4624 with SMTP id 00721157ae682-85d6b84418fmr6398017b3.25.1787855714879;
        Thu, 27 Aug 2026 11:35:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:6de1:2161:6e4f:d299? ([2600:1700:6476:1430:6de1:2161:6e4f:d299])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85b6143f759sm14780507b3.28.2026.08.27.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:35:14 -0700 (PDT)
Message-ID: <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com>
Subject: Re: [PATCH v2 0/7] hfsplus: convert regular file I/O to iomap-based
 operations
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, vdubeyko@coreweave.com
Date: Thu, 27 Aug 2026 11:35:12 -0700
In-Reply-To: <ao9_az3JPNhHooMl@casper.infradead.org>
References: <20260826225614.486112-1-slava@dubeyko.com>
	 <ao9_az3JPNhHooMl@casper.infradead.org>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-27 at 01:06 +0100, Matthew Wilcox wrote:
> On Wed, Aug 26, 2026 at 03:56:07PM -0700, Viacheslav Dubeyko wrote:
> > Christoph Hellwig has detected that taking the page lock around
> > the kmap/modify/kunmap section is not enough on its own:
> > writeback drops the page lock before the write actually completes,
> > so a mutator that only waits on the lock can still start rewriting
> > a page whose old contents are still in flight to the device.
> > Mark the allocation file's mapping with mapping_set_stable_writes()
> > and call folio_wait_stable() right after taking the page lock in
> > both functions, so a mutator also waits out any writeback that was
> > already in progress when it acquired the lock.
>=20
> Why would you indirect through the stable mechanism rather than just
> calling folio_wait_writeback() directly?

The HFS+ allocation file (block bitmap) is represented by sbi-
>alloc_file inode and mapping represents the block bitmap space. If one
thread is calling hfsplus_block_allocate() or hfsplus_block_free(),
then it tries to modify the content of folios/pages in this mapping.
But writeback could happen in the background in another thread. It
sounds like "folio's contents to stay unchanged while writeback is in
progress". This is why folio_wait_stable() was suggested. Do you mean
that it is not exactly correct approach? Do you think that
folio_wait_writeback() is better approach?

Thanks,
Slava.
