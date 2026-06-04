Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897A360751;
	Thu,  4 Jun 2026 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566204; cv=none; b=bALmrwMeqH2vZvYLkvPjsKRHI/Jw442mglI08QbCOz9BNFdihb/DZloyEPy1a/ndksmXeS/YSFDLnonkHhsD3wNlt+1mfWoLWRWrZd4OepE1pX/qdzgsNija5wojSLY+kgClXZVE5pTIPUOzomozCR/iHQag3xLjSpcGqI1iwJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566204; c=relaxed/simple;
	bh=LhawOvyRtRMMXBTHxHHd0oa3qymcQE0gXD1YImAXXXE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lTjkTzU7oW3vPIy1e043hDqv4xfpm4B7qBPgsoKiD765ITuwgJdMeQ0b9Wbp0Lsg13+Y/+8u/lWRIwsvP/TnxDVuDWF35mrg34hWwapLJ8upLOUDLtAdvUNjTin+Ei17v0U/GjmzSeomJxBEko1Y7/P2YL5tiroUAHpzwcw7DSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=bbR4k5Dc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUBKS/UP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="bbR4k5Dc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUBKS/UP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C80701D000D5;
	Thu,  4 Jun 2026 05:43:20 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 04 Jun 2026 05:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1780566200; x=1780652600; bh=Vwtnw06eLMAyNpnezM4yOLQvIVtwS6o86OX
	sctV/SNQ=; b=bbR4k5DcDGg6dhP0DTZ8rCLxErBIHZja/7RSn/8wku7k1yE8B9n
	7274T+Iad+g3Q2L9g5X01yC0W0A1ThCv4Xsj6/y4ZFf2+FHh6h/OpKRr+59CwWa2
	qy2cGZiwRNSk80DVgzoskPdAWu+ctp1wqu/p1BQpQxckdTF6IcIuQeKpmZHWnfOV
	AHW/gdH0A+58qSN+wB/ApHLPuawaUroraixVfLh6PMMzUe7ZjET9Rsqj0pgpGOQg
	9nSWCxDWLHHrNC6a/gPg4DqKmvzBCsNUBWoN8karHXkZpfHL0sDfeu7E+9JHJ3vS
	kLu9FYrKIbGQDml0m5iaJi1ntutixRnnSVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780566200; x=
	1780652600; bh=Vwtnw06eLMAyNpnezM4yOLQvIVtwS6o86OXsctV/SNQ=; b=W
	UBKS/UPuVXl5sYa0O1tLmn5ggFYuHaVRkxz3D2jUNflt4QQSRxpX44df0+Z51pJg
	wOBEbIfk43zUGwINDAwe6gh+CnnXdatwx0r0cTfmEAXGSRSMTy0AQB1Kz5BILkr7
	BQGSHjwVXEwQNB9vwEg3LsgWIoRqWx7FVUymD+7hxlkSWUY8y+7X0S53A1LCLh8H
	UU5O6rv1gZLuLH5YQdH/YHs4DbW1XZEqSorqQgg/ZL+b2kJmKG01FE9iJm4SdvCZ
	D2tVvSxwghlNej8Q7+BIwXST9eB7nufrX3p0EI3HspQUTSikbbTE9K50zUAZbvv5
	S2WtmHcMZC48MMe46O7/g==
X-ME-Sender: <xms:uEghauB34Iq30TMphY90WAFqB19lFnUJ0QT1IkWdaGwdppq-ZdjTKg>
    <xme:uEghahekwpOrYKWda1ojnwjshwn9gZEyQy2Mf71cpomI7ZimMsJxOjSHFga46NVhG
    AlT7gpG2-JVT5O2dSR6pQDREkr_cQxTI6RtJul38Wbm3TGQ>
