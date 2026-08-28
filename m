Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9538C433
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953948; cv=none; b=sbym9p2K22UqHv5jXnXUJ0YGlDFE55UAFIFUMSDHb7VLTjqdLbScwouyfoN5O1ZQQYbZKgsITdnH4c1DMWp8lqwQGCL6c9FbAAUQulLct6MClPxtYieA+bBfkdweM9BAMeSovvuWHVHxEOWMdw0xykMDDgjFIGzwgRrcY3mJA5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953948; c=relaxed/simple;
	bh=DRefc24OVjT9scvG+5DWXa483jmtKY+huRR4cZlwGak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WYLc/EKEjbnulHPYzu+PIRbpiJYRt8tj1XDvwjwYUO7KYf7nIuxf/uDZ92mVCGU1rZ/YC/1qQhV/7Mh4KqwT60fwo+YJ1S3ErTeQJ/yHlCn/MWLGAHc4ADH+oIUBFdzlT84t14s0JDnFKHCWIliw9N5ZSZd3AcpOlMqKj/xPKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=lA8KnRZx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="lA8KnRZx"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836cbcd0a48so24286957b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787953946; x=1788558746; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BgN/bcwu5IYN+qVbFqEsPvEYgULI4u6VMTKJBMG3cjM=;
        b=lA8KnRZxz0euSd+GUGn1MNFWrBMPbTGSQdmplr/izQLEK/8nYf/p24JrFf616Pe61V
         JicFLP7+PHb5VVq98TTHVjYymholHfQXd+wS7fQY/XWwHQgkp1CPYiFpPDRrzTrJ9TyT
         SUVK0JLwAPXchhz8NG40rZacHr6N0+8wqzlItU3QR97Q+SjBS+lruL2dNZEDvvQwk8ir
         nYySiLoOExEKb5XIkqr9Ri7cPEO12VsdtWSeWjzE46yuArADW8aYgbFhprB81T940dan
         9WOcowq8BDhtxYVfP3Odz2mcbe1ItdOzySOY5bzKrjXF4lvFG6QtyLDX028PRehohjY4
         G9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787953946; x=1788558746;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BgN/bcwu5IYN+qVbFqEsPvEYgULI4u6VMTKJBMG3cjM=;
        b=ljB2DioWmIL+xSneu+wTamsiqm7XirkPaBQyR7WNswgOm0ESWEMXjrQqR4ricWKlcr
         YWGfjw/s6DYapd4XkbNiJhSA1DHa7DSuBS+IyURK00WFsJs34Fy4Auw79TaxonkWci47
         emfWKci71KqdVjW1SDLzLQ40jq74A30IVEyevD37yWvx8NN2c6xeLqmRxRN3R5TRunsM
         lLVRLQVlD+X/sNa6OWzKkdqtCWtIaHMXATbLtJ2EicwuYanb275z29trJA0wL5AE8kYy
         Wu7MT+eOHg91hn5I8FX0bktR/Wql3N9shMCZXp+fr2j97szGKpq/rnzm1pnVP4cqvK3E
         3Xww==
X-Forwarded-Encrypted: i=1; AKwUvBx3tnAq9q7XYScT11/YuiyqTZvahHwhyAHYHM5PjFOeYHKUo6ExDtRknbnSf+YTUi7Oq90V00r3ZdS4B7yC@vger.kernel.org
X-Gm-Message-State: AFuF++mTz4wGIk7Ic8mKM2qh2/Y+XPjn7Jw9/4RBRVct2uZOFFV2ynb+
	OgIwt1jrHjWjqjHzcP0JTB+xdlq5RVzg7m0vQYd6MPTr4lcMC8zPlKpO0MCaFwR3Fi/Vt5E4kQq
	XrXCT
X-Gm-Gg: AYBFou3X0PPcq3fLe2ZpHIQEg/F5DsN0oZmf8xECAD9UfaaP1M4pXg6QohYn9ZRCVxK
	g+VBgnbtdWtjFHjth6XXUO05rMiXW6swdqzjJlsT08Ov3GmLGoZWsPx2K7u3lPnQMXSUkGDHIro
	+ct+d0W4Cy2S/DNmak3fWLiB6p80BpejGEh1X0yEFt1Y4ZujH8sJA0SPTcd2HBoM6fz58u7vPwD
	37eMKVQ8vaTjHXmDFIC8/66KOdLD3SS1XZeoN9N+ZWfqvZELxUvGgtpyV0lW5vLR9mJFBV6b+zh
	VO4S3rnzbIL/13b5N5maiNZhn5MHxSHdCtNKnpJ+oJN8tcYhV7Au0y07SQMAFTJLvrfs5HGKp3I
	o6O+ueZxXKyxCrve0rEpUGi/3ew3nfiKqeZLvHx7X16Dp3c/XXsAnFBRwRLZnEI3rJphtCSYt8P
	xHVJLkimmFB2xg9XnNJTUjmXKAar+gHrCripgNRIvQyEjyp+IKIx8vPzmVR4J4TLffHKal7UNEY
	5mzoVWwT8mBopOqdNDBIJv2+WgTvFH0eroIXHRT6HsD4LeT8dhSDV0R/9hhDKMxxETDqVPhZzAW
	frFiCWGwPdCD9QHEwQ==
