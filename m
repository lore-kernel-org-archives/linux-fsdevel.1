Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2533937B
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788217742; cv=none; b=CbWq4wNQOqsQZUb/Lr8BL7JiTTF9VFT30covKVVpfduTom5v58U3l4OJGWP1TeeoBlV7XTP5x9M0Ge7mgkqPAQTm3xjgeudJWoXUoZo+z4NFVcTdqQd9hqrBUsEOy1ilqmLuSwRvwZIz5dQziHG6IDQ+KXYBrSR2EYbH8Q/0Qug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788217742; c=relaxed/simple;
	bh=YyYziHSl2QWjsBQET6oZ/7hvKWTAkN08BNCz/SeSbMY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpwKdYaB4/qjDMSNe85JDEJKTeL9OOahSd+l5P4AYs60UVL9qS08h11JZ/N05aIiOgylSSAudymDTdys3pKSQmqRMW4rANZX4LvfIdqiH8MyYlJJdFVLn40is4FRHsjRUfDLdts/dKViE2nNAJnpTC9c7K3b1RIDIDK25YePTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=MhuZCloP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="MhuZCloP"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8200b55dc47so39139197b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788217739; x=1788822539; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTWd0LvMes+WcHSbad5XAdJ72TMt436AGiM+WL9awAo=;
        b=MhuZCloPeNApV4Ms47Gn8tFhZ3sw2yjo9kAWfIWw4pYZ1RWrorrcEplY1YNuyMAHsq
         8HMrHdc74c27I/4DBz3PvXv0Ky/B4fq1C9GnCYJnMWqj43AR6bYGY4DylCxhfnOtgDfE
         vaRAvd6EB5Y981Dj8yjIYfulO+KXXzTk1qnR9OAaRuOKSiAsIGmDAPGTv6tBY2ufRKsN
         M9G0VDmdCbar3ZXxfUEp+rsOKbS0qwYMN+q7gWX+BlKpyzHtqK9YWlxl5RU0nnkQgonH
         VrPau8uk+yDy+365anmdqZwP8JZ/BHCNu6ZNczW9DE9IwSsy2gZhlZh01QZY9VubSVpf
         kYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788217739; x=1788822539;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qTWd0LvMes+WcHSbad5XAdJ72TMt436AGiM+WL9awAo=;
        b=hfaKzh1Lm9LVgDpSRHWtjNwX6MW8PnH1nQGvS6DrY6HLPmRGzynlAQf7wX/QLlWSGV
         11pIpL5mdU8zOYQ9cLlAq3i4OWy6o6ZUgsw+2r55xrZPBwGqLqqsfJSBAnx8PgB/QeAz
         A4YAbINdwZ74rr7zZUbjoS2YBiowbUCPBO8YIm2j8/N+IR5Ec3rhSmjD/SDyqm2hvpqE
         bjMP9yQgfVdZmvh/mORZpGuJUvAJISKG0RrohUXbqLCngLVilVdNd6z78+hkDUQ8Gt//
         rPkDLUxaEcY4frJHRWk4kzgXIyUXGSROP603ZX/ClQSIxYQmzYIpJNuOy3PzQmTxbmEg
         HewA==
X-Forwarded-Encrypted: i=1; AKwUvBwXQ1c6iNcuFKAOAq6yZgkJbaUedttPrqqGpsF0kNrtc5QqDwuIVyZ4iItdidl+evgNG0A7v3G/f2HE9l5u@vger.kernel.org
X-Gm-Message-State: AFuF++lsW4ghD8maJBWp1XQdOvVhLId85a6GVi4X/mzFnDqzWfVgGfZO
	GmSYAnedS3rq2Ux5yL9y8zRbqJPh7sSx3ISU5yWSLiltdwXOJu86P0PulUJR/auyqtA=
X-Gm-Gg: AYBFou26+RGyXOniinfRThfM+05x1Fv4LI2wHZYJ34u6lFEqjQvThEVsV2ZF9/8PMQF
	zvPKi7G1LboqbeH3qt74GqrQPXqolQFrYPjYhnCbr/0sRGSZpOenxjqBdsFB1wJNUKjWLEpO1VI
	wMiRhy7LXbwt50OoNM3wycUTAfJke8oBCpZ9p04ZPqQXfchy2I1CNkUarJE2avFg6xB5yq0vf5a
	fc2tYruISVHbR3U720YyHxob5dW5rvQsjU8PbC09O+czekTxHEroiJXcn9CC1honnvDvg1r6XKa
	moFOd8t354khz4EQdIM2kG0RkJAZzaZ8qY3RPxPqh1Bke4CwJ+42ClX082DjNr5+E826v6aqE1P
	ah1alk/F0OZfbe3HYxNivLCMxeJ2ATNzRbBXsH8jDJbVvlg/Az+fkhH1EYwWbgEm4Nw5PL7QPlT
	CQt/JRIwBwVU0MsEZwcSn3EhIu8MWQxsb8CfDRWFWl8pFs7eda9QqXkCfCVorz/YZYL1/A6Mv+s
	X+uyLL9u1BXXo3XxrwaMqmn+W4wbtaDx+b5vscaBz1EgqVWH6y9JmZ1Ywn2dUJdZzUt6Zbpsv9z
	AIm4iM26KcIynfrx9WFd9oWdc519eh3mAGmbiYCZEzasxqbnqIEmcw==
X-Received: by 2002:a05:690e:d54:b0:66b:15f3:97f5 with SMTP id 956f58d0204a3-66e4c65e493mr7703796d50.9.1788217738776;
        Mon, 31 Aug 2026 16:08:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:bedd:8cbb:d030:f70c? ([2600:1700:6476:1430:bedd:8cbb:d030:f70c])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4eb569d8sm7081487d50.6.2026.08.31.16.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:08:57 -0700 (PDT)
