Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485C47D938
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 10:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987144; cv=none; b=I6AIlIvwNl+SwMEARAOZ5TwKQxz+379ueePzR3K0lWavJgQnzXJdIS4MKae4gZVEjqpAfM7PAebC7ctIVzBQ+trW8CBjNKJReipTEftCHJ7gbVej0Wl9qgn5h7nMC6SHH0xAJgXj1e7OlPLRKFiUnb+IXU1aSf4CbQfv0p6RQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987144; c=relaxed/simple;
	bh=OeAXm453eNl5Ju9vclt8/yInKnA5PVD4LHUB+k7IU+s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XkuXCJe4dXxx3Zo5GVYB6oJ0xe87m1SrRSSTDJRREWNGFRvspuy1FYNRpdlUi0Lf16nND0AbL12p6cnO2mt/uTEjXN8JXT1/q9MyxxusaAlS1bLgaSONbQTOSo/VzR7fRoTFX2nvKDC4jr3y2VniuoDnA8feoTxpqa8keCWQ7NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Y2lOFcwu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KgNd8Hmy; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Y2lOFcwu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KgNd8Hmy"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 47F5C140019F;
	Thu,  2 Jul 2026 06:12:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 02 Jul 2026 06:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1782987141; x=1783073541; bh=ZYD1YbWe03+/DFv5xIwGAahSLweuFow8F6W
	CVPyG7bU=; b=Y2lOFcwuYxc5SKCP1czYId41EPu+kUhIs3VkUllgrrZlCuwahqp
	dpfNiOCZJ+zuxoXPYVH+vyI+LbFQr2qySOib8SMK17dAsBIa/WYyCJDUmU5Bv/OB
	Og/6iBaG/Cx2QE1zJ76T4uQkGYyMNXv79hzIGNTj4lISRCXSXbVb7HI2awLrc6Ae
	ocYoAYXAdeTVPXd8sQf8sEciDOlb9Yq8F++w+rH7HZj8mslsL7F/Qnt5AA97gWBg
	nMiFTxGofaQbXP4qFd8bDnwvKm5/BQRbGahHYqxItkZalboorLYK61DiHxU8RFBQ
	/NzIw2mf1z0oUFVaDjezdLuQCUiqBNzafEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782987141; x=
	1783073541; bh=ZYD1YbWe03+/DFv5xIwGAahSLweuFow8F6WCVPyG7bU=; b=K
	gNd8HmyhD9Cgb6ztA8RN8QIqhMnK9xGARs3BrtePZcEeXLVBWLN0qF+CEei8/b3n
	jQBes/yZCzZYR+K/3tsJPksL/c5flwEbwHU9un944zDfSVYxpsRyXPpTrSUEW0cR
	zYnd03P2XA2gd6mJFR82S72smR5JX/LbLUT27RM5XIIQoSQyseHVqIEU7Pvn+G81
	qMzPxcf01joLDcp8enxxv6hZF1ntv/6PtSuY7W9VPqNUlyFlf2usbiMsu8GtJHXJ
	9iUY/b03vMPANdjqeWQ13MvmN8UEclK+HU37y/DWWCL6lLPn6GDejR5vnjOi44hp
	PvdAjNAPMjkfJmDzXrQiQ==
X-ME-Sender: <xms:hTlGalj9iRe5v0wejp6ybuqf-OYLVx9wdzxbHvD4c3rEhqSa02fm-A>
    <xme:hTlGan38nbXbIeEL-ApFvCWcy1RS1G6fZuJ0dLb12Q09FE09oBL61fM9M3qE3TVja
    6Dklkr-fY_VzJ8AZRGJzRkG0Bc4D04enIugiaOLlZo2MpvxEw>
X-ME-Received: <xmr:hTlGavgEmhtWCBo-bz9mx9zEgB-S3d2mqH9_6xfEpid_0tdwEZHYpdLN5WNTMijx9vOuwpL-rpIpmAuo8aio9Ry1f_9Rmc8>
X-ME-Proxy-Cause: dmFkZTG1IeEmh/Uah6csLmcYOFyJeWX7zbNxpwjrBvI6QLnwvproBKNaQrnkbV0ePqvHYS
    hlYXn8KkFUM8i1URVbGu5lYm3xtYysnXCbuo3n4XWYPPumw7jetrjj7C9+oYf6fjnK70AN
    h+1KE3bbtUDaNYnpxOgVt69yfw8M97gaR7vBksj6TIfL1pvudCcnVIKLDNGkjaV+xWzwao
    abLxGAz3FMPN8uaHu+J22a81OB3dv8vXo6mfG/feIRXa7cUizVxyoYIKXulVHmgnEVO+rm
    0wJwxw2XcdASAdNy4u1GrZ8cnxUaDRAItpBWN23Ol0lvCTMuuKUDDy4k+YBMY7CLcVPRaA
    fOFivJXbTD4+4cbXqDU0OFs8L1MB6oL1MSIt5MRp1PiRyk1t60AYkdcqg7Tajqwng5sO5R
    z9+QoALqxpsMA3wNBayWFiy9hpZlJ1MDrg43lBSlKpgB96uJTJuux3pYwpjKJU+ZI2/aMc
    9+/rFkTKVCpvDUEnK6DHte8XJNOiieZhVpUadInzz9BUqbU+xqRxS6wbzMo9g8Xzs0cI8k
    +8VBmD5LSz1S74cZ92Lj96jPHevQnk4C4NWSO0sS4nKq/X5l0Ds1PjYKK7n9sNm0e5P1sQ
    H1jx3NrYmI6WzZo3HzqTKsN5Zf6WtMsDyKynwwPqmSO9LZSbzx5VscP8Axug