X-Received: by 2002:a05:690c:d8c:b0:820:a55:3ca3 with SMTP id 00721157ae682-85d6c5026a2mr45234407b3.33.1787953945797;
        Fri, 28 Aug 2026 14:52:25 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:ea83:524e:5ab7:94d1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e68ae126bsm13159077b3.9.2026.08.28.14.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 14:52:25 -0700 (PDT)
Message-ID: <a7b30d5e625da9cbb4a888e31a81df03d37ce91e.camel@dubeyko.com>
Subject: Re: [PATCH v2 0/7] hfsplus: convert regular file I/O to iomap-based
 operations
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	vdubeyko@coreweave.com
Date: Fri, 28 Aug 2026 14:52:22 -0700
In-Reply-To: <apCQPaalWMaB5D-p@pedro-suse.lan>
References: <20260826225614.486112-1-slava@dubeyko.com>
	 <ao9_az3JPNhHooMl@casper.infradead.org>
	 <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com>
	 <apCQPaalWMaB5D-p@pedro-suse.lan>
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

On Thu, 2026-08-27 at 20:35 +0100, Pedro Falcato wrote:
> On Thu, Aug 27, 2026 at 11:35:12AM -0700, Viacheslav Dubeyko wrote:
> > On Thu, 2026-08-27 at 01:06 +0100, Matthew Wilcox wrote:
> > > On Wed, Aug 26, 2026 at 03:56:07PM -0700, Viacheslav Dubeyko
> > > wrote:
> > > > Christoph Hellwig has detected that taking the page lock around
> > > > the kmap/modify/kunmap section is not enough on its own:
> > > > writeback drops the page lock before the write actually
> > > > completes,
> > > > so a mutator that only waits on the lock can still start
> > > > rewriting
> > > > a page whose old contents are still in flight to the device.
> > > > Mark the allocation file's mapping with
> > > > mapping_set_stable_writes()
> > > > and call folio_wait_stable() right after taking the page lock
> > > > in
> > > > both functions, so a mutator also waits out any writeback that
> > > > was
> > > > already in progress when it acquired the lock.
> > >=20
> > > Why would you indirect through the stable mechanism rather than
> > > just
> > > calling folio_wait_writeback() directly?
> >=20
> > The HFS+ allocation file (block bitmap) is represented by sbi-
> > > alloc_file inode and mapping represents the block bitmap space.
> > > If one
> > thread is calling hfsplus_block_allocate() or hfsplus_block_free(),
> > then it tries to modify the content of folios/pages in this
> > mapping.
> > But writeback could happen in the background in another thread. It
> > sounds like "folio's contents to stay unchanged while writeback is
> > in
> > progress". This is why folio_wait_stable() was suggested. Do you
> > mean
> > that it is not exactly correct approach? Do you think that
>=20
> Why do you want to do this? It's definitely unusual for filesystems
> (AFAIK)?
> It sounds like you're trying to guarantee some sort of consistency in
> your
> writes, without journaling, but I can't tell exactly why.
>=20
> (FWIW, if you're trying to do this for metadata consistency reasons,
> I
> really don't think this works, because not only do you not know if
> data
> hits the disk, but you also don't know if other writes (e.g inodes)
> hit
> the disk, etc)

The sbi->alloc_file [1] is not regular inode. It is embedded into a
superblock structure the special inode for representing metadata:

struct hfsplus_sb_info {
<skipped>
	struct inode *alloc_file;
<skipped>
};

This inode participates in metadata operations only:
hfsplus_block_allocate(), hfsplus_block_free(). If this inode is marked
as dirty, then hfsplus_file_fsync() [2], hfsplus_sync_fs() [3] can
call:

 filemap_write_and_wait(sbi->alloc_file->i_mapping)

And this call could take place concurrently with
hfsplus_block_allocate(), hfsplus_block_free(). The main goal of
folio_wait_stable() or folio_wait_writeback() is to prevent the
allocate or free methods from accessing memory page until it under
writeback. It is not about to guarantee some sort of consistency in
writes.

But if you believe that the whole approach of managing Allocation File
is implemented in wrong way many years ago, then you are welcomed top
implement it in right way. :)

Thanks,
Slava.

[1]
https://elixir.bootlin.com/linux/v7.2/source/fs/hfsplus/hfsplus_fs.h#L120
[2]
https://elixir.bootlin.com/linux/v7.2/source/fs/hfsplus/inode.c#L415
[3]
https://elixir.bootlin.com/linux/v7.2/source/fs/hfsplus/super.c#L272

