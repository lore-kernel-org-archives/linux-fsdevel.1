Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006B53B14CE
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208512; cv=none; b=ELv+W+HltAtKCGXNk51kop4vu9V9LZbZ0k696Dznru6cSIlfGOcsNk+x22nC30GIHDZlz9BBqA5I1fcAThmLU3Z1OJRvlH2kCTndHnHMuVHa7C4WAvVU23wOA9ijW3AwrijVJ7s2cekFazhS2gwrLtYnY2rLaa13mdQ/JvEWJic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208512; c=relaxed/simple;
	bh=/UCVxZk2QssJLuKMX9Jg2Mh+HN80WKve1xMiWQfJ4AM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6ikATyiem6/B1p4fm+gBtas7iSIZnqf3Zcas9nbUTSMnH6CFqBYusojAsZ9B504x+jkvj6V3KHtKV1nstuyOmI7tg7yOVrGaqVu5109e6Vvrnpt3k1GVi+g2pXsma4L1W0/Kmw7MoE94wUAVhUXETYfp9zugpdsjf9/Q1Bm0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYH0kmcK; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYH0kmcK"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc149372c14so1093019a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787208510; x=1787813310; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:subject:cc:to:from:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pgkmn85tVZpcP5UWnOcsGVdM3fDAb124VxlJmt14G5U=;
        b=dYH0kmcKaG0AhtSeQWYenkZTjEzXEOVhMQX5BW/4t4SrKV3cDu1ShV3dH34UNtu1iG
         znAmLKf5YRYbCB8ERTJIVIQXaM0kSSZ/68aPZQ/F9GHG+RBQfLPd9YWpWVIfjcfditsp
         DKUh+f4e/rDCy8t0+7vadRtvuz091etuY+CJxwXOUS2sjXLYJSf+VPEoCvFw3CgL7M00
         NoWhDPegzHesgMEQdeTzB/GU7ITgGdlKQUxCeyyo8t6vRkZngh/OgsrKS2tEF1vvCwoB
         f/lyRfYJy4leJHB9YeJ/4K/1n1DRhDqPwoLsuRP2WG2cUE+2kxQKku8rSrEGLy9pWSm2
         IzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787208510; x=1787813310;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:subject:cc:to:from:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pgkmn85tVZpcP5UWnOcsGVdM3fDAb124VxlJmt14G5U=;
        b=CQFmY1rCSCiE78fW7YnMI6+hXwYgXBAL0fl4rAc0hoE8DEFNJHnwvR8e3RoLHmDPia
         7hkUtOl1Laqe/2H2/o+3zMnIAdB6Hv9ODqPaVVjB3KjeHz97ad/Rca/16MrTgcrJwA57
         KDzf1XUSmpK+OaH1W0R9uVMhYBMB3juNUmu3Dz9icSXhv4tjBQ3dkz93FcNQQIKnVeXC
         aVnm9L/5CcfFutTmC6IzAWO5AvlmkJytQmGccjFj5myY3rnPKLmRRvzmDtQmPHrStyKy
         zt3eSrnMOVdT8Ut5RpHLcKgFFQCWfs6PGkaFLsI5FOAoi43HlomM83MH0D/AaNC9qHZk
         D4IA==
X-Forwarded-Encrypted: i=1; AHgh+RoWQ2vU64bxkzxeaTmQ2dZU+h3mH8MWUswMx6mfBXMQMaegl8nsd8g6yLnC58iDRd01Mb55VoqRsUzgVTWW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OVZPLSh46p4PSb6M53TfItaT+3fu+ovVEKx8gD7MYCLCHX8x
	JkuZ5jldyJsdw76G7u0cWpMTc9mh8Q6ntv8+gtjqap8F7PNAiIUbjIQNaPmS0G98qk8=
X-Gm-Gg: AR+sD11ZIZfr6xqiittEoQz+QhiI4PN43Q0RqFMUcfK9btyNKmW5dePIXSFFjGLmXG1
	NFUC2GemCw7DwCwsny7PZJIQ077/82y2vydpRvk7icrVY7wGZZw8f6Rdu7NlxL7f2YUDup+4p6r
	qnB3JK3/ZBc3P1WmHJp6w3xjwBghSkZbLqGbpBUurjUD9v5jVHXJDj/z9jGIzplLKCcbivaTYXH
	jT1zxraGFAJ8RnBcZaIVJGqlT4XLZjWotvTimLdw3ngVUz4RO2Apscp13FnfD6+IW5Ciq6lLq0K
	2/BL/mxjbDhemQg/bvVIn2W7+uEYkdICfAq9pmLiUoTJlSBMHoh8hOW0UMo3Yhwh4WlBjrrhz9H
	VEptt5Ub8QQ5EB+sg0f7erMbdChuVWyAxg+/N1ixNCWOqMzeKBBvH7xTzW8JIdChl2sEBaHfju3
	kQ7nsbSpSSTdh9t6M+t2F/u3Id+CMCijCOFMa7uYXKDMLRJbdxZKpOT9ucwTIzHBWV6lyZYazTb
	+lgTCNc7nqyBQC5KQIoOqo2RsTKkjOsLEfW9Pj8MLE/cA==