X-ME-Received: <xmr:uEghatLPuVYG7AI0_pAF2Huabo1agfWEEZflQxPaIUmGiPrjKxACzr2Qd7phyJd2eNmqKzdG6ANjAA0GYp1oCi5tDQxohlk>
X-ME-Proxy-Cause: dmFkZTFoRNuElNb44XKJIPfoa+ZURoUK/BHTmQiRxgVF5le6it5Iams2pMXG5A9Uhb8SlL
    rvFGL59n+ZqkYbg5zsQcYO+rirt6OtR2YvJMF0nTygdv+/PGtZtmFv8hRTXUSuZ4zh2e4L
    zsVDnKKZT3ichNR9Ogx5TYYBk+vxFAHXsG04HM1TVBGGOVOh32UKewv72Kxwa9KDjv1jAR
    HijN9yONIGez8XR3h1iBzdD/JTgDxCd/vUKYOvSTEjOgGRq0g1isUBB+vWu5WHiw1aSx++
    N03b+prHm/wQYrJ7RuxWsffm4mk0BROY8TTrI1/oMZADMj33F8IACN9aTfALQVEnDvj7sR
    4bAoJ3j4M6Jl2/GYCzVe3dGXEvxnOyXh2bj8t3VIVrGVO1A+3Ol0FUpNG4OeTQomEc8oTg
    smnY8LiqDRWkaCN5xW+rtnsNA9yKsqmurPg5GWE9oGk7u7fUh/3TncK0e8HlFlk/nyx0zL
    vCwpDgFnn+eMsa8r+uE5bFICytofGVPhnYDeFQdb1SVZct/e4NVRUfx1tKnPDQwfrOT1T7
    kUAwteN3r0eqGO+qqSO9FinyhqwhSg5OxqteAt8qz7SEEBw9+rBgGUJZVBUrFTCaX3jRAW
    XlKdp7ZJ6iRe91wyUgATiNTkj527oBuQvRfsr7twOw9JSDfnLcaUbpV1Fyfg
X-ME-Proxy: <xmx:uEghas1p3YY9d_I0XIyFDPKkZLOrPdBwV7TLHUgT0HLdd0yRas7rDQ>
    <xmx:uEghaviUE_HjaOd8XhvbkS66D0VMBk5cq9bOGbLkHuJe9QCrQyprHQ>
    <xmx:uEghalWtuoU67OW4cxfjpE3W5-iASWziabcL_yVF5fN0-KPOCtu9yQ>
    <xmx:uEghamX6B4_iOQNEGVAa1zCyn7t_OuqR86xcsVOXZqHdMClk8BYKxg>
    <xmx:uEghailUfEVZwvKvdLAyUmadATAa8gm2g9Xz07NWwPqBBtgslPIZ1lr5>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 05:43:18 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Cc: =?utf-8?b?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
In-reply-to:
 <CAJfpegswAZv8OmDAcK-5u8kssAF1vZKe4gdDB2XPErAnoGFSYg@mail.gmail.com>
References:
 <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
  <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com>
  <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
  <CAJfpegswAZv8OmDAcK-5u8kssAF1vZKe4gdDB2XPErAnoGFSYg@mail.gmail.com>