Message-ID: <4aff885c944377da60ed6a24907e83ab35cc74f3.camel@dubeyko.com>
Subject: Re: [PATCH v2 0/7] hfsplus: convert regular file I/O to iomap-based
 operations
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	vdubeyko@coreweave.com
Date: Mon, 31 Aug 2026 16:08:55 -0700
In-Reply-To: <apV-epG6dtc71Fgt@pedro-suse>
References: <20260826225614.486112-1-slava@dubeyko.com>
	 <ao9_az3JPNhHooMl@casper.infradead.org>
	 <e865789c62b799baf43a2afd67c67302e3eaea25.camel@dubeyko.com>
	 <apCQPaalWMaB5D-p@pedro-suse.lan>
	 <a7b30d5e625da9cbb4a888e31a81df03d37ce91e.camel@dubeyko.com>
	 <apV-epG6dtc71Fgt@pedro-suse>
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

On Mon, 2026-08-31 at 14:21 +0100, Pedro Falcato wrote:
> On Fri, Aug 28, 2026 at 02:52:22PM -0700, Viacheslav Dubeyko wrote:
> > On Thu, 2026-08-27 at 20:35 +0100, Pedro Falcato wrote:
> > > On Thu, Aug 27, 2026 at 11:35:12AM -0700, Viacheslav Dubeyko
> > > wrote:
> > > > On Thu, 2026-08-27 at 01:06 +0100, Matthew Wilcox wrote:
> > > > > On Wed, Aug 26, 2026 at 03:56:07PM -0700, Viacheslav Dubeyko
> > > > > wrote:
> > > > > > Christoph Hellwig has detected that taking the page lock
> > > > > > around
> > > > > > the kmap/modify/kunmap section is not enough on its own:
> > > > > > writeback drops the page lock before the write actually
> > > > > > completes,
> > > > > > so a mutator that only waits on the lock can still start
> > > > > > rewriting
> > > > > > a page whose old contents are still in flight to the
> > > > > > device.
> > > > > > Mark the allocation file's mapping with
> > > > > > mapping_set_stable_writes()
> > > > > > and call folio_wait_stable() right after taking the page
> > > > > > lock
> > > > > > in
> > > > > > both functions, so a mutator also waits out any writeback
> > > > > > that
> > > > > > was
> > > > > > already in progress when it acquired the lock.
> > > > >=20
> > > > > Why would you indirect through the stable mechanism rather
> > > > > than
> > > > > just
> > > > > calling folio_wait_writeback() directly?
> > > >=20
> > > > The HFS+ allocation file (block bitmap) is represented by sbi-
> > > > > alloc_file inode and mapping represents the block bitmap
> > > > > space.
> > > > > If one
> > > > thread is calling hfsplus_block_allocate() or
> > > > hfsplus_block_free(),
> > > > then it tries to modify the content of folios/pages in this
> > > > mapping.
> > > > But writeback could happen in the background in another thread.
> > > > It
> > > > sounds like "folio's contents to stay unchanged while writeback
> > > > is
> > > > in
> > > > progress". This is why folio_wait_stable() was suggested. Do
> > > > you
> > > > mean
> > > > that it is not exactly correct approach? Do you think that
> > >=20
> > > Why do you want to do this? It's definitely unusual for
> > > filesystems
> > > (AFAIK)?
> > > It sounds like you're trying to guarantee some sort of
> > > consistency in
> > > your
> > > writes, without journaling, but I can't tell exactly why.
> > >=20
> > > (FWIW, if you're trying to do this for metadata consistency
> > > reasons,
> > > I
> > > really don't think this works, because not only do you not know
> > > if
> > > data
> > > hits the disk, but you also don't know if other writes (e.g
> > > inodes)
> > > hit
> > > the disk, etc)
> >=20
> > The sbi->alloc_file [1] is not regular inode. It is embedded into a
> > superblock structure the special inode for representing metadata:
> >=20
> > struct hfsplus_sb_info {
> > <skipped>
> > 	struct inode *alloc_file;
> > <skipped>
> > };
> >=20
> > This inode participates in metadata operations only:
> > hfsplus_block_allocate(), hfsplus_block_free(). If this inode is
> > marked
> > as dirty, then hfsplus_file_fsync() [2], hfsplus_sync_fs() [3] can
> > call:
> >=20
> > =C2=A0filemap_write_and_wait(sbi->alloc_file->i_mapping)
> >=20
> > And this call could take place concurrently with
> > hfsplus_block_allocate(), hfsplus_block_free(). The main goal of
> > folio_wait_stable() or folio_wait_writeback() is to prevent the
> > allocate or free methods from accessing memory page until it under
> > writeback.
>=20
> Why is that a problem? Racing writeback is fine for most block
> devices
> (those that aren't have bdev_stable_writes(), thus just doing
> folio_wait_stable()
> should work, I think)
>=20

The problem here that before modification of block bitmap's page we
need to be sure that writeback operation has been finished. Otherwise,
we could have finally inconsistent state of the block bitmap on the
volume. Frankly speaking, I don't quite follow what are we discussing
here? Do you have a particular suggestion or improvement of the patch 3
in the series? What is the wrong in patch 3, from your point of view?

Thanks,
Slava.

> > writes.
> >=20
> > But if you believe that the whole approach of managing Allocation
> > File
> > is implemented in wrong way many years ago, then you are welcomed
> > top
> > implement it in right way. :)
>=20
> Oh. I don't think that's wrong. I'm just trying to understand why you
> think
> excluding against writeback unconditionally is the right thing to do.