X-ME-Proxy: <xmx:hTlGanc7QRSRyY5c4UzAdQFuehF04RbC6DLDEDLJVW0Txe57D51XSA>
    <xmx:hTlGailP0sYKOgwc3CzWqdhFD4iopflu68dqXLgJhygpBKHauDL9bA>
    <xmx:hTlGagtxoz2sCdXl2rz4kZMan-RKojNIUEeVp3nz5RnJmL7S0wJt5g>
    <xmx:hTlGao-WXXmxQVk4NRBpMtv8Grz8IJ-pBU02RUkAbRN7TfOVuTfFCA>
    <xmx:hTlGahKl0xwXWgKa7sdjDN07dTwy-6r2cmoB5ajzPep0wBS2jw6CTcId>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 06:12:19 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "David Howells" <dhowells@redhat.com>
Cc: dhowells@redhat.com, "Marc Dionne" <marc.dionne@auristor.com>,
 linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] afs: use d_time instead of d_fsdata
In-reply-to: <139684.1782982460@warthog.procyon.org.uk>
References: <20260702020350.3403907-2-neilb@ownmail.net>
  <20260702020350.3403907-1-neilb@ownmail.net>
  <139684.1782982460@warthog.procyon.org.uk>
Date: Thu, 02 Jul 2026 20:12:15 +1000
Message-id: <178298713518.27465.922344481963289625@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 02 Jul 2026, David Howells wrote:
> NeilBrown <neilb@ownmail.net> wrote:
>=20
> > afs uses ->d_fsdata to store version information for the parent
> > directory.  ->d_time is arguably a better field to store this
> > information as the version is like a time stamp, and ->d_time is an
> > unsigned long, while ->d_fsdata is a void *.
>=20
> It wasn't clear that ->d_time was available for private use by the filesyst=
em.

Fair enough - it isn't clearly documented.
5 different filesystems use it, no common VFS code touches it.

>=20
> > This will leave ->d_fsdata free for a different use ...  which
> > admittedly is also not a void*, but is certainly not at all a time.
>=20
> Are you going to use ->d_fsdata for something generic?

I only need 1 bit - a flag to say that the dentry is being removed on
the server.  I've occasionally thought of asking for a DCACHE_PRIVATE
flag but ->d_fsdata is just as good.

>=20
> > Interestingly the value stored in ->d_time or d_fsdata is u64 which does
> > not fit in "unsigned long" or "void *" on 32 bit hosts.  Maybe that
> > doesn't matter.
>=20
> I know.  I just have to hope that someone triggers revalidation on a dirent
> before 4 billion changes have been made to the directory on a 32-bit machin=
e.
> I could use both d_time and d_fsdata on 32-bit, I suppose.  I really don't
> want to allocate an 8-byte blob for each dentry.

I only want 1 bit of d_fsdata, and 60 bits is likely plenty for a
version number.  So that would be the easiest approach.

>=20
> Maybe I should switch to a single-bit flag and "invalidate" all the dentries
> attached to a directory if I detect a jump in the directory's version number
> due to a third-party modification (the version is monotonically incremented
> for each modification committed).
>=20
> I'm not sure how to do a mass invalidation without risking deadlock, though,
> because I'd quite likely be starting from a random dirent in a directory and
> then have to walk through all the other dirents of the directory.  I suppos=
e I
> could lock the directory (probably using dvnode->validate_lock) and then wa=
lk
> through d_children.

Walking d_children could work, but that list can be long so you want to
allow scheduling points.
I haven't actually tried this, but I think you can allocate a
DCACHE_CURSOR dentry on the stack and insert it in the list whenever you
want to drop ->d_lock and schedule.

Maybe not worth the effort though - 32-bit is a vanishing breed.

NeilBrown