Date: Thu, 04 Jun 2026 19:43:14 +1000
Message-id: <178056619459.3392745.3091041855723132411@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 04 Jun 2026, Miklos Szeredi wrote:
> On Tue, 2 Jun 2026 at 01:43, NeilBrown <neilb@ownmail.net> wrote:
>=20
> > +               if (d_really_is_negative(child)) {
> > +                       spin_lock(&child->d_lock);
> > +                       if (d_really_is_negative(child)) {
> > +                               fuse_dir_changed(parent);
> > +                               if (!(flags & FUSE_EXPIRE_ONLY))
> > +                                       __d_drop(entry);
> > +                               fuse_invalidate_entry_cache(entry);
> > +                               spin_unlock(&child->d_lock);
> > +                               dput(child);
> > +                               err =3D 0;
> > +                               goto put_parent;
> > +                       }
> > +                       spin_unlock(&child->d_lock);
> > +                       dput(child);
> > +               } else {
> > +                       entry =3D start_removing_dentry(dir, child);
> > +                       dput(child);
> > +                       if (IS_ERR(entry))
> > +                               goto put_parent;
>=20
> There are still races (move out from dir, unlink) that result in
> EINVAL and ENOENT respectively, but AFAICS these cases need to be
> retried instead of faling.  Rather convoluted.

Yes, error from start_remove_dentry() should go around the loop again
rather than failing.
Also I think we do need a parent lock for the negative dentry case.  I
was thinking of protecting this code, but to protect other code that
might instantiate the dentry, we need a proper lock.

>=20
> Can you explain why exactly is this needed?

It isn't clear to me what "this" you are referring to.

My guess is you refer to the need for retry-on-error.
I need that design so that locking can be pushed closer to the
filesystem and ultimately, in some cases, removed.
It is a lot like the reason that we often use cmp-xchg loops instead of
holding a spinlock while performing a simple operation.  The code is
more complex but it scales better.

Thanks for the on going review!

This is my current thought about how to fix this code.

Thanks,
NeilBrown



diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 70948fe385da..7d744c7b923a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1601,55 +1601,74 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u6=
4 parent_nodeid,
 	dir =3D d_find_alias(parent);
 	if (!dir)
 		goto put_parent;
-	while (!entry) {
-		struct dentry *child =3D try_lookup_noperm(name, dir);
-		if (!child || IS_ERR(child))
-			goto put_parent;
-		entry =3D start_removing_dentry(dir, child);
-		dput(child);
-		if (IS_ERR(entry))
-			goto put_parent;
+
+do_lookup:
+	if (IS_DEADDIR(parent))
+		goto put_parent;
+	entry =3D try_lookup_noperm(name, dir);
+	if (!entry || IS_ERR(entry))
+		goto put_parent;
+	/*
+	 * We need to lock against concurrent create/rename/etc whether
+	 * entry is negative or positive, so use whichever of
+	 * start_creating_dentry() and start_removing_dentry() works.
+	 */
+	if (d_really_is_negative(entry) &&
+	    !IS_ERR(start_creating_dentry(dir, entry))) {
+		/* entry is negative, it cannot have been renamed */
+		fuse_dir_changed(parent);
+		if (!(flags & FUSE_EXPIRE_ONLY))
+			d_invalidate(entry);
+		fuse_invalidate_entry_cache(entry);
+		end_creating(entry);
+		err =3D 0;
+	} else if (!IS_ERR(start_removing_dentry(dir, entry))) {
+		/* entry is positive */
+
 		if (!d_same_name(entry, dir, name)) {
 			end_removing(entry);
-			entry =3D NULL;
+			dput(entry);
+			goto do_lookup;
 		}
-	}
=20
-	fuse_dir_changed(parent);
-	if (!(flags & FUSE_EXPIRE_ONLY))
-		d_invalidate(entry);
-	fuse_invalidate_entry_cache(entry);
-
-	if (child_nodeid !=3D 0) {
-		inode_lock(d_inode(entry));
-		if (get_node_id(d_inode(entry)) !=3D child_nodeid) {
-			err =3D -ENOENT;
-			goto badentry;
-		}
-		if (d_mountpoint(entry)) {
-			err =3D -EBUSY;
-			goto badentry;
-		}
-		if (d_is_dir(entry)) {
-			shrink_dcache_parent(entry);
-			if (!simple_empty(entry)) {
-				err =3D -ENOTEMPTY;
+		fuse_dir_changed(parent);
+		if (!(flags & FUSE_EXPIRE_ONLY))
+			d_invalidate(entry);
+		fuse_invalidate_entry_cache(entry);
+		err =3D 0;
+		if (child_nodeid !=3D 0) {
+			inode_lock(d_inode(entry));
+			if (get_node_id(d_inode(entry)) !=3D child_nodeid) {
+				err =3D -ENOENT;
 				goto badentry;
 			}
-			d_inode(entry)->i_flags |=3D S_DEAD;
+			if (d_mountpoint(entry)) {
+				err =3D -EBUSY;
+				goto badentry;
+			}
+			if (d_is_dir(entry)) {
+				shrink_dcache_parent(entry);
+				if (!simple_empty(entry)) {
+					err =3D -ENOTEMPTY;
+					goto badentry;
+				}
+				d_inode(entry)->i_flags |=3D S_DEAD;
+			}
+			dont_mount(entry);
+			clear_nlink(d_inode(entry));
+		badentry:
+			inode_unlock(d_inode(entry));
+			if (!err)
+				d_delete(entry);
 		}
-		dont_mount(entry);
-		clear_nlink(d_inode(entry));
-		err =3D 0;
- badentry:
-		inode_unlock(d_inode(entry));
-		if (!err)
-			d_delete(entry);
+
+		end_removing(entry);
 	} else {
-		err =3D 0;
+		/* must have raced with rename before we got the lock */
+		dput(entry);
+		goto do_lookup;
 	}
-
-	end_removing(entry);
+	dput(entry);
  put_parent:
 	dput(dir);
 	iput(parent);
