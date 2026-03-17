Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A01DE8BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 19:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776851; cv=pass; b=moYDchTdfFj2QdIkRS8TbMQk0N7p1vKeys5RTvgArc7v8i50R5MqdaKk2mc2NRkk86yK63bEbWYT0fVx0D3LHTTUhcg0TaJtKRztrV5hYiwqgewpwv83saVMBAyCcQinQz5Pahu2rj577HvjgAjf7C5cBSdNWGawdbVQ7KA2IhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776851; c=relaxed/simple;
	bh=L2Dh8Qua0O0KE9Blzpt6fkVTCg7LgaOkDM5Ur8K1XW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAGs7F9X/HWvoo746NmM+gnTgm5dEti6RLfCNPMiLczFgARy01Pp/LZlyQhEGaCogfLSrAB44eXKP6abTRUuzU9Yp/5lRjhzqxhGK4LK/7tXzu3Fcwb2sw1MvfiMx0slM6QgwP82JqBQ/QwKCuWNFPKnOFCUrejpwJATjLCQHg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc9JjRNZ; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc9JjRNZ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b45bb7548so19243f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 12:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773776849; cv=none;
        d=google.com; s=arc-20240605;
        b=S9o+yCwYfsvtBw1w9N98Gf9u64coYtfyrq9H9NZpcjDgDBLvV0nqEWphnaHBEr8DGL
         shAebO/H5aSCiYVB1lpIfgKPZoVOucLbYKAD4CyK6vrLT2hKb8+ikCzw8J1a+auC8cmQ
         iJpwbC8sQXDkjPCTjTMD/9vCsyErz/KHiB9ygyeXigTzBP9UZwrWksUPbTKbyAoU6cyx
         RA9O8ysNfBoSzx06WL1cI8PotCCB554+ZoLLAIZo5ox/ViOWlKxdxnuAx/XfslR3rM1m
         5zK6hNqkfw5T7k0xASygI0LUHJgUxJe4eVHXkOML5t7rLQnq8rgaDYKKAzpdjg5H+HmX
         kJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zA9mqNr0MuEhUcZVTAz1lGhWQYCIw4d289TxJWqIlY=;
        fh=khAwRLqKVHiKMcTfTX3HyNnZwd2PWKHJ90SmcdewTjc=;
        b=Dn/DMIUk6bWzIkhNnKYPsiZ71+KxECzDU/7pCM7c/sCw3IKG8lot/S55jWnzjl3McB
         TKkqTsxYT+C6dyNfSZvuZgDs6XGxldftEMSV2NF/2JcQGc2gPliXlpEPPHrFYbJXg9WM
         FzEMu9/iKxJI44ldW/WbTpc6RF+IgVQmw/yofd9zIBlBb66iM+T/HPLHJPfJCy5+9nTe
         HQGXycZdpQD3PZSGI05PW+y9k7wX3AGJtoog669Cpg5imrh3dI+ggpZi/eSE3KeUCwTf
         FjPtey6vHjRQ1KCgc0DLCEuBCjvlMN7/b16QRczYrXTu/Rp329mncsc3iq79ZSzpf+l9
         kYoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773776849; x=1774381649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zA9mqNr0MuEhUcZVTAz1lGhWQYCIw4d289TxJWqIlY=;
        b=lc9JjRNZCZ2FQG2J7OOCKNF+fTFF4O61MhwYwWw2jVxz3PLZKNnhxZ+lJ13vUKUZFn
         nGYHp3Af6eXYZEyZP8Z+m6xsmQtR1XFFnmey3QGcXrn+xs2cTYM3xI02BINkEITCOjI2
         ct1APNi02Oo8tYDpwyk6K+dsNq12XGngSUvlSAqHGiqxzNtY7Mf32XAOWD96B169KZH8
         Q34HvQyzu2PdlmK3joybbOo47nBI2UDMbi3Lr1HrGeQK1TauH1EHNGGeX3CBR+fn8Ad2
         3QIc6S8BPPTmJKm/e4cPvFXJd7b5j197lBcTtuYkCyjVYGWRPxT7Z3PVtzKT7ZpFrS3O
         lmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773776849; x=1774381649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zA9mqNr0MuEhUcZVTAz1lGhWQYCIw4d289TxJWqIlY=;
        b=ZzQ73M3dwT1YnGlUASmmmbKp+sKMfIaT0DjrVJiNoT3xuMLueRkx3pmVZRJp3QW5Ct
         qTF/8Dchjx/PGw+8ZACb4n1hJ3J+0ZE9oDIebpIyfcsD3rXUwfgkqzHyqHAxRKmfrbZL
         y8/fxMzAgqPJzNKMpaH7HZSoTnSY+phFyfA+U1OdNabSkIEVJ4TrlnwOXvGZsKBCdbqC
         423Uothxvx0+j/rRtpTDojc4R+D01WHJmFHup84geTsp4LNMGVhOzqnd3nr+lI4mYX4B
         bAB3XplfeIygjV/n7Zg3aFLC/n1LlmSjQuZYbZonGbGKe1TqbkaIbUI4FmCUGXg6PayB
         tgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzonS4ViY2Nmwp5TsYMsx6fo0cWh7mKaFSkb3CmCgpzri2H1CGywIu6SzoWDu/2Rz4cJpoBQbN5R3mi3re@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3GB6ipoGRoE9TVH3Psafu6Sa3uj7ZFcpnH0iSuTZ39WyhdQRy
	3/6Hobk+amtEFi+tHKUnPGG9I2Hw22uvq0QzVKdiG6l1KVux6mbRW63nygnGx42RM+OE36yuHn9
	zva8B+boX3zDigvyPt80zs7FkGQaZIOY=