X-Received: by 2002:a05:6372:a80c:b0:3cd:f6c:6cdd with SMTP id adf61e73a8af0-3cd0f6cc723mr11226457637.16.1787208510058;
        Wed, 19 Aug 2026 23:48:30 -0700 (PDT)
Received: from localhost (75-172-9-230.tukw.qwest.net. [75.172.9.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10a94dsm13351085eec.15.2026.08.19.23.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:48:29 -0700 (PDT)
Message-ID: <6a86a33d.92d2873c.12c24f.5c15@mx.google.com>
X-Google-Original-Message-ID: <aoajOSBZV063ofyZ@DESKTOP-HH660AU.>
Date: Wed, 19 Aug 2026 23:48:25 -0700
From: Dennis Tighe <dennis.tighe@gmail.com>
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntfs: validate usa_ofs before preserving the update
 sequence number
References: <49b4a00a-351b-4eae-8466-feadb1851156@gmail.com>
 <CANFS6bb7QQy6jbhu6Ny5uHXg2YaJbzfxgbvaXAboL6JXagXRmA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFS6bb7QQy6jbhu6Ny5uHXg2YaJbzfxgbvaXAboL6JXagXRmA@mail.gmail.com>

On Tue, Aug 18, 2026 at 04:46:12PM +0900, Hyunchul Lee wrote:
> 2026년 8월 18일 (화) 오후 3:05, Dennis Tighe <dennis.tighe@gmail.com>님이 작성:
> >
> > When ntfs_mft_record_alloc() reuses a free mft record it reads the old
> > update sequence number straight from the on-disk record:
> >
> >      usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
> >
> > Here m points into the raw $MFT page-cache folio, which still holds
> > unvalidated, MST-protected bytes: the folio is read by a plain
> > iomap_read_folio() and neither post_read_mst_fixup() nor
> > ntfs_mft_record_check() has run on it (both work on private copies).
> > m->usa_ofs is therefore an untrusted u16, and a corrupted record can put
> > it past the end of the record so the two-byte read lands outside the
> > folio.  Reading such a record while creating a file gives, under KASAN:
> >
> >    BUG: KASAN: use-after-free in ntfs_mft_record_alloc+...
> >    Read of size 2 at addr ...
> >     ntfs_mft_record_alloc -> __ntfs_create -> ntfs_create -> path_openat
> >
> > Only preserve the old update sequence number when usa_ofs is even and in
> > range, mirroring the check ntfs_mft_record_check() already applies;
> > otherwise leave usn zero, which the existing restore below skips.
> >
> > Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
> > ---
> >
> > Reached by creating a file on a mounted image whose $MFT holds a
> > corrupted free record.  This seems like a fairly low-impact one, but
> > given that
> > it fires KASAN, it felt worth submitting a patch for.
> >
> > The KASAN error that I received on 7.1.7 is listed above. On a RW mount
> > this is a
> > one-shot per image and only trips KASAN when the next page happens to be
> > poisoned.
> >
> > A reproducer is available if you'd like (just reach out privately).
> >
> > Found and fixed with AI assistance.
> >
> >   fs/ntfs/mft.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> > index fd20d7a..271a265 100644
> > --- a/fs/ntfs/mft.c
> > +++ b/fs/ntfs/mft.c
> > @@ -2333,7 +2333,17 @@ int ntfs_mft_record_alloc(struct ntfs_volume
> > *vol, const int mode,
> >            * wrong with the previous mft record.
> >            */
> >           seq_no = m->sequence_number;
> > -        usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
> > +        /*
> > +         * The mft record still holds unvalidated, MST-protected on-disk
> > +         * bytes, so m->usa_ofs is untrusted here.  Only preserve the old
> > +         * update sequence number if that offset is in bounds; otherwise
> > +         * leave usn zero so it is not restored below.
> > +         */
> 
> Could you remove the above comment?
> Also, as I mentioned in the previous mail,
> I could not apply this patch.
> 

That was a misconfigured email client on my end. Sorry about that! I've fixed
both of those and resent.

> > +        if (!(le16_to_cpu(m->usa_ofs) & 1) &&
> > +            le16_to_cpu(m->usa_ofs) + sizeof(usn) <= vol->mft_record_size)
> > +            usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
> > +        else
> > +            usn = 0;
> >           err = ntfs_mft_record_layout(vol, bit, m);
> >           if (unlikely(err)) {
> >               ntfs_error(vol->sb, "Failed to layout allocated mft record
> > 0x%llx.",
> > --
> > 2.47.3
> >
> 
> 
> -- 
> Thanks,
> Hyunchul