X-Gm-Gg: ATEYQzyrfldbwxgP6cECykMtiIiTeM9ByWa7YC2LX6KjSTUEg9k+xN3Qp8c4LLcZwru
	f6IzvYJVJPUAH+QbGpgEcwRsSZU5innHXi2t2Ti5digqgAMpQBCO2hTg+1Trtei6hHNat4R/0/X
	iB1mVt2SMYz2Ykq00DR2Q4RtdCbz+XYRAomnGuiaUA0YwRSZljuN1AOe8WCj2xBX0hpQTEr5Vu/
	BDEJamY0DswZAMp/AviTxtXhJguhag7ncAObV2LmkCyvfsv4kUJVeXGYZrUuzhWrOs3rLl19+RB
	cLrf7w==
X-Received: by 2002:a05:6000:1ac6:b0:439:c9e0:83a5 with SMTP id
 ffacd0b85a97d-43b527cccd2mr827377f8f.54.1773776848485; Tue, 17 Mar 2026
 12:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com> <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
 <35327273-23ae-4fc7-93b9-03bd4abf631a@wdc.com> <CAJnrk1YSW5m6mHuFX6cMxZHBt2qdc8aEx9B623WGoTyL1cjjBg@mail.gmail.com>
 <20260310215933.GA1742010@frogsfrogsfrogs>
In-Reply-To: <20260310215933.GA1742010@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 12:47:16 -0700
X-Gm-Features: AaiRm53VN6xEA0I39pkXKZZOAIGOwM9QY0IU_krwUnn-E871DUDw2nC-BjbUEyY
Message-ID: <CAJnrk1Y-gSXNcokA39n4jHeiH4n7uN-eqFRCT4Wh4JBwfBFNkQ@mail.gmail.com>
Subject: Re: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 2:59=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Tue, Mar 10, 2026 at 02:08:28PM -0700, Joanne Koong wrote:
> > On Tue, Mar 10, 2026 at 4:44=E2=80=AFAM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> > >
> > >
> > > >
> > > > 3. If you're able to repro this consistently, would you be able to =
add
> > > > these lines right above the WARN_ON on line 487 and sharing what it
> > > > prints out?
> > > >
> > > > +++ b/fs/iomap/buffered-io.c
> > > > @@ -484,6 +484,17 @@ static void iomap_read_end(struct folio *folio=
,
> > > > size_t bytes_submitted)
> > > >                   * to the IO helper, in which case we are responsi=
ble for
> > > >                   * unlocking the folio here.
> > > >                   */
> > > > +               if (bytes_submitted) {
> > > > +                       struct inode *inode =3D folio->mapping->hos=
t;
> > > > +                       struct block_device *bdev =3D inode->i_sb->=
s_bdev;
> > > > +
> > > > +                       pr_warn("bytes_submitted=3D%zu folio_size=
=3D%zu
> > > > blkbits=3D%u isize=3D%lld "
> > > > +                               "logical_bs=3D%u physical_bs=3D%u\n=
",
> > > > +                               bytes_submitted, folio_size(folio),
> > > > inode->i_blkbits,
> > > > +                               i_size_read(inode),
> > > > +                               bdev ? bdev_logical_block_size(bdev=
) : 0,
> > > > +                               bdev ? bdev_physical_block_size(bde=
v) : 0);
> > > > +               }
> > > >                  WARN_ON_ONCE(bytes_submitted);
> > > >                  folio_unlock(folio);
> > > >          }
> > >
> > > Here we go:
> > >
> > > [   17.872952] bytes_submitted=3D1024 folio_size=3D4096 blkbits=3D12
> > > isize=3D5278880768 logical_bs=3D0 physical_bs=3D0
> >
> > Thank you, this is very helpful.
> >
> > Is it correct that the block device's inode->i_blkbits doesn't reflect
> > its actual logical block size (512) or is that itself a bug somewhere
> > in the block layer?
>
> For a bdev, i_blkbits is only loosely tied to the storage device's block
> size.  i_blkbits can't be smaller than log2(lba_size) and it can't be
> larger than PAGE_SHIFT (or the max folio order if LBS is present).
>
> Typically it starts out matching PAGE_SIZE, but a program that opens the
> block device can call BLKBSZSET to set the block size.  This is usually
> done by userspace filesystem tools to improve performance and/or ensure
> that the kernel actually supports that block size.
>
> Note that kernel filesystem drivers also call sb_set_blocksize to set
> the block size.
>
> The bdev block size seemingly resets to 4k after closing.

Thanks for the explanation. I hadn't realized inode->i_blkbits is only
loosely tied to the actual I/O granularity.

Thanks,
Joanne
>
> > On the iomap side, it uses inode->i_blkbits to
> > determine whether or not an ifs should be attached and what logic to
> > correspondingly call. For this case, shouldn't the inode's i_blkbits
> > be 9 since "isize=3D 5278880768" indicates it's 512-byte aligned, not
> > 4096-byte aligned? I'm not familiar with the block layer, so your
> > thoughts on this would be appreciated.
>
> <shrug> Regular files can have a larger i_blkbits than the underlying
> storage device, so I don't see why bdevs would be different?
>
> --D
>
